From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/4] mmc: core: use mmc_power_up in hw_reset
Date: Mon, 03 Nov 2014 12:59:15 +0200
Message-ID: <54576003.6040100@intel.com>
References: <1414154790-20893-1-git-send-email-johanru@axis.com>	<1414154790-20893-3-git-send-email-johanru@axis.com>	<54574901.3020806@intel.com> <CA+20K0BQGP8TQiw_HN5pgM1cV7H8Q0Aw689jDjfpipdKJxEOTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31802 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbaKCLB0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Nov 2014 06:01:26 -0500
In-Reply-To: <CA+20K0BQGP8TQiw_HN5pgM1cV7H8Q0Aw689jDjfpipdKJxEOTA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@axis.com>
Cc: Johan Rudholm <johanru@axis.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

On 03/11/14 12:13, Johan Rudholm wrote:
> 2014-11-03 10:21 GMT+01:00 Adrian Hunter <adrian.hunter@intel.com>:
>> On 24/10/14 15:46, Johan Rudholm wrote:
>>> The steps performed in mmc_do_hw_reset for eMMC:s after the hardware
>>> reset are very similar to those performed by mmc_power_up, so do a call
>>
>> They perform different functions.  mmc_power_up() does nothing if the card
>> is powered up.  To share the common code you need to create a function for
>> the common functionality which is setting the initial state e.g.
>>
>> int mmc_set_initial_state(struct mmc_host *host)
>> {
>>         ...
>> }
>>
>> And call that from mmc_do_hw_reset and mmc_power_up.
> 
> Thank you for the comment. What do you think of doing a complete
> mmc_power_cycle after having performed a (successful) reset? In this
> way we can simplify the SD card reset and we don't have to break out
> the common code from mmc_power_up. Naming discussion apart, something
> like this:

I would keep the concept of hw_reset separate from how that is
implemented i.e. whether it has anything to do with power.

> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 486cda8..941f631 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2236,12 +2236,15 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
>  static int mmc_do_reset(struct mmc_host *host, int check)
>  {
>         int ret;
> +       struct mmc_card *card = host->card;
> 
>         if (!host->bus_ops || !host->bus_ops->power_reset ||
>                         host->bus_ops->power_reset(host, MMC_POWER_RESET_TEST))
>                 return -EOPNOTSUPP;
> 
>         ret = host->bus_ops->power_reset(host, check);
> +       if (!ret && card)
> +               mmc_power_cycle(host, card->ocr);
> 
>         pr_warning("%s: tried to reset card (%d)\n", mmc_hostname(host), ret);
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ac5192c..900133a 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1794,8 +1794,6 @@ static int mmc_power_reset(struct mmc_host
> *host, int test)
>                 }
>         }
> 
> -       mmc_power_up(host, card->ocr);
> -
>         mmc_host_clk_release(host);
> 
>         return 0;
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 9ad46b2..d5b8ee7 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1187,8 +1187,6 @@ static int mmc_sd_power_reset(struct mmc_host
> *host, int test)
>         if (test == MMC_POWER_RESET_TEST)
>                 return 0;
> 
> -       mmc_power_cycle(host, card->ocr);
> -
>         return 0;
>  }
> 
> //Johan
> 
> 

