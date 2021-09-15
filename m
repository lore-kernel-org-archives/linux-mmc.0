Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232E5C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Sep 2021 12:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2F26135D
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Sep 2021 12:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhIOMFd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:05:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3088 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbhIOMFY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2021 08:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631707445; x=1663243445;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jpypBgyzwfsk1DXAiLahV3NjKEwv2YK1tRg9a3OHO10=;
  b=kvuNPWZGYmHPsKBtZ/hjrsKOgXkic2fHribcEi31yjeAXV4GwxuiJBAX
   3H+SZyNXIr+sebjBAkQ4bjwh2qbNOIfj+X4pjPYlh+UGnylMMCI2CdayR
   PuL3AmqI6Z/TukFGkZTN5gbIVZyEpwPCBX8LtysM+8fTS/xy15RPbDESK
   SAw870fKS2bNt0NZxeQiB1sm6hKhq2pJNZ7ShnMb1QzJtoFWi+EAbQ7AI
   f/Cth9nFb6q4H/2hVUtRN13i80RGrN15PNt28czumx0aZTor6jeL0l76z
   VVxnABMTFZatWsKYSxMNM5zTxmNc1C2PRMJKrt63qb5ykyrEf9WOHdZiG
   A==;
IronPort-SDR: /JGRzrd4tnvUA6K4uy9WSP8eT6hj1ilG/68CvM9zw9V0lQiPmznUffEYmsLdOTHt4zbHxPHR00
 5y17UfxhIS4i+pWnmsNcZeeBUPZBKJKnCgvZokrt5KRflptwfETxC1zebrgG5lvMxn5rTm6h0B
 Y+0h8FbdQ54k3DSHipRxWsskJnGW0MaAhRPdi7SyPCGk9hQElbGRTlQK7GXT4AOZoCRMjziqjY
 Yjo/B76KzJ/CIaXU8gHNtFhiMYIskkE2A8KYDbi9EOdwhunKM8NrkuBbyQhDxIf68aqgk8BceR
 92MB387szdu63ltppQ/PrZ9W
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="129389395"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2021 05:04:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Sep 2021 05:04:03 -0700
Received: from [10.171.246.91] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 15 Sep 2021 05:04:01 -0700
Subject: Re: [PATCH] mmc: sdhci-of-at91: wait for calibration done before
 proceed
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <adrian.hunter@intel.com>, <eugen.hristev@microchip.com>,
        <ulf.hansson@linaro.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210915102838.8344-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <1d204203-59d7-1384-4592-7eb0f0cf8326@microchip.com>
Date:   Wed, 15 Sep 2021 14:04:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210915102838.8344-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/09/2021 at 12:28, Claudiu Beznea wrote:
> Datasheet specifies that at the end of calibration the SDMMC_CALCR_EN
> bit will be cleared. No commands should be send before calibration is
> done.
> 
> Fixes: dbdea70f71d67 ("mmc: sdhci-of-at91: fix CALCR register being rewritten")
> Fixes: 727d836a375ad ("mmc: sdhci-of-at91: add DT property to enable calibration on full reset")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Indeed, needed. Thanks Claudiu,
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
>   drivers/mmc/host/sdhci-of-at91.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 5564d7b23e7c..2b28711e039d 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -114,6 +114,8 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	unsigned long timeout = jiffies + msecs_to_jiffies(20);
> +	unsigned int tmp;
>   
>   	sdhci_reset(host, mask);
>   
> @@ -126,6 +128,14 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
>   
>   		sdhci_writel(host, calcr | SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
>   			     SDMMC_CALCR);
> +
> +		do {
> +			tmp = sdhci_readl(host, SDMMC_CALCR);
> +		} while (time_before(jiffies, timeout) &&
> +			 (tmp & SDMMC_CALCR_EN));
> +
> +		if (tmp & SDMMC_CALCR_EN)
> +			dev_err(mmc_dev(host->mmc), "Failed to calibrate\n");
>   	}
>   }
>   
> 


-- 
Nicolas Ferre
