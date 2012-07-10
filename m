From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: poll for card even when card is logically unremovable
Date: Mon, 09 Jul 2012 23:16:43 -0400
Message-ID: <87wr2ctiec.fsf@octavius.laptop.org>
References: <20120705210613.8B3F89D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52747 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826Ab2GJDQr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Jul 2012 23:16:47 -0400
In-Reply-To: <20120705210613.8B3F89D401E@zog.reactivated.net> (Daniel Drake's
	message of "Thu, 5 Jul 2012 22:06:13 +0100 (BST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Dan,

On Thu, Jul 05 2012, Daniel Drake wrote:
> The Marvell CaFe is now marked as having bad card detection to fix
> a problem during system resume.
>
> Now on the OLPC XO-1 we are facing the issue that the card is marked
> as logically unremovable (via MMC_UNSAFE_RESUME), which means that
> mmc_card_is_removable considers the card non-removable. The existing
> code logic decides not to poll for card presence in this case, and
> card detection is also disabled because of the quirk being set.
> This means that no SD cards are detected when inserted after boot.
>
> Refine the logic to enable card presence polling in the case when
> a card is logically unremovable, only avoiding the poll in the case
> when the card is physically non-removable (denoted with
> MMC_CAP_NONREMOVABLE).
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4b8b4d..dd71a05 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2779,7 +2779,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>  
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> -	    mmc_card_is_removable(mmc))
> +	    !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
>  		mmc->caps |= MMC_CAP_NEEDS_POLL;
>  
>  	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
