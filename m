From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmc.c check if mmc cards < 2GB do sector
	addressing
Date: Thu, 24 Feb 2011 19:12:00 +0000
Message-ID: <20110224191200.GB11663@void.printf.net>
References: <4CC152D1-81A6-4AA7-B382-E45A22116E24@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35195 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125Ab1BXTMB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 14:12:01 -0500
Content-Disposition: inline
In-Reply-To: <4CC152D1-81A6-4AA7-B382-E45A22116E24@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

Hi Philip,

On Sun, Feb 13, 2011 at 11:13:09PM -0800, Philip Rakity wrote:
> 
> Some TOSHIBA MMC cards only support sector addressing
> even though the size is < 2GB.  According to JEDEC
> Spec JESD84-A441-1 the ocr register (bits 30, 29)
> determine byte/sector mode.  Use them.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/core/mmc.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6396c5d..6c5d3d4 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -421,6 +421,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	int err, ddr = 0;
>  	u32 cid[4];
>  	unsigned int max_dtr;
> +	u32 rocr;
>  
>  	BUG_ON(!host);
>  	WARN_ON(!host->claimed);
> @@ -434,7 +435,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	mmc_go_idle(host);
>  
>  	/* The extra bit indicates that we support high capacity */
> -	err = mmc_send_op_cond(host, ocr | (1 << 30), NULL);
> +	err = mmc_send_op_cond(host, ocr | (1 << 30), &rocr);
>  	if (err)
>  		goto err;
>  
> @@ -522,6 +523,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  		err = mmc_read_ext_csd(card);
>  		if (err)
>  			goto free_card;
> +
> +		/* if doing byte addressing check if required to do sector */
> +		/* addressing.  Handle case of cards < 2GB needing sector */
> +		/* addressing.  See section 8.1 JEDEC Standard JED84-A441 */
> +		/* ocr register has bit 30 set for sector addressing */
> +		if (!(mmc_card_blockaddr(card)) && (rocr & (1<<30)))
> +			mmc_card_set_blockaddr(card);
>  		/* Erase size depends on CSD and Extended CSD */
>  		mmc_set_erase_size(card);
>  	}

Thanks, pushed to mmc-next for .39.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
