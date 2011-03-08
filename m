From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH resend] sdhci: work around broken dma boundary behaviour
Date: Tue, 08 Mar 2011 15:12:18 -0500
Message-ID: <m31v2hqsm5.fsf@pullcord.laptop.org>
References: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48821 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549Ab1CHUOb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Mar 2011 15:14:31 -0500
In-Reply-To: <1299530457-19904-1-git-send-email-mmvinni@yahoo.com> (Mikko
	Vinni's message of "Mon, 7 Mar 2011 22:40:57 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: linux-mmc@vger.kernel.org

Hi Mikko,

On Mon, Mar 07 2011, Mikko Vinni wrote:
> Some SD host controllers (noticed on an integrated JMicron SD reader
> on an HP Pavilion dv5-1250eo laptop) don't update the dma address
> register before signaling a dma interrupt due to a dma boundary.
> Detect this and update the register to the next 512KB boundary,
> at which the transfer presumably stopped.
>
> As long as each transfer is at most 512KB in size (on this hardware
> the max seems to be 65536 bytes), this fix is needed at most once
> per transfer.
>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=28462
>
> Signed-off-by: Mikko Vinni <mmvinni <at> yahoo.com>
> ---
> Sent on 2011-02-21 21:23:32 GMT
> (http://thread.gmane.org/gmane.linux.kernel.mmc/5568/focus=6145)
>
> Hoping to be able to drop this patch eventually from my own
> repo and have the hardware just work with mainline code.
> Maybe first in -next if nobody sees any serious problems
> straight away?
>
> This patch should not break anything for anybody whose
> hardware isn't already broken.
>
>  drivers/mmc/host/sdhci.c |   24 +++++++++++++++++++++---
>  1 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a25db42..8651731 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1537,9 +1537,27 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  		 * boundaries, but as we can't disable the feature
>  		 * we need to at least restart the transfer.
>  		 */
> -		if (intmask & SDHCI_INT_DMA_END)
> -			sdhci_writel(host, sdhci_readl(host, SDHCI_DMA_ADDRESS),
> -				SDHCI_DMA_ADDRESS);
> +		if (intmask & SDHCI_INT_DMA_END) {
> +			u32 dmastart, dmanow;
> +			dmastart = sg_dma_address(host->data->sg);
> +			dmanow = sdhci_readl(host, SDHCI_DMA_ADDRESS);
> +			if (dmanow == dmastart) {
> +				/*
> +				 * HW failed to increase the address.
> +				 * Update to the next 512KB block boundary.
> +				 */
> +				dmanow = (dmanow & ~0x7ffff) + 0x80000;
> +				if (dmanow > dmastart + host->data->blksz *
> +							host->data->blocks) {
> +					WARN_ON(1);
> +					dmanow = dmastart;
> +				}
> +				DBG("%s: next DMA address forced "
> +				    "from 0x%08x to 0x%08x\n",
> +				    mmc_hostname(host->mmc), dmastart, dmanow);
> +			}
> +			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +		}
>  
>  		if (intmask & SDHCI_INT_DATA_END) {
>  			if (host->cmd) {

Thanks, I agree, pushed to -next for testing.  I'd still appreciate
a Reviewed-by: from someone on linux-mmc@, and would like to hear
if anyone thinks this needs to be a quirk rather than a generic fix.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
