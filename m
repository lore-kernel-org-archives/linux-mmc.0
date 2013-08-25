From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc/core: free mmc_card when cmd 3,9,7 got failed in mmc_sd_init_card
Date: Sat, 24 Aug 2013 22:53:50 -0400
Message-ID: <87wqnascox.fsf@octavius.laptop.org>
References: <1374042070-32765-1-git-send-email-wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41045 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933Ab3HYCx6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 22:53:58 -0400
In-Reply-To: <1374042070-32765-1-git-send-email-wei_wang@realsil.com.cn> (wei
	wang's message of "Wed, 17 Jul 2013 14:21:10 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: devel@linuxdriverproject.org, linux-mmc@vger.kernel.org

Hi Wei,

On Wed, Jul 17 2013, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
>
> In function mmc_sd_init_card, if command 3/9/7 got failed, mmc_card
> allocated just before won't be freed. This would cause memory leak.
>
> Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
> ---
>  drivers/mmc/core/sd.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 176d125..1240a85 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -942,13 +942,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  	if (!mmc_host_is_spi(host)) {
>  		err = mmc_send_relative_addr(host, &card->rca);
>  		if (err)
> -			return err;
> +			goto free_card;
>  	}
>  
>  	if (!oldcard) {
>  		err = mmc_sd_get_csd(host, card);
>  		if (err)
> -			return err;
> +			goto free_card;
>  
>  		mmc_decode_cid(card);
>  	}
> @@ -959,7 +959,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  	if (!mmc_host_is_spi(host)) {
>  		err = mmc_select_card(card);
>  		if (err)
> -			return err;
> +			goto free_card;
>  	}
>  
>  	err = mmc_sd_setup_card(host, card, oldcard != NULL);

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
