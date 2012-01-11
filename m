From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH][v2] mmc:sdhci: restore the enabled dma when do reset all
Date: Wed, 11 Jan 2012 14:25:34 -0500
Message-ID: <m2zkdudosx.fsf@bob.laptop.org>
References: <1325147580-31281-1-git-send-email-Shaohui.Xie@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58805 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932901Ab2AKTZu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jan 2012 14:25:50 -0500
In-Reply-To: <1325147580-31281-1-git-send-email-Shaohui.Xie@freescale.com>
	(Shaohui Xie's message of "Thu, 29 Dec 2011 16:33:00 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hi Shaohui,

On Thu, Dec 29 2011, Shaohui Xie wrote:
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
> changes for v2:
> call the wrapper API instead of access the register directly.
>
>  drivers/mmc/host/sdhci.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 19ed580..cf6a048 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -214,6 +214,11 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>  
>  	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
>  		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
> +
> +	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> +		if ((host->ops->enable_dma) && (mask & SDHCI_RESET_ALL))
> +			host->ops->enable_dma(host);
> +	}
>  }
>  
>  static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);

Thanks, I'll merge this for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
