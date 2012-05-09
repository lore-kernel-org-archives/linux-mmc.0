From: Saugata Das <saugata.das@stericsson.com>
Subject: [RFC 2/2] [MMC-4.5] [MMC UTIL] Disable emulation
Date: Wed, 9 May 2012 20:18:21 +0530
Message-ID: <1336574901-26579-2-git-send-email-saugata.das@stericsson.com>
References: <1336574901-26579-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:58268 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751133Ab2EIOsm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 May 2012 10:48:42 -0400
In-Reply-To: <1336574901-26579-1-git-send-email-saugata.das@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, saugata.das@linaro.org

From: Saugata Das <saugata.das@linaro.org>

In this patch, we add utility to disable emulation mode in the eMMC-4.5.
This is done to increase the data sector size to 4KB.

Signed-off-by: Saugata Das <saugata.das@linaro.org>
---
 mmc.c      |    6 ++++++
 mmc.h      |    2 ++
 mmc_cmds.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |    1 +
 4 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/mmc.c b/mmc.c
index c27fc24..43b95aa 100644
--- a/mmc.c
+++ b/mmc.c
@@ -65,6 +65,12 @@ static struct Command commands[] = {
 		"Set the eMMC writeprotect status of <device>.",
 	  NULL
 	},
+	{ do_disable_emulation, -1,
+	  "disable emulation", "<device>\n"
+		"Set the eMMC data sector size to 4KB by disabling emulation <device>.",
+	  NULL
+	},
+
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 3af36f1..a2050fa 100644
--- a/mmc.h
+++ b/mmc.h
@@ -35,6 +35,8 @@
 #define EXT_CSD_PART_SWITCH_TIME	199
 #define EXT_CSD_BOOT_CFG		179
 #define EXT_CSD_BOOT_WP			173
+#define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
+#define EXT_CSD_NATIVE_SECTOR	62 /* R/W */
 
 /*
  * EXT_CSD field definitions
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 4562cef..2713ccd 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -168,6 +168,48 @@ int do_writeprotect_set(int nargs, char **argv)
 	return ret;
 }
 
+
+int do_disable_emulation(int nargs, char **argv)
+{
+	__u8 ext_csd[512], native_sector_size;
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
+	native_sector_size = ext_csd[EXT_CSD_NATIVE_SECTOR_SIZE];
+
+	if (native_sector_size) {
+		ret = write_extcsd_value(fd, EXT_CSD_NATIVE_SECTOR, 1);
+
+		if (ret) {
+			fprintf(stderr, "Could not write 0x%02x to "
+				"EXT_CSD[%d] in %s\n",
+				1, EXT_CSD_BOOT_WP, device);
+			exit(1);
+		}
+	} else {
+		printf("MMC does not support 4KB native sector\n");
+	}
+
+	return ret;
+}
+
+
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 66e9acb..dd107d5 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -19,3 +19,4 @@ int do_read_extcsd(int nargs, char **argv);
 int do_write_extcsd(int nargs, char **argv);
 int do_writeprotect_get(int nargs, char **argv);
 int do_writeprotect_set(int nargs, char **argv);
+int do_disable_emulation(int nargs, char **argv);
-- 
1.7.4.3

