From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/4] mmc: core: use mmc_power_up in hw_reset
Date: Mon, 03 Nov 2014 11:21:05 +0200
Message-ID: <54574901.3020806@intel.com>
References: <1414154790-20893-1-git-send-email-johanru@axis.com> <1414154790-20893-3-git-send-email-johanru@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24019 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbaKCJWg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Nov 2014 04:22:36 -0500
In-Reply-To: <1414154790-20893-3-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@axis.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?windows-1252?Q?David?= =?windows-1252?Q?_Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

On 24/10/14 15:46, Johan Rudholm wrote:
> The steps performed in mmc_do_hw_reset for eMMC:s after the hardware
> reset are very similar to those performed by mmc_power_up, so do a call

They perform different functions.  mmc_power_up() does nothing if the card
is powered up.  To share the common code you need to create a function for
the common functionality which is setting the initial state e.g.

int mmc_set_initial_state(struct mmc_host *host)
{
	...
}

And call that from mmc_do_hw_reset and mmc_power_up.

> to this function instead.
> 
> Signed-off-by: Johan Rudholm <johanru@axis.com>
> ---
>  drivers/mmc/core/core.c |   11 +----------
>  1 files changed, 1 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5d215ee..d56e222 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2273,16 +2273,7 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
>  		}
>  	}
>  
> -	if (mmc_host_is_spi(host)) {
> -		host->ios.chip_select = MMC_CS_HIGH;
> -		host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
> -	} else {
> -		host->ios.chip_select = MMC_CS_DONTCARE;
> -		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
> -	}
> -	host->ios.bus_width = MMC_BUS_WIDTH_1;
> -	host->ios.timing = MMC_TIMING_LEGACY;
> -	mmc_set_ios(host);
> +	mmc_power_up(host, card->ocr);
>  
>  	mmc_host_clk_release(host);
>  
> 

