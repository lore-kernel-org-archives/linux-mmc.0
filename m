From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH mmc/next] mmc: renesas-sdhi: provide a whitelist for Gen3
 SoC ES versions
Date: Thu, 3 Aug 2017 12:52:04 +0200
Message-ID: <CAPDyKFrFPh0VZZaOjt1T_9am+ZQfqVg1zexjtzH8nO++c-vVRg@mail.gmail.com>
References: <1501678122-13956-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35798 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbdHCKwG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2017 06:52:06 -0400
Received: by mail-qk0-f175.google.com with SMTP id d145so5228827qkc.2
        for <linux-mmc@vger.kernel.org>; Thu, 03 Aug 2017 03:52:05 -0700 (PDT)
In-Reply-To: <1501678122-13956-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 2 August 2017 at 14:48, Simon Horman <horms+renesas@verge.net.au> wrote:
> Provide a whitelist for Gen3 SoC ES versions for both the SYS DMAC and
> internal DMAC variants of the SDHI driver.  This is to allow drivers to
> only initialise for Gen3 SoC ES versions for which they are the appropriate
> DMAC implementation.  Currently internal DMAC is the appropriate
> implementation for all supported Gen3 SoC ES versions.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 15 +++++++++++++++
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index a26c6ed8e029..6717003888e2 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/scatterlist.h>
> +#include <linux/sys_soc.h>
>
>  #include "renesas_sdhi.h"
>  #include "tmio_mmc.h"
> @@ -241,8 +242,22 @@ static struct tmio_mmc_dma_ops renesas_sdhi_internal_dmac_dma_ops = {
>         .dataend = renesas_sdhi_internal_dmac_dataend_dma,
>  };
>
> +/*
> + * Whitelist of specific R-Car Gen3 SoC ES versions to use this DMAC
> + * implementation as others may use a different implementation.
> + */
> +static const struct soc_device_attribute gen3_soc_whitelist[] = {
> +        { .soc_id = "r8a7795", .revision = "ES1.*" },
> +        { .soc_id = "r8a7795", .revision = "ES2.0" },
> +        { .soc_id = "r8a7796", .revision = "ES1.0" },
> +        { /* sentinel */ }
> +};
> +
>  static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
>  {
> +       if (!soc_device_match(gen3_soc_whitelist))
> +               return -ENODEV;
> +
>         return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops);
>  }
>
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index b6789f5197b3..718cb8a9d2ce 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -18,8 +18,10 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/pagemap.h>
>  #include <linux/scatterlist.h>
> +#include <linux/sys_soc.h>
>
>  #include "renesas_sdhi.h"
>  #include "tmio_mmc.h"
> @@ -459,8 +461,21 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_sys_dmac_dma_ops = {
>         .dataend = renesas_sdhi_sys_dmac_dataend_dma,
>  };
>
> +/*
> + * Whitelist of specific R-Car Gen3 SoC ES versions to use this DMAC
> + * implementation. Currently empty as all supported ES versions use
> + * the internal DMAC.
> + */
> +static const struct soc_device_attribute gen3_soc_whitelist[] = {
> +        { /* sentinel */ }
> +};
> +
>  static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
>  {
> +       if (of_device_get_match_data(&pdev->dev) == &of_rcar_gen3_compatible &&
> +           !soc_device_match(gen3_soc_whitelist))
> +               return -ENODEV;
> +
>         return renesas_sdhi_probe(pdev, &renesas_sdhi_sys_dmac_dma_ops);
>  }
>
> --
> 2.1.4
>
