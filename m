From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: jz4740: Use clk_prepare_enable/clk_disable_unprepare
Date: Thu, 27 Jun 2013 10:19:56 -0400
Message-ID: <87wqpfskj7.fsf@octavius.laptop.org>
References: <1368382358-4433-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35898 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab3F0OUB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:20:01 -0400
In-Reply-To: <1368382358-4433-1-git-send-email-lars@metafoo.de> (Lars-Peter
	Clausen's message of "Sun, 12 May 2013 20:12:38 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mmc@vger.kernel.org

Hi,

Lars-Peter Clausen <lars@metafoo.de> writes:
> In preparation to switching the jz4740 clk driver to the common clk framework
> update the clk enable/disable calls to clk_prepare_enable/clk_disable_unprepare.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/mmc/host/jz4740_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 2391c6b..2bc147f 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -626,7 +626,7 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  			gpio_set_value(host->pdata->gpio_power,
>  					!host->pdata->power_active_low);
>  		host->cmdat |= JZ_MMC_CMDAT_INIT;
> -		clk_enable(host->clk);
> +		clk_prepare_enable(host->clk);
>  		break;
>  	case MMC_POWER_ON:
>  		break;
> @@ -634,7 +634,7 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		if (gpio_is_valid(host->pdata->gpio_power))
>  			gpio_set_value(host->pdata->gpio_power,
>  					host->pdata->power_active_low);
> -		clk_disable(host->clk);
> +		clk_disable_unprepare(host->clk);
>  		break;
>  	}

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
