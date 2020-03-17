Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E6C10F29
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BED4206EC
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgCQJwb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:52:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:11234 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgCQJwb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 05:52:31 -0400
IronPort-SDR: 3gFeyB/sMtAXH5KgvDK4vJqCTYN2ML2o1fV2Hbt2t69CrfzhYhAfwC9f/98fVEMCgeaOFpXYV1
 SvgJzUEcUjtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 02:52:30 -0700
IronPort-SDR: +azI8A9fKBjRQ58L4+ha8WqErnfAG+LfoivYULQdO/g/GXyyXzucTRi5GuxYPJzGwecRN6XO9x
 S0F1069bxh+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="443697708"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2020 02:52:27 -0700
Subject: Re: [PATCH v1 3/3] mmc: tegra: Enable host capability
 MMC_CAP2_LONG_WAIT_HW_BUSY
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, baolin.wang@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        bradleybolen@gmail.com, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     anrao@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <1583799205-8442-1-git-send-email-skomatineni@nvidia.com>
 <1583799205-8442-3-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c46fef86-ac9c-a921-1464-dbca58bc3169@intel.com>
Date:   Tue, 17 Mar 2020 11:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583799205-8442-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/03/20 2:13 am, Sowjanya Komatineni wrote:
> Some mmc operations take longer than maximum HW busy detection and
> mmc core driver converts R1B type to R1 type response for these
> operations based on host max busy timeout and command operation time
> and uses SW poll for busy.
> 
> Tegra host support long HW busy detection where host waits forever
> till the card is busy.
> 
> This patch enables MMC_CAP2_LONG_WAIT_HW_BUSY capability for Tegra
> host.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 40a221d..9d0f371 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1583,6 +1583,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
>  		host->mmc->caps |= MMC_CAP_1_8V_DDR;
>  
> +	host->mmc->caps2 |= MMC_CAP2_LONG_WAIT_HW_BUSY;
>  	tegra_sdhci_parse_dt(host);
>  
>  	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
> 

