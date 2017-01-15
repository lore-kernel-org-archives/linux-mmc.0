From: Arthur Simchaev <Arthur.Simchaev@sandisk.com>
Subject: FW: [PATCH] mmc-utils: modified FFU to use multiple write command
Date: Sun, 15 Jan 2017 11:46:19 +0000
Message-ID: <F48E81F355625149BC1F1BC9E5CF520C03538F@ULS-OP-MBXIP04.sdcorp.global.sandisk.com>
References: <1484480494-10094-1-git-send-email-Arthur.Simchaev@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn3nam01on0042.outbound.protection.outlook.com ([104.47.33.42]:46098
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750824AbdAOLqa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 15 Jan 2017 06:46:30 -0500
In-Reply-To: <1484480494-10094-1-git-send-email-Arthur.Simchaev@sandisk.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "chris@printf.net" <chris@printf.net>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Until now the FW was written in a Single Write Command (CMD24) mode.
In order to write the firmware, the host sends hundreds of CMD24.
By using new mode (closed ended multiple write: CMD23,CMD25), the number of=
 write commands is reduced to few commands.
In case the host doesn't support closed ended writing, flash the ffu by sin=
gle sector writing.
By set [sector] to 1 or omit this parameter.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@sandisk.com>
---
 mmc.c      |   10 +++-
 mmc.h      |    1 +
 mmc_cmds.c |  184 ++++++++++++++++++++++++++++++++++++++++++++------------=
----
 3 files changed, 146 insertions(+), 49 deletions(-)

diff --git a/mmc.c b/mmc.c
index 50c9c9e..069ce9f 100644
--- a/mmc.c
+++ b/mmc.c
@@ -211,8 +211,14 @@ static struct Command commands[] =3D {
 	  NULL
 	},
 	{ do_ffu, -2,
-	  "ffu", "<image name> <device>\n"
-		"Run Field Firmware Update with <image name> on <device>.\n",
+	  "ffu", "<image name> <device> [sectors]\n"
+		  "Run Field Firmware Update with <image name> on <device>\n"
+		  "Write FFU file into device with number of blocks =3D <sectors>\n"
+		  "[sectors] is optional ,default value of the <sector> is 1 sector.\n"
+		  "In case the platform has [sectors] limitation\n"
+		  "(e.g. limited by hw, unsupported close ended writing),\n"
+		  "use default (one sector) command.\n"
+		  "[sectors] parameter cannot be more then MMC_IOC_MAX_BYTES/device=20
+sector size\n",
 	  NULL
 	},
 	{ 0, 0, 0, 0 }
diff --git a/mmc.h b/mmc.h
index a3d732c..89ebb9f 100644
--- a/mmc.h
+++ b/mmc.h
@@ -37,6 +37,7 @@
 #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
 #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
+#define MMC_SET_BLOCK_COUNT	23	/* adtc [31:0] data addr   R1  */
 #define MMC_WRITE_BLOCK		24	/* adtc [31:0] data addr	R1  */
 #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
 #define MMC_SET_WRITE_PROT	28    /* ac   [31:0] data addr   R1b */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 6b86115..c0df757 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2357,18 +2357,21 @@ int do_ffu(int nargs, char **argv)
 	exit(1);
 #else
 	int dev_fd, img_fd;
-	int sect_done =3D 0, retry =3D 3, ret =3D -EINVAL;
+	int sect_done =3D 0, retry =3D 5, ret =3D -EINVAL;
+	int num_ioctl_blks  =3D 0;
 	unsigned int sect_size;
 	__u8 ext_csd[512];
-	__u8 *buf;
-	__u32 arg;
+	__u8 *buf =3D NULL;
+	__u32 arg =3D 0;
 	off_t fw_size;
-	ssize_t chunk_size;
+	int remain_fw_size =3D 0;
+	ssize_t chunk_size =3D 0;
 	char *device;
-	struct mmc_ioc_multi_cmd *multi_cmd;
-
-	CHECK(nargs !=3D 3, "Usage: ffu <image name> </path/to/mmcblkX> \n",
-			exit(1));
+	struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
+	int bl_counter =3D 1;
+	CHECK(nargs !=3D 3 && nargs !=3D 4,
+		"Usage: ffu <image name> </path/to/mmcblkX> <sectors>\n",
+		exit(1));
=20
 	device =3D argv[2];
 	dev_fd =3D open(device, O_RDWR);
@@ -2383,10 +2386,23 @@ int do_ffu(int nargs, char **argv)
 		exit(1);
 	}
=20
-	buf =3D malloc(512);
-	multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
-				3 * sizeof(struct mmc_ioc_cmd));
-	if (!buf || !multi_cmd) {
+	if (nargs =3D=3D 3)
+		bl_counter =3D 1;
+	else
+		bl_counter =3D atoi(argv[3]);
+	if (bl_counter <=3D 0) {
+		fprintf(stderr, "Wrong <sector> value %d\n", bl_counter);
+		goto out;
+	}
+
+	if (bl_counter =3D=3D 1)
+		multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
+			3 * sizeof(struct mmc_ioc_cmd));
+	else/* using multiple write cmd */
+		multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
+			4 * sizeof(struct mmc_ioc_cmd));
+
+	if (!multi_cmd) {
 		perror("failed to allocate memory");
 		goto out;
 	}
@@ -2427,55 +2443,119 @@ int do_ffu(int nargs, char **argv)
 		goto out;
 	}
=20
+	if (sect_size * bl_counter > MMC_IOC_MAX_BYTES) {
+		fprintf(stderr, "<sectors> parameter cannot be more when %d\n",
+				(int) MMC_IOC_MAX_BYTES/sect_size);
+		goto out;
+	}
+
+	buf =3D calloc(1, bl_counter * sect_size);
+	if (!buf) {
+		perror("failed to allocate memory");
+		goto out;
+	}
 	/* set CMD ARG */
 	arg =3D ext_csd[EXT_CSD_FFU_ARG_0] |
 		ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
 		ext_csd[EXT_CSD_FFU_ARG_2] << 16 |
 		ext_csd[EXT_CSD_FFU_ARG_3] << 24;
+	/* In this case single write cmd will be use
+	 * Needed for the platform which doesn't support
+	 * close ended writing */
+	if (bl_counter =3D=3D 1) {
+		multi_cmd->num_of_cmds =3D 3;
+		/* put device into ffu mode */
+		multi_cmd->cmds[0].opcode =3D MMC_SWITCH;
+		multi_cmd->cmds[0].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+				(EXT_CSD_MODE_CONFIG << 16) |
+				(EXT_CSD_FFU_MODE << 8) |
+				EXT_CSD_CMD_SET_NORMAL;
+		multi_cmd->cmds[0].flags =3D MMC_RSP_SPI_R1B |
+				MMC_RSP_R1B |
+				MMC_CMD_AC;
+		multi_cmd->cmds[0].write_flag =3D 1;
+
+		/* send image chunk */
+		multi_cmd->cmds[1].opcode =3D MMC_WRITE_BLOCK;
+		multi_cmd->cmds[1].blksz =3D sect_size;
+		multi_cmd->cmds[1].blocks =3D 1;
+		multi_cmd->cmds[1].arg =3D arg;
+		multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 |
+				MMC_RSP_R1 |
+				MMC_CMD_ADTC;
+		multi_cmd->cmds[1].write_flag =3D 1;
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf);
=20
-	/* prepare multi_cmd to be sent */
-	multi_cmd->num_of_cmds =3D 3;
+		/* return device into normal mode */
+		multi_cmd->cmds[2].opcode =3D MMC_SWITCH;
+		multi_cmd->cmds[2].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+				(EXT_CSD_MODE_CONFIG << 16) |
+				(EXT_CSD_NORMAL_MODE << 8) |
+				EXT_CSD_CMD_SET_NORMAL;
+		multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1B |
+				MMC_RSP_R1B |
+				MMC_CMD_AC;
+		multi_cmd->cmds[2].write_flag =3D 1;
+	} else {
+		/* prepare multi_cmd to be sent */
+		multi_cmd->num_of_cmds =3D 4;
+		/* put device into ffu mode */
+		multi_cmd->cmds[0].opcode =3D MMC_SWITCH;
+		multi_cmd->cmds[0].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+				(EXT_CSD_MODE_CONFIG << 16) |
+				(EXT_CSD_FFU_MODE << 8) |
+				EXT_CSD_CMD_SET_NORMAL;
+		multi_cmd->cmds[0].flags =3D MMC_RSP_SPI_R1B |
+				MMC_RSP_R1B |
+				MMC_CMD_AC;
+		multi_cmd->cmds[0].write_flag =3D 1;
+
+		multi_cmd->cmds[1].opcode =3D MMC_SET_BLOCK_COUNT;
+		multi_cmd->cmds[1].arg =3D bl_counter & 0x0000FFFF;
+		multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1
+				|MMC_RSP_R1 |
+				MMC_CMD_AC;
+		multi_cmd->cmds[1].write_flag =3D 1;
=20
-	/* put device into ffu mode */
-	multi_cmd->cmds[0].opcode =3D MMC_SWITCH;
-	multi_cmd->cmds[0].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
-			(EXT_CSD_MODE_CONFIG << 16) |
-			(EXT_CSD_FFU_MODE << 8) |
-			EXT_CSD_CMD_SET_NORMAL;
-	multi_cmd->cmds[0].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	multi_cmd->cmds[0].write_flag =3D 1;
-
-	/* send image chunk */
-	multi_cmd->cmds[1].opcode =3D MMC_WRITE_BLOCK;
-	multi_cmd->cmds[1].blksz =3D sect_size;
-	multi_cmd->cmds[1].blocks =3D 1;
-	multi_cmd->cmds[1].arg =3D arg;
-	multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
-	multi_cmd->cmds[1].write_flag =3D 1;
-	mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf);
-
-	/* return device into normal mode */
-	multi_cmd->cmds[2].opcode =3D MMC_SWITCH;
-	multi_cmd->cmds[2].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+		multi_cmd->cmds[2].opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
+		multi_cmd->cmds[2].blksz =3D sect_size;
+		multi_cmd->cmds[2].blocks =3D bl_counter;
+		multi_cmd->cmds[2].arg =3D arg;
+		multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1 |
+				MMC_RSP_R1 |
+				MMC_CMD_ADTC;
+		multi_cmd->cmds[2].write_flag =3D 1;
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf);
+
+		multi_cmd->cmds[3].opcode =3D MMC_SWITCH;
+		multi_cmd->cmds[3].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
 			(EXT_CSD_MODE_CONFIG << 16) |
 			(EXT_CSD_NORMAL_MODE << 8) |
 			EXT_CSD_CMD_SET_NORMAL;
-	multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-	multi_cmd->cmds[2].write_flag =3D 1;
+		multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B |
+				MMC_RSP_R1B |
+				MMC_CMD_AC;
+		multi_cmd->cmds[3].write_flag =3D 1;
+	}
=20
 do_retry:
 	/* read firmware chunk */
 	lseek(img_fd, 0, SEEK_SET);
-	chunk_size =3D read(img_fd, buf, 512);
+	num_ioctl_blks =3D bl_counter;
+	chunk_size =3D read(img_fd, buf, num_ioctl_blks * sect_size);
+	remain_fw_size =3D fw_size - chunk_size;
=20
 	while (chunk_size > 0) {
 		/* send ioctl with multi-cmd */
 		ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
=20
 		if (ret) {
-			perror("Multi-cmd ioctl");
+			perror("Multi-cmd ioctl failed.");
 			/* In case multi-cmd ioctl failed before exiting from ffu mode */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
+			if (bl_counter =3D=3D 1)
+				ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
+			else
+				ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
 			goto out;
 		}
=20
@@ -2494,7 +2574,6 @@ do_retry:
 		if (sect_done =3D=3D 0) {
 			if (retry > 0) {
 				retry--;
-				fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
 				goto do_retry;
 			}
 			fprintf(stderr, "Programming failed! Aborting...\n"); @@ -2502,14 +2581=
,25 @@ do_retry:
 		} else {
 			fprintf(stderr, "Programmed %d/%jd bytes\r", sect_done * sect_size, (in=
tmax_t)fw_size);
 		}
+		memset(buf, 0, num_ioctl_blks);
=20
+		if (remain_fw_size >=3D bl_counter * sect_size)
+			num_ioctl_blks =3D bl_counter;
+		else
+			num_ioctl_blks =3D remain_fw_size / sect_size;
 		/* read the next firmware chunk (if any) */
-		chunk_size =3D read(img_fd, buf, 512);
+		chunk_size =3D read(img_fd, buf, num_ioctl_blks * sect_size);
+		if (chunk_size > 0)
+			remain_fw_size =3D remain_fw_size - chunk_size;
+		/* Update the values for Multiple Write CMD */
+		if (bl_counter > 1) {
+			multi_cmd->cmds[1].arg =3D num_ioctl_blks & 0x0000FFFF;
+			multi_cmd->cmds[2].blocks =3D num_ioctl_blks;
+		}
 	}
-
 	if ((sect_done * sect_size) =3D=3D fw_size) {
 		fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)fw_size, (intmax=
_t)fw_size);
-		fprintf(stderr, "Programming finished with status %d \n", ret);
+		fprintf(stderr, "Programming finished with status %d\n", ret);
 	}
 	else {
 		fprintf(stderr, "FW size and number of sectors written mismatch. Status =
return %d\n", ret); @@ -2529,9 +2619,9 @@ do_retry:
 		multi_cmd->cmds[1].blksz =3D 0;
 		multi_cmd->cmds[1].blocks =3D 0;
 		multi_cmd->cmds[1].arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
-				(EXT_CSD_MODE_OPERATION_CODES << 16) |
-				(EXT_CSD_FFU_INSTALL << 8) |
-				EXT_CSD_CMD_SET_NORMAL;
+			(EXT_CSD_MODE_OPERATION_CODES << 16) |
+			(EXT_CSD_FFU_INSTALL << 8) |
+			EXT_CSD_CMD_SET_NORMAL;
 		multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 		multi_cmd->cmds[1].write_flag =3D 1;
=20
--
1.7.9.5

