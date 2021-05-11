Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F99C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 12:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B678A6191A
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 12:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhEKMmE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 08:42:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:13352 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhEKMmD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 May 2021 08:42:03 -0400
IronPort-SDR: pysKYhdEoPYKFzI7Nc0A8aziFXsSjBvXPl+nupOnf5Hujid0pt3HA2dV/Pr42tL+W9Ov8XcT2z
 /phuHlGNq2tg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="260692222"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="260692222"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 05:40:40 -0700
IronPort-SDR: cLZSzduEwAzCFr+a5a+Xy/Z6a+lpXIl9Q7+qxiw5jzqngA3arR7JJIpmPpDlB+rZRF0CfOfCB1
 JfGyHaQG50SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="541634012"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2021 05:40:37 -0700
Subject: Re: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode through
 MMC caps
To:     Lucas Stach <l.stach@pengutronix.de>,
        Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210510190400.105162-1-l.stach@pengutronix.de>
 <20210510190400.105162-2-l.stach@pengutronix.de>
 <VI1PR04MB5294AF754C68D41C844083A990539@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <8b7ab5139fea41caf15b398ec975ed71229dfd5d.camel@pengutronix.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2269d9ee-9ca0-a1b7-666e-8f2d9bae51d3@intel.com>
Date:   Tue, 11 May 2021 15:40:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8b7ab5139fea41caf15b398ec975ed71229dfd5d.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/05/21 11:18 am, Lucas Stach wrote:
> Am Dienstag, dem 11.05.2021 um 03:00 +0000 schrieb Bough Chen:
>>> -----Original Message-----
>>> From: Lucas Stach [mailto:l.stach@pengutronix.de]
>>> Sent: 2021年5月11日 3:04
>>> To: Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunter
>>> <adrian.hunter@intel.com>; Bough Chen <haibo.chen@nxp.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>; dl-linux-imx <linux-imx@nxp.com>;
>>> kernel@pengutronix.de; linux-mmc@vger.kernel.org;
>>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>>> Subject: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode through
>>> MMC caps
>>>
>>> Instead of having an indirection through the SDHCI layer and emulating a
>>> capability bit, that isn't there in hardware, do the same same thing as
>> with
>>> HS400_ES and advertise the support for HS400 directly through the MMC
>> caps.
>>>
>>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>> ---
>>>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> index a20459744d21..65a52586db36 100644
>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> @@ -427,9 +427,6 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int
>>> reg)
>>>  					|
>> FIELD_PREP(SDHCI_RETUNING_MODE_MASK,
>>>  						     SDHCI_TUNING_MODE_3);
>>>
>>> -			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>>> -				val |= SDHCI_SUPPORT_HS400;
>>> -
>>>  			/*
>>>  			 * Do not advertise faster UHS modes if there are no
>>>  			 * pinctrl states for 100MHz/200MHz.
>>> @@ -1603,7 +1600,7 @@ static int sdhci_esdhc_imx_probe(struct
>>> platform_device *pdev)
>>>  		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>>>
>>>  	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>>> -		host->quirks2 |= SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
>>> +		host->mmc->caps2 |= MMC_CAP2_HS400;
>>
>> Hi Lucas,
>>
>> I think patch1 and patch 2 are enough to cover your requirement.
>> For this patch, I think it's unnecessary, sdhci-esdhc-imx.c need to reuse
>> sdhci.c as much as possible.
>> In sdhci.c, already contain the following logic. 
>>
>>          if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 &&
>>              (host->caps1 & SDHCI_SUPPORT_HS400))
>>                  mmc->caps2 |= MMC_CAP2_HS400;
>>
>> The reason why we directly use host->mmc->caps2 for HS400ES mode is that
>> sdhci.c do not contain the similar logic.
> 
> No, it's not enough. We call mmc_of_parse(), which clears the HS400
> flags, before sdhci_setup_host() is called, which will then add the
> HS400 flags again. So either I still need to evaluate the DT property
> in the esdhc driver to make it return the right emulated SDHCI caps bit
> for the HS400 case, or do it like in this patch.
> 
> While the way it is done here is a bit of a layering violation between

We see SDHCI as more of a library, not a layer, so this is OK

> SDHCI and MMC, it still feels like the cleaner and more straight
> forward solution.
> 
> Regards,
> Lucas
> 

