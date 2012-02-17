From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: fix au_size according to sd spec3.0
Date: Fri, 17 Feb 2012 19:46:04 +0900
Message-ID: <4F3E2FEC.6030808@samsung.com>
References: <1329473681-5071-1-git-send-email-hyeonsu.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58080 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab2BQKqI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2012 05:46:08 -0500
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZJ00KIS9WVS3L0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 17 Feb 2012 19:46:07 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZJ006TG9WUDI90@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 17 Feb 2012 19:46:06 +0900 (KST)
In-reply-to: <1329473681-5071-1-git-send-email-hyeonsu.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: hyeonsu.kim@samsung.com
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kyungmin.park@samsung.com, jh80.chung@samsung.com

Hi.
On 02/17/2012 07:14 PM, hyeonsu.kim@samsung.com wrote:

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
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c63ad03..cf8bf0e 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -244,7 +244,7 @@ static int mmc_read_ssr(struct mmc_card *card)
>  	 * bitfield positions accordingly.
>  	 */
>  	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
> -	if (au > 0 || au <= 9) {
> +	if (au >= 0 && au < 16) {

I think "if (au > 0 && au <= 0xf)" is more readable and 
need to check the sd-spec.
Because in SD2.0, didn't define from 0xa to 0xf.

>  		card->ssr.au = 1 << (au + 4);

Is it right???
card->ssr.au = 1 << (au + 4) is something wrong.
If au is 1, card->ssr.au is 32KB. BUt in spec, defined 16KB.
I think the wrong bit operation. this is more problem.

If my point is right, will send the patch.

Best Regards,
Jaehoon Chung

>  		es = UNSTUFF_BITS(ssr, 408 - 384, 16);
>  		et = UNSTUFF_BITS(ssr, 402 - 384, 6);


