From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH] mmc: sdhci-pci: remove SDHCI_QUIRK2_OWN_CARD_DETECTION
Date: Mon, 12 Dec 2011 10:38:20 +0800
Message-ID: <5D8008F58939784290FAB48F549751984EC27784E0@shsmsx502.ccr.corp.intel.com>
References: <1323416198-14200-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8688 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756Ab1LLCjS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Dec 2011 21:39:18 -0500
In-Reply-To: <1323416198-14200-1-git-send-email-adrian.hunter@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>

Hi Adrian,
> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Adrian Hunter
> Sent: Friday, December 09, 2011 3:37 PM
> To: Chris Ball
> Cc: linux-mmc@vger.kernel.org; Hunter, Adrian
> Subject: [PATCH] mmc: sdhci-pci: remove SDHCI_QUIRK2_OWN_CARD_DETECTION
> 
> Even if a driver provides separate card detection,
> an interrupt is still needed to abort mmc requests
> that are in progress.  SDHCI_QUIRK2_OWN_CARD_DETECTION
> prevents that, so remove it.
I think this should be considered by the new registered irq handler but not directly removing this quirk.
If removing it directly, inserting/removing a card will cause driver to get two interrupts and that makes people confusing why there are two interrupts actually. So, shall we change the mfd_sd_cd function like below?

static irqreturn_t mfd_sd_cd(int irq, void *dev_id)
{
	struct sdhci_pci_slot *slot = dev_id;
	struct sdhci_host *host = slot->host;

	if (host->card_tasklet.func == NULL)
		return IRQ_NONE;

	tasklet_schedule(&host->card_tasklet);

	return IRQ_HANDLED;
}

With this, driver can also abort the mmc requests that are in progress.

Thanks
Chuanxiao
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-pci.c |    1 -
>  drivers/mmc/host/sdhci.c     |    3 ---
>  include/linux/mmc/sdhci.h    |    2 --
>  3 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index d2e77fb..abced67 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -233,7 +233,6 @@ static int mfd_sd_probe_slot(struct sdhci_pci_slot *slot)
> 
>  	slot->cd_gpio = gpio;
>  	slot->cd_irq = irq;
> -	slot->host->quirks2 |= SDHCI_QUIRK2_OWN_CARD_DETECTION;
> 
>  	return 0;
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ab6018f..ec10288 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -149,9 +149,6 @@ static void sdhci_set_card_detection(struct sdhci_host
> *host, bool enable)
>  	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>  		return;
> 
> -	if (host->quirks2 & SDHCI_QUIRK2_OWN_CARD_DETECTION)
> -		return;
> -
>  	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>  			      SDHCI_CARD_PRESENT;
>  	irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index e4b6935..dad7a46 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -90,8 +90,6 @@ struct sdhci_host {
> 
>  	unsigned int quirks2;	/* More deviations from spec. */
> 
> -#define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
> -
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 
> --
> 1.7.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
