From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc-util: add the method to enable the bkops
Date: Tue, 17 Jul 2012 15:06:30 +0530
Message-ID: <CANfBPZ--SWDN+VM+zrBzrOhqW0wB5mSHCMF4XSWz_rE9EtV3XA@mail.gmail.com>
References: <5004D179.6080706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:57021 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293Ab2GQJgy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 05:36:54 -0400
Received: by bkty7 with SMTP id y7so124759bkt.3
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jul 2012 02:36:51 -0700 (PDT)
In-Reply-To: <5004D179.6080706@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Maya Erez <merez@codeaurora.org>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>

Minor printk nits..

On Tue, Jul 17, 2012 at 8:14 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This patch added the method to enable the bkops.
> In ext_csd register, BKOPS_EN bit is one-time programable.
> So if you want to use the bkops, use the this command.
>
> <usage>
> #mmc bkops enable /dev/mmcblk0
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  mmc.c      |    5 +++++
>  mmc.h      |    7 +++++++
>  mmc_cmds.c |   39 +++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |    1 +
>  4 files changed, 52 insertions(+), 0 deletions(-)
>
> diff --git a/mmc.c b/mmc.c
> index 379d667..3a12653 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -75,6 +75,11 @@ static struct Command commands[] = {
>                 "Enable the boot partition for the <device>.\nTo receive acknowledgment of boot from the card set <send_ack>\nto 1, else set it to 0.",
>           NULL
>         },
> +       { do_write_bkops_en, -1,
> +         "bkops enable", "<device>\n"
> +               "Enable the eMMC BKOPS feature enable on <device>.",
s/feature enable on/feature on/

> +         NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>
> diff --git a/mmc.h b/mmc.h
> index 0a521a8..3d77b38 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -31,12 +31,14 @@
>   */
>  #define EXT_CSD_S_CMD_SET              504
>  #define EXT_CSD_HPI_FEATURE            503
> +#define EXT_CSD_BKOPS_SUPPORT          502     /* RO */
>  #define EXT_CSD_BOOT_INFO              228     /* R/W */
>  #define EXT_CSD_PART_SWITCH_TIME       199
>  #define EXT_CSD_BOOT_CFG               179
>  #define EXT_CSD_PART_CONFIG            179
>  #define EXT_CSD_BOOT_WP                        173
>  #define EXT_CSD_WR_REL_PARAM           166
> +#define EXT_CSD_BKOPS_EN               163     /* R/W */
>  #define EXT_CSD_NATIVE_SECTOR_SIZE     63 /* R */
>  #define EXT_CSD_USE_NATIVE_SECTOR      62 /* R/W */
>  #define EXT_CSD_DATA_SECTOR_SIZE       61 /* R */
> @@ -48,6 +50,11 @@
>  #define EN_REL_WR      (1<<2)
>
>  /*
> + * BKOPS_EN field definition
> + */
> +#define BKOPS_ENABLE   (1<<0)
> +
> +/*
>   * EXT_CSD field definitions
>   */
>  #define EXT_CSD_HPI_SUPP               (1<<0)
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 90619db..271d1e4 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -280,6 +280,45 @@ int do_write_boot_en(int nargs, char **argv)
>         return ret;
>  }
>
> +int do_write_bkops_en(int nargs, char **argv)
> +{
> +       __u8 ext_csd[512], value = 0;
> +       int fd, ret;
> +       char *device;
> +
> +       CHECK(nargs != 2, "Usage: mmc bkops enable </path/to/mmcblkX>\n",
> +                       exit(1));
> +
> +       device = argv[1];
> +
> +       fd = open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("open");
> +               exit(1);
> +       }
> +
> +       ret = read_extcsd(fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
> +               exit(1);
> +       }
> +
> +       if (!(ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)) {
> +               fprintf(stderr, "Didn't support BKOPS from %s\n", device);

Better reported as fprintf(stderr, "%s does not support BKOPS\n", device);

After fixing this, feel free to add my
Reviewed-by: Venkatraman S<svenkatr@ti.com>
