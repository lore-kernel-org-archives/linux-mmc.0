From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RESEND] sdhci: Only handle CARD_INT for SDIO cards
Date: Thu, 5 Jan 2017 11:36:49 +0200
Message-ID: <39099b85-e55c-ac70-8e0f-889638a68418@intel.com>
References: <20170102182350.14326-1-krisman@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:41864 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762478AbdAEJl7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Jan 2017 04:41:59 -0500
In-Reply-To: <20170102182350.14326-1-krisman@collabora.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org

On 02/01/17 20:23, Gabriel Krisman Bertazi wrote:
> One of our kernelCI boxes hanged at boot because a faulty eSDHC device
> was triggering spurious CARD_INT interrupts for SD cards, causing CMD52
> reads, which are not allowed for SD devices.  This adds a sanity check
> to the interruption path, preventing that illegal command from getting
> sent to SD devices.
> 
> This quirk allows that particular machine to resume boot despite the
> faulty hardware, instead of getting hung dealing with thousands of
> mishandled interrupts.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
> CC: Adrian Hunter <adrian.hunter@intel.com>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 23909804ffb8..43913876581e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2665,6 +2665,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  {
>  	irqreturn_t result = IRQ_NONE;
>  	struct sdhci_host *host = dev_id;
> +	struct mmc_host *mmc = host->mmc;
>  	u32 intmask, mask, unexpected = 0;
>  	int max_loops = 16;
>  
> @@ -2733,7 +2734,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  		if (intmask & SDHCI_INT_RETUNE)
>  			mmc_retune_needed(host->mmc);
>  
> -		if (intmask & SDHCI_INT_CARD_INT) {
> +		if (intmask & SDHCI_INT_CARD_INT && mmc->card &&
> +		    (mmc->card->type == MMC_TYPE_SDIO ||
> +		     mmc->card->type == MMC_TYPE_SD_COMBO)) {

We shouldn't have to look at the card type.  But if the interrupt is not
enabled, then we shouldn't process it.  What about:

		if (intmask & SDHCI_INT_CARD_INT &&
		    (host->ier & SDHCI_INT_CARD_INT)) {

>  			sdhci_enable_sdio_irq_nolock(host, false);
>  			host->thread_isr |= SDHCI_INT_CARD_INT;
>  			result = IRQ_WAKE_THREAD;
> 

