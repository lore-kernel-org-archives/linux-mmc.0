From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/2] mmc-utils: add support to create gp partition
Date: Thu, 24 Apr 2014 16:17:52 +0530
Message-ID: <1398336472-16679-3-git-send-email-balajitk@ti.com>
References: <1398336472-16679-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33421 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbaDXKr6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Apr 2014 06:47:58 -0400
In-Reply-To: <1398336472-16679-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: Balaji T K <balajitk@ti.com>

create gp partition if needed with enhanced / extended attribute.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 mmc.c      |    5 ++
 mmc.h      |    2 +
 mmc_cmds.c |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |    1 +
 4 files changed, 143 insertions(+), 0 deletions(-)

diff --git a/mmc.c b/mmc.c
index 926e92f..2fdd916 100644
--- a/mmc.c
+++ b/mmc.c
@@ -70,6 +70,11 @@ static struct Command commands[] = {
 		"Set the eMMC data sector size to 4KB by disabling emulation on\n<device>.",
 	  NULL
 	},
+	{ do_create_gp_partition, -6,
+	  "gp create", "<-y|-n> " "<length KiB> " "<partition> " "<enh_attr> " "<ext_attr> " "<device>\n"
+		"create general purpose partition for the <device>.\nDry-run only unless -y is passed.\nNOTE!  This is a one-time programmable (unreversible) change.\nTo set enhanced attribute to general partition being created set\n <enh_attr> to 1 else set it to 0.\nTo set extended attribute to general partition\n set <ext_attr> to 1,2 else set it to 0",
+	  NULL
+	},
 	{ do_enh_area_set, -4,
 	  "enh_area set", "<-y|-n> " "<start KiB> " "<length KiB> " "<device>\n"
 		"Enable the enhanced user area for the <device>.\nDry-run only unless -y is passed.\nNOTE!  This is a one-time programmable (unreversible) change.",
diff --git a/mmc.h b/mmc.h
index e78dd54..157f85c 100644
--- a/mmc.h
+++ b/mmc.h
@@ -79,6 +79,8 @@
 #define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
 #define EXT_CSD_USE_NATIVE_SECTOR	62 /* R/W */
 #define EXT_CSD_DATA_SECTOR_SIZE	61 /* R */
+#define EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_1	53
+#define EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_0	52
 
 /*
  * WR_REL_PARAM field definitions
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 941d29f..b531d2f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -500,6 +500,7 @@ int check_enhanced_area_total_limit(const char * const device, int fd)
 	__u32 regl;
 	unsigned long max_enh_area_sz, user_area_sz, enh_area_sz = 0;
 	unsigned long gp4_part_sz, gp3_part_sz, gp2_part_sz, gp1_part_sz;
+	unsigned long total_sz, total_gp_user_sz;
 	unsigned int wp_sz, erase_sz;
 	int ret;
 
@@ -573,6 +574,140 @@ int check_enhanced_area_total_limit(const char * const device, int fd)
 			enh_area_sz, max_enh_area_sz, device);
 		return 1;
 	}
+	total_sz = get_sector_count(ext_csd) / 2;
+	total_gp_user_sz = gp4_part_sz + gp3_part_sz + gp2_part_sz +
+				gp1_part_sz + user_area_sz;
+	if (total_gp_user_sz > total_sz) {
+		fprintf(stderr,
+			"requested total partition size %lu KiB cannot exceed card capacity %lu KiB %s\n",
+			total_gp_user_sz, total_sz, device);
+		return 1;
+	}
+
+	return 0;
+}
+
+int do_create_gp_partition(int nargs, char **argv)
+{
+	__u8 value;
+	__u8 ext_csd[512];
+	__u8 address;
+	int fd, ret;
+	char *device;
+	int dry_run = 1;
+	int partition, enh_attr, ext_attr;
+	unsigned int length_kib, gp_size_mult;
+	unsigned long align;
+
+	CHECK(nargs != 7, "Usage: mmc gp create <-y|-n> <length KiB> "
+		"<partition> <enh_attr> <ext_attr> </path/to/mmcblkX>\n", exit(1));
+
+	if (!strcmp("-y", argv[1]))
+		dry_run = 0;
+
+	length_kib = strtol(argv[2], NULL, 10);
+	partition = strtol(argv[3], NULL, 10);
+	enh_attr = strtol(argv[4], NULL, 10);
+	ext_attr = strtol(argv[5], NULL, 10);
+	device = argv[6];
+
+	if (partition < 0 || partition > 4) {
+		printf("Invalid gp parition number valid range [1-4]\n");
+		exit(1);
+	}
+
+	if (enh_attr && ext_attr) {
+		printf("Not allowed to set both enhanced attribute and extended attribute\n");
+		exit(1);
+	}
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		exit(1);
+	}
+
+	/* assert not PARTITION_SETTING_COMPLETED */
+	if (ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED]) {
+		printf(" Device is already partitioned\n");
+		exit(1);
+	}
+
+	align = 512l * get_hc_wp_grp_size(ext_csd) * get_hc_erase_grp_size(ext_csd);
+	gp_size_mult = (length_kib + align/2l) / align;
+
+	/* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
+	ret = write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x1 to EXT_CSD[%d] in %s\n",
+			EXT_CSD_ERASE_GROUP_DEF, device);
+		exit(1);
+	}
+
+	value = (gp_size_mult >> 16) & 0xff;
+	address = EXT_CSD_GP_SIZE_MULT_1_2 + (partition - 1) * 3;
+	ret = write_extcsd_value(fd, address, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+			value, address, device);
+		exit(1);
+	}
+	value = (gp_size_mult >> 8) & 0xff;
+	address = EXT_CSD_GP_SIZE_MULT_1_1 + (partition - 1) * 3;
+	ret = write_extcsd_value(fd, address, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+			value, address, device);
+		exit(1);
+	}
+	value = gp_size_mult & 0xff;
+	address = EXT_CSD_GP_SIZE_MULT_1_0 + (partition - 1) * 3;
+	ret = write_extcsd_value(fd, address, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+			value, address, device);
+		exit(1);
+	}
+
+	value = ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE];
+	if (enh_attr)
+		value |= (1 << partition);
+	else
+		value &= ~(1 << partition);
+
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value);
+	if (ret) {
+		fprintf(stderr, "Could not write EXT_CSD_ENH_%x to EXT_CSD[%d] in %s\n",
+			partition, EXT_CSD_PARTITIONS_ATTRIBUTE, device);
+		exit(1);
+	}
+
+	address = EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_0 + (partition - 1) / 2;
+	value = ext_csd[address];
+	if (ext_attr)
+		value |= (ext_attr << (4 * ((partition - 1) % 2)));
+	else
+		value &= (0xF << (4 * ((partition % 2))));
+
+	ret = write_extcsd_value(fd, address, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%x to EXT_CSD[%d] in %s\n",
+			value, address, device);
+		exit(1);
+	}
+
+	ret = check_enhanced_area_total_limit(device, fd);
+	if (ret)
+		exit(1);
+
+	if (!set_partitioning_setting_completed(dry_run, device, fd))
+		exit(1);
 
 	return 0;
 }
diff --git a/mmc_cmds.h b/mmc_cmds.h
index f06cc10..0f92d06 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -26,5 +26,6 @@ int do_hwreset_en(int nargs, char **argv);
 int do_hwreset_dis(int nargs, char **argv);
 int do_sanitize(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
+int do_create_gp_partition(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
 int do_write_reliability_set(int nargs, char **argv);
-- 
1.7.5.4

