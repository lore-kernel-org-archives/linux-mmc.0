From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: add SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33
 quirk support
Date: Thu, 4 Jun 2015 09:48:22 +0200
Message-ID: <CAPDyKFqb3y9xV8ouZyK0bapMs0P+gA+KLux10yHz3K8mbitLHw@mail.gmail.com>
References: <1433228980-5676-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:33778 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbbFDHsX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2015 03:48:23 -0400
Received: by qcmi9 with SMTP id i9so14760435qcm.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2015 00:48:22 -0700 (PDT)
In-Reply-To: <1433228980-5676-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On 2 June 2015 at 09:09, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> This quirk is used for controllers that can only support 1.8V
> voltage but the peripheral hardware circuit has capability to
> support 3.3V voltage.

Which voltage are you referring to? The I/O voltage or the power to
the card? VCC or VCCQ?

Kind regards
Uffe

>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  drivers/mmc/host/sdhci.h | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c80287a..40de0d3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2959,6 +2959,9 @@ int sdhci_add_host(struct sdhci_host *host)
>                         host->caps1 :
>                         sdhci_readl(host, SDHCI_CAPABILITIES_1);
>
> +       if (host->quirks2 & SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33)
> +               caps[0] = caps[0] | SDHCI_CAN_VDD_330;
> +
>         if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>                 host->flags |= SDHCI_USE_SDMA;
>         else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index e639b7f..2704daf1 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -409,6 +409,10 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_SUPPORT_SINGLE                    (1<<13)
>  /* Controller broken with using ACMD23 */
>  #define SDHCI_QUIRK2_ACMD23_BROKEN                     (1<<14)
> +/* Controller only supports 1.8V, but the peripheral hardware
> + * circuit has capability to support 3.3V
> + */
> +#define SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33              (1<<15)
>
>         int irq;                /* Device IRQ */
>         void __iomem *ioaddr;   /* Mapped address */
> --
> 2.1.0.27.g96db324
>
