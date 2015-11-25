From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: mvsdio: delete platform data code path
Date: Wed, 25 Nov 2015 17:34:20 +0100
Message-ID: <CAPDyKFo0LxjhEna+Koqgg1Ckpvi=reP8VDCPXnzUxy0UVL5dOA@mail.gmail.com>
References: <1448459877-32626-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:32955 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbbKYQeU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 11:34:20 -0500
Received: by ykdv3 with SMTP id v3so61569730ykd.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 08:34:20 -0800 (PST)
In-Reply-To: <1448459877-32626-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On 25 November 2015 at 14:57, Linus Walleij <linus.walleij@linaro.org> wrote:
> There are no in-kernel users of the MVSDIO platform data method
> (instantiating from a board file) so just delete this code and
> make this a DT-only driver. We depend on OF and check that we have
> an OF node in probe().
>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, applied for next!

I decided to keep the patches as is, because I think the split
provided an easy way to review the changes.

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig  |  1 +
>  drivers/mmc/host/mvsdio.c | 63 +++++++++++------------------------------------
>  2 files changed, 15 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1dee533634c9..1526b8a10b09 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -455,6 +455,7 @@ config MMC_TIFM_SD
>  config MMC_MVSDIO
>         tristate "Marvell MMC/SD/SDIO host driver"
>         depends on PLAT_ORION
> +       depends on OF
>         ---help---
>           This selects the Marvell SDIO host driver.
>           SDIO may currently be found on the Kirkwood 88F6281 and 88F6192
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 18c70380ea93..42296e55b9de 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -20,8 +20,6 @@
>  #include <linux/scatterlist.h>
>  #include <linux/irq.h>
>  #include <linux/clk.h>
> -#include <linux/gpio.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_irq.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/slot-gpio.h>
> @@ -36,12 +34,6 @@
>  static int maxfreq;
>  static int nodma;
>
> -struct mvsdio_platform_data {
> -       unsigned int clock;
> -       int gpio_card_detect;
> -       int gpio_write_protect;
> -};
> -
>  struct mvsd_host {
>         void __iomem *base;
>         struct mmc_request *mrq;
> @@ -709,6 +701,10 @@ static int mvsd_probe(struct platform_device *pdev)
>         struct resource *r;
>         int ret, irq;
>
> +       if (!np) {
> +               dev_err(&pdev->dev, "no DT node\n");
> +               return -ENODEV;
> +       }
>         r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         irq = platform_get_irq(pdev, 0);
>         if (!r || irq < 0)
> @@ -732,8 +728,12 @@ static int mvsd_probe(struct platform_device *pdev)
>          * fixed rate clock).
>          */
>         host->clk = devm_clk_get(&pdev->dev, NULL);
> -       if (!IS_ERR(host->clk))
> -               clk_prepare_enable(host->clk);
> +       if (IS_ERR(host->clk)) {
> +               dev_err(&pdev->dev, "no clock associated\n");
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +       clk_prepare_enable(host->clk);
>
>         mmc->ops = &mvsd_ops;
>
> @@ -749,45 +749,10 @@ static int mvsd_probe(struct platform_device *pdev)
>         mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count;
>         mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
>
> -       if (np) {
> -               if (IS_ERR(host->clk)) {
> -                       dev_err(&pdev->dev, "DT platforms must have a clock associated\n");
> -                       ret = -EINVAL;
> -                       goto out;
> -               }
> -
> -               host->base_clock = clk_get_rate(host->clk) / 2;
> -               ret = mmc_of_parse(mmc);
> -               if (ret < 0)
> -                       goto out;
> -       } else {
> -               const struct mvsdio_platform_data *mvsd_data;
> -
> -               mvsd_data = pdev->dev.platform_data;
> -               if (!mvsd_data) {
> -                       ret = -ENXIO;
> -                       goto out;
> -               }
> -               mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ |
> -                           MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
> -               host->base_clock = mvsd_data->clock / 2;
> -               /* GPIO 0 regarded as invalid for backward compatibility */
> -               if (mvsd_data->gpio_card_detect &&
> -                   gpio_is_valid(mvsd_data->gpio_card_detect)) {
> -                       ret = mmc_gpio_request_cd(mmc,
> -                                                 mvsd_data->gpio_card_detect,
> -                                                 0);
> -                       if (ret)
> -                               goto out;
> -               } else {
> -                       mmc->caps |= MMC_CAP_NEEDS_POLL;
> -               }
> -
> -               if (mvsd_data->gpio_write_protect &&
> -                   gpio_is_valid(mvsd_data->gpio_write_protect))
> -                       mmc_gpio_request_ro(mmc, mvsd_data->gpio_write_protect);
> -       }
> -
> +       host->base_clock = clk_get_rate(host->clk) / 2;
> +       ret = mmc_of_parse(mmc);
> +       if (ret < 0)
> +               goto out;
>         if (maxfreq)
>                 mmc->f_max = maxfreq;
>
> --
> 2.4.3
>
