From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: s3cmci: Use DMA slave map rather than exported
 DMA filter
Date: Thu, 27 Oct 2016 09:47:20 +0200
Message-ID: <CAPDyKFr-m8thnPLpoyn_67AMcCs_fGYHZzc3Te-hpYOn1R7sRQ@mail.gmail.com>
References: <1477499453-22549-1-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:32815 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935819AbcJ0Opx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 10:45:53 -0400
Received: by mail-lf0-f42.google.com with SMTP id x79so33683136lff.0
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 07:45:52 -0700 (PDT)
In-Reply-To: <1477499453-22549-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, sam.van.den.berge@telenet.be, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 26 October 2016 at 18:30, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> Support for DMA slave map has been added to the s3c24xx-dma
> controller in commit 34681d84a0f7cc22ded1413dc79eef8a2f23d9c3
> "dmaengine: s3c24xx: Add dma_slave_map for s3c2440 devices"
> This patch converts the s3cmci driver to also use it, so we can
> eventually get rid of the exported filter function once all
> related DMA clients are updated.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes since v1:
>  - dma_request_chan() used instead of dma_request_slave_channel()
>    for better error handling.
>
>  drivers/mmc/host/s3cmci.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index c531dee..932a4b1 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -28,7 +28,6 @@
>  #include <mach/dma.h>
>  #include <mach/gpio-samsung.h>
>
> -#include <linux/platform_data/dma-s3c24xx.h>
>  #include <linux/platform_data/mmc-s3cmci.h>
>
>  #include "s3cmci.h"
> @@ -1682,19 +1681,13 @@ static int s3cmci_probe(struct platform_device *pdev)
>                 gpio_direction_input(host->pdata->gpio_wprotect);
>         }
>
> -       /* depending on the dma state, get a dma channel to use. */
> +       /* Depending on the dma state, get a DMA channel to use. */
>
>         if (s3cmci_host_usedma(host)) {
> -               dma_cap_mask_t mask;
> -
> -               dma_cap_zero(mask);
> -               dma_cap_set(DMA_SLAVE, mask);
> -
> -               host->dma = dma_request_slave_channel_compat(mask,
> -                       s3c24xx_dma_filter, (void *)DMACH_SDI, &pdev->dev, "rx-tx");
> -               if (!host->dma) {
> +               host->dma = dma_request_chan(&pdev->dev, "rx-tx");
> +               ret = PTR_ERR_OR_ZERO(host->dma);
> +               if (ret) {
>                         dev_err(&pdev->dev, "cannot get DMA channel.\n");
> -                       ret = -EBUSY;
>                         goto probe_free_gpio_wp;
>                 }
>         }
> --
> 1.9.1
>
