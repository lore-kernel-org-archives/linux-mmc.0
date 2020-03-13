Return-Path: <SRS0=lJwf=46=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C601BC10DCE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 07:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E80206EB
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 07:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgCMHTd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Mar 2020 03:19:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:25776 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgCMHTd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Mar 2020 03:19:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 00:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,547,1574150400"; 
   d="scan'208";a="237126832"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2020 00:19:30 -0700
Subject: Re: [PATCH] mmc: sdhci-of-at91: Display clock changes for debug
 purpose only
To:     Tudor.Ambarus@microchip.com, Ludovic.Desroches@microchip.com,
        ulf.hansson@linaro.org
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian.Birsan@microchip.com
References: <20200312142904.232822-1-tudor.ambarus@microchip.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <975a35de-3c8a-2bad-8395-1c165fd1e66f@intel.com>
Date:   Fri, 13 Mar 2020 09:18:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312142904.232822-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/20 4:29 pm, Tudor.Ambarus@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> The sdhci_at91_set_clks_presets() function is called multiple times
> at runtime and the messages are shown on the console. Display clk mul,
> gck rate and clk base for debug porpose only.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index ab2bd314a390..88f17abb69a7 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -204,8 +204,8 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>  	/* Set capabilities in ro mode. */
>  	writel(0, host->ioaddr + SDMMC_CACR);
>  
> -	dev_info(dev, "update clk mul to %u as gck rate is %u Hz and clk base is %u Hz\n",
> -		 clk_mul, gck_rate, clk_base_rate);
> +	dev_dbg(dev, "update clk mul to %u as gck rate is %u Hz and clk base is %u Hz\n",
> +		clk_mul, gck_rate, clk_base_rate);
>  
>  	/*
>  	 * We have to set preset values because it depends on the clk_mul
> 

