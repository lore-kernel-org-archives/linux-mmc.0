From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Fix FSL ESDHC reset handling quirk
Date: Fri, 19 Dec 2014 11:44:34 +0100
Message-ID: <CAPDyKFr-mAW6iUy3SA_5zXjSAF1t_0q-zs8-GSomaEVpzCJC=g@mail.gmail.com>
References: <1418114438-17776-1-git-send-email-alessio.bogani@elettra.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:39593 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaLSKoe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 05:44:34 -0500
Received: by mail-qa0-f41.google.com with SMTP id s7so394468qap.14
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 02:44:34 -0800 (PST)
In-Reply-To: <1418114438-17776-1-git-send-email-alessio.bogani@elettra.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Cc: Chris Ball <chris@printf.net>, Dong Aisheng <dongas86@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 9 December 2014 at 09:40, Alessio Igor Bogani
<alessio.bogani@elettra.eu> wrote:
> The commit 0718e59ae259 ("mmc: sdhci: move FSL ESDHC reset handling quirk into
> esdhc code") states that Freescale esdhc is the only controller which needs
> the interrupt registers restored after a reset. So it moves
> SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET quirk handling code into the
> esdhc-imx driver only. Unfortunately the same controller is used in
> other boards which use the of-esdhc driver instead (like powerpc P2020).
>
> Restore interrupts after reset in the sdhci-of-esdhc driver also.
>
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>

Thanks! Queued for 3.20.

Next time, please bump the version when sending an updated patch.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 10 +++++++++-
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
> 2.1.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
