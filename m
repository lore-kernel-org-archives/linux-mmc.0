Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EEBC4361B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 08:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F344023343
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 08:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLPILT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:11:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:24548 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPILT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 16 Dec 2020 03:11:19 -0500
IronPort-SDR: PrV3jvXjWkQsqB91vM5doTNhgPHffUufaOp9qg5M71flZoxtuFBZB2int0I7u0Da9uO06cQYlB
 ScNAAcTLW6nQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="154831232"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="154831232"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 00:10:38 -0800
IronPort-SDR: N99cSldepDNkWOTMEKCXuWei04c8vZlcya9zI79ryZfoF+KmIBn2y3avHZf7jM8nSycZHQsmbz
 a8o65CK7De+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="559651320"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga005.fm.intel.com with ESMTP; 16 Dec 2020 00:10:36 -0800
Subject: Re: [PATCH v2 2/3] mmc: xenon: add AP807 compatible string
To:     kostap@marvell.com, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        mw@semihalf.com, jaz@semihalf.com
References: <20201216074540.30616-1-kostap@marvell.com>
 <20201216074540.30616-3-kostap@marvell.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e5524e00-c3dc-8e7a-70ff-156edbc1f12a@intel.com>
Date:   Wed, 16 Dec 2020 10:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201216074540.30616-3-kostap@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/12/20 9:45 am, kostap@marvell.com wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> This patch adds new compatible string to differentiate
> between the controllers versions included in the AP807
> north bridge. Thanks to this change, the SoCs which use
> AP807 will not run unintentionally in the 'slow mode'
> with disabled UHS modes.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
> index c67611fdaa8a..add1b4dcd5e5 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -684,6 +684,7 @@ static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
>  
>  static const struct of_device_id sdhci_xenon_dt_ids[] = {
>  	{ .compatible = "marvell,armada-ap806-sdhci", .data = (void *)XENON_AP806},
> +	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
>  	{}
> 

