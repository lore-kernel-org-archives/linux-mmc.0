From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH mmc/next] mmc: renesas-sdhi: provide a whitelist for Gen3
 SoC ES versions
Date: Mon, 14 Aug 2017 15:24:36 +0200
Message-ID: <CAMuHMdUxiknajWxdNohSXA5hGdj1Gz1CdQ8Vu81rf+S5LbKnrg@mail.gmail.com>
References: <1501678122-13956-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36537 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdHNNYh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Aug 2017 09:24:37 -0400
In-Reply-To: <1501678122-13956-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Simon,

On Wed, Aug 2, 2017 at 2:48 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Provide a whitelist for Gen3 SoC ES versions for both the SYS DMAC and
> internal DMAC variants of the SDHI driver.  This is to allow drivers to
> only initialise for Gen3 SoC ES versions for which they are the appropriate
> DMAC implementation.  Currently internal DMAC is the appropriate
> implementation for all supported Gen3 SoC ES versions.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 15 +++++++++++++++
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index a26c6ed8e029..6717003888e2 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c

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

The pattern followed here is different from the pattern followed so far in
other places where we use soc_device_match(): instead of implementing a
specific behavior for early SoC revisions, and another behavior for later (and
future!) SoC revisions, this check tests for all current SoC revisions, and
breaks[*] for future versions (R-Car H3 ES2.1 and later, R-Car M3-W ES1.1 and
later).

I guess this is done this way because we don't have any R-Car Gen3 SoCs yet
that do support SYS-DMAC for SDHI?

[*] I understand it doesn't really break, but falls back to PIO on future
    revisions? Hence it should be OK.

> +
>         return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops);
>  }
>
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index b6789f5197b3..718cb8a9d2ce 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c

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

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
