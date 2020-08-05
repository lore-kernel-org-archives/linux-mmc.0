Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF2AC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 07:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D8822B40
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 07:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHEHtQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:49:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:40323 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgHEHtP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Aug 2020 03:49:15 -0400
IronPort-SDR: 0K+5ET+WOd1uiXNm+axO7fwQmCnYAh79VB6IjJP5r+/xiBYeOcZkj/Fu1ylcl/7pbgGkk1yVXU
 G0pC5LpZD1JA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132046072"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="132046072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 00:49:14 -0700
IronPort-SDR: ik29/gHE1/qYrJ+mcPEOXOZQNZ8fPyZ5ZR8n8Bv0oNadrviTy1trgUVGCn/mFR4z1yzOWL51UI
 vIb0dr6lIdLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="493191854"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2020 00:49:12 -0700
Subject: Re: [PATCH v2 1/6] sdhci: tegra: Remove
 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <1596515363-27235-1-git-send-email-skomatineni@nvidia.com>
 <1596515363-27235-2-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <63829275-2572-929b-c26c-79823f1e0ba5@intel.com>
Date:   Wed, 5 Aug 2020 10:48:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596515363-27235-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/08/20 7:29 am, Sowjanya Komatineni wrote:
> commit b5a84ecf025a ("mmc: tegra: Add Tegra210 support")

So that could be a Fixes tag?

> 
> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is set for Tegra210 from the
> beginning of Tegra210 support in the driver.
> 
> Tegra210 SDMMC hardware by default uses timeout clock (TMCLK)
> instead of SDCLK and this quirk should not be set.
> 
> So, this patch remove this quirk for Tegra210.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 0a3f9d0..2be3511 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1418,7 +1418,6 @@ static const struct sdhci_ops tegra210_sdhci_ops = {
>  
>  static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>  	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> -		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>  		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
> 

