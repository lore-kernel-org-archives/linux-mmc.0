From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: fix mmc mode selection for HS-DDR and higher
Date: Wed, 01 Jun 2016 10:25:05 +0900
Message-ID: <574E3971.30202@samsung.com>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
 <CGME20160529070454epcas1p4cf3be0deda6773296b516e7d25a4188e@epcas1p4.samsung.com>
 <1464505484-3661-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54500 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcFABZI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2016 21:25:08 -0400
In-reply-to: <1464505484-3661-2-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 05/29/2016 04:04 PM, Chen-Yu Tsai wrote:
> When IS_ERR_VALUE was removed from the mmc core code, it was replaced
> with a simple not-zero check. This does not work, as the value checked
> is the return value for mmc_select_bus_width, which returns the set
> bit width on success. This made eMMC modes higher than HS-DDR unusable.
> 
> Fix this by checking for a positive return value instead.
> 
> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/core/mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c984321d1881..aafb73d080ca 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
>  	 * switch to HS200 mode if bus width is set successfully.
>  	 */
>  	err = mmc_select_bus_width(card);
> -	if (!err) {
> +	if (err > 0) {
>  		val = EXT_CSD_TIMING_HS200 |
>  		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>  		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	} else if (mmc_card_hs(card)) {
>  		/* Select the desired bus width optionally */
>  		err = mmc_select_bus_width(card);
> -		if (!err) {
> +		if (err > 0) {
>  			err = mmc_select_hs_ddr(card);
>  			if (err)
>  				goto free_card;
> 

