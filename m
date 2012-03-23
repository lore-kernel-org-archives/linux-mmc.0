From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH] mmc: block: Remove use of mmc_blk_set_blksize
Date: Fri, 23 Mar 2012 12:49:19 +0530
Message-ID: <000001cd08c5$456f6440$d04e2cc0$@codeaurora.org>
References: <1332413246-27953-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:2795 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab2CWHTY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Mar 2012 03:19:24 -0400
In-Reply-To: <1332413246-27953-1-git-send-email-ulf.hansson@stericsson.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>
Cc: 'Per Forlin' <per.forlin@stericsson.com>, 'Johan Rudholm' <johan.rudholm@stericsson.com>, 'Lee Jones' <lee.jones@linaro.org>


Reviewed-by: Subhash Jadavani <subhashj@codeauora.org>

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Ulf Hansson
> Sent: Thursday, March 22, 2012 4:17 PM
> To: linux-mmc@vger.kernel.org; Chris Ball
> Cc: Subhash Jadavani; Per Forlin; Ulf Hansson; Johan Rudholm; Lee Jones
> Subject: [PATCH] mmc: block: Remove use of mmc_blk_set_blksize
> 
> According to the specifications for SD and (e)MMC default blocksize (named
> BLOCKLEN in Spec.) must always be 512 bytes. Since we hardcoded to always
> use 512 bytes, we do not explicitly have to set it. Future improvements
> should potentially make it possible to use a greater blocksize than 512
bytes,
> but until then let's skip this.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>  drivers/mmc/card/block.c |   27 +--------------------------
>  1 files changed, 1 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c index
> a7c75d8..ce171c6 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1624,24 +1624,6 @@ static int mmc_blk_alloc_parts(struct mmc_card
> *card, struct mmc_blk_data *md)
>  	return ret;
>  }
> 
> -static int
> -mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card) -{
> -	int err;
> -
> -	mmc_claim_host(card->host);
> -	err = mmc_set_blocklen(card, 512);
> -	mmc_release_host(card->host);
> -
> -	if (err) {
> -		pr_err("%s: unable to set block size to 512: %d\n",
> -			md->disk->disk_name, err);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  static void mmc_blk_remove_req(struct mmc_blk_data *md)  {
>  	struct mmc_card *card;
> @@ -1769,7 +1751,6 @@ static const struct mmc_fixup blk_fixups[] =  static
> int mmc_blk_probe(struct mmc_card *card)  {
>  	struct mmc_blk_data *md, *part_md;
> -	int err;
>  	char cap_str[10];
> 
>  	/*
> @@ -1782,10 +1763,6 @@ static int mmc_blk_probe(struct mmc_card *card)
>  	if (IS_ERR(md))
>  		return PTR_ERR(md);
> 
> -	err = mmc_blk_set_blksize(md, card);
> -	if (err)
> -		goto out;
> -
>  	string_get_size((u64)get_capacity(md->disk) << 9, STRING_UNITS_2,
>  			cap_str, sizeof(cap_str));
>  	pr_info("%s: %s %s %s %s\n",
> @@ -1810,7 +1787,7 @@ static int mmc_blk_probe(struct mmc_card *card)
>   out:
>  	mmc_blk_remove_parts(card, md);
>  	mmc_blk_remove_req(md);
> -	return err;
> +	return 0;
>  }
> 
>  static void mmc_blk_remove(struct mmc_card *card) @@ -1846,8 +1823,6
> @@ static int mmc_blk_resume(struct mmc_card *card)
>  	struct mmc_blk_data *md = mmc_get_drvdata(card);
> 
>  	if (md) {
> -		mmc_blk_set_blksize(md, card);
> -
>  		/*
>  		 * Resume involves the card going into idle state,
>  		 * so current partition is always the main one.
> --
> 1.7.9
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

