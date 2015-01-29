From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Apply FSL ESDHC reset handling quirk to OF
Date: Thu, 29 Jan 2015 13:19:55 +0100
Message-ID: <CAPDyKFqwieB6h9WXHea1J1QM3yHJgMMH2-b0ym4xUfZc1iHPQw@mail.gmail.com>
References: <20150128195236.GA31422@darwin.bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:45946 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754229AbbA2MT4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jan 2015 07:19:56 -0500
Received: by mail-qg0-f50.google.com with SMTP id f51so27055262qge.9
        for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2015 04:19:55 -0800 (PST)
In-Reply-To: <20150128195236.GA31422@darwin.bork.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Hicks <mort@bork.org>
Cc: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

On 28 January 2015 at 20:52, Martin Hicks <mort@bork.org> wrote:
>
> The reset code was pushed into the esdhc-imx driver, but missed being
> pushed into the FSL OF driver at the same time.  The commit that broke
> the OF ESDHC driver was 0718e59ae259f7c48155b4e852d8b0632d59028e
>
> Signed-off-by: Martin Hicks <mort@bork.org>

Martin, thanks for the patch. Though I have already queued a patch for
this issue. It's available on my next branch.

Alessio Igor Bogani <alessio.bogani@elettra.eu>
mmc: sdhci: Fix FSL ESDHC reset handling quirk

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 8872c85..4a654d4 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -276,6 +276,14 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
>                         ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
>  }
>
> +static void esdhc_reset(struct sdhci_host *host, u8 mask)
> +{
> +       sdhci_reset(host, mask);
> +
> +       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +}
> +
>  static const struct sdhci_ops sdhci_esdhc_ops = {
>         .read_l = esdhc_readl,
>         .read_w = esdhc_readw,
> @@ -290,7 +298,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
>         .platform_init = esdhc_of_platform_init,
>         .adma_workaround = esdhci_of_adma_workaround,
>         .set_bus_width = esdhc_pltfm_set_bus_width,
> -       .reset = sdhci_reset,
> +       .reset = esdhc_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>
> --
> 1.7.10.4
>
>
> --
> Martin Hicks P.Eng.    |      mort@bork.org
> Bork Consulting Inc.   |  +1 (613) 266-2296
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
