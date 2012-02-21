From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH] mmc: core: fix au_size according to sd spec3.0
Date: Tue, 21 Feb 2012 16:12:44 +0530
Message-ID: <000201ccf085$8d3c7d10$a7b57730$@codeaurora.org>
References: <1329473681-5071-1-git-send-email-hyeonsu.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:39148 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab2BUKms (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Feb 2012 05:42:48 -0500
In-Reply-To: <1329473681-5071-1-git-send-email-hyeonsu.kim@samsung.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: hyeonsu.kim@samsung.com, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: kyungmin.park@samsung.com, jh80.chung@samsung.com



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of hyeonsu.kim@samsung.com
> Sent: Friday, February 17, 2012 3:45 PM
> To: linux-mmc@vger.kernel.org; cjb@laptop.org
> Cc: kyungmin.park@samsung.com; jh80.chung@samsung.com; Hyeonsu Kim
> Subject: [PATCH] mmc: core: fix au_size according to sd spec3.0
> 
> From: Hyeonsu Kim <hyeonsu.kim@samsung.com>
> 
> This "if phrase" is illogical.
> and SD Spec 3.0 supports au_size from 0 to 0xF.
> 
> Signed-off-by: Hyeonsu Kim <hyeonsu.kim@samsung.com>
> ---
>  drivers/mmc/core/sd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> c63ad03..cf8bf0e 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -244,7 +244,7 @@ static int mmc_read_ssr(struct mmc_card *card)
>  	 * bitfield positions accordingly.
>  	 */
>  	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
> -	if (au > 0 || au <= 9) {
> +	if (au >= 0 && au < 16) {

au = 0 is still invalid. And as "Jaehoon Chung" mentioned, we would need to
check the SD spec version here as au value from 10 to 15 is invalide for
cards till SD2.0 spec.

>  		card->ssr.au = 1 << (au + 4);
>  		es = UNSTUFF_BITS(ssr, 408 - 384, 16);
>  		et = UNSTUFF_BITS(ssr, 402 - 384, 6);
> --
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

