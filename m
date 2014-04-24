From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/2] mmc-utils: add check for max enhanced user area.
Date: Thu, 24 Apr 2014 16:17:51 +0530
Message-ID: <1398336472-16679-2-git-send-email-balajitk@ti.com>
References: <1398336472-16679-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33424 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbaDXKsB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Apr 2014 06:48:01 -0400
In-Reply-To: <1398336472-16679-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: Balaji T K <balajitk@ti.com>

In addition to user area, General purpose partition can be
be marked with enhanced attribute, retain enhanced attributes of
gp partition while creating enhanced user area and add
check for max enhanced area of the device.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 mmc.h      |   16 ++++++++++
 mmc_cmds.c |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/mmc.h b/mmc.h
index 9871d62..e78dd54 100644
--- a/mmc.h
+++ b/mmc.h
@@ -57,6 +57,18 @@
 #define EXT_CSD_MAX_ENH_SIZE_MULT_0	157
 #define EXT_CSD_PARTITIONS_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SETTING_COMPLETED	155	/* R/W */
+#define EXT_CSD_GP_SIZE_MULT_4_2	154
+#define EXT_CSD_GP_SIZE_MULT_4_1	153
+#define EXT_CSD_GP_SIZE_MULT_4_0	152
+#define EXT_CSD_GP_SIZE_MULT_3_2	151
+#define EXT_CSD_GP_SIZE_MULT_3_1	150
+#define EXT_CSD_GP_SIZE_MULT_3_0	149
+#define EXT_CSD_GP_SIZE_MULT_2_2	148
+#define EXT_CSD_GP_SIZE_MULT_2_1	147
+#define EXT_CSD_GP_SIZE_MULT_2_0	146
+#define EXT_CSD_GP_SIZE_MULT_1_2	145
+#define EXT_CSD_GP_SIZE_MULT_1_1	144
+#define EXT_CSD_GP_SIZE_MULT_1_0	143
 #define EXT_CSD_ENH_SIZE_MULT_2		142
 #define EXT_CSD_ENH_SIZE_MULT_1		141
 #define EXT_CSD_ENH_SIZE_MULT_0		140
@@ -105,6 +117,10 @@
 #define EXT_CSD_PART_CONFIG_ACC_ACK	  (0x40)
 #define EXT_CSD_PARTITIONING_EN		(1<<0)
 #define EXT_CSD_ENH_ATTRIBUTE_EN	(1<<1)
+#define EXT_CSD_ENH_4			(1<<4)
+#define EXT_CSD_ENH_3			(1<<3)
+#define EXT_CSD_ENH_2			(1<<2)
+#define EXT_CSD_ENH_1			(1<<1)
 #define EXT_CSD_ENH_USR			(1<<0)
 
 /* From kernel linux/mmc/core.h */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index b8afa74..941d29f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -494,6 +494,89 @@ int set_partitioning_setting_completed(int dry_run, const char * const device,
 	return 0;
 }
 
+int check_enhanced_area_total_limit(const char * const device, int fd)
+{
+	__u8 ext_csd[512];
+	__u32 regl;
+	unsigned long max_enh_area_sz, user_area_sz, enh_area_sz = 0;
+	unsigned long gp4_part_sz, gp3_part_sz, gp2_part_sz, gp1_part_sz;
+	unsigned int wp_sz, erase_sz;
+	int ret;
+
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		exit(1);
+	}
+	wp_sz = get_hc_wp_grp_size(ext_csd);
+	erase_sz = get_hc_erase_grp_size(ext_csd);
+
+	regl = (ext_csd[EXT_CSD_GP_SIZE_MULT_4_2] << 16) |
+		(ext_csd[EXT_CSD_GP_SIZE_MULT_4_1] << 8) |
+		ext_csd[EXT_CSD_GP_SIZE_MULT_4_0];
+	gp4_part_sz = 512l * regl * erase_sz * wp_sz;
+	if (ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] & EXT_CSD_ENH_4) {
+		enh_area_sz += gp4_part_sz;
+		printf("Enhanced GP4 Partition Size [GP_SIZE_MULT_4]: 0x%06x\n", regl);
+		printf(" i.e. %lu KiB\n", gp4_part_sz);
+	}
+
+	regl = (ext_csd[EXT_CSD_GP_SIZE_MULT_3_2] << 16) |
+		(ext_csd[EXT_CSD_GP_SIZE_MULT_3_1] << 8) |
+		ext_csd[EXT_CSD_GP_SIZE_MULT_3_0];
+	gp3_part_sz = 512l * regl * erase_sz * wp_sz;
+	if (ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] & EXT_CSD_ENH_3) {
+		enh_area_sz += gp3_part_sz;
+		printf("Enhanced GP3 Partition Size [GP_SIZE_MULT_3]: 0x%06x\n", regl);
+		printf(" i.e. %lu KiB\n", gp3_part_sz);
+	}
+
+	regl = (ext_csd[EXT_CSD_GP_SIZE_MULT_2_2] << 16) |
+		(ext_csd[EXT_CSD_GP_SIZE_MULT_2_1] << 8) |
+		ext_csd[EXT_CSD_GP_SIZE_MULT_2_0];
+	gp2_part_sz = 512l * regl * erase_sz * wp_sz;
+	if (ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] & EXT_CSD_ENH_2) {
+		enh_area_sz += gp2_part_sz;
+		printf("Enhanced GP2 Partition Size [GP_SIZE_MULT_2]: 0x%06x\n", regl);
+		printf(" i.e. %lu KiB\n", gp2_part_sz);
+	}
+
+	regl = (ext_csd[EXT_CSD_GP_SIZE_MULT_1_2] << 16) |
+		(ext_csd[EXT_CSD_GP_SIZE_MULT_1_1] << 8) |
+		ext_csd[EXT_CSD_GP_SIZE_MULT_1_0];
+	gp1_part_sz = 512l * regl * erase_sz * wp_sz;
+	if (ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] & EXT_CSD_ENH_1) {
+		enh_area_sz += gp1_part_sz;
+		printf("Enhanced GP1 Partition Size [GP_SIZE_MULT_1]: 0x%06x\n", regl);
+		printf(" i.e. %lu KiB\n", gp1_part_sz);
+	}
+
+	regl = (ext_csd[EXT_CSD_ENH_SIZE_MULT_2] << 16) |
+		(ext_csd[EXT_CSD_ENH_SIZE_MULT_1] << 8) |
+		ext_csd[EXT_CSD_ENH_SIZE_MULT_0];
+	user_area_sz = 512l * regl * erase_sz * wp_sz;
+	if (ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] & EXT_CSD_ENH_USR) {
+		enh_area_sz += user_area_sz;
+		printf("Enhanced User Data Area Size [ENH_SIZE_MULT]: 0x%06x\n", regl);
+		printf(" i.e. %lu KiB\n", user_area_sz);
+	}
+
+	regl = (ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT_2] << 16) |
+		(ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT_1] << 8) |
+		ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT_0];
+	max_enh_area_sz = 512l * regl * erase_sz * wp_sz;
+	printf("Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x%06x\n", regl);
+	printf(" i.e. %lu KiB\n", max_enh_area_sz);
+	if (enh_area_sz > max_enh_area_sz) {
+		fprintf(stderr,
+			"Programmed total enhanced size %lu KiB cannot exceed max enhanced area %lu KiB %s\n",
+			enh_area_sz, max_enh_area_sz, device);
+		return 1;
+	}
+
+	return 0;
+}
+
 int do_enh_area_set(int nargs, char **argv)
 {
 	__u8 value;
@@ -615,8 +698,8 @@ int do_enh_area_set(int nargs, char **argv)
 			EXT_CSD_ENH_SIZE_MULT_0, device);
 		exit(1);
 	}
-
-	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, EXT_CSD_ENH_USR);
+	value = ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE] | EXT_CSD_ENH_USR;
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, value);
 	if (ret) {
 		fprintf(stderr, "Could not write EXT_CSD_ENH_USR to "
 			"EXT_CSD[%d] in %s\n",
@@ -624,6 +707,10 @@ int do_enh_area_set(int nargs, char **argv)
 		exit(1);
 	}
 
+	ret = check_enhanced_area_total_limit(device, fd);
+	if (ret)
+		exit(1);
+
 	printf("Done setting ENH_USR area on %s\n", device);
 
 	if (!set_partitioning_setting_completed(dry_run, device, fd))
-- 
1.7.5.4

