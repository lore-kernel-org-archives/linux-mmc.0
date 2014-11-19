From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc_block: Increase max_devices
Date: Wed, 19 Nov 2014 11:30:28 +0100
Message-ID: <CAPDyKFqFOOa9BpXDyu_jcmV69BFxp+pR1b+FYRLv0t7_bfwmrQ@mail.gmail.com>
References: <1415244909.3398.51.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:36604 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598AbaKSKa3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 05:30:29 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so172102qcw.37
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2014 02:30:28 -0800 (PST)
In-Reply-To: <1415244909.3398.51.camel@decadent.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 6 November 2014 04:35, Ben Hutchings <ben@decadent.org.uk> wrote:
> Currently the driver imposes a limit of 256 total minor numbers,
> apparently based on the historic Unix/Linux limit.  This is quite
> restrictive, particularly if we raise the maximum number of
> partitions per card to 256 to match sd.
>
> In order to make the full minor number space available we would
> have to replace the static dev_use and name_use arrays with struct
> ida.  But we can at least allow use of 256 cards rather than just
> 256 minors, with only a small change.
>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1fa4c80..d9783da 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -78,13 +78,16 @@ static int perdev_minors = CONFIG_MMC_BLOCK_MINORS;
>
>  /*
>   * We've only got one major, so number of mmcblk devices is
> - * limited to 256 / number of minors per device.
> + * limited to (1 << 20) / number of minors per device.  It is also
> + * currently limited by the size of the static bitmaps below.
>   */
>  static int max_devices;
>
> -/* 256 minors, so at most 256 separate devices */
> -static DECLARE_BITMAP(dev_use, 256);
> -static DECLARE_BITMAP(name_use, 256);
> +#define MAX_DEVICES 256
> +
> +/* TODO: Replace these with struct ida */
> +static DECLARE_BITMAP(dev_use, MAX_DEVICES);
> +static DECLARE_BITMAP(name_use, MAX_DEVICES);
>
>  /*
>   * There is one mmc_blk_data per slot.
> @@ -2563,7 +2566,7 @@ static int __init mmc_blk_init(void)
>         if (perdev_minors != CONFIG_MMC_BLOCK_MINORS)
>                 pr_info("mmcblk: using %d minors per device\n", perdev_minors);
>
> -       max_devices = 256 / perdev_minors;
> +       max_devices = min(MAX_DEVICES, (1 << MINORBITS) / perdev_minors);
>
>         res = register_blkdev(MMC_BLOCK_MAJOR, "mmc");
>         if (res)
>
> --
> Ben Hutchings
> Beware of programmers who carry screwdrivers. - Leonard Brandwein
