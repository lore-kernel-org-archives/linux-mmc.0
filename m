From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: refine non-removable card checking for card detection
Date: Wed, 18 Apr 2012 19:57:11 -0400
Message-ID: <8762cwmw4o.fsf@laptop.org>
References: <20120409231420.B54649D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56384 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab2DRX5D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Apr 2012 19:57:03 -0400
In-Reply-To: <20120409231420.B54649D401E@zog.reactivated.net> (Daniel Drake's
	message of "Tue, 10 Apr 2012 00:14:20 +0100 (BST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, "Hunter, Adrian" <adrian.hunter@intel.com>

Hi Dan,

On Mon, Apr 09 2012, Daniel Drake wrote:
> Commit c79396c191bc19703df6eb6bbd0f673ed0df6c9d disables card detection
> where the cards are marked as non-removable.
>
> This makes sense, but the implementation detail of calling
> mmc_card_is_removable() causes some problems, because
> mmc_card_is_removable() is overloaded with CONFIG_MMC_UNSAFE_RESUME
> semantics.
>
> In the OLPC XO case, we need CONFIG_MMC_UNSAFE_RESUME because our root
> filesystem is stored on SD, but we also have external SD card slots
> where we want automatic card detection.
>
> Refine the check to only apply to hosts marked as MMC_CAP_NONREMOVABLE,
> which is defined to mean that the card is *really* nonremovable. This
> could be revisited in future if we find a way to improve
> CONFIG_MMC_UNSAFE_RESUME semantics.
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9aa77f3..ccefdeb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -147,7 +147,7 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
>  	u32 present, irqs;
>  
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
> -	    !mmc_card_is_removable(host->mmc))
> +	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
>  		return;
>  
>  	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &

Thanks, pushed to mmc-next for 3.4 with Chuanxiao's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
