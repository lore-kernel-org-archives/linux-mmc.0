From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH] mmc: core: fix wrong bit operation for SD card's au_size
Date: Tue, 21 Feb 2012 16:04:17 +0530
Message-ID: <000001ccf084$5f956f80$1ec04e80$@codeaurora.org>
References: <4F431E23.8050006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:65156 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab2BUKeW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Feb 2012 05:34:22 -0500
In-Reply-To: <4F431E23.8050006@samsung.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, hyeonsu.kim@samsung.com



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Jaehoon Chung
> Sent: Tuesday, February 21, 2012 10:02 AM
> To: linux-mmc
> Cc: Chris Ball; Kyungmin Park; hyeonsu.kim@samsung.com
> Subject: [PATCH] mmc: core: fix wrong bit operation for SD card's au_size
> 
> In SD spec, AU_SIZE and the value can be selected from 16KB.
> But this code should be selected from 32KB.
> I think right that shift (au + 3) instead of (au + 4).
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> CC: Hyeonsu Kim <hyeonsu.kim@samsung.com>
> ---
>  drivers/mmc/core/sd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> 5017f93..85c7b39 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -245,7 +245,7 @@ static int mmc_read_ssr(struct mmc_card *card)
>  	 */
>  	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
>  	if (au > 0 || au <= 9) {
> -		card->ssr.au = 1 << (au + 4);
> +		card->ssr.au = 1 << (au + 3);

(au+4) is correct only. Look at the definition of "card->ssr.au"
("include/linux/mmc/card.h"), au is in terms of sectors.
		struct sd_ssr {
		        unsigned int            au;                     /*
In sectors */

Now let's take the example of "AU_SIZE" = 1 then (1 << (au+4)) would be 32.
Now as "card->sss.au" is in term of sectors, 32 sectors means 16KB (assuming
512 byte sector size).

Regards,
Subhash

>  		es = UNSTUFF_BITS(ssr, 408 - 384, 16);
>  		et = UNSTUFF_BITS(ssr, 402 - 384, 6);
>  		eo = UNSTUFF_BITS(ssr, 400 - 384, 2);
> --
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

