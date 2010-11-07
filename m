From: Chris Ball <cjb@laptop.org>
Subject: Re: PATCH: mmc.c DDR print of card type not correct
Date: Sun, 7 Nov 2010 21:28:16 +0000
Message-ID: <20101107212816.GA13608@void.printf.net>
References: <24C0629C-F7E8-4D4A-A42A-2B6578B5AE2D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59352 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194Ab0KGV2S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 7 Nov 2010 16:28:18 -0500
Content-Disposition: inline
In-Reply-To: <24C0629C-F7E8-4D4A-A42A-2B6578B5AE2D@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>

Hi Philip,

On Fri, Oct 29, 2010 at 01:13:38AM -0700, Philip Rakity wrote:
> we should not call mmc_card_set_ddr_mode if we are in single data mode.  This sets DDR and causes 
> the print out in the log to say the card is DDR when it is not.
> 
> Explicitly set ddr to 0 rather then rely on MMC_SDR_MODE being 0 when doing the checks.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> 
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 995261f..37ddb0d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -375,7 +375,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> 	struct mmc_card *oldcard)
> {
> 	struct mmc_card *card;
> -	int err, ddr = MMC_SDR_MODE;
> +	int err, ddr = 0 ;
> 	u32 cid[4];
> 	unsigned int max_dtr;
> 
> @@ -562,7 +562,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> 			       1 << bus_width, ddr);
> 			err = 0;
> 		} else {
> -			mmc_card_set_ddr_mode(card);
> +			if (ddr)
> +				mmc_card_set_ddr_mode(card);
> +			else
> +				ddr = MMC_SDR_MODE;
> 			mmc_set_bus_width_ddr(card->host, bus_width, ddr);
> 		}
> 	}

Thanks, pushed and queued for 2.6.37.

(Note, this patch was corrupt -- please fix your mailer and check that
patches apply successfully.)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
