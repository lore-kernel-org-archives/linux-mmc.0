Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E685AC433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Oct 2021 09:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAECB61027
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Oct 2021 09:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbhJHJk3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:40:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:5161 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhJHJkZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 Oct 2021 05:40:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226373516"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="226373516"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 02:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="524976647"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2021 02:38:26 -0700
Subject: Re: [PATCH v1 1/6] mmc: sdhci: Introduce couple of quirks to ignore
 particular state of CD GPIO
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
 <20211005102430.63716-2-andriy.shevchenko@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2bed40e1-9601-7aae-a246-9939cb744526@intel.com>
Date:   Fri, 8 Oct 2021 12:38:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005102430.63716-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 05/10/2021 13:24, Andy Shevchenko wrote:
> Some platforms may provide contradictory info in some states of CD GPIO line,
> and hence that state or states should be ignored. Introduce couple of quirks
> for that.

OK, I have looked closer now :-)

Hooking ->get_cd() should work, and that is preferred to new quirks.
Please try that.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/sdhci.c | 13 ++++++++-----
>  drivers/mmc/host/sdhci.h |  4 ++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 357b365bf0ec..a7960ee3ef4f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2395,7 +2395,7 @@ EXPORT_SYMBOL_GPL(sdhci_set_ios);
>  static int sdhci_get_cd(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -	int gpio_cd = mmc_gpio_get_cd(mmc);
> +	int gpio_cd;
>  
>  	if (host->flags & SDHCI_DEVICE_DEAD)
>  		return 0;
> @@ -2405,11 +2405,14 @@ static int sdhci_get_cd(struct mmc_host *mmc)
>  		return 1;
>  
>  	/*
> -	 * Try slot gpio detect, if defined it take precedence
> -	 * over build in controller functionality
> +	 * Try slot GPIO detect, if defined it take precedence
> +	 * over build in controller functionality.
>  	 */
> -	if (gpio_cd >= 0)
> -		return !!gpio_cd;
> +	gpio_cd = mmc_gpio_get_cd(mmc);
> +	if (gpio_cd == 0 && !(host->quirks2 & SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_LOW))
> +		return 0;
> +	if (gpio_cd > 0 && !(host->quirks2 & SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_HIGH))
> +		return 1;
>  
>  	/* If polling, assume that the card is always present. */
>  	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index e8d04e42a5af..fb7910d22b18 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -464,6 +464,10 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
>  /* Controller has CRC in 136 bit Command Response */
>  #define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
> +/* Controller requires additional card detection test on GPIO low */
> +#define SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_LOW		(1<<17)
> +/* Controller requires additional card detection test on GPIO high */
> +#define SDHCI_QUIRK_CARD_DETECTION_IF_GPIO_HIGH		(1<<18)
>  /*
>   * Disable HW timeout if the requested timeout is more than the maximum
>   * obtainable timeout.
> 

