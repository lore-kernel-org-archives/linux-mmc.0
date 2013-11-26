From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: sd: implement proper support for sd3.0 au sizes
Date: Tue, 26 Nov 2013 14:14:51 +0900
Message-ID: <52942E4B.9010501@samsung.com>
References: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:65038 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab3KZFOr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Nov 2013 00:14:47 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWU00KPMUKLNFD0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 26 Nov 2013 14:14:45 +0900 (KST)
In-reply-to: <1385428585-17516-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, H Hartley Sweeten <hartleys@visionengravers.com>

Hi Wolfram,

Good catch. It's right. Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 11/26/2013 10:16 AM, Wolfram Sang wrote:
> This reverts and updates commit 77776fd0a4cc541b9a528eacc1d31ca47eb1ae7a
> ("mmc: sd: fix the maximum au_size for SD3.0"). The au_size for SD3.0
> cannot be achieved by a simple bit shift, so this needs to be
> implemented differently. Also, don't print the warning in case of 0
> since 'not defined' is different from 'invalid'.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: H Hartley Sweeten <hartleys@visionengravers.com>
> 
> ---
> 
> Only tested with non SD3.0 cards (au = 0 and au = 9). Testers for 3.0 cards
> much appreciated.
> 
>  drivers/mmc/core/sd.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6f42050..3b5ac4d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -45,6 +45,13 @@ static const unsigned int tacc_mant[] = {
>  	35,	40,	45,	50,	55,	60,	70,	80,
>  };
>  
> +static const unsigned int sd_au_size[] = {
> +	0,		SZ_16K / 512,		SZ_32K / 512,	SZ_64K / 512,
> +	SZ_128K / 512,	SZ_256K / 512,		SZ_512K / 512,	SZ_1M / 512,
> +	SZ_2M / 512,	SZ_4M / 512,		SZ_8M / 512,	(SZ_8M + SZ_4M) / 512,
> +	SZ_16M / 512,	(SZ_16M + SZ_8M) / 512,	SZ_32M / 512,	SZ_64M / 512,
> +};
> +
>  #define UNSTUFF_BITS(resp,start,size)					\
>  	({								\
>  		const int __size = size;				\
> @@ -216,7 +223,7 @@ static int mmc_decode_scr(struct mmc_card *card)
>  static int mmc_read_ssr(struct mmc_card *card)
>  {
>  	unsigned int au, es, et, eo;
> -	int err, i, max_au;
> +	int err, i;
>  	u32 *ssr;
>  
>  	if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
> @@ -240,26 +247,25 @@ static int mmc_read_ssr(struct mmc_card *card)
>  	for (i = 0; i < 16; i++)
>  		ssr[i] = be32_to_cpu(ssr[i]);
>  
> -	/* SD3.0 increases max AU size to 64MB (0xF) from 4MB (0x9) */
> -	max_au = card->scr.sda_spec3 ? 0xF : 0x9;
> -
>  	/*
>  	 * UNSTUFF_BITS only works with four u32s so we have to offset the
>  	 * bitfield positions accordingly.
>  	 */
>  	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
> -	if (au > 0 && au <= max_au) {
> -		card->ssr.au = 1 << (au + 4);
> -		es = UNSTUFF_BITS(ssr, 408 - 384, 16);
> -		et = UNSTUFF_BITS(ssr, 402 - 384, 6);
> -		eo = UNSTUFF_BITS(ssr, 400 - 384, 2);
> -		if (es && et) {
> -			card->ssr.erase_timeout = (et * 1000) / es;
> -			card->ssr.erase_offset = eo * 1000;
> +	if (au) {
> +		if (au <= 9 || card->scr.sda_spec3) {
> +			card->ssr.au = sd_au_size[au];
> +			es = UNSTUFF_BITS(ssr, 408 - 384, 16);
> +			et = UNSTUFF_BITS(ssr, 402 - 384, 6);
> +			if (es && et) {
> +				eo = UNSTUFF_BITS(ssr, 400 - 384, 2);
> +				card->ssr.erase_timeout = (et * 1000) / es;
> +				card->ssr.erase_offset = eo * 1000;
> +			}
> +		} else {
> +			pr_warning("%s: SD Status: Invalid Allocation Unit size.\n",
> +				   mmc_hostname(card->host));
>  		}
> -	} else {
> -		pr_warning("%s: SD Status: Invalid Allocation Unit "
> -			"size.\n", mmc_hostname(card->host));
>  	}
>  out:
>  	kfree(ssr);
> 

