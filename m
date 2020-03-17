Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79862C3F2CE
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA3920719
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCQJ54 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:57:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:39045 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgCQJ5s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 05:57:48 -0400
IronPort-SDR: Qltgi2wKZcZUeVY3mmRYUx3HSyLVptyixBkBuYfWsoaEj8GdxXQwaLIPAecT42LzJBwyO5sEsH
 aMDK2mqPjz6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 02:57:47 -0700
IronPort-SDR: AXxfFlexHGkT4CGeJ3felSJPRCzQqgJDsZxjRmIw7WSVV4bXyGvJvHF4z90wxa1j2H30mVKcrb
 wH7I4dFTDQPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="443699264"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2020 02:57:45 -0700
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix cd-gpios for SAMA5D2
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8d10950d9940468577daef4772b82a071b204716.1584290561.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7b5c5f2e-a10f-88b5-907c-dfbf6eaa43c6@intel.com>
Date:   Tue, 17 Mar 2020 11:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8d10950d9940468577daef4772b82a071b204716.1584290561.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/03/20 6:44 pm, Michał Mirosław wrote:
> SAMA5D2x doesn't drive CMD line if GPIO is used as CD line (at least
> SAMA5D27 doesn't). Fix this by forcing card-detect in the module
> if module-controlled CD is not used.
> 
> Fixed commit addresses the problem only for non-removable cards. This
> amends it to also cover gpio-cd case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7a1e3f143176 ("mmc: sdhci-of-at91: force card detect value for non removable devices")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index d90f4ed18283..8f8da2fe48a9 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -185,7 +185,8 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
>  
>  	sdhci_reset(host, mask);
>  
> -	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +	    || mmc_gpio_get_cd(host->mmc) >= 0)
>  		sdhci_at91_set_force_card_detect(host);
>  
>  	if (priv->cal_always_on && (mask & SDHCI_RESET_ALL))
> @@ -487,8 +488,11 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  	 * detection procedure using the SDMCC_CD signal is bypassed.
>  	 * This bit is reset when a software reset for all command is performed
>  	 * so we need to implement our own reset function to set back this bit.
> +	 *
> +	 * WA: SAMA5D2 doesn't drive CMD if using CD GPIO line.
>  	 */
> -	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +	    || mmc_gpio_get_cd(host->mmc) >= 0)
>  		sdhci_at91_set_force_card_detect(host);
>  
>  	pm_runtime_put_autosuspend(&pdev->dev);
> 

