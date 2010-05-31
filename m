From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] Recognize CSD structure version 3
Date: Mon, 31 May 2010 08:06:43 +0100
Message-ID: <20100531070643.GJ4720@trinity.fluff.org>
References: <20100531064035.GA25269@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:46094 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252Ab0EaHGp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 31 May 2010 03:06:45 -0400
Content-Disposition: inline
In-Reply-To: <20100531064035.GA25269@july>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

On Mon, May 31, 2010 at 03:40:35PM +0900, Kyungmin Park wrote:
> The eMMC spec 4.4 and 4.3 + additional feature chips has CSD structure version 3
> To probe these chip properly and make it simple.
> it doesn't check CSD structure.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89f7a25..9e42bc6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -118,15 +118,12 @@ static int mmc_decode_csd(struct mmc_card *card)
>  	u32 *resp = card->raw_csd;
>  
>  	/*
> -	 * We only understand CSD structure v1.1 and v1.2.
> +	 * We understand all CSD structure v1.1, v1.2 and v1.3.
>  	 * v1.2 has extra information in bits 15, 11 and 10.
>  	 */
>  	csd_struct = UNSTUFF_BITS(resp, 126, 2);
> -	if (csd_struct != 1 && csd_struct != 2) {

Hmm, it isn't easy to see what was going on here, this version field is 2bits?

I'd still check for 0 in case someone repurposes the 0 bit to mean some
future version we don't know.

> -		printk(KERN_ERR "%s: unrecognised CSD structure version %d\n",
> +	printk(KERN_DEBUG "%s: recognised CSD structure version %d\n",
>  			mmc_hostname(card->host), csd_struct);
> -		return -EINVAL;
> -	}
>  
>  	csd->mmca_vsn	 = UNSTUFF_BITS(resp, 122, 4);
>  	m = UNSTUFF_BITS(resp, 115, 4);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

