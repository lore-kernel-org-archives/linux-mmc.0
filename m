From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: RE: [PATCH 1/1 v3] mmc_utils: add ffu support
Date: Mon, 7 Mar 2016 19:22:49 +0000
Message-ID: <SN1PR02MB1389B01C997E16B4C11AD11D83B10@SN1PR02MB1389.namprd02.prod.outlook.com>
References: <SN1PR02MB138923B8D2F1819665213E4283BB0@SN1PR02MB1389.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0091.outbound.protection.outlook.com ([207.46.100.91]:63296
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753061AbcCGTWy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2016 14:22:54 -0500
In-Reply-To: <SN1PR02MB138923B8D2F1819665213E4283BB0@SN1PR02MB1389.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Yaniv Agman <Yaniv.Agman@sandisk.com>

Ping...
Hi Chris 
Can you review the patch?

Thanks,
Avi

> -----Original Message-----
> From: Avi Shchislowski
> Sent: Tuesday, March 01, 2016 11:05 AM
> To: Chris Ball; Ulf Hansson
> Cc: linux-mmc@vger.kernel.org; Alex Lemberg; Yaniv Agman
> Subject: [PATCH 1/1 v3] mmc_utils: add ffu support
> 
> Adding support for field firmware update over multiple command ioctl.
> As multiple command ioctl is supported only from kernel 4.4, this patch should
> be used against kernel 4.4 and above.
> 
> Known issues:
> - There is no support for Multiple Block write commands (CMD25) in existing
>    IOCTL implementation
> - In case MODE_OPERATION_CODES field is not supported by the device
>    manual reset of the device/platform is required.
>    The reset issue discussed in another email thread - " [RFC 0/6] mmc: Field
> Firmware Update"
> 
> Change since v2:
> - add MMC_IOC_MULTI_CMD define to avoid compile error
> 
> Change since v1:
> - modified copyright header
> 
> Signed-off-by: Yaniv Agman <yaniv.agman@sandisk.com>
> Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
> 
> diff --git a/mmc.c b/mmc.c
> index a13d9ae..2ac98ae 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -13,6 +13,9 @@
>   * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
>   * Boston, MA 021110-1307, USA.
>   *
> + * Modified to add field firmware update support,
> + * those modifications are Copyright (c) 2016 SanDisk Corp.
> + *
>   * (This code is based on btrfs-progs/btrfs.c.)
>   */
> 
> @@ -175,6 +178,11 @@ static struct Command commands[] = {
>  		"NOTE! The cache is an optional feature on devices >=
> eMMC4.5.",
>  	  NULL
>  	},
> +	{ do_ffu, -2,
> +	  "ffu", "<image name> <device>\n"
> +		"Run Field Firmware Update with <image name> on
> <device>.\n",
> +	  NULL
> +	},
>  	{ 0, 0, 0, 0 }
>  };
> 
> diff --git a/mmc.h b/mmc.h
> index b7063fb..38b215f 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -12,6 +12,9 @@
>   * License along with this program; if not, write to the
>   * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
>   * Boston, MA 021110-1307, USA.
> + *
> + * Modified to add field firmware update support,
> + * those modifications are Copyright (c) 2016 SanDisk Corp.
>   */
> 
>  #include <asm-generic/int-ll64.h>
> @@ -34,6 +37,7 @@
>  #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
>  #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value
> */
>  #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
> +#define MMC_WRITE_BLOCK		24	/* adtc [31:0] data addr	R1  */
>  #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
> 
>  /*
> @@ -42,6 +46,17 @@
>  #define EXT_CSD_S_CMD_SET		504
>  #define EXT_CSD_HPI_FEATURE		503
>  #define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
> +#define EXT_CSD_SUPPORTED_MODES		493	/* RO */
> +#define EXT_CSD_FFU_FEATURES		492	/* RO */
> +#define EXT_CSD_FFU_ARG_3		490	/* RO */
> +#define EXT_CSD_FFU_ARG_2		489	/* RO */
> +#define EXT_CSD_FFU_ARG_1		488	/* RO */
> +#define EXT_CSD_FFU_ARG_0		487	/* RO */
> +#define EXT_CSD_NUM_OF_FW_SEC_PROG_3	305	/* RO */
> +#define EXT_CSD_NUM_OF_FW_SEC_PROG_2	304	/* RO */
> +#define EXT_CSD_NUM_OF_FW_SEC_PROG_1	303	/* RO */
> +#define EXT_CSD_NUM_OF_FW_SEC_PROG_0	302	/* RO */
> +#define EXT_CSD_FIRMWARE_VERSION	254	/* RO */
>  #define EXT_CSD_CACHE_SIZE_3		252
>  #define EXT_CSD_CACHE_SIZE_2		251
>  #define EXT_CSD_CACHE_SIZE_1		250
> @@ -58,6 +73,7 @@
>  #define EXT_CSD_BOOT_BUS_CONDITIONS	177
>  #define EXT_CSD_ERASE_GROUP_DEF		175
>  #define EXT_CSD_BOOT_WP			173
> +#define EXT_CSD_FW_CONFIG		169	/* R/W */
>  #define EXT_CSD_WR_REL_SET		167
>  #define EXT_CSD_WR_REL_PARAM		166
>  #define EXT_CSD_SANITIZE_START		165
> @@ -94,6 +110,9 @@
>  #define EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_1	53
>  #define EXT_CSD_EXT_PARTITIONS_ATTRIBUTE_0	52
>  #define EXT_CSD_CACHE_CTRL		33
> +#define EXT_CSD_MODE_CONFIG		30
> +#define EXT_CSD_MODE_OPERATION_CODES	29	/* W */
> +#define EXT_CSD_FFU_STATUS		26	/* R */
> 
>  /*
>   * WR_REL_PARAM field definitions
> @@ -109,6 +128,11 @@
>  /*
>   * EXT_CSD field definitions
>   */
> +#define EXT_CSD_FFU_INSTALL		(0x01)
> +#define EXT_CSD_FFU_MODE		(0x01)
> +#define EXT_CSD_NORMAL_MODE		(0x00)
> +#define EXT_CSD_FFU			(1<<0)
> +#define EXT_CSD_UPDATE_DISABLE		(1<<0)
>  #define EXT_CSD_HPI_SUPP		(1<<0)
>  #define EXT_CSD_HPI_IMPL		(1<<1)
>  #define EXT_CSD_CMD_SET_NORMAL		(1<<0)
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 77446b4..da3c5ce 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -12,6 +12,9 @@
>   * License along with this program; if not, write to the
>   * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
>   * Boston, MA 021110-1307, USA.
> + *
> + * Modified to add field firmware update support,
> + * those modifications are Copyright (c) 2016 SanDisk Corp.
>   */
> 
>  #include <stdio.h>
> @@ -1017,6 +1020,9 @@ int do_read_extcsd(int nargs, char **argv)
>  	ext_csd_rev = ext_csd[EXT_CSD_REV];
> 
>  	switch (ext_csd_rev) {
> +	case 8:
> +		str = "5.1";
> +		break;
>  	case 7:
>  		str = "5.0";
>  		break;
> @@ -1430,6 +1436,10 @@ int do_read_extcsd(int nargs, char **argv)
>  		/*Reserved [31:0] */
>  	}
> 
> +	if (ext_csd_rev >= 7) {
> +		printf("eMMC Firmware Version: %s\n",
> +			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
> +	}
>  out_free:
>  	return ret;
>  }
> @@ -2032,3 +2042,224 @@ int do_cache_dis(int nargs, char **argv)  {
>  	return do_cache_ctrl(0, nargs, argv);
>  }
> +
> +int do_ffu(int nargs, char **argv)
> +{
> +#ifndef MMC_IOC_MULTI_CMD
> +	fprintf(stderr, "mmc-utils has been compiled without
> MMC_IOC_MULTI_CMD"
> +			" support, needed by FFU.\n");
> +	exit(1);
> +#else
> +	int dev_fd, img_fd;
> +	int sect_done = 0, retry = 3, ret = -EINVAL;
> +	unsigned int sect_size;
> +	__u8 ext_csd[512];
> +	__u8 *buf;
> +	__u32 arg;
> +	off_t fw_size;
> +	ssize_t chunk_size;
> +	char *device;
> +	struct mmc_ioc_multi_cmd *multi_cmd;
> +
> +	CHECK(nargs != 3, "Usage: ffu <image name> </path/to/mmcblkX> \n",
> +			exit(1));
> +
> +	device = argv[2];
> +	dev_fd = open(device, O_RDWR);
> +	if (dev_fd < 0) {
> +		perror("device open failed");
> +		exit(1);
> +	}
> +	img_fd = open(argv[1], O_RDONLY);
> +	if (img_fd < 0) {
> +		perror("image open failed");
> +		close(dev_fd);
> +		exit(1);
> +	}
> +
> +	buf = malloc(512);
> +	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> +				3 * sizeof(struct mmc_ioc_cmd));
> +	if (!buf || !multi_cmd) {
> +		perror("failed to allocate memory");
> +		goto out;
> +	}
> +
> +	ret = read_extcsd(dev_fd, ext_csd);
> +	if (ret) {
> +		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> +		goto out;
> +	}
> +
> +	if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
> +		fprintf(stderr,
> +			"The FFU feature is only available on devices >= "
> +			"MMC 5.0, not supported in %s\n", device);
> +		goto out;
> +	}
> +
> +	if (!(ext_csd[EXT_CSD_SUPPORTED_MODES] & EXT_CSD_FFU)) {
> +		fprintf(stderr, "FFU is not supported in %s\n", device);
> +		goto out;
> +	}
> +
> +	if (ext_csd[EXT_CSD_FW_CONFIG] & EXT_CSD_UPDATE_DISABLE) {
> +		fprintf(stderr, "Firmware update was disabled in %s\n",
> device);
> +		goto out;
> +	}
> +
> +	fw_size = lseek(img_fd, 0, SEEK_END);
> +
> +	if (fw_size == 0) {
> +		fprintf(stderr, "Firmware image is empty");
> +		goto out;
> +	}
> +
> +	sect_size = (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 0) ? 512 : 4096;
> +	if (fw_size % sect_size) {
> +		fprintf(stderr, "Firmware data size (%jd) is not aligned!\n",
> (intmax_t)fw_size);
> +		goto out;
> +	}
> +
> +	/* set CMD ARG */
> +	arg = ext_csd[EXT_CSD_FFU_ARG_0] |
> +		ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
> +		ext_csd[EXT_CSD_FFU_ARG_2] << 16 |
> +		ext_csd[EXT_CSD_FFU_ARG_3] << 24;
> +
> +	/* prepare multi_cmd to be sent */
> +	multi_cmd->num_of_cmds = 3;
> +
> +	/* put device into ffu mode */
> +	multi_cmd->cmds[0].opcode = MMC_SWITCH;
> +	multi_cmd->cmds[0].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24)
> |
> +			(EXT_CSD_MODE_CONFIG << 16) |
> +			(EXT_CSD_FFU_MODE << 8) |
> +			EXT_CSD_CMD_SET_NORMAL;
> +	multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> MMC_CMD_AC;
> +	multi_cmd->cmds[0].write_flag = 1;
> +
> +	/* send image chunk */
> +	multi_cmd->cmds[1].opcode = MMC_WRITE_BLOCK;
> +	multi_cmd->cmds[1].blksz = sect_size;
> +	multi_cmd->cmds[1].blocks = 1;
> +	multi_cmd->cmds[1].arg = arg;
> +	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_ADTC;
> +	multi_cmd->cmds[1].write_flag = 1;
> +	mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf);
> +
> +	/* return device into normal mode */
> +	multi_cmd->cmds[2].opcode = MMC_SWITCH;
> +	multi_cmd->cmds[2].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24)
> |
> +			(EXT_CSD_MODE_CONFIG << 16) |
> +			(EXT_CSD_NORMAL_MODE << 8) |
> +			EXT_CSD_CMD_SET_NORMAL;
> +	multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
> MMC_CMD_AC;
> +	multi_cmd->cmds[2].write_flag = 1;
> +
> +do_retry:
> +	/* read firmware chunk */
> +	lseek(img_fd, 0, SEEK_SET);
> +	chunk_size = read(img_fd, buf, 512);
> +
> +	while (chunk_size > 0) {
> +		/* send ioctl with multi-cmd */
> +		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +
> +		if (ret) {
> +			perror("Multi-cmd ioctl");
> +			/* In case multi-cmd ioctl failed before exiting from ffu
> mode */
> +			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
> +			goto out;
> +		}
> +
> +		ret = read_extcsd(dev_fd, ext_csd);
> +		if (ret) {
> +			fprintf(stderr, "Could not read EXT_CSD from %s\n",
> device);
> +			goto out;
> +		}
> +
> +		/* Test if we need to restart the download */
> +		sect_done = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
> +
> 	ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
> +
> 	ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
> +
> 	ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
> +		/* By spec, host should re-start download from the first sector
> if sect_done is 0 */
> +		if (sect_done == 0) {
> +			if (retry > 0) {
> +				retry--;
> +				fprintf(stderr, "Programming failed. Retrying...
> (%d)\n", retry);
> +				goto do_retry;
> +			}
> +			fprintf(stderr, "Programming failed! Aborting...\n");
> +			goto out;
> +		} else {
> +			fprintf(stderr, "Programmed %d/%jd bytes\r",
> sect_done * sect_size, (intmax_t)fw_size);
> +		}
> +
> +		/* read the next firmware chunk (if any) */
> +		chunk_size = read(img_fd, buf, 512);
> +	}
> +
> +	if ((sect_done * sect_size) == fw_size) {
> +		fprintf(stderr, "Programmed %jd/%jd bytes\n",
> (intmax_t)fw_size, (intmax_t)fw_size);
> +		fprintf(stderr, "Programming finished with status %d \n", ret);
> +	}
> +	else {
> +		fprintf(stderr, "FW size and number of sectors written
> mismatch. Status return %d\n", ret);
> +		goto out;
> +	}
> +
> +	/* check mode operation for ffu install*/
> +	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> +		fprintf(stderr, "Please reboot to complete firmware installation
> on %s\n", device);
> +	} else {
> +		fprintf(stderr, "Installing firmware on %s...\n", device);
> +		/* Re-enter ffu mode and install the firmware */
> +		multi_cmd->num_of_cmds = 2;
> +
> +		/* set ext_csd to install mode */
> +		multi_cmd->cmds[1].opcode = MMC_SWITCH;
> +		multi_cmd->cmds[1].blksz = 0;
> +		multi_cmd->cmds[1].blocks = 0;
> +		multi_cmd->cmds[1].arg =
> (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
> +				(EXT_CSD_MODE_OPERATION_CODES << 16)
> |
> +				(EXT_CSD_FFU_INSTALL << 8) |
> +				EXT_CSD_CMD_SET_NORMAL;
> +		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B |
> MMC_RSP_R1B | MMC_CMD_AC;
> +		multi_cmd->cmds[1].write_flag = 1;
> +
> +		/* send ioctl with multi-cmd */
> +		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +
> +		if (ret) {
> +			perror("Multi-cmd ioctl failed setting install mode");
> +			/* In case multi-cmd ioctl failed before exiting from ffu
> mode */
> +			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[2]);
> +			goto out;
> +		}
> +
> +		ret = read_extcsd(dev_fd, ext_csd);
> +		if (ret) {
> +			fprintf(stderr, "Could not read EXT_CSD from %s\n",
> device);
> +			goto out;
> +		}
> +
> +		/* return status */
> +		ret = ext_csd[EXT_CSD_FFU_STATUS];
> +		if (ret) {
> +			fprintf(stderr, "%s: error %d during FFU install:\n",
> device, ret);
> +			goto out;
> +		} else {
> +			fprintf(stderr, "FFU finished successfully\n");
> +		}
> +	}
> +
> +out:
> +	free(buf);
> +	free(multi_cmd);
> +	close(img_fd);
> +	close(dev_fd);
> +	return ret;
> +#endif
> +}
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 75d8f8c..54abf0f 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -12,6 +12,9 @@
>   * License along with this program; if not, write to the
>   * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
>   * Boston, MA 021110-1307, USA.
> + *
> + * Modified to add field firmware update support,
> + * those modifications are Copyright (c) 2016 SanDisk Corp.
>   */
> 
>  /* mmc_cmds.c */
> @@ -36,3 +39,4 @@ int do_rpmb_read_block(int nargs, char **argv);  int
> do_rpmb_write_block(int nargs, char **argv);  int do_cache_en(int nargs, char
> **argv);  int do_cache_dis(int nargs, char **argv);
> +int do_ffu(int nargs, char **argv);
> --
> 1.9.1
