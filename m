From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 4/8] Support SEND_STATUS command
Date: Thu, 30 May 2013 17:12:47 -0400
Message-ID: <4d9680506e1db390cc0003069e59ffb2bd816223.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:52468 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758308Ab3E3VNN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 17:13:13 -0400
Received: by mail-ie0-f180.google.com with SMTP id b11so1893216iee.39
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2013 14:13:13 -0700 (PDT)
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

mmc status get </path/to/mmcblkX>

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 mmc.c      |    5 +++++
 mmc.h      |    2 ++
 mmc_cmds.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |    1 +
 4 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/mmc.c b/mmc.c
index a2de863..c22ce9e 100644
--- a/mmc.c
+++ b/mmc.c
@@ -70,6 +70,11 @@ static struct Command commands[] = {
 		"Set the eMMC data sector size to 4KB by disabling emulation on\n<device>.",
 	  NULL
 	},
+	{ do_status_get, -1,
+	  "status get", "<device>\n"
+	  "Print the response to STATUS_SEND (CMD13).",
+	  NULL
+	},
 	{ do_write_boot_en, -3,
 	  "bootpart enable", "<boot_partition> " "<send_ack> " "<device>\n"
 		"Enable the boot partition for the <device>.\nTo receive acknowledgment of boot from the card set <send_ack>\nto 1, else set it to 0.",
diff --git a/mmc.h b/mmc.h
index 3420d7b..3577f42 100644
--- a/mmc.h
+++ b/mmc.h
@@ -24,6 +24,8 @@
 /* From kernel linux/mmc/mmc.h */
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
+#define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
+#define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
 
 /*
diff --git a/mmc_cmds.c b/mmc_cmds.c
index dd7498e..a2ccc1d 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -72,6 +72,25 @@ int write_extcsd_value(int fd, __u8 index, __u8 value)
 	return ret;
 }
 
+int send_status(int fd, __u32 *response)
+{
+	int ret = 0;
+	struct mmc_ioc_cmd idata;
+
+	memset(&idata, 0, sizeof(idata));
+	idata.opcode = MMC_SEND_STATUS;
+	idata.arg = (1 << 16);
+	idata.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	ret = ioctl(fd, MMC_IOC_CMD, &idata);
+	if (ret)
+	perror("ioctl");
+
+	*response = idata.response[0];
+
+	return ret;
+}
+
 void print_writeprotect_status(__u8 *ext_csd)
 {
 	__u8 reg;
@@ -377,6 +396,34 @@ int do_write_bkops_en(int nargs, char **argv)
 	return ret;
 }
 
+int do_status_get(int nargs, char **argv)
+{
+	__u32 response;
+	int fd, ret;
+	char *device;
+
+	CHECK(nargs != 2, "Usage: mmc status get </path/to/mmcblkX>\n",
+		exit(1));
+
+	device = argv[1];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = send_status(fd, &response);
+	if (ret) {
+		fprintf(stderr, "Could not read response to SEND_STATUS from %s\n", device);
+		exit(1);
+	}
+
+	printf("SEND_STATUS response: 0x%08x\n", response);
+
+	return ret;
+}
+
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index e52d622..3a754bf 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -24,3 +24,4 @@ int do_write_boot_en(int nargs, char **argv);
 int do_write_bkops_en(int nargs, char **argv);
 int do_hwreset_en(int nargs, char **argv);
 int do_hwreset_dis(int nargs, char **argv);
+int do_status_get(int nargs, char **argv);
-- 
1.7.3.5

