From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc-util: add the method to enable the bkops
Date: Tue, 17 Jul 2012 11:44:09 +0900
Message-ID: <5004D179.6080706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14058 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab2GQCoc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jul 2012 22:44:32 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M7A00463A9XTF10@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 17 Jul 2012 11:44:26 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M7A00JXIAA1BEC0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 17 Jul 2012 11:44:25 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Maya Erez <merez@codeaurora.org>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>

This patch added the method to enable the bkops.
In ext_csd register, BKOPS_EN bit is one-time programable.
So if you want to use the bkops, use the this command.

<usage>
#mmc bkops enable /dev/mmcblk0

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 mmc.c      |    5 +++++
 mmc.h      |    7 +++++++
 mmc_cmds.c |   39 +++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |    1 +
 4 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/mmc.c b/mmc.c
index 379d667..3a12653 100644
--- a/mmc.c
+++ b/mmc.c
@@ -75,6 +75,11 @@ static struct Command commands[] = {
 		"Enable the boot partition for the <device>.\nTo receive acknowledgment of boot from the card set <send_ack>\nto 1, else set it to 0.",
 	  NULL
 	},
+	{ do_write_bkops_en, -1,
+	  "bkops enable", "<device>\n"
+		"Enable the eMMC BKOPS feature enable on <device>.",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 0a521a8..3d77b38 100644
--- a/mmc.h
+++ b/mmc.h
@@ -31,12 +31,14 @@
  */
 #define EXT_CSD_S_CMD_SET		504
 #define EXT_CSD_HPI_FEATURE		503
+#define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
 #define EXT_CSD_BOOT_INFO		228	/* R/W */
 #define EXT_CSD_PART_SWITCH_TIME	199
 #define EXT_CSD_BOOT_CFG		179
 #define EXT_CSD_PART_CONFIG		179
 #define EXT_CSD_BOOT_WP			173
 #define EXT_CSD_WR_REL_PARAM		166
+#define EXT_CSD_BKOPS_EN		163	/* R/W */
 #define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
 #define EXT_CSD_USE_NATIVE_SECTOR	62 /* R/W */
 #define EXT_CSD_DATA_SECTOR_SIZE	61 /* R */
@@ -48,6 +50,11 @@
 #define EN_REL_WR	(1<<2)
 
 /*
+ * BKOPS_EN field definition
+ */
+#define BKOPS_ENABLE	(1<<0)
+
+/*
  * EXT_CSD field definitions
  */
 #define EXT_CSD_HPI_SUPP		(1<<0)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 90619db..271d1e4 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -280,6 +280,45 @@ int do_write_boot_en(int nargs, char **argv)
 	return ret;
 }
 
+int do_write_bkops_en(int nargs, char **argv)
+{
+	__u8 ext_csd[512], value = 0;
+	int fd, ret;
+	char *device;
+
+	CHECK(nargs != 2, "Usage: mmc bkops enable </path/to/mmcblkX>\n",
+			exit(1));
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
+	if (!(ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)) {
+		fprintf(stderr, "Didn't support BKOPS from %s\n", device);
+		exit(1);
+	}
+
+	ret = write_extcsd_value(fd, EXT_CSD_BKOPS_EN, BKOPS_ENABLE);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n",
+			value, EXT_CSD_BKOPS_EN, device);
+		exit(1);
+	}
+
+	return ret;
+}
+
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 2eb1df5..1dd4324 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -21,3 +21,4 @@ int do_writeprotect_get(int nargs, char **argv);
 int do_writeprotect_set(int nargs, char **argv);
 int do_disable_512B_emulation(int nargs, char **argv);
 int do_write_boot_en(int nargs, char **argv);
+int do_write_bkops_en(int nargs, char **argv);
-- 
1.7.4.1
