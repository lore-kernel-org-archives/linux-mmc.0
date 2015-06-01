From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Fix off-by-one error in mmc_do_calc_max_discard()
Date: Mon, 01 Jun 2015 13:36:45 +0300
Message-ID: <556C35BD.4050809@intel.com>
References: <1433150435-19997-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60755 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbbFAKjH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Jun 2015 06:39:07 -0400
In-Reply-To: <1433150435-19997-1-git-send-email-david@protonic.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Jander <david@protonic.nl>, Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: Johan Rudholm <johan.rudholm@axis.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/06/15 12:20, David Jander wrote:
> qty is the maximum number of discard that _do_ fit in the timeout, not
> the first amount that does _not_ fit anymore.
> This seemingly harmless error has a very severe performance impact when
> the timeout value is enough for only 1 erase group.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/mmc/core/core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 92e7671..1f9573b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2234,16 +2234,13 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>  	if (!qty)
>  		return 0;
>  
> -	if (qty == 1)
> -		return 1;
> -
>  	/* Convert qty to sectors */
>  	if (card->erase_shift)
> -		max_discard = --qty << card->erase_shift;
> +		max_discard = qty << card->erase_shift;
>  	else if (mmc_card_sd(card))
>  		max_discard = qty;
>  	else
> -		max_discard = --qty * card->erase_size;
> +		max_discard = qty * card->erase_size;
>  
>  	return max_discard;
>  }
> 

This keeps coming up but there is more to it than that.  See here:

	http://marc.info/?l=linux-mmc&m=142504164427546

