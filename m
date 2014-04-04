From: Seunguk Shin <seunguk.shin@samsung.com>
Subject: [PATCH] mmc-utils: Support sending Samsung eMMC 4.5 FFU
Date: Fri, 04 Apr 2014 21:07:47 +0900
Message-ID: <000301cf4ffe$7e1dbf80$7a593e80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55788 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaDDMHr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Apr 2014 08:07:47 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N3I00K299OY4F10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 04 Apr 2014 21:07:46 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, cpgs@samsung.com

This change adds support to invoke Samsung eMMC 4.5 field firmware update
(ffu) process.
New command was added: "emmc45 ffu".

Samsung eMMC 4.5 FFU protocol is similar with eMMC 5.0 FFU without
MODE_OPERATION.
It uses the different EXT_CSD offset.

This patch depends on patch mmc-utils: Support-sending-eMMC-v5.0 committed
by Avi Shchislowski <avi.shchislowski@sandisk.com> and mmc: Support FFU for
Samsung eMMC v4.5 committed by Seunguk Shin <seunguk.shin@samsung.com>

---
 mmc.c      |  5 ++++
 mmc.h      |  1 +
 mmc_cmds.c | 87
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h |  1 +
 4 files changed, 94 insertions(+)

diff --git a/mmc.c b/mmc.c
index 7234953..44aaf6d 100644
--- a/mmc.c
+++ b/mmc.c
@@ -115,6 +115,11 @@ static struct Command commands[] = {
 		"run eMMC 5.0 Field firmware update.\n.",
 	  NULL
 	},
+	{ do_emmc45_ffu, -2,
+	  "emmc45 ffu", "<image path> <device>\n"
+		"run eMMC 4.5 Field firmware update for samsung.\n.",
+	  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 19eaaba..ca4b70b 100644
--- a/mmc.h
+++ b/mmc.h
@@ -86,6 +86,7 @@
 
 #define FFU_DWONLOAD_OP        302
 #define FFU_INSTALL_OP 303
+#define FFU_SAMSUNG45_OP	304
 
 /*
  * EXT_CSD field definitions
diff --git a/mmc_cmds.c b/mmc_cmds.c
index f667d10..17e50d8 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1271,3 +1271,90 @@ exit:
        return ret;
 }
 
+static int ffu_execute(int fw_fd, int mmc_fd)
+{
+	int ret = 0;
+	struct mmc_ioc_cmd mmc_ioc_cmd;
+	char data_buff[MMC_IOC_MAX_BYTES];
+	int file_size;
+	int data_length;
+
+	memset(data_buff, 0, sizeof(data_buff));
+	/* get file size */
+	file_size = lseek(fw_fd, 0, SEEK_END);
+	if (file_size < 0) {
+		ret = -1;
+		perror("seek file error \n");
+		goto exit;
+	}
+
+	lseek(fw_fd, 0, SEEK_SET);
+
+	if (file_size > MMC_IOC_MAX_BYTES) {
+		ret = -1;
+		perror("firmware file size error \n");
+		goto exit;
+	} else {
+		/* Read FW data from file */
+		data_length = read(fw_fd, data_buff, file_size);
+		if (data_length == -1) {
+			ret = -1;
+			goto exit;
+		}
+		/* prepare and send ioctl */
+		memset(&mmc_ioc_cmd, 0, sizeof(mmc_ioc_cmd));
+		mmc_ioc_cmd.opcode = FFU_SAMSUNG45_OP;
+		mmc_ioc_cmd.blksz = CARD_BLOCK_SIZE;
+		mmc_ioc_cmd.blocks = (data_length + mmc_ioc_cmd.blksz - 1) /
+			mmc_ioc_cmd.blksz;
+		mmc_ioc_cmd.arg = 0;
+		mmc_ioc_cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
MMC_CMD_ADTC;
+		mmc_ioc_cmd.write_flag = 1;
+		mmc_ioc_cmd_set_data(mmc_ioc_cmd, data_buff);
+		ret = ioctl(mmc_fd, MMC_IOC_CMD, &mmc_ioc_cmd);
+
+		if (ret) {
+			perror("ioctl FW download");
+			goto exit;
+		}
+	}
+
+exit:
+
+	return ret;
+}
+
+int do_emmc45_ffu(int nargs, char **argv)
+{
+	int fd, fw_fd, ret;
+	char *device;
+
+	CHECK(nargs != 3, "Usage: ffu <image path> </path/to/mmcblkX> \n",
+		exit(1));
+
+	device = argv[2];
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("device open error \n");
+		exit(1);
+	}
+
+	/* open eMMC4.5 firmware image file */
+	fw_fd = open(argv[1], O_RDONLY);
+	if (fw_fd < 0) {
+		perror("open eMMC4.5 firmware file");
+		ret = -1;
+		goto exit;
+	}
+
+	ret = ffu_execute(fw_fd, fd);
+	if (ret)
+		goto exit;
+
+exit:
+	close(fd);
+	close(fw_fd);
+
+	return ret;
+}
+
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 3ff3440..1ab9cd5 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -29,3 +29,4 @@ int do_status_get(int nargs, char **argv);
 int do_enh_area_set(int nargs, char **argv);
 int do_write_reliability_set(int nargs, char **argv);
 int do_emmc50_ffu(int nargs, char **argv);
+int do_emmc45_ffu(int nargs, char **argv);
-- 
1.8.3.2

