From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: fix division by zero in MMC core
Date: Wed, 5 Jan 2011 21:55:46 +0000
Message-ID: <20110105215546.GK9198@void.printf.net>
References: <1294184672-31644-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35807 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312Ab1AEVzs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jan 2011 16:55:48 -0500
Content-Disposition: inline
In-Reply-To: <1294184672-31644-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Pierre Tardy <tardyp@gmail.com>

Hi Linus,

On Wed, Jan 05, 2011 at 12:44:32AM +0100, Linus Walleij wrote:
> The card is not always clocked and the clock frequency zero
> is perfectly legal, thus this code in mmc_set_data_timeout()
> may cause a division by zero. It will be triggered more often
> if you're using software clock gating but can be triggered
> under other conditions too.
> 
> Reported-by: Pierre Tardy <tardyp@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  drivers/mmc/core/core.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 97e0624..ef4f7f8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -299,8 +299,9 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>  		unsigned int timeout_us, limit_us;
>  
>  		timeout_us = data->timeout_ns / 1000;
> -		timeout_us += data->timeout_clks * 1000 /
> -			(mmc_host_clk_rate(card->host) / 1000);
> +		if (mmc_host_clk_rate(card->host))
> +			timeout_us += data->timeout_clks * 1000 /
> +				(mmc_host_clk_rate(card->host) / 1000);
>  
>  		if (data->flags & MMC_DATA_WRITE)
>  			/*

Thanks, pushed to mmc-next for .38.  I'll add a stable tag.  Looks like
the potential for the divide-by-zero has always existed in the tree.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
