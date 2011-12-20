From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: [PATCH 1/1] mmc: User Application for testing SD/MMC Commands and extra IOCTL Command for MMC card reset
Date: Tue, 20 Dec 2011 19:24:48 +0530
Message-ID: <1324389288-23217-1-git-send-email-shashidharh@vayavyalabs.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35213 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab1LTNzD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2011 08:55:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <awarkentin@vmware.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Venkatraman S <svenkatr@ti.com>, linux-doc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

The patch adds the user space application that uses the MMC ioctl to test the SD/MMC
commands. It also has the enhancement for an extra IOCTL command for resetting the card.
The extra ioctl becomes necessary since the user application implementation expects the card
to be in idle state independent of current state.To run the test module the mmc_block and
driver modules must be inserted first.

Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
---
 Documentation/mmc/cmd_test/Makefile   |    9 ++
 Documentation/mmc/cmd_test/README     |   10 ++
 Documentation/mmc/cmd_test/cmd_test.c |  245 +++++++++++++++++++++++++++++++++
 Documentation/mmc/cmd_test/cmd_test.h |   42 ++++++
 Documentation/mmc/cmd_test/config     |  130 +++++++++++++++++
 drivers/mmc/card/block.c              |   43 ++++++
 include/linux/mmc/ioctl.h             |    1 +
 7 files changed, 480 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/mmc/cmd_test/Makefile
 create mode 100644 Documentation/mmc/cmd_test/README
 create mode 100644 Documentation/mmc/cmd_test/cmd_test.c
 create mode 100644 Documentation/mmc/cmd_test/cmd_test.h
 create mode 100644 Documentation/mmc/cmd_test/config

diff --git a/Documentation/mmc/cmd_test/Makefile b/Documentation/mmc/cmd_test/Makefile
new file mode 100644
index 0000000..5d2b85e
--- /dev/null
+++ b/Documentation/mmc/cmd_test/Makefile
@@ -0,0 +1,9 @@
+#
+# Makefile for the User Space Application for Testing Commands
+#
+all:CMD_TEST
+CMD_TEST:	cmd_test.o
+	 	gcc cmd_test.c -o cmd_test
+
+clean:
+	rm cmd_test.o cmd_test
diff --git a/Documentation/mmc/cmd_test/README b/Documentation/mmc/cmd_test/README
new file mode 100644
index 0000000..e0d03ab
--- /dev/null
+++ b/Documentation/mmc/cmd_test/README
@@ -0,0 +1,10 @@
+The Command Test Module implements the user space application for
+testing of the SD/MMC Commands.
+
+To Run the Module
+a. Do a Make
+b. Run the executable by name cmd_test
+c. The program prompts for the Command index
+d. Enter the Command number to be tested.
+e. The command's response and status will be displayed on terminal.
+
diff --git a/Documentation/mmc/cmd_test/cmd_test.c b/Documentation/mmc/cmd_test/cmd_test.c
new file mode 100644
index 0000000..ce24c84
--- /dev/null
+++ b/Documentation/mmc/cmd_test/cmd_test.c
@@ -0,0 +1,245 @@
+/*
+ * linux/Documentation/mmc/cmd_test/cmd_test.c
+ *
+ * This is a user space application that can be used to test few of the
+ * the SD/MMC commands.
+ * Author: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
+ * Copyright 2011 VayavyaLabs Pvt. Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <linux/mmc/ioctl.h>
+#include <sys/ioctl.h>
+#include <string.h>
+#include <stdlib.h>
+#include "cmd_test.h"
+
+
+static struct mmc_ioc_cmd mmc_local_cmd = {0};
+
+
+int main(void)
+{
+	int fd, ret_val, opcode, opc, i;
+	FILE *fp;
+	unsigned int *shifted_rca;
+	char stream[80];
+	char *local = NULL;
+	char *lhs_str = NULL;
+	char *rhs_str = NULL;
+	char *ret_str = NULL;
+	struct cmd **cmd_ptr = NULL;
+	struct cmd *test_cmd = NULL;
+
+	printf("Please Enter the Command Index to be tested\n");
+	scanf("%d", &opcode);
+	if (opcode > 55)
+		printf("\nERROR: Command not Supported\n"\
+			"Please Enter Command Index below 55\n");
+	cmd_ptr = calloc(55 , sizeof(struct cmd));
+	fp = fopen("config", "r");
+
+	while (NULL != fgets(stream, 80, fp)) {
+		if ((stream[0] == '#') || (stream[0] == '}')
+			|| (stream[0] == '{') || (stream[0] == '\n'))
+			continue;
+		local = strdup(stream);
+		lhs_str = strtok(local, " ");
+		rhs_str = strtok(NULL, " ");
+		remove_newline(rhs_str);
+		if (!strcmp(lhs_str, "OPCODE")) {
+			opc = atoi(rhs_str);
+			cmd_ptr[opc] = calloc(1, sizeof(struct cmd));
+			cmd_ptr[opc]->opcode = opc;
+		} else if (!strcmp(lhs_str, "ARG")) {
+			if (!strcmp(rhs_str, "SHIFTED_RCA"))
+				cmd_ptr[opc]->arg = IS_RCA;
+			else
+				cmd_ptr[opc]->arg = atoi(rhs_str);
+		} else if (!strcmp(lhs_str, "FLAGS")) {
+			cmd_ptr[opc]->flags = rhs_str;
+		} else if (!strcmp(lhs_str, "PRE_SEQ")) {
+			if (strcmp(rhs_str, "NONE")) {
+				for (i = 0, (ret_str = strtok(rhs_str, ","));
+					(ret_str != NULL); i++,
+					(ret_str = strtok(NULL, ","))) {
+					cmd_ptr[opc]->pre_seq[i]
+						= cmd_ptr[atoi(ret_str)];
+				}
+			}
+		}
+	}
+
+	fd = open(DEV_NAME, O_RDWR);
+	if (fd < 0) {
+		printf("cannot open device file: %s\n", DEV_NAME);
+		return -1;
+	}
+
+	ret_val = ioctl(fd, MMC_IOC_CMD_RESET);
+	if (ret_val)
+		printf("\nERROR: Card reset Failed");
+	if (cmd_ptr[opcode] != NULL) {
+		test_cmd = cmd_ptr[opcode];
+		sleep(2);
+		if (test_cmd != NULL) {
+			shifted_rca = calloc(1, sizeof(unsigned int));
+			send_pre_seq(test_cmd->pre_seq, fd, shifted_rca);
+			send_cmd(test_cmd, fd, shifted_rca);
+		}
+	} else {
+		printf("\nError: Command Not Supported by the Module\n");
+	}
+
+	close(fd);
+	fclose(fp);
+
+	return 0;
+}
+
+void send_pre_seq(struct cmd **pre_seq, int fd, unsigned int *shifted_rca)
+{
+	int i;
+	if (pre_seq[0] != NULL) {
+		for (i = 0; (pre_seq[i] != NULL); i++) {
+			if (pre_seq[i]->opcode == 41)
+				send_cmd41(pre_seq[i], fd);
+			else
+					send_cmd(pre_seq[i], fd, shifted_rca);
+		}
+	}
+}
+
+/* Helper Functions */
+
+/* Forms the command structure and invokes the ioctl for any command */
+void send_cmd(struct cmd *cmd_ptr, int fd, unsigned int *shifted_rca)
+{
+	int ret_val;
+
+	mmc_local_cmd.opcode = cmd_ptr->opcode;
+	if (cmd_ptr->arg == IS_RCA)
+		mmc_local_cmd.arg = *shifted_rca;
+	else
+		mmc_local_cmd.arg = cmd_ptr->arg;
+	mmc_local_cmd.flags =  get_resp_type(cmd_ptr->flags);
+	mmc_local_cmd.write_flag = 2;
+	mmc_local_cmd.data_ptr = (int)0;
+	ret_val = ioctl(fd, MMC_IOC_CMD, &mmc_local_cmd);
+	/* some delay for card to respond */
+	sleep(2);
+	if (ret_val)
+		printf("\nERROR: Sending Command %d Failed"
+			, mmc_local_cmd.opcode);
+	else {
+		printf("\nSending Command %d Successful", mmc_local_cmd.opcode);
+		printf("\nCMD RESPONSES are RESP[0] %x"
+			"\n                  RESP[1] %x"
+			"\n                  RESP[2] %x"
+			"\n                  RESP[3] %x\n"
+			, mmc_local_cmd.response[0]
+			, mmc_local_cmd.response[1]
+			, mmc_local_cmd.response[2]
+			, mmc_local_cmd.response[3]);
+	}
+	if (cmd_ptr->opcode == 3)
+		*shifted_rca = mmc_local_cmd.response[0];
+}
+
+unsigned int get_resp_type(char *rsp_str)
+{
+	unsigned int ret;
+
+	if (!strcmp(rsp_str, "MMC_RSP_R1"))
+		ret = MMC_RSP_R1;
+	else if (!strcmp(rsp_str, "MMC_RSP_R2"))
+		ret = MMC_RSP_R2;
+	else if (!strcmp(rsp_str, "MMC_RSP_R3"))
+		ret = MMC_RSP_R3;
+	else if (!strcmp(rsp_str, "MMC_RSP_R7"))
+		ret = MMC_RSP_R7;
+	else if (!strcmp(rsp_str, "MMC_RSP_R1B"))
+		ret = MMC_RSP_R1B;
+	else if (!strcmp(rsp_str, "MMC_RSP_NONE"))
+		ret = 0;
+	else {
+		printf("Incorrect response Type");
+		exit(1);
+	}
+	return ret;
+}
+
+/* Special case where CMD 55 and 41 are sent recurssively */
+void send_cmd41(struct cmd *tmp_cmd, int fd)
+{
+	int ret_val = 0;
+
+	if ((mmc_local_cmd.response[0] & 0xff) == 0xAA) {
+		int timeout = 100;
+		mmc_local_cmd.arg = 0;
+		do {
+			mmc_local_cmd.opcode = 55,
+			mmc_local_cmd.flags = MMC_RSP_R1,
+			mmc_local_cmd.arg = 0,
+			mmc_local_cmd.write_flag = 2,
+			mmc_local_cmd.data_ptr = (int)0;
+			ret_val = ioctl(fd, MMC_IOC_CMD, &mmc_local_cmd);
+			if (ret_val) {
+				printf("\nERROR: Sending Command %d Failed"
+					, mmc_local_cmd.opcode);
+				break;
+			} else {
+			printf("\nSending Command %d Successful"
+				, mmc_local_cmd.opcode);
+			printf("\nCMD RESPONSES are RESP[0] %x"
+				"\n                  RESP[1] %x"
+				"\n                  RESP[2] %x"
+				"\n                  RESP[3] %x\n"
+				, mmc_local_cmd.response[0]
+				, mmc_local_cmd.response[1]
+				, mmc_local_cmd.response[2]
+				, mmc_local_cmd.response[3]);
+			}
+			mmc_local_cmd.opcode = tmp_cmd->opcode;
+			mmc_local_cmd.flags = MMC_RSP_R3;
+			mmc_local_cmd.arg
+				= ((0x00100000 | 0x00200000) & 0xff8000);
+			mmc_local_cmd.write_flag = 2;
+			mmc_local_cmd.data_ptr = (int)0;
+			ret_val = ioctl(fd, MMC_IOC_CMD, &mmc_local_cmd);
+
+			sleep(1);
+			if (ret_val)
+				printf("\nERROR: Sending Command %d Failed"
+					, mmc_local_cmd.opcode);
+			else {
+				printf("\nSending Command %d Successful"
+					, mmc_local_cmd.opcode);
+				printf("\nCMD RESPONSES are RESP[0] %x"
+					"\n                  RESP[1] %x"
+					"\n                  RESP[2] %x"
+					"\n                  RESP[3] %x\n"
+					, mmc_local_cmd.response[0]
+					, mmc_local_cmd.response[1]
+					, mmc_local_cmd.response[2]
+					, mmc_local_cmd.response[3]);
+			}
+
+		} while ((!(mmc_local_cmd.response[0] & (1 << 31))) && --timeout);
+	}
+}
+
+void remove_newline(char *str)
+{
+	int len;
+
+		len = strlen(str);
+		if (str[len-1] == '\n')
+			str[len-1] = '\0';
+}
diff --git a/Documentation/mmc/cmd_test/cmd_test.h b/Documentation/mmc/cmd_test/cmd_test.h
new file mode 100644
index 0000000..a7858a7
--- /dev/null
+++ b/Documentation/mmc/cmd_test/cmd_test.h
@@ -0,0 +1,42 @@
+/*
+ *  linux/Documentation/mmc/cmd_test/cmd_test.h
+ *
+ * Author: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
+ * Copyright 2011 VayavyaLabs Pvt. Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+/* TODO change the DEV_NAME  by the name card is mounted as */
+#define DEV_NAME "/dev/mmcblk0"
+#define MMC_BLOCK_MAJOR 179
+#define MMC_RSP_R2  ((1 << 0) | (1 << 1) | (1 << 2))
+#define MMC_RSP_R1  ((1 << 0) | (1 << 2) | (1 << 4))
+#define MMC_RSP_R1B ((1 << 0) | (1 << 2) | (1 << 4) | (1 << 3))
+#define MMC_RSP_R7  ((1 << 0) | (1 << 1) | (1 << 4))
+#define MMC_RSP_R3  (1 << 0)
+#define MMC_RSP_NONE 0
+#define IS_RCA -1
+#define MAX_PRE_CNT 20
+
+/* The command list that will hold the
+ * info captured from config file
+ */
+struct cmd {
+	unsigned int	opcode;
+	unsigned int	arg;
+	char		*flags;
+	unsigned short  special_case;
+	struct cmd	*pre_seq[MAX_PRE_CNT];
+};
+
+/* Function Prototypes of Helper functions */
+void send_cmd41(struct cmd *tmp_cmd, int fd);
+void send_cmd(struct cmd *test_cmd, int fd, unsigned int *shifted_rca);
+unsigned int get_resp_type(char *rsp_str);
+void remove_newline(char *str);
+void send_pre_seq(struct cmd **pre_seq, int fd, unsigned int *shifted_rca);
+
diff --git a/Documentation/mmc/cmd_test/config b/Documentation/mmc/cmd_test/config
new file mode 100644
index 0000000..641f774
--- /dev/null
+++ b/Documentation/mmc/cmd_test/config
@@ -0,0 +1,130 @@
+########################################################
+# Config File for the SD/MMC Command Testing
+#
+# Please Note that all the pre sequence commands must
+# be defined before using them.
+# Author: Shashidhar Hiremath
+# Copyright 2011 VayavyaLabs Pvt. Ltd
+#
+# Please maintain fix sequence for the Argument
+# Order for each Command
+########################################################
+
+{
+  OPCODE 0
+  ARG  0
+  FLAGS MMC_RSP_NONE
+  PRE_SEQ NONE
+}
+
+{
+  OPCODE 5
+  ARG SHIFTED_RCA
+  FLAGS MMC_RSP_R1B
+  PRE_SEQ NONE
+}
+
+{
+  OPCODE 8
+  ARG 426
+  FLAGS MMC_RSP_R7
+  PRE_SEQ 0
+}
+
+{
+  OPCODE 55
+  ARG 0
+  FLAGS MMC_RSP_R1
+  PRE_SEQ 0,8
+}
+
+{
+  OPCODE 41
+  ARG 1362100224
+  FLAGS MMC_RSP_R3
+  PRE_SEQ 0,8,55
+}
+
+{
+  OPCODE 1
+  ARG 0
+  FLAGS MMC_RSP_R3
+  PRE_SEQ 0,8,55,41
+}
+
+{
+  OPCODE 2
+  ARG 0
+  FLAGS MMC_RSP_R2
+  PRE_SEQ 0,8,41
+}
+
+{
+  OPCODE 3
+  ARG 0
+  FLAGS MMC_RSP_R1
+  PRE_SEQ 0,8,41,2
+}
+
+{
+  OPCODE 9
+  ARG SHIFTED_RCA
+  FLAGS MMC_RSP_R2
+  PRE_SEQ 0,8,41,2,3
+}
+
+{
+  OPCODE 10
+  ARG SHIFTED_RCA
+  FLAGS MMC_RSP_R2
+  PRE_SEQ 0,8,41,2,3
+}
+
+{
+  OPCODE 7
+  ARG SHIFTED_RCA
+  FLAGS MMC_RSP_R1
+  PRE_SEQ 0,8,41,2,3,9
+}
+{
+  OPCODE 60
+  ARG 0
+  FLAGS MMC_RSP_NONE
+  PRE_SEQ 7
+}
+
+{
+  OPCODE 12
+  ARG 0
+  FLAGS MMC_RSP_R1B
+  PRE_SEQ 0
+}
+
+{
+  OPCODE 13
+  ARG  SHIFTED_RCA
+  FLAGS MMC_RSP_R1
+  PRE_SEQ 0,8,41,2,3,9,7
+}
+
+{
+  OPCODE 15
+  ARG  SHIFTED_RCA
+  FLAGS MMC_RSP_NONE
+  PRE_SEQ NONE
+}
+
+{
+  OPCODE 16
+  ARG 512
+  FLAGS MMC_RSP_R1
+  PRE_SEQ 0,8,41,2,3,9,7
+}
+
+{
+  OPCODE 22
+  ARG 0
+  FLAGS MMC_RSP_R1
+  PRE_SEQ NONE
+}
+
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 0c959c9..deb62e8 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -61,6 +61,9 @@ MODULE_ALIAS("mmc:block");
 
 static DEFINE_MUTEX(block_mutex);
 
+void mmc_power_off(struct mmc_host *host);
+void mmc_power_up(struct mmc_host *host);
+
 /*
  * The defaults come from config options but can be overriden by module
  * or bootarg options.
@@ -488,12 +491,52 @@ cmd_done:
 	return err;
 }
 
+static int mmc_reset_request(struct block_device *bdev)
+{
+	struct mmc_blk_data *md;
+	struct mmc_card *card;
+	int err = 0;
+
+	/*
+	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
+	 * whole block device, not on a partition.  This prevents overspray
+	 * between sibling partitions.
+	 */
+	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
+		return -EPERM;
+
+
+
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	card = md->queue.card;
+	if (IS_ERR(card)) {
+		err = PTR_ERR(card);
+		goto error;
+	}
+
+	mmc_claim_host(card->host);
+	mmc_power_off(card->host);
+	mmc_power_up(card->host);
+
+error:
+	mmc_blk_put(md);
+	return err;
+
+}
+
 static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	int ret = -EINVAL;
 	if (cmd == MMC_IOC_CMD)
 		ret = mmc_blk_ioctl_cmd(bdev, (struct mmc_ioc_cmd __user *)arg);
+	else if (cmd == MMC_IOC_CMD_RESET)
+		ret = mmc_reset_request(bdev);
 	return ret;
 }
 
diff --git a/include/linux/mmc/ioctl.h b/include/linux/mmc/ioctl.h
index 8fa5bc5..bdec574 100644
--- a/include/linux/mmc/ioctl.h
+++ b/include/linux/mmc/ioctl.h
@@ -43,6 +43,7 @@ struct mmc_ioc_cmd {
 #define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr
 
 #define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
+#define MMC_IOC_CMD_RESET _IO(MMC_BLOCK_MAJOR, 0)
 
 /*
  * Since this ioctl is only meant to enhance (and not replace) normal access
-- 
1.7.6.4

