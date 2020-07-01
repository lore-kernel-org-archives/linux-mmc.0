Return-Path: <SRS0=joLi=AM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F6C433E1
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 10:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E0A20747
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 10:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgGAKeS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:34:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:1968 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgGAKeS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Jul 2020 06:34:18 -0400
IronPort-SDR: tXPm5DZxN8Nc4u5kMMFPc+FVBAP5palGdp7J2o8ByiMduucpju6kx9UFwll+4yafsjVyskQ//x
 tw84jEzwh7yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="231406762"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="231406762"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 03:34:17 -0700
IronPort-SDR: /SGe/XKYWuaoce/TsPtS7IN2mBOQJUEX4bShJOO4dvuuaJiwiojG3GnU8un3tzbr0p7pjm/jMt
 IqGbDE29Gpaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="303803013"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jul 2020 03:34:15 -0700
Subject: Re: [PATCH] mmc: host: dereference null return value
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, jh80.chung@samsung.com,
        kgene@kernel.org, krzk@kernel.org, michal.simek@xilinx.com,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-imx@nxp.com
References: <1592885209-25839-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cdc9b395-37ea-8ecd-6e20-1e32f2bd0931@intel.com>
Date:   Wed, 1 Jul 2020 13:33:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1592885209-25839-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/06/20 7:06 am, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> of_match_node() has the opportunity to return NULL, so need to
> dereference null return value.
> This is reported by Coverity.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c   | 5 +++--
>  drivers/mmc/host/dw_mmc-k3.c       | 5 +++--
>  drivers/mmc/host/dw_mmc-pltfm.c    | 3 ++-
>  drivers/mmc/host/sdhci-of-arasan.c | 2 ++
>  4 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 5e3d95b63676..27ab55abb03f 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -545,12 +545,13 @@ MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
>  
>  static int dw_mci_exynos_probe(struct platform_device *pdev)
>  {
> -	const struct dw_mci_drv_data *drv_data;
> +	const struct dw_mci_drv_data *drv_data = NULL;
>  	const struct of_device_id *match;
>  	int ret;
>  
>  	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
> -	drv_data = match->data;
> +	if (match)
> +		drv_data = match->data;

Could be 1 line change:

	drv_data = match ? match->data : NULL;

>  
>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 50977ff18074..e8a148c306b3 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -451,11 +451,12 @@ MODULE_DEVICE_TABLE(of, dw_mci_k3_match);
>  
>  static int dw_mci_k3_probe(struct platform_device *pdev)
>  {
> -	const struct dw_mci_drv_data *drv_data;
> +	const struct dw_mci_drv_data *drv_data = NULL;
>  	const struct of_device_id *match;
>  
>  	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
> -	drv_data = match->data;
> +	if (match)
> +		drv_data = match->data;

Could be 1 line change:

	drv_data = match ? match->data : NULL;

>  
>  	return dw_mci_pltfm_register(pdev, drv_data);
>  }
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 7de37f524a96..d3dcb96efd13 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -78,7 +78,8 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
>  
>  	if (pdev->dev.of_node) {
>  		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
> -		drv_data = match->data;
> +		if (match)
> +			drv_data = match->data;
>  	}
>  
>  	return dw_mci_pltfm_register(pdev, drv_data);
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index fb26e743e1fd..f2090f944a0e 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1520,6 +1520,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	const struct sdhci_arasan_of_data *data;
>  
>  	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
> +	if (match == NULL)

(!match) seems to be preferred over (match == NULL)

> +		return -ENOPARAM;

ENOPARAM is unconventional here.  ENODEV or EINVAL are better

>  	data = match->data;
>  	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
>  
> 

