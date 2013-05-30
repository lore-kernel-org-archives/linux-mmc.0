From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 8/8] support setting the OTP enhanced user area parameters
Date: Thu, 30 May 2013 17:12:51 -0400
Message-ID: <99692e8658dc8e2d86e683e241273f30ba2aa395.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:45507 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758369Ab3E3VNT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 17:13:19 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so1839925ief.26
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2013 14:13:19 -0700 (PDT)
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 mmc.c      |    5 ++
 mmc.h      |    3 +
 mmc_cmds.c |  170 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 mmc_cmds.h |    1 +
 4 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/mmc.c b/mmc.c
index c22ce9e..30e3ce0 100644
--- a/mmc.c
+++ b/mmc.c
@@ -70,6 +70,11 @@ static struct Command commands[] = {
 		"Set the eMMC data sector size to 4KB by disabling emulation on\n<device>.",
 	  NULL
 	},
+	{ do_enh_area_set, -4,
+	  "enh_area set", "<-y|-n> " "<start KiB> " "<length KiB> " "<device>\n"
+		"Enable the enhanced user area for the <device>. Dry-run only unless -y is passed.",
+	  NULL
+	},
 	{ do_status_get, -1,
 	  "status get", "<device>\n"
 	  "Print the response to STATUS_SEND (CMD13).",
diff --git a/mmc.h b/mmc.h
index 5385e0e..f16bd89 100644
--- a/mmc.h
+++ b/mmc.h
@@ -42,11 +42,13 @@
 #define EXT_CSD_PART_SWITCH_TIME	199
 #define EXT_CSD_BOOT_CFG		179
 #define EXT_CSD_PART_CONFIG		179
+#define EXT_CSD_ERASE_GROUP_DEF		175
 #define EXT_CSD_BOOT_WP			173
 #define EXT_CSD_WR_REL_PARAM		166
 #define EXT_CSD_BKOPS_EN		163	/* R/W */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_PARTITIONING_SUPPORT	160	/* RO */
+#define EXT_CSD_PARTITIONS_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SETTING_COMPLETED	155	/* R/W */
 #define EXT_CSD_ENH_SIZE_MULT_2		142
 #define EXT_CSD_ENH_SIZE_MULT_1		141
@@ -96,6 +98,7 @@
 #define EXT_CSD_PART_CONFIG_ACC_ACK	  (0x40)
 #define EXT_CSD_PARTITIONING_EN		(1<<0)
 #define EXT_CSD_ENH_ATTRIBUTE_EN	(1<<1)
+#define EXT_CSD_ENH_USR		(1<<0)
 
 /* From kernel linux/mmc/core.h */
 #define MMC_RSP_PRESENT	(1 << 0)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 37bb211..6993ac4 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -449,6 +449,172 @@ unsigned int get_hc_erase_grp_size(__u8 *ext_csd)
 	return ext_csd[224];
 }
 
+int do_enh_area_set(int nargs, char **argv)
+{
+	__u8 value;
+	__u8 ext_csd[512];
+	int fd, ret;
+	char *device;
+	int dry_run = 1;
+	unsigned int start_kib, length_kib, enh_start_addr, enh_size_mult;
+	unsigned long align;
+
+	CHECK(nargs != 5, "Usage: mmc enh_area set <-y|-n> <start KiB> <length KiB> "
+			  "</path/to/mmcblkX>\n", exit(1));
+
+	if (!strcmp("-y", argv[1]))
+		dry_run = 0;
+
+	start_kib = strtol(argv[2], NULL, 10);
+	length_kib = strtol(argv[3], NULL, 10);
+	device = argv[4];
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
+	/* assert ENH_ATTRIBUTE_EN */
+	if (!(ext_csd[EXT_CSD_PARTITIONING_SUPPORT] & EXT_CSD_ENH_ATTRIBUTE_EN))
+	{
+		printf(" Device cannot have enhanced tech.\n");
+		exit(1);
+	}
+
+	/* assert not PARTITION_SETTING_COMPLETED */
+	if (ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED])
+	{
+		printf(" Device is already partitioned\n");
+		exit(1);
+	}
+
+	align = 512l * get_hc_wp_grp_size(ext_csd) * get_hc_erase_grp_size(ext_csd);
+
+	enh_size_mult = (length_kib + align/2l) / align;
+
+	enh_start_addr = start_kib * 1024 / (is_blockaddresed(ext_csd) ? 512 : 1);
+	enh_start_addr /= align;
+	enh_start_addr *= align;
+
+	/* set EXT_CSD_ERASE_GROUP_DEF bit 0 */
+	ret = write_extcsd_value(fd, EXT_CSD_ERASE_GROUP_DEF, 0x1);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x1 to "
+			"EXT_CSD[%d] in %s\n",
+			EXT_CSD_ERASE_GROUP_DEF, device);
+		exit(1);
+	}
+
+	/* write to ENH_START_ADDR and ENH_SIZE_MULT and PARTITIONS_ATTRIBUTE's ENH_USR bit */
+	value = (enh_start_addr >> 24) & 0xff;
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_3, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n", value,
+			EXT_CSD_ENH_START_ADDR_3, device);
+		exit(1);
+	}
+	value = (enh_start_addr >> 16) & 0xff;
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_2, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n", value,
+			EXT_CSD_ENH_START_ADDR_2, device);
+		exit(1);
+	}
+	value = (enh_start_addr >> 8) & 0xff;
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_1, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n", value,
+			EXT_CSD_ENH_START_ADDR_1, device);
+		exit(1);
+	}
+	value = enh_start_addr & 0xff;
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_START_ADDR_0, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n", value,
+			EXT_CSD_ENH_START_ADDR_0, device);
+		exit(1);
+	}
+
+	value = (enh_size_mult >> 16) & 0xff;
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_2, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n", value,
+			EXT_CSD_ENH_SIZE_MULT_2, device);
+		exit(1);
+	}
+	value = (enh_size_mult >> 8) & 0xff;
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_1, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n", value,
+			EXT_CSD_ENH_SIZE_MULT_1, device);
+		exit(1);
+	}
+	value = enh_size_mult & 0xff;
+	ret = write_extcsd_value(fd, EXT_CSD_ENH_SIZE_MULT_0, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n", value,
+			EXT_CSD_ENH_SIZE_MULT_0, device);
+		exit(1);
+	}
+
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITIONS_ATTRIBUTE, EXT_CSD_ENH_USR);
+	if (ret) {
+		fprintf(stderr, "Could not write EXT_CSD_ENH_USR to "
+			"EXT_CSD[%d] in %s\n",
+			EXT_CSD_PARTITIONS_ATTRIBUTE, device);
+		exit(1);
+	}
+
+	if (dry_run)
+	{
+		fprintf(stderr, "NOT setting PARTITION_SETTING_COMPLETED\n");
+		exit(1);
+	}
+
+	fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
+	ret = write_extcsd_value(fd, EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x1 to "
+			"EXT_CSD[%d] in %s\n",
+			EXT_CSD_PARTITION_SETTING_COMPLETED, device);
+		exit(1);
+	}
+
+	__u32 response;
+	ret = send_status(fd, &response);
+	if (ret) {
+		fprintf(stderr, "Could not get response to SEND_STATUS from %s\n", device);
+		exit(1);
+	}
+
+	if (response & R1_SWITCH_ERROR)
+	{
+		fprintf(stderr, "Setting ENH_USR area failed on %s\n", device);
+		exit(1);
+	}
+
+	fprintf(stderr, "Setting ENH_USR area on %s SUCCESS\n", device);
+	fprintf(stderr, "Device power cycle needed for settings to take effect.\n"
+		"Confirm that PARTITION_SETTING_COMPLETED bit is set using 'extcsd read'"
+		"after power cycle\n");
+
+	return 0;
+}
+
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
@@ -733,7 +899,7 @@ int do_read_extcsd(int nargs, char **argv)
 	printf("Boot bus Conditions [BOOT_BUS_CONDITIONS: 0x%02x]\n",
 		ext_csd[177]);
 	printf("High-density erase group definition"
-		" [ERASE_GROUP_DEF: 0x%02x]\n", ext_csd[175]);
+		" [ERASE_GROUP_DEF: 0x%02x]\n", ext_csd[EXT_CSD_ERASE_GROUP_DEF]);
 
 	print_writeprotect_status(ext_csd);
 
@@ -776,7 +942,7 @@ int do_read_extcsd(int nargs, char **argv)
 		printf(" i.e. %lu KiB\n", 512l * reg * wp_sz * erase_sz);
 
 		printf("Partitions attribute [PARTITIONS_ATTRIBUTE]: 0x%02x\n",
-			ext_csd[156]);
+			ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE]);
 		reg = ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED];
 		printf("Partitioning Setting"
 			" [PARTITION_SETTING_COMPLETED]: 0x%02x\n",
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 3a754bf..bb1a9ca 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -25,3 +25,4 @@ int do_write_bkops_en(int nargs, char **argv);
 int do_hwreset_en(int nargs, char **argv);
 int do_hwreset_dis(int nargs, char **argv);
 int do_status_get(int nargs, char **argv);
+int do_enh_area_set(int nargs, char **argv);
-- 
1.7.3.5

