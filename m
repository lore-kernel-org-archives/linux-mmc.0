Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF8EC433FE
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Nov 2022 18:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiKCSwA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Nov 2022 14:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKCSv4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2022 14:51:56 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA79F7E
        for <linux-mmc@vger.kernel.org>; Thu,  3 Nov 2022 11:51:53 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 0EC493A1F1D;
        Thu,  3 Nov 2022 19:51:52 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id F310E3A1F1B;
        Thu,  3 Nov 2022 19:51:51 +0100 (CET)
X-TM-AS-ERS: 10.149.2.42-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (sbdeex04.sbitdom.lan [10.149.2.42])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Thu,  3 Nov 2022 19:51:51 +0100 (CET)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 3 Nov 2022
 19:51:51 +0100
Received: from sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818]) by
 sbdeex04.sbitdom.lan ([fe80::2047:4968:b5a0:1818%9]) with mapi id
 15.02.1118.009; Thu, 3 Nov 2022 19:51:51 +0100
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>
Subject: [PATCHv3] mmc-utils: Implement alternative boot operation
Thread-Topic: [PATCHv3] mmc-utils: Implement alternative boot operation
Thread-Index: AdjvtTotZkuh0EQzTjmgArInEQi3XA==
Date:   Thu, 3 Nov 2022 18:51:51 +0000
Message-ID: <f999a7ed7bb645948ac74d5d5341e913@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.7]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27242.002
X-TMASE-Result: 10--2.450600-10.000000
X-TMASE-MatchedRID: 6E41RGmUyPq9nTq7rJdwXKekGZXOwUBuUrr7Qc5WhKjAuQ0xDMaXkHU3
        oKSu0J1xwUvinrDLhqnSbuZ7S4XjmuM08db7ghTyA9lly13c/gGUq+GQ/zyJdN8pqleQItEFhFA
        nTzcsrmVnBd+7QItl3U2jo2v+wN3NbVcsZW9h4Cgdahq+rGDn//NkoMDX+kiul8eCd8viB1TToh
        hY3qi5AnMWeasl9UKPJcenWlfqR84pQD5WvouNbIXQ/hu1OV/0c7WhpDnUK40AIXlMppp3X0/Lm
        ZgDl1csU5+9+/1J0rsoPQ/c1fY3gcm0JnqSM1ZkIGmn4OlOtCOk2H/b/X5aJZ7oC1rVz/uNo8WM
        kQWv6iUig6xaCvyzXY6HM5rqDwqtzFiyZ1wVw5onHDd7FSY23N+1yxoOeesEAi9XhgjNwjNEFgt
        Jh4H8/Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 8658c22f-03e6-4ffc-9c4d-df704cd6b3cf-0-0-200-0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Implements the alternative boot operation for eMMCs.
Note the limitations of the help.

This is mostly useful for testing purposes if you set
up the boot partition configuration correctly.

Usage:
$ sudo dd if=/dev/mmcblk2boot0 of=bootdatammcblk count=2
2+0 records in
2+0 records out
1024 bytes (1.0 kB, 1.0 KiB) copied, 0.00482308 s, 212 kB/s

$ sudo ./mmc boot_operation bootdata /dev/mmcblk2

$ diff -s bootdata bootdatammcblk
Files bootdata and bootdatammcblk are identical

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
-v3: Alternative boot mode support check
-v2: Frees, closes, removal of boot_blocks parameter and boot ack check
 mmc.c      |  12 +++++++
 mmc.h      |   2 ++
 mmc_cmds.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |   1 +
 4 files changed, 118 insertions(+)

diff --git a/mmc.c b/mmc.c
index 170ee39..adcd814 100644
--- a/mmc.c
+++ b/mmc.c
@@ -255,6 +255,18 @@ static struct Command commands[] = {
 	  "Issues a CMD0 GO_PRE_IDLE",
 	  NULL
 	},
+	{ do_alt_boot_op, -1,
+	  "boot_operation", "<boot_data_file> <device>\n"
+	  "Does the alternative boot operation and writes the specified starting blocks of boot data into the requested file.\n\n"
+	  "Note some limitations\n:"
+	  "1. The boot operation must be configured, e.g. for legacy speed:\n"
+	  "mmc-utils bootbus set single_backward retain x8 /dev/mmcblk2\n"
+	  "mmc-utils bootpart enable 1 0 /dev/mmcblk2\n"
+	  "2. The MMC must currently be running at the bus mode that is configured for the boot operation (HS200 and HS400 not supported at all).\n"
+	  "3. Only up to 512K bytes of boot data will be transferred.\n"
+	  "4. The MMC will perform a soft reset, if your system cannot handle that do not use the boot operation from mmc-utils.\n",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 6511dbc..6f1bf3e 100644
--- a/mmc.h
+++ b/mmc.h
@@ -24,6 +24,7 @@
 #define MMC_GO_IDLE_STATE         0   /* bc                          */
 #define MMC_GO_IDLE_STATE_ARG		0x0
 #define MMC_GO_PRE_IDLE_STATE_ARG	0xF0F0F0F0
+#define MMC_BOOT_INITIATION_ARG		0xFFFFFFFA
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
 #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
@@ -97,6 +98,7 @@
 #define EXT_CSD_CACHE_SIZE_0		249
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231
 #define EXT_CSD_BOOT_INFO		228	/* R/W */
+#define EXT_CSD_BOOT_MULT		226	/* RO */
 #define EXT_CSD_HC_ERASE_GRP_SIZE	224
 #define EXT_CSD_HC_WP_GRP_SIZE		221
 #define EXT_CSD_SEC_COUNT_3		215
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 3db17e1..e6d3273 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -3101,3 +3101,106 @@ int do_preidle(int nargs, char **argv)
 
 	return 0;
 }
+
+int do_alt_boot_op(int nargs, char **argv)
+{
+	int fd, ret, boot_data_fd;
+	char *device, *boot_data_file;
+	struct mmc_ioc_multi_cmd *mioc;
+	__u8 ext_csd[512];
+	__u8 *boot_buf;
+	unsigned int boot_blocks, ext_csd_boot_size;
+
+	if (nargs != 3) {
+		fprintf(stderr, "Usage: mmc boot_op <boot_data_file> </path/to/mmcblkX>\n");
+		exit(1);
+	}
+	boot_data_file = argv[1];
+	device = argv[2];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open device");
+		exit(1);
+	}
+
+	ret = read_extcsd(fd, ext_csd);
+	if (ret) {
+		perror("read extcsd");
+		goto dev_fd_close;
+	}
+	if (!(ext_csd[EXT_CSD_BOOT_INFO] & EXT_CSD_BOOT_INFO_ALT)) {
+		ret = -EINVAL;
+		perror("Card does not support alternative boot mode");
+		goto dev_fd_close;
+	}
+	if (ext_csd[EXT_CSD_PART_CONFIG] & EXT_CSD_PART_CONFIG_ACC_ACK) {
+		ret = -EINVAL;
+		perror("Boot Ack must not be enabled");
+		goto dev_fd_close;
+	}
+	ext_csd_boot_size = ext_csd[EXT_CSD_BOOT_MULT] * 128 * 1024;
+	boot_blocks = ext_csd_boot_size / 512;
+	if (ext_csd_boot_size > MMC_IOC_MAX_BYTES) {
+		printf("Boot partition size is bigger than IOCTL limit, limiting to 512K\n");
+		boot_blocks = MMC_IOC_MAX_BYTES / 512;
+	}
+
+	boot_data_fd = open(boot_data_file, O_WRONLY | O_CREAT, 0644);
+	if (boot_data_fd < 0) {
+		perror("open boot data file");
+		ret = 1;
+		goto boot_data_close;
+	}
+
+	boot_buf = calloc(1, sizeof(__u8) * boot_blocks * 512);
+	mioc = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
+			   2 * sizeof(struct mmc_ioc_cmd));
+	if (!mioc || !boot_buf) {
+		perror("Failed to allocate memory");
+		ret = -ENOMEM;
+		goto alloced_error;
+	}
+
+	mioc->num_of_cmds = 2;
+	mioc->cmds[0].opcode = MMC_GO_IDLE_STATE;
+	mioc->cmds[0].arg = MMC_GO_PRE_IDLE_STATE_ARG;
+	mioc->cmds[0].flags = MMC_RSP_NONE | MMC_CMD_AC;
+	mioc->cmds[0].write_flag = 0;
+
+	mioc->cmds[1].opcode = MMC_GO_IDLE_STATE;
+	mioc->cmds[1].arg = MMC_BOOT_INITIATION_ARG;
+	mioc->cmds[1].flags = MMC_RSP_NONE | MMC_CMD_ADTC;
+	mioc->cmds[1].write_flag = 0;
+	mioc->cmds[1].blksz = 512;
+	mioc->cmds[1].blocks = boot_blocks;
+	/* Access time of boot part differs wildly, spec mandates 1s */
+	mioc->cmds[1].data_timeout_ns = 2 * 1000 * 1000 * 1000;
+	mmc_ioc_cmd_set_data(mioc->cmds[1], boot_buf);
+
+	ret = ioctl(fd, MMC_IOC_MULTI_CMD, mioc);
+	if (ret) {
+		perror("multi-cmd ioctl error\n");
+		goto alloced_error;
+	}
+
+	ret = DO_IO(write, boot_data_fd, boot_buf, boot_blocks * 512);
+	if (ret < 0) {
+		perror("Write error\n");
+		goto alloced_error;
+	}
+	ret = 0;
+
+alloced_error:
+	if (mioc)
+		free(mioc);
+	if (boot_buf)
+		free(boot_buf);
+boot_data_close:
+	close(boot_data_fd);
+dev_fd_close:
+	close(fd);
+	if (ret)
+		exit(1);
+	return 0;
+}
diff --git a/mmc_cmds.h b/mmc_cmds.h
index faab362..5f2bef1 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -49,3 +49,4 @@ int do_erase(int nargs, char **argv);
 int do_general_cmd_read(int nargs, char **argv);
 int do_softreset(int nargs, char **argv);
 int do_preidle(int nargs, char **argv);
+int do_alt_boot_op(int nargs, char **argv);
-- 
2.37.3

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

