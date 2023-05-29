Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D402AC77B7A
	for <linux-mmc@archiver.kernel.org>; Mon, 29 May 2023 10:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjE2Krr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 May 2023 06:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjE2Krq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 May 2023 06:47:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1939E3
        for <linux-mmc@vger.kernel.org>; Mon, 29 May 2023 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685357262; x=1716893262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v7AXNIBlc9vrFPdRyp5dILuH6/orHfex/WmEhFivCbQ=;
  b=QbDGMKTPGnuSXFWUWMX0zfm+AEsXy72duTdrLSy2m8aKfZdz2NrpFv2Q
   G/d1thpZTgcBd1D8wqk6MQLQDjyWZodlnq347WrxV9jSnJQw8WlCt0Zsi
   2WDAylV6OrPmSGIuOsvgKJTPiB7H7PhJkEPFGKjZALF6Hw/iO1rHi4jBg
   4JyWJer9TyaYKiWTMy71FGpmK+IZvH0ihZadJmed+eZowlLgzbVmWAo8U
   ks6OwgWMEkkCpiUGyY32Np1FVKUXH7rUZmfcB7br8e77hZbccSICI/429
   /z80MfuWrJQYYoTWwLRfINei07m/oByFGqIGtTgUhUPZFadpbXkSi9lGc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357928740"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="357928740"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 03:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="830357487"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="830357487"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.110])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 03:47:39 -0700
Message-ID: <76cbf5ed-200e-092b-abe2-87d89772d9d2@intel.com>
Date:   Mon, 29 May 2023 13:47:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: enable IPG clock before
 register access during suspend/resume
Content-Language: en-US
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
References: <20230518082035.335112-1-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230518082035.335112-1-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18/05/23 11:20, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> During suspend/resume, need to access usdhc register, so need
> to enable IPG clock to avoid bus error.
> 
> Find this issue when a card slot do not insert a card, so when
> system suspend, sdhci_esdhc_runtime_resume() will not be called
> before sdhci_esdhc_suspend(), so will meet system hung or bus err
> once access usdhc register.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
> The first thing I do is try to merge the sdhci_esdhc_suspend() into
> current sdhci_esdhc_runtime_suspend(), but find some obstacles:
> 1, sdhci_esdhc_imx_hwinit() is called in original sdhci_esdhc_resume(),
>    it will clear the DLL config, which after remove to sdhci_esdhc_runtime_resume,
>    will finally impact the DDR50 timing.
> 2, if merge, everytime after sdhci_esdhc_runtime_resume, will do re-tuning,
>    this is unnecessary for the normal runtime PM case without power lost.
> 3, the CD gpio wakeup. Seems strange to enable the CD gpio wakeup in
>    sdhci_esdhc_runtime_suspend().
> 
> So, finally I drop this merge method, and directly add change in the original
> sdhci_esdhc_suspend()/sdhci_esdhc_resume().
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index eebf94604a7f..4cf42a028bb9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1836,6 +1836,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
> +	pm_runtime_get_sync(dev);
> +
>  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
>  		ret = cqhci_suspend(host->mmc);
>  		if (ret)
> @@ -1855,6 +1857,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	pm_runtime_force_suspend(dev);

Won't this result both in sdhci_suspend_host() and sdhci_runtime_suspend_host()
being called.  Please ensure that just call one of them is called.

And cqhci_suspend() will be called twice.  Please avoid that.

> +
>  	ret = pinctrl_pm_select_sleep_state(dev);
>  	if (ret)
>  		return ret;
> @@ -1873,6 +1877,8 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	pm_runtime_force_resume(dev);
> +
>  	/* re-initialize hw state in case it's lost in low power mode */
>  	sdhci_esdhc_imx_hwinit(host);
>  
> @@ -1886,6 +1892,8 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	if (!ret)
>  		ret = mmc_gpio_set_cd_wake(host->mmc, false);
>  
> +	pm_runtime_put_autosuspend(dev);
> +
>  	return ret;
>  }
>  #endif

