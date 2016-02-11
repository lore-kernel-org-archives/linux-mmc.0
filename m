From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 1/2] mmc: sdhci: Allow CAPS check for SDHCI_CAN_64BIT
 to use overridden caps
Date: Thu, 11 Feb 2016 14:22:41 +0200
Message-ID: <56BC7D11.6020505@intel.com>
References: <1455135940-29758-1-git-send-email-alcooperx@gmail.com>
 <1455135940-29758-2-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42546 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbcBKM0M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Feb 2016 07:26:12 -0500
In-Reply-To: <1455135940-29758-2-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On 10/02/16 22:25, Al Cooper wrote:
> sdhci_add_host() allows the Host Controller Capability registers
> to be supplied by the calling driver by using
> SDHCI_QUIRK_MISSING_CAPS, but the check for the Capabilities bit
> SDHCI_CAN_64BIT doesn't use the applied value and instead reads
> the Host register directly. This change uses the supplied "caps"
> register instead of reading the host register.
> 
> This change will allow a calling driver to simply clear the
> SDHCI_CAN_64BIT bit in "caps" to handle some cases of
> SDHCI_QUIRK2_BROKEN_64_BIT_DMA.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d622435..ba3b072 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2926,7 +2926,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
>  	 * implement.
>  	 */
> -	if (sdhci_readl(host, SDHCI_CAPABILITIES) & SDHCI_CAN_64BIT)
> +	if (caps[0] & SDHCI_CAN_64BIT)
>  		host->flags |= SDHCI_USE_64_BIT_DMA;
>  
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> 

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

