From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix FSL ESDHC reset handling quirk
Date: Fri, 5 Dec 2014 20:07:18 +0800
Message-ID: <CAA+hA=QRDnkG50=ah6ze6=nzL3fpbSUqdB9WZzVYevmrpJTWfA@mail.gmail.com>
References: <1417773533-10052-1-git-send-email-alessio.bogani@elettra.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:60749 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaLEMHT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Dec 2014 07:07:19 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so318819qcy.21
        for <linux-mmc@vger.kernel.org>; Fri, 05 Dec 2014 04:07:18 -0800 (PST)
In-Reply-To: <1417773533-10052-1-git-send-email-alessio.bogani@elettra.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Cc: Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Dec 5, 2014 at 5:58 PM, Alessio Igor Bogani
<alessio.bogani@elettra.eu> wrote:
> The commit 0718e59ae259 ("mmc: sdhci: move FSL ESDHC reset handling quirk into
> esdhc code") states that Freescale esdhc is the only controller which needs
> the interrupt registers restored after a reset. So it moves
> SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET quirk handling code into the
> esdhc-imx driver only. Unfortunately the same controller is used in
> other boards which use the of-esdhc driver instead (like powerpc P2020).
>
> This patch partially reverts the above mentioned commit and make
> SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET dependency explicit in both drivers.
>
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>

Personally i prefer to manually restore irq in sdhci-of-esdhc driver
too as imx esdhc driver
instead of reverting the patch to avoid adding new QUIRK in common
driver if it's only
for esdhc controller.

I think people hates to see a lot QUIRK in common driver...

Regards
Dong Aisheng

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++----------
>  drivers/mmc/host/sdhci-of-esdhc.c  |  1 +
>  drivers/mmc/host/sdhci.c           |  5 +++++
>  include/linux/mmc/sdhci.h          |  2 ++
>  4 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 587ee0e..216e765 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -872,14 +872,6 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>         esdhc_change_pinstate(host, timing);
>  }
>
> -static void esdhc_reset(struct sdhci_host *host, u8 mask)
> -{
> -       sdhci_reset(host, mask);
> -
> -       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> -       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> -}
> -
>  static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -912,14 +904,15 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>         .set_timeout = esdhc_set_timeout,
>         .set_bus_width = esdhc_pltfm_set_bus_width,
>         .set_uhs_signaling = esdhc_set_uhs_signaling,
> -       .reset = esdhc_reset,
> +       .reset = sdhci_reset,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
>         .quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
>                         | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
>                         | SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
> -                       | SDHCI_QUIRK_BROKEN_CARD_DETECTION,
> +                       | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> +                       | SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET,
>         .ops = &sdhci_esdhc_ops,
>  };
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 8872c85..9121078 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -359,6 +359,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>                  * host control register
>                  */
>                 host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
> +               host->quirks |= SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET;
>         }
>
>         /* call to generic mmc_of_parse to support additional capabilities */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ada1a3e..ac86775 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -205,6 +205,11 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
>
>         host->ops->reset(host, mask);
>
> +       if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET) {
> +               sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +               sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +       }
> +
>         if (mask & SDHCI_RESET_ALL) {
>                 if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
>                         if (host->ops->enable_dma)
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index dba793e..201978d 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -59,6 +59,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_INVERTED_WRITE_PROTECT             (1<<16)
>  /* Controller does not like fast PIO transfers */
>  #define SDHCI_QUIRK_PIO_NEEDS_DELAY                    (1<<18)
> +/* Controller losing signal/interrupt enable states after reset */
> +#define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET           (1<<19)
>  /* Controller has to be forced to use block size of 2048 bytes */
>  #define SDHCI_QUIRK_FORCE_BLK_SZ_2048                  (1<<20)
>  /* Controller cannot do multi-block transfers */
> --
> 2.1.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
