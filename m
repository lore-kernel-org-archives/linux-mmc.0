From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH] mmc-utils: add the way to enable boot-partition
Date: Thu, 19 Apr 2012 10:58:37 +0200
Message-ID: <1334825917-2146-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:57173 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751501Ab2DSI6u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Apr 2012 04:58:50 -0400
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 03ABF1A7
	for <linux-mmc@vger.kernel.org>; Thu, 19 Apr 2012 08:58:43 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 684571F80
	for <linux-mmc@vger.kernel.org>; Thu, 19 Apr 2012 08:58:43 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

This adds a new option to enable the boot from eMMC
by writing to the 179 ext_csd register.

The example below shows as to enable the mmcblk0boot0
partition and also set/reset the ACK bit).

$ ./mmc booten 1 1 /dev/mmcblk0boot0
$ ./mmc extcsd read /dev/mmcblk0boot0 | grep PARTITION_CON
Boot configuration bytes [PARTITION_CONFIG: 0x49]

Reported-by: Youssef TRIKI <youssef.triki@st.com>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 mmc.c      |    5 ++++
 mmc.h      |    6 +++++
 mmc_cmds.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |    1 +
 4 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/mmc.c b/mmc.c
index c27fc24..c295885 100644
--- a/mmc.c
+++ b/mmc.c
@@ -65,6 +65,11 @@ static struct Command commands[] = {
 		"Set the eMMC writeprotect status of <device>.",
 	  NULL
 	},
+	{ do_write_boot_en, -3,
+	  "booten", "<boot_partition> " "<ack> " "<device>\n"
+		"Enable the boot partition for the <device>.",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 3af36f1..cedfae1 100644
--- a/mmc.h
+++ b/mmc.h
@@ -35,6 +35,7 @@
 #define EXT_CSD_PART_SWITCH_TIME	199
 #define EXT_CSD_BOOT_CFG		179
 #define EXT_CSD_BOOT_WP			173
+#define EXT_CSD_PART_CONFIG		179
 
 /*
  * EXT_CSD field definitions
@@ -52,6 +53,11 @@
 #define EXT_CSD_BOOT_CFG_ACK		(1<<6)
 #define EXT_CSD_BOOT_CFG_EN		(0x38)
 #define EXT_CSD_BOOT_CFG_ACC		(0x03)
+#define EXT_CSD_PART_CONFIG_ACC_MASK	  (0x7)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT0	  (0x1)
+#define EXT_CSD_PART_CONFIG_ACC_BOOT1	  (0x2)
+#define EXT_CSD_PART_CONFIG_ACC_USER_AREA (0x7)
+#define EXT_CSD_PART_CONFIG_ACC_ACK	  (0x40)
 
 /* From kernel linux/mmc/core.h */
 #define MMC_RSP_PRESENT	(1 << 0)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 4562cef..f588b17 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -168,6 +168,68 @@ int do_writeprotect_set(int nargs, char **argv)
 	return ret;
 }
 
+int do_write_boot_en(int nargs, char **argv)
+{
+	__u8 ext_csd[512];
+	__u8 value = 0;
+	int fd, ret;
+	char *device;
+	int boot_area, ack;
+
+	CHECK(nargs != 4, "Usage: mmc booten <partition_number> "
+			  "<ack> </path/to/mmcblkX>\n", exit(1));
+
+	boot_area = strtol(argv[1], NULL, 10);
+	ack = strtol(argv[2], NULL, 10);
+	device = argv[3];
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
+	value = ext_csd[EXT_CSD_PART_CONFIG];
+
+	switch (boot_area) {
+	case EXT_CSD_PART_CONFIG_ACC_BOOT0:
+		value |= (1 << 3);
+		value &= ~(3 << 4);
+		break;
+	case EXT_CSD_PART_CONFIG_ACC_BOOT1:
+		value |= (1 << 4);
+		value &= ~(1 << 3);
+		value &= ~(1 << 5);
+		break;
+	case EXT_CSD_PART_CONFIG_ACC_USER_AREA:
+		value |= (boot_area << 3);
+		break;
+	default:
+		fprintf(stderr, "Cannot enable the boot area\n");
+		exit(1);
+	}
+	if (ack)
+		value |= EXT_CSD_PART_CONFIG_ACC_ACK;
+	else
+		value &= ~EXT_CSD_PART_CONFIG_ACC_ACK;
+
+	ret = write_extcsd_value(fd, EXT_CSD_PART_CONFIG, value);
+	if (ret) {
+		fprintf(stderr, "Could not write 0x%02x to "
+			"EXT_CSD[%d] in %s\n",
+			value, EXT_CSD_PART_CONFIG, device);
+		exit(1);
+	}
+	return ret;
+}
+
+
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 66e9acb..264409a 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -19,3 +19,4 @@ int do_read_extcsd(int nargs, char **argv);
 int do_write_extcsd(int nargs, char **argv);
 int do_writeprotect_get(int nargs, char **argv);
 int do_writeprotect_set(int nargs, char **argv);
+int do_write_boot_en(int nargs, char **argv);
-- 
1.7.4.4

