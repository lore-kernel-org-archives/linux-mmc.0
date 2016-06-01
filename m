From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: mmc: fix check on mmc_select_bus_width return value
Date: Wed, 01 Jun 2016 21:43:50 +0900
Message-ID: <574ED886.4090902@samsung.com>
References: <CGME20160601121538epcas1p1dbeabd6d68d9ca32e1a24705aee0f07a@epcas1p1.samsung.com>
 <1464783435-19338-1-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:53061 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299AbcFAMnx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2016 08:43:53 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O83034SZFD2CDC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Jun 2016 21:43:50 +0900 (KST)
In-reply-to: <1464783435-19338-1-git-send-email-dan@emutex.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan O'Donovan <dan@emutex.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de

On 06/01/2016 09:17 PM, Dan O'Donovan wrote:
> This fixes a bug introduced by commit 287980e49ffc ("remove lots of
> IS_ERR_VALUE abuses").  mmc_select_bus_width can return positive
> integer values upon success, so the (!err) check is incorrect here.
> This causes mmc initialisation failure, and subsequently boot
> failure, on some platforms.

Refer to below patch.

https://patchwork.kernel.org/patch/9139673/

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  drivers/mmc/core/mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c984321..5d438ad 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
>  	 * switch to HS200 mode if bus width is set successfully.
>  	 */
>  	err = mmc_select_bus_width(card);
> -	if (!err) {
> +	if (err >= 0) {
>  		val = EXT_CSD_TIMING_HS200 |
>  		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>  		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	} else if (mmc_card_hs(card)) {
>  		/* Select the desired bus width optionally */
>  		err = mmc_select_bus_width(card);
> -		if (!err) {
> +		if (err >= 0) {
>  			err = mmc_select_hs_ddr(card);
>  			if (err)
>  				goto free_card;
> 

