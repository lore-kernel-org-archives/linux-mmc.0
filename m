From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 RESEND] sdhci: Ignore unexpected CARD_INT interrupts
Date: Thu, 19 Jan 2017 12:28:26 +0200
Message-ID: <de8e1567-0392-6de7-9669-0f7ace327d56@intel.com>
References: <20170116142342.21283-1-krisman@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18740 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751727AbdASKdo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Jan 2017 05:33:44 -0500
In-Reply-To: <20170116142342.21283-1-krisman@collabora.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.co.uk>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

On 16/01/17 16:23, Gabriel Krisman Bertazi wrote:
> One of our kernelCI boxes hanged at boot because a faulty eSDHC device
> was triggering spurious CARD_INT interrupts for SD cards, causing CMD52
> reads, which are not allowed for SD devices.  This adds a sanity check
> to the interruption path, preventing that illegal command from getting
> sent if the CARD_INT interruption should be disabled.
> 
> This quirk allows that particular machine to resume boot despite the
> faulty hardware, instead of getting hung dealing with thousands of
> mishandled interrupts.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc@vger.kernel.org

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 51cd4f0e973f..a2efa25c7f3b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2733,7 +2733,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  		if (intmask & SDHCI_INT_RETUNE)
>  			mmc_retune_needed(host->mmc);
>  
> -		if (intmask & SDHCI_INT_CARD_INT) {
> +		if ((intmask & SDHCI_INT_CARD_INT) &&
> +		    (host->ier & SDHCI_INT_CARD_INT)) {
>  			sdhci_enable_sdio_irq_nolock(host, false);
>  			host->thread_isr |= SDHCI_INT_CARD_INT;
>  			result = IRQ_WAKE_THREAD;
> 

