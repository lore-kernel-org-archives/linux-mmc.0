Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E69C4361B
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73FE227C3
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 17:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgLORRB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:17:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:27334 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbgLORQy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Dec 2020 12:16:54 -0500
IronPort-SDR: 9JUSVY4GmF+LSCFAWuKWTIFfixqU4Sx7LoLtUD4GYwocGRpKeozRaQJOvQ3M8/M0VXXUP6uHf1
 UAa0A6GTaVfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="193292086"
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="193292086"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 09:16:12 -0800
IronPort-SDR: U9ByCr36JadSqj3Hs0PoJBV6xqwxW/vC6ty3U4gCyFx+WlQr08OuvincbcjJMpdsZvnah3UVn5
 h7K3+Qm+/r+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="559219738"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga005.fm.intel.com with ESMTP; 15 Dec 2020 09:16:10 -0800
Subject: Re: [PATCH 2/3] mmc: xenon: add AP807 compatible string
To:     kostap@marvell.com, linux-mmc@vger.kernel.org
Cc:     huziji@marvell.com, ulf.hansson@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        mw@semihalf.com, jaz@semihalf.com
References: <20201215155636.28474-1-kostap@marvell.com>
 <20201215155636.28474-3-kostap@marvell.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <30d17db8-5735-8e3c-b026-3a7f4794d1c7@intel.com>
Date:   Tue, 15 Dec 2020 19:16:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201215155636.28474-3-kostap@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/12/20 5:56 pm, kostap@marvell.com wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> This patch adds new compatible string to differentiate
> between the controllers versions included in the AP807
> north bridge. Thanks to this change, the SoCs which use
> AP807 will not run unintentionally in the 'slow mode'
> with disabled UHS modes.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 4 ++++
>  drivers/mmc/host/sdhci-xenon.c                | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> index 623010f3ca89..e9a740ec22cb 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> @@ -27,3 +27,7 @@
>  		#clock-cells = <1>;
>  	};
>  };
> +
> +&ap_sdhci0 {
> +	compatible = "marvell,armada-ap807-sdhci";
> +};
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 24c978de2a3f..29f6bede9b96 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -668,6 +668,7 @@ static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
>  
>  static const struct of_device_id sdhci_xenon_dt_ids[] = {
>  	{ .compatible = "marvell,armada-ap806-sdhci",},
> +	{ .compatible = "marvell,armada-ap807-sdhci",},

Didn't you add match data here?  Then it needs a re-base on Ulf's 'next' branch.

>  	{ .compatible = "marvell,armada-cp110-sdhci",},
>  	{ .compatible = "marvell,armada-3700-sdhci",},
>  	{}
> 

