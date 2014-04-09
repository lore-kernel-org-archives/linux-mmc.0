From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: [RFC PATCH 1/1 v2] mmc-utils: Support-sending-eMMC-5.0-FFU
Date: Wed, 9 Apr 2014 19:53:08 +0000
Message-ID: <FDD07FEB422EF948A392FDC201AEEAE64117FFD6@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:37727
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933481AbaDITxO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Apr 2014 15:53:14 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'cjb@laptop.org'" <cjb@laptop.org>
Cc: 'Grant Grundler' <grundler@chromium.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

The mmc-utils was modified to invoke eMMC5.0 Field Firmware Update (FFU) process in mmc driver  New command was add: "do_emmc50_ffu".

 This patch depends on patch  mmc: Support-FFU-for-eMMC-v5.0 Committed by Avi Shchislowski <avi.shchislowski@sandisk.com>

 FFU will be done in two steps. Two new IOCTL codes will be sent to the driver in order to operate FFU code:
	1.  FFU_DWONLOAD_OP (sent in ffu_download_image() function)
	2.  FFU_INSTALL_OP (sent in ffu_install() function)

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

diff --git a/mmc.c b/mmc.c
index 926e92f..ee23cd3 100644
--- a/mmc.c
+++ b/mmc.c
@@ -110,6 +110,11 @@ static struct Command commands[] = {
 		"Send Sanitize command to the <device>.\nThis will delete the unmapped memory region of the device.",
 	  NULL
 	},
+	{ do_emmc50_ffu, -2,
+		  "ffu", "<image name> <device>\n"
+			"run eMMC 5.0 Field firmware update.\n.",
+		  NULL
+	},
 	{ 0, 0, 0, 0 }
 };
 
diff --git a/mmc.h b/mmc.h
index 9871d62..b338e1d 100644
--- a/mmc.h
+++ b/mmc.h
@@ -64,6 +64,7 @@
 #define EXT_CSD_ENH_START_ADDR_2	138
 #define EXT_CSD_ENH_START_ADDR_1	137
 #define EXT_CSD_ENH_START_ADDR_0	136
+#define EXT_CSD_REV			192
 #define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
 #define EXT_CSD_USE_NATIVE_SECTOR	62 /* R/W */
 #define EXT_CSD_DATA_SECTOR_SIZE	61 /* R */
@@ -79,6 +80,9 @@
  */
 #define BKOPS_ENABLE	(1<<0)
 
+#define MMC_FFU_DOWNLOAD_OP	302
+#define MMC_FFU_INSTALL_OP	303
+
 /*
  * EXT_CSD field definitions
  */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index b8afa74..71a2ce3 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1142,7 +1142,7 @@ int do_sanitize(int nargs, char **argv)
 	char *device;
 
 	CHECK(nargs != 2, "Usage: mmc sanitize </path/to/mmcblkX>\n",
-			exit(1));
+		exit(1));
 
 	device = argv[1];
 
@@ -1163,3 +1163,94 @@ int do_sanitize(int nargs, char **argv)
 
 }
 
+static int ffu_download_image(char *fname, int mmc_fd, int blk_size) {
+	int ret = 0;
+	struct mmc_ioc_cmd mmc_ioc_cmd;
+	char firmware_name[512];
+
+	memset(firmware_name, 0, sizeof(firmware_name));
+	memcpy(firmware_name, fname, strlen(fname));
+
+	/* prepare and send ioctl */
+	memset(&mmc_ioc_cmd, 0, sizeof(mmc_ioc_cmd));
+	mmc_ioc_cmd.opcode = MMC_FFU_DOWNLOAD_OP;
+	mmc_ioc_cmd.blksz = blk_size;
+	mmc_ioc_cmd.blocks = 1;
+	mmc_ioc_cmd.arg = 0;
+	mmc_ioc_cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	mmc_ioc_cmd.write_flag = 1;
+	mmc_ioc_cmd_set_data(mmc_ioc_cmd, firmware_name);
+	ret = ioctl(mmc_fd, MMC_IOC_CMD, &mmc_ioc_cmd);
+	if (ret) {
+		fprintf(stderr, "ioctl FW download error%d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int ffu_install(int mmc_fd, int blk_size) {
+	int ret;
+	struct mmc_ioc_cmd mmc_ioc_cmd;
+
+	memset(&mmc_ioc_cmd, 0, sizeof(mmc_ioc_cmd));
+	mmc_ioc_cmd.opcode = MMC_FFU_INSTALL_OP;
+	mmc_ioc_cmd.blksz = blk_size;
+	mmc_ioc_cmd.blocks = 0;
+	mmc_ioc_cmd.arg = 0;
+	mmc_ioc_cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	mmc_ioc_cmd.write_flag = 0;
+	ret = ioctl(mmc_fd, MMC_IOC_CMD, &mmc_ioc_cmd);
+
+	return ret;
+}
+
+int do_emmc50_ffu (int nargs, char **argv) {
+	int fd, ret;
+	char *device;
+	char *path;
+	__u8 ext_csd[512];
+	int blk_size;
+
+	CHECK(nargs != 3, "Usage: ffu <image name> </path/to/mmcblkX> \n",
+		exit(1));
+
+	device = argv[2];
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
+	if (ext_csd[EXT_CSD_REV] < 7) {
+		fprintf(stderr, "FFU is not supported on device %s\n", device);
+		exit(1);
+	}
+
+	blk_size = (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 0) ? 512 : 4096;
+	path = argv[1];
+	ret = ffu_download_image(path, fd, blk_size);
+	if (ret) {
+		fprintf(stderr, "FFU failed %d\n", ret);
+		exit(1);
+	}
+
+	ret = ffu_install(fd, blk_size);
+	if (ret) {
+		fprintf(stderr, "FFU failed %d\n", ret);
+		exit(1);
+	}
+
+	close(fd);
+	fprintf(stderr, "FFU finished with status %d \n", ret);
+	return ret;
+}
diff --git a/mmc_cmds.h b/mmc_cmds.h
index f06cc10..3ff3440 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -28,3 +28,4 @@ int do_sanitize(int nargs, char **argv);  int do_status_get(int nargs, char **argv);  int do_enh_area_set(int nargs, char **argv);  int do_write_reliability_set(int nargs, char **argv);
+int do_emmc50_ffu(int nargs, char **argv);


