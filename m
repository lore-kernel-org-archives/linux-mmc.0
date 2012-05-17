From: Saugata Das <saugata.das@stericsson.com>
Subject: [PATCH v2 2/2] [MMC-4.5] [MMC UTIL] Disable emulation
Date: Thu, 17 May 2012 16:32:22 +0530
Message-ID: <1337252542-25795-2-git-send-email-saugata.das@stericsson.com>
References: <1337252542-25795-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:60126 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932284Ab2EQLGY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 May 2012 07:06:24 -0400
In-Reply-To: <1337252542-25795-1-git-send-email-saugata.das@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, saugata.das@linaro.org, subhashj@codeaurora.org, arnd.bergmann@linaro.org, venkat@linaro.org, lporzio@micron.com, linkinjeon@gmail.com

From: Saugata Das <saugata.das@linaro.org>

In this patch, we add utility to disable emulation mode in the eMMC-4.5.
This is done to increase the data sector size to 4KB.

Signed-off-by: Saugata Das <saugata.das@linaro.org>

changes in v2:
	Removed extra blank lines around do_disable_512B_emulation
	Review rework based on comments from Subhash
---
 mmc.c      |    6 ++++++
 mmc.h      |   10 ++++++++++
 mmc_cmds.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |    1 +
 4 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/mmc.c b/mmc.c
index c27fc24..ebc7ab2 100644
--- a/mmc.c
+++ b/mmc.c
@@ -65,6 +65,12 @@ static struct Command commands[] = {
 		"Set the eMMC writeprotect status of <device>.",
 	  NULL
 	},
+	{ do_disable_512B_emulation, -1,
+	  "disable 512B emulation", "<device>\n"
+		"Set the eMMC data sector size to 4KB by disabling emulation <device>.",
+	  NULL
+	},
+
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 3af36f1..34c31d3 100644
--- a/mmc.h
+++ b/mmc.h
@@ -35,6 +35,16 @@
 #define EXT_CSD_PART_SWITCH_TIME	199
 #define EXT_CSD_BOOT_CFG		179
 #define EXT_CSD_BOOT_WP			173
+#define EXT_CSD_WR_REL_PARAM	166
+#define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
+#define EXT_CSD_USE_NATIVE_SECTOR	62 /* R/W */
+#define EXT_CSD_DATA_SECTOR_SIZE	61 /* R */
+
+/*
+ * WR_REL_PARAM field definitions
+ */
+#define HS_CTRL_REL	(1<<0)
+#define EN_REL_WR	(1<<2)
 
 /*
  * EXT_CSD field definitions
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 4562cef..4bc1fd6 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -168,6 +168,55 @@ int do_writeprotect_set(int nargs, char **argv)
 	return ret;
 }
 
+int do_disable_512B_emulation(int nargs, char **argv)
+{
+	__u8 ext_csd[512], native_sector_size, data_sector_size, wr_rel_param;
+	int fd, ret;
+	char *device;
+
+	CHECK(nargs != 2, "Usage: mmc </path/to/mmcblkX>\n", exit(1));
+
+	device = argv[1];
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
+	wr_rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
+	native_sector_size = ext_csd[EXT_CSD_NATIVE_SECTOR_SIZE];
+	data_sector_size = ext_csd[EXT_CSD_DATA_SECTOR_SIZE];
+
+	if (native_sector_size &&
+		!data_sector_size &&
+		(wr_rel_param & EN_REL_WR)) {
+		ret = write_extcsd_value(fd, EXT_CSD_USE_NATIVE_SECTOR, 1);
+
+		if (ret) {
+			fprintf(stderr, "Could not write 0x%02x to "
+					"EXT_CSD[%d] in %s\n",
+					1, EXT_CSD_BOOT_WP, device);
+			exit(1);
+		}
+		printf("MMC disable 512B emulation successful\n"
+				"Now reset the device to switch to 4KB "
+				"native sector mode\n");
+	} else if (native_sector_size && data_sector_size) {
+		printf("MMC already disabled 512B emulation mode\n");
+	} else {
+		printf("MMC does not support disabling 512B emulation mode\n");
+	}
+
+	return ret;
+}
+
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 66e9acb..56f46d7 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -19,3 +19,4 @@ int do_read_extcsd(int nargs, char **argv);
 int do_write_extcsd(int nargs, char **argv);
 int do_writeprotect_get(int nargs, char **argv);
 int do_writeprotect_set(int nargs, char **argv);
+int do_disable_512B_emulation(int nargs, char **argv);
-- 
1.7.4.3

