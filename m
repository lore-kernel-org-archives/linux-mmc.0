From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 17/21] mmc: omap: Don't use mmc_card_present() when
 validating for inserted card
Date: Mon, 2 Jan 2017 09:11:40 -0800
Message-ID: <20170102171140.GD9325@atomide.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
 <1483102054-1752-18-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54166 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933733AbdABRLo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 2 Jan 2017 12:11:44 -0500
Content-Disposition: inline
In-Reply-To: <1483102054-1752-18-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

* Ulf Hansson <ulf.hansson@linaro.org> [161230 04:49]:
> The mmc_card_present() function helps the mmc core to track an internal
> state of the card device. More importantly, it's not intended to be used by
> mmc host drivers to check for an inserted card. Therefore, let's stop using
> it and instead rely on checking for a valid pointer to a struct mmc_card,
> as it should be good enough.
> 
> Cc: linux-omap@vger.kernel.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index be3c49f..bd49f34 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -893,7 +893,7 @@ static void mmc_omap_cover_handler(unsigned long param)
>  	 * If no card is inserted, we postpone polling until
>  	 * the cover has been closed.
>  	 */
> -	if (slot->mmc->card == NULL || !mmc_card_present(slot->mmc->card))
> +	if (slot->mmc->card == NULL)
>  		return;
>  
>  	mod_timer(&slot->cover_timer,

Makes sense to me:

Acked-by: Tony Lindgren <tony@atomide.com>
