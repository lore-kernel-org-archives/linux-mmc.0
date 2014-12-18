From: Yuli Izrailov <yuli.izrailov@sandisk.com>
Subject: [PATCH] Support sending vendor specific commands.
Date: Thu, 18 Dec 2014 09:16:03 -0500
Message-ID: <1418912163-27948-1-git-send-email-yuli.izrailov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0054.outbound.protection.outlook.com ([65.55.169.54]:23503
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751116AbaLRQFj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Dec 2014 11:05:39 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: chris@printf.net, linux-mmc@vger.kernel.org, alex.lemberg@sandisk.com, Yuli Izrailov <yuli.izrailov@sandisk.com>

This change adds support to invoke eMMC
vendor specific commands (CMD60...CMD63).

New command was added: "do_manufacturer".

Only AC command type is supported at this stage,
ADTC command type is not.

AC - addressed commands, no data transfer.
ADTC - addressed data transfer commands.

Example:
mmc manufacturer 60 ac r1 0x40302010 /dev/block/mmcblk0

Signed-off-by: Yuli Izrailov <yuli.izrailov@sandisk.com>
---
 mmc.c      |   10 +++++++
 mmc.h      |    8 ++++++
 mmc_cmds.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |    1 +
 4 files changed, 111 insertions(+)

diff --git a/mmc.c b/mmc.c
index aeaedf6..5fc34fa 100644
--- a/mmc.c
+++ b/mmc.c
@@ -150,6 +150,16 @@ static struct Command commands[] = {
 		  "    mmc rpmb write-block /dev/mmcblk0rpmb 0x02 - -",
 	  NULL
 	},
+	{ do_manufacturer, 5,
+	  "manufacturer", "<cmd number> " "<cmd type> "
+		"<response type> " "<argument> " "<device>\n"
+		"Send a manufacturer specific command to the <device>.\n"
+		"<cmd number>    - [60 - 63]\n"
+		"<cmd type>      - [ac] (adtc is not implemented)\n"
+		"<response type> - [r1, r1b]\n"
+		"<argument>      - 4 byte arbitrary argument in hex",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 5fe5fec..314b1b4 100644
--- a/mmc.h
+++ b/mmc.h
@@ -37,6 +37,14 @@
 #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
 
 /*
+ * MMC manufacturer specific command definitions
+ */
+#define MMC_SEND_MANUFACTURER_1		60
+#define MMC_SEND_MANUFACTURER_2		61
+#define MMC_SEND_MANUFACTURER_3		62
+#define MMC_SEND_MANUFACTURER_4		63
+
+/*
  * EXT_CSD fields
  */
 #define EXT_CSD_S_CMD_SET		504
diff --git a/mmc_cmds.c b/mmc_cmds.c
index cea943f..7eeb6fc 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1677,3 +1677,95 @@ int do_rpmb_write_block(int nargs, char **argv)
 
 	return ret;
 }
+
+static int str_to_u32(const char *src, __u32 *dest, int base)
+{
+	char *endptr;
+	__u32 tmp;
+
+	tmp = strtoul(src, &endptr, base);
+	if (errno || *endptr)
+		return 1;
+
+	*dest = tmp;
+	return 0;
+}
+
+int do_manufacturer(int nargs, char **argv)
+{
+	int fd;
+	char *device;
+	unsigned int cmd_type;
+	unsigned int resp_type;
+	__u32 opcode;
+	__u32 arg;
+	struct mmc_ioc_cmd idata = {0};
+
+	/* Command number */
+	if (str_to_u32(argv[1], &opcode, 10) ||
+		(opcode != MMC_SEND_MANUFACTURER_1 &&
+		opcode  != MMC_SEND_MANUFACTURER_2 &&
+		opcode  != MMC_SEND_MANUFACTURER_3 &&
+		opcode  != MMC_SEND_MANUFACTURER_4)) {
+		fprintf(stderr, "%s: invalid argument '%s'\n",
+			argv[0], argv[1]);
+		exit(1);
+	}
+
+	/* Command type */
+	if (0 == strcasecmp("ac", argv[2])) {
+		cmd_type = MMC_CMD_AC;
+	}
+	else if (0 == strcasecmp("adtc", argv[2])) {
+		fprintf(stderr, "%s: 'adtc' is not implemented\n",
+			argv[0]);
+		exit(1);
+	}
+	else {
+		fprintf(stderr, "%s: invalid argument '%s'\n",
+			argv[0], argv[2]);
+		exit(1);
+	}
+
+	/* Response type */
+	if (0 == strcasecmp("r1b", argv[3])) {
+		resp_type = MMC_RSP_R1B;
+	}
+	else if (0 == strcasecmp("r1", argv[3])) {
+		resp_type = MMC_RSP_R1;
+	}
+	else {
+		fprintf(stderr, "%s: invalid argument '%s'\n",
+			argv[0], argv[3]);
+		exit(1);
+	}
+
+	/* Argument */
+	if (str_to_u32(argv[4], &arg, 16)) {
+		fprintf(stderr, "%s: invalid argument '%s'\n",
+			argv[0], argv[4]);
+		exit(1);
+	}
+
+	/* Device */
+	device = argv[5];
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open device");
+		exit(1);
+	}
+
+	/* Fill ioctl & send */
+	idata.opcode = opcode;
+	idata.arg    = arg;
+	idata.flags  = (cmd_type | resp_type);
+
+	if (ioctl(fd, MMC_IOC_CMD, &idata)) {
+		perror("ioctl");
+		exit(1);
+	}
+
+	close(fd);
+
+	return 0;
+}
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 9e625c9..de4ac7a 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -32,3 +32,4 @@ int do_rpmb_write_key(int nargs, char **argv);
 int do_rpmb_read_counter(int nargs, char **argv);
 int do_rpmb_read_block(int nargs, char **argv);
 int do_rpmb_write_block(int nargs, char **argv);
+int do_manufacturer(int nargs, char **argv);
-- 
1.7.9.5

