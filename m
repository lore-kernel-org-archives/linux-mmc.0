From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc-utils: Support enable/disable of eMMC H/W Reset function
Date: Fri, 19 Oct 2012 17:29:07 -0400
Message-ID: <87lif2tal8.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53887 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759345Ab2JSV3O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Oct 2012 17:29:14 -0400
Received: from c-76-24-28-220.hsd1.ma.comcast.net ([76.24.28.220] helo=octavius.laptop.org)
	by void.printf.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <cjb@laptop.org>)
	id 1TPK7x-0001xd-Us
	for linux-mmc@vger.kernel.org; Fri, 19 Oct 2012 22:29:10 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

(Note: one-time programmable fuse.)

$ mmc hwreset enable /dev/mmcblk0
$ mmc hwreset disable /dev/mmcblk0
---
 mmc.c      | 10 ++++++++++
 mmc.h      |  4 ++++
 mmc_cmds.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  2 ++
 4 files changed, 75 insertions(+)

diff --git a/mmc.c b/mmc.c
index 56f621c..a2de863 100644
--- a/mmc.c
+++ b/mmc.c
@@ -80,6 +80,16 @@ static struct Command commands[] = {
 		"Enable the eMMC BKOPS feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
 	  NULL
 	},
+	{ do_hwreset_en, -1,
+	  "hwreset enable", "<device>\n"
+		"Permanently enable the eMMC H/W Reset feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
+	  NULL
+	},
+	{ do_hwreset_dis, -1,
+	  "hwreset disable", "<device>\n"
+		"Permanently disable the eMMC H/W Reset feature on <device>.\nNOTE!  This is a one-time programmable (unreversible) change.",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 3d77b38..c863751 100644
--- a/mmc.h
+++ b/mmc.h
@@ -39,6 +39,7 @@
 #define EXT_CSD_BOOT_WP			173
 #define EXT_CSD_WR_REL_PARAM		166
 #define EXT_CSD_BKOPS_EN		163	/* R/W */
+#define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
 #define EXT_CSD_USE_NATIVE_SECTOR	62 /* R/W */
 #define EXT_CSD_DATA_SECTOR_SIZE	61 /* R */
@@ -70,6 +71,9 @@
 #define EXT_CSD_BOOT_CFG_ACK		(1<<6)
 #define EXT_CSD_BOOT_CFG_EN		(0x38)
 #define EXT_CSD_BOOT_CFG_ACC		(0x03)
+#define EXT_CSD_RST_N_EN_MASK		(0x03)
+#define EXT_CSD_HW_RESET_EN		(0x01)
+#define EXT_CSD_HW_RESET_DIS		(0x02)
 #define EXT_CSD_PART_CONFIG_ACC_MASK	  (0x7)
 #define EXT_CSD_PART_CONFIG_ACC_BOOT0	  (0x1)
 #define EXT_CSD_PART_CONFIG_ACC_BOOT1	  (0x2)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 05d7e13..b407f65 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -280,6 +280,65 @@ int do_write_boot_en(int nargs, char **argv)
 	return ret;
 }
 
+int do_hwreset(int value, int nargs, char **argv)
+{
+	__u8 ext_csd[512];
+	int fd, ret;
+	char *device;
+
+	CHECK(nargs != 2, "Usage: mmc hwreset enable </path/to/mmcblkX>\n",
+			  exit(1));
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
+	if ((ext_csd[EXT_CSD_RST_N_FUNCTION] & EXT_CSD_RST_N_EN_MASK) ==
+	    EXT_CSD_HW_RESET_EN) {
+		fprintf(stderr,
+			"H/W Reset is already permanently enabled on %s\n",
+			device);
+		exit(1);
+	}
+	if ((ext_csd[EXT_CSD_RST_N_FUNCTION] & EXT_CSD_RST_N_EN_MASK) ==
+	    EXT_CSD_HW_RESET_DIS) {
+		fprintf(stderr,
+			"H/W Reset is already permanently disabled on %s\n",
+			device);
+		exit(1);
+	}
+
+	ret = write_extcsd_value(fd, EXT_CSD_RST_N_FUNCTION, value);
+	if (ret) {
+		fprintf(stderr,
+			"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+			value, EXT_CSD_RST_N_FUNCTION, device);
+		exit(1);
+	}
+
+	return ret;
+}
+
+int do_hwreset_en(int nargs, char **argv)
+{
+	return do_hwreset(EXT_CSD_HW_RESET_EN, nargs, argv);
+}
+
+int do_hwreset_dis(int nargs, char **argv)
+{
+	return do_hwreset(EXT_CSD_HW_RESET_DIS, nargs, argv);
+}
+
 int do_write_bkops_en(int nargs, char **argv)
 {
 	__u8 ext_csd[512], value = 0;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 1dd4324..e52d622 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -22,3 +22,5 @@ int do_writeprotect_set(int nargs, char **argv);
 int do_disable_512B_emulation(int nargs, char **argv);
 int do_write_boot_en(int nargs, char **argv);
 int do_write_bkops_en(int nargs, char **argv);
+int do_hwreset_en(int nargs, char **argv);
+int do_hwreset_dis(int nargs, char **argv);
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
