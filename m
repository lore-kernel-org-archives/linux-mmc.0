From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: block: Remove use of mmc_blk_set_blksize
Date: Fri, 23 Mar 2012 16:38:28 +0900
Message-ID: <4F6C2874.3080505@samsung.com>
References: <1332413246-27953-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20289 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826Ab2CWHij (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Mar 2012 03:38:39 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M1B0088PUJVX7F0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 23 Mar 2012 16:38:38 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0M1B00LY0UKD3X00@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 23 Mar 2012 16:38:37 +0900 (KST)
In-reply-to: <1332413246-27953-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Subhash Jadavani <subhashj@codeaurora.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Ulf.

Just one question.
mmc_blk_probe() is always returned 0?

Best Regards,
Jaehoon Chung

On 03/22/2012 07:47 PM, Ulf Hansson wrote:

> According to the specifications for SD and (e)MMC default
> blocksize (named BLOCKLEN in Spec.) must always be 512
> bytes. Since we hardcoded to always use 512 bytes, we do
> not explicitly have to set it. Future improvements should
> potentially make it possible to use a greater blocksize
> than 512 bytes, but until then let's skip this.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>  drivers/mmc/card/block.c |   27 +--------------------------
>  1 files changed, 1 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index a7c75d8..ce171c6 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1624,24 +1624,6 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
>  	return ret;
>  }
>  
> -static int
> -mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
> -{
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
>  static void mmc_blk_remove_req(struct mmc_blk_data *md)
>  {
>  	struct mmc_card *card;
> @@ -1769,7 +1751,6 @@ static const struct mmc_fixup blk_fixups[] =
>  static int mmc_blk_probe(struct mmc_card *card)
>  {
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
>  static void mmc_blk_remove(struct mmc_card *card)
> @@ -1846,8 +1823,6 @@ static int mmc_blk_resume(struct mmc_card *card)
>  	struct mmc_blk_data *md = mmc_get_drvdata(card);
>  
>  	if (md) {
> -		mmc_blk_set_blksize(md, card);
> -
>  		/*
>  		 * Resume involves the card going into idle state,
>  		 * so current partition is always the main one.


