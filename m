Return-Path: <SRS0=RtJ+=3D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30274C33CB1
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 12:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032A72465A
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 12:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgANMLy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:11:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:14197 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANMLy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Jan 2020 07:11:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 04:11:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="256276608"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jan 2020 04:11:51 -0800
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix memleak on clk_get failure
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-mmc@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <b2a44d5be2e06ff075f32477e466598bb0f07b36.1577961679.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <96974b11-55f6-e52d-abdb-9f6f77d5c84a@intel.com>
Date:   Tue, 14 Jan 2020 14:10:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b2a44d5be2e06ff075f32477e466598bb0f07b36.1577961679.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/01/20 12:42 pm, Michał Mirosław wrote:
> sdhci_alloc_host() does its work not using managed infrastructure, so
> needs explicit free on error path. Add it where needed.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index b2a8c45c9c23..ab2bd314a390 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -345,20 +345,23 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  			priv->mainck = NULL;
>  		} else {
>  			dev_err(&pdev->dev, "failed to get baseclk\n");
> -			return PTR_ERR(priv->mainck);
> +			ret = PTR_ERR(priv->mainck);
> +			goto sdhci_pltfm_free;
>  		}
>  	}
>  
>  	priv->hclock = devm_clk_get(&pdev->dev, "hclock");
>  	if (IS_ERR(priv->hclock)) {
>  		dev_err(&pdev->dev, "failed to get hclock\n");
> -		return PTR_ERR(priv->hclock);
> +		ret = PTR_ERR(priv->hclock);
> +		goto sdhci_pltfm_free;
>  	}
>  
>  	priv->gck = devm_clk_get(&pdev->dev, "multclk");
>  	if (IS_ERR(priv->gck)) {
>  		dev_err(&pdev->dev, "failed to get multclk\n");
> -		return PTR_ERR(priv->gck);
> +		ret = PTR_ERR(priv->gck);
> +		goto sdhci_pltfm_free;
>  	}
>  
>  	ret = sdhci_at91_set_clks_presets(&pdev->dev);
> 

