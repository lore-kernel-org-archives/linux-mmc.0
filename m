From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc:sdhci: restore the enabled dma when do reset all
Date: Wed, 28 Dec 2011 13:42:36 +0200
Message-ID: <4EFB00AC.5070209@intel.com>
References: <1325065281-17785-1-git-send-email-Shaohui.Xie@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:28073 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab1L1Lmi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Dec 2011 06:42:38 -0500
In-Reply-To: <1325065281-17785-1-git-send-email-Shaohui.Xie@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 28/12/11 11:41, Shaohui Xie wrote:
> If dma is enabled, it'll be cleared when reset all is performed, this can
> be observed on some platforms, such as P2041 which has a version 2.3
> controller, but platform like P4080 which has a version 2.2 controller,
> does not suffer this, so we will check if the dma is enabled, we should
> restore it after reset all.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> based on http://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git,
> branch 'for-linus'.
> 
>  drivers/mmc/host/sdhci.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 19ed580..22033c3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -29,6 +29,7 @@
>  #include <linux/mmc/host.h>
>  
>  #include "sdhci.h"
> +#include "sdhci-esdhc.h"
>  
>  #define DRIVER_NAME "sdhci"
>  
> @@ -176,6 +177,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	unsigned long timeout;
>  	u32 uninitialized_var(ier);
> +	u32 uninitialized_var(dma);
>  
>  	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
>  		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
> @@ -189,6 +191,8 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>  	if (host->ops->platform_reset_enter)
>  		host->ops->platform_reset_enter(host, mask);
>  
> +	dma = sdhci_readl(host, ESDHC_DMA_SYSCTL);


You must not access eSDHC-specific registers in generic SDHCI code


> +
>  	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
>  
>  	if (mask & SDHCI_RESET_ALL)
> @@ -214,6 +218,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>  
>  	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
>  		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
> +
> +	if ((dma & ESDHC_DMA_SNOOP) && (mask & SDHCI_RESET_ALL))
> +		sdhci_writel(host, dma, ESDHC_DMA_SYSCTL);
>  }
>  
>  static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);

