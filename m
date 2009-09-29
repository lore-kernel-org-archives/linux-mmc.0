From: Matt Fleming <matt@console-pimps.org>
Subject: Re: TMIO MMC: full patchset.
Date: Tue, 29 Sep 2009 14:20:58 +0100
Message-ID: <20090929132058.GC6934@console-pimps.org>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:55756 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbZI2NUX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2009 09:20:23 -0400
Content-Disposition: inline
In-Reply-To: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org, magnus.damm@gmail.com, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, Pierre Ossman <pierre@ossman.eu>

On Tue, Sep 29, 2009 at 01:52:50PM +0100, Ian Molton wrote:
> From bc0e0adbc24cb7bf8c0119e65d43b42410ce316a Mon Sep 17 00:00:00 2001
> From: Ian Molton <ian@mnementh.co.uk>
> Date: Tue, 29 Sep 2009 13:39:29 +0100
> Subject: [PATCH 5/5] MMC: Retry initialisation at a lower frequency if it times out
> 
> 	This patch retrys the MMC card initialisation at a lower frequency
> 	if it fails. It is needed on certain tmio controllers with fussy cards.
> 
> Signed-off-by: Ian Molton <ian@mnementh.co.uk>
> ---
>  drivers/mmc/core/mmc.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 06084db..03e782f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -295,13 +295,17 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	struct mmc_card *oldcard)
>  {
>  	struct mmc_card *card;
> -	int err;
> +	int err, slow_retry = 0;
>  	u32 cid[4];
>  	unsigned int max_dtr;
>  
>  	BUG_ON(!host);
>  	WARN_ON(!host->claimed);
>  
> +retry:
> +	if (slow_retry)
> +		mmc_set_clock(host, host->f_min);
> +
>  	/*
>  	 * Since we're changing the OCR value, we seem to
>  	 * need to tell some cards to go back to the idle
> @@ -464,6 +468,11 @@ free_card:
>  		mmc_remove_card(card);
>  err:
>  
> +	if (err == -ETIMEDOUT && host->f_min < 400000) {
> +		slow_retry = 1;
> +		goto retry;
> +	}
> +
>  	return err;
>  }
>  
> -- 
> 1.6.3.3
> 

I'm not sure that propagating this magical 400kHz constant around the
MMC code is the best way to go. It could do with a #define.

You're the second person to run into issues with the lower limit
initialisation patch. Does anybody know where that value came from? Is
it definitely the best value to use or has it just been picked out of
the air?
