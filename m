Return-Path: <SRS0=pl8z=67=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EDBC433E0
	for <linux-mmc@archiver.kernel.org>; Sun, 17 May 2020 13:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9F4207C4
	for <linux-mmc@archiver.kernel.org>; Sun, 17 May 2020 13:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgEQNNE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 17 May 2020 09:13:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:4870 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgEQNNE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 17 May 2020 09:13:04 -0400
IronPort-SDR: cuF+pvHey5smhSBCRXoo4XA+NUFEFY8JLeD6eR5elbjyXWuo7tcdN8/I19DHyrSr32Akro/Jf7
 AvgBnYg6oPSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 06:13:03 -0700
IronPort-SDR: y+vDWVJlT0/rJbbIq5mNl2yC4y73dy8XZAQWg8ZHDSb3va8g5kUdAWBlPF2EHajLhfPRz2rew1
 uxFMvLYuHrDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,403,1583222400"; 
   d="scan'208";a="263688284"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2020 06:13:01 -0700
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: add HS400 support for i.MX6SLL
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-mmc@vger.kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
References: <1589527703-19108-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4b9f8108-0569-d4f8-d671-4ab6f2b08ee0@intel.com>
Date:   Sun, 17 May 2020 16:13:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589527703-19108-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/05/20 10:28 am, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> i.MX6SLL support MMC up to V5.0, which means support HS400 mode.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 38cd83118082..d770cb0bf78b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -215,6 +215,7 @@ static const struct esdhc_soc_data usdhc_imx6sl_data = {
>  static const struct esdhc_soc_data usdhc_imx6sll_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_HS400
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  
> 

