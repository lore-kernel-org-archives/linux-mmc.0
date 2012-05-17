From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH 2/2] [MMC-4.5] [MMC UTIL] Disable emulation
Date: Thu, 17 May 2012 13:18:55 +0530
Message-ID: <000001cd3401$8511cb80$8f356280$@codeaurora.org>
References: <1337185615-17202-1-git-send-email-saugata.das@stericsson.com> <1337185615-17202-2-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:24955 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760778Ab2EQHtA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 May 2012 03:49:00 -0400
In-Reply-To: <1337185615-17202-2-git-send-email-saugata.das@stericsson.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Saugata Das' <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, venkat@linaro.org
Cc: patches@linaro.org, saugata.das@linaro.org, arnd.bergmann@linaro.org, lporzio@micron.com

Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

Sougata,
There are additional blank lines before and after the
do_disable_512B_emulation() function. You may want to remove them.

Regards,
Subhash

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Saugata Das
> Sent: Wednesday, May 16, 2012 9:57 PM
> To: linux-mmc@vger.kernel.org; venkat@linaro.org
> Cc: patches@linaro.org; saugata.das@linaro.org; arnd.bergmann@linaro.org;
> lporzio@micron.com
> Subject: [PATCH 2/2] [MMC-4.5] [MMC UTIL] Disable emulation
> 
> From: Saugata Das <saugata.das@linaro.org>
> 
> In this patch, we add utility to disable emulation mode in the eMMC-4.5.
> This is done to increase the data sector size to 4KB.
> 
> Signed-off-by: Saugata Das <saugata.das@linaro.org>
> 
> changes in v2:
> 	Review rework based on comments from Subhash
> ---
>  mmc.c      |    6 ++++++
>  mmc.h      |   10 ++++++++++
>  mmc_cmds.c |   51
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |    1 +
>  4 files changed, 68 insertions(+), 0 deletions(-)
> 
> diff --git a/mmc.c b/mmc.c
> index c27fc24..ebc7ab2 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -65,6 +65,12 @@ static struct Command commands[] = {
>  		"Set the eMMC writeprotect status of <device>.",
>  	  NULL
>  	},
> +	{ do_disable_512B_emulation, -1,
> +	  "disable 512B emulation", "<device>\n"
> +		"Set the eMMC data sector size to 4KB by disabling emulation
> <device>.",
> +	  NULL
> +	},
> +
>  	{ 0, 0, 0, 0 }
>  };
> 
> diff --git a/mmc.h b/mmc.h
> index 3af36f1..34c31d3 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -35,6 +35,16 @@
>  #define EXT_CSD_PART_SWITCH_TIME	199
>  #define EXT_CSD_BOOT_CFG		179
>  #define EXT_CSD_BOOT_WP			173
> +#define EXT_CSD_WR_REL_PARAM	166
> +#define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
> +#define EXT_CSD_USE_NATIVE_SECTOR	62 /* R/W */
> +#define EXT_CSD_DATA_SECTOR_SIZE	61 /* R */
> +
> +/*
> + * WR_REL_PARAM field definitions
> + */
> +#define HS_CTRL_REL	(1<<0)
> +#define EN_REL_WR	(1<<2)
> 
>  /*
>   * EXT_CSD field definitions
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 4562cef..f0e64c9 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -168,6 +168,57 @@ int do_writeprotect_set(int nargs, char **argv)
>  	return ret;
>  }
> 
> +
> +int do_disable_512B_emulation(int nargs, char **argv) {
> +	__u8 ext_csd[512], native_sector_size, data_sector_size,
> wr_rel_param;
> +	int fd, ret;
> +	char *device;
> +
> +	CHECK(nargs != 2, "Usage: mmc </path/to/mmcblkX>\n", exit(1));
> +
> +	device = argv[1];
> +
> +	fd = open(device, O_RDWR);
> +	if (fd < 0) {
> +		perror("open");
> +		exit(1);
> +	}
> +
> +	ret = read_extcsd(fd, ext_csd);
> +	if (ret) {
> +		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> +		exit(1);
> +	}
> +
> +	wr_rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
> +	native_sector_size = ext_csd[EXT_CSD_NATIVE_SECTOR_SIZE];
> +	data_sector_size = ext_csd[EXT_CSD_DATA_SECTOR_SIZE];
> +
> +	if (native_sector_size &&
> +		!data_sector_size &&
> +		(wr_rel_param & EN_REL_WR)) {
> +		ret = write_extcsd_value(fd,
> EXT_CSD_USE_NATIVE_SECTOR, 1);
> +
> +		if (ret) {
> +			fprintf(stderr, "Could not write 0x%02x to "
> +					"EXT_CSD[%d] in %s\n",
> +					1, EXT_CSD_BOOT_WP, device);
> +			exit(1);
> +		}
> +		printf("MMC disable 512B emulation successful\n"
> +				"Now reset the device to switch to 4KB "
> +				"native sector mode\n");
> +	} else if (native_sector_size && data_sector_size) {
> +		printf("MMC already disabled 512B emulation mode\n");
> +	} else {
> +		printf("MMC does not support disabling 512B emulation
> mode\n");
> +	}
> +
> +	return ret;
> +}
> +
> +
>  int do_read_extcsd(int nargs, char **argv)  {
>  	__u8 ext_csd[512], ext_csd_rev, reg;
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 66e9acb..56f46d7 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -19,3 +19,4 @@ int do_read_extcsd(int nargs, char **argv);  int
> do_write_extcsd(int nargs, char **argv);  int do_writeprotect_get(int
nargs,
> char **argv);  int do_writeprotect_set(int nargs, char **argv);
> +int do_disable_512B_emulation(int nargs, char **argv);
> --
> 1.7.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

