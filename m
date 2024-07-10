Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BC1E488;
	Wed, 10 Jul 2024 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614826; cv=none; b=uFDGEz4Sm6up5v1695XpElEfDJhG2gSO3lOsD1w9bMdEVtIrYjMi5CnqIEpqZcLnjl2RwoJTAynwYz9etjPXr0DaKfs6F1pViVGICtEsdxwBLmNSWgcM36vE539rPybkB6IQcbUGPhidGfXTBrJ7xno9HNOzg8ATn4YAq55Alp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614826; c=relaxed/simple;
	bh=D/HzqGuhP3NYW+XxGQ8A8QMZOg6KNiCyKTUfYD3JVXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rb1i52HF8JfSab1h3CGw/Uzl89AG+ucGOrbbTKvAcu06G3AT2VSW/f6KqHFu2V745zEZAlmOp09+bKYdY6AOSnnowgfLPqbEyAu6iSeLsUzOsdNUueKzqOCFBLaVI+wCyDov07gwaL17QhG0r/2ZwvR2SlkPyKBwgHWqvdqg4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6wj3QEz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6wj3QEz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720614824; x=1752150824;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D/HzqGuhP3NYW+XxGQ8A8QMZOg6KNiCyKTUfYD3JVXY=;
  b=h6wj3QEzp1fTR2p5cE0WVYewcBBC7+9uRZm1EtXoO3G/yoYwHYzHpMQu
   AcK0X+YhqFIuZMv+GPgsqVvAKDGKXN6eET2WX2wxmsqcTkvJKKb1pFALo
   p2sVul6Qf1LeNsN3l5WExr2AhpIaVbnMU1kyqCCRHR195zQDTTFUxVdL0
   x/+/OU12wW/gp0qJFiIhaTk4vELfxBsePz+lREvPXup/DxheZEEw48kkr
   O2DuZAWML1jAJVMyGfG01KLAQt5d18+9IK1tglUuj6h1AydxvsHJdPjPP
   VQAsYKc0OhsbjXPLQezsEYNB9rEvrD5OlPfsu0MNIy8m4XUKP3ouqWj3O
   g==;
X-CSE-ConnectionGUID: yTWospOwRzeuG+BF043L/w==
X-CSE-MsgGUID: qTw7et9ORSWE9nY0jqZKFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18136657"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="18136657"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 05:33:43 -0700
X-CSE-ConnectionGUID: 4+Vv64UGR++LVj8uSbIL2g==
X-CSE-MsgGUID: UeU6/3mIR6uAtO1+bAV86g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48082214"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 05:33:40 -0700
Message-ID: <dbd73f2b-54ab-4832-9610-a4bc70e3b9f2@intel.com>
Date: Wed, 10 Jul 2024 15:33:34 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: sdhci-esdhc-imx: obtain the 'per' clock rate
 after its enablement
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, s32@nxp.com
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
 <20240708121018.246476-3-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240708121018.246476-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/07/24 15:10, Ciprian Costea wrote:
> The I.MX SDHCI driver assumes that the frequency of the 'per' clock
> can be obtained even on disabled clocks, which is not always the case.
> 
> According to 'clk_get_rate' documentation, it is only valid
> once the clock source has been enabled.

The kerneldoc comment for clk_get_rate() says

	Can be called regardless of the clock enabledness

which sounds like the opposite.  Please clarify.

> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 21d984a77be8..8f0bc6dca2b0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1709,7 +1709,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	}
>  
>  	pltfm_host->clk = imx_data->clk_per;
> -	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
>  	err = clk_prepare_enable(imx_data->clk_per);
>  	if (err)
>  		goto free_sdhci;
> @@ -1720,6 +1719,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (err)
>  		goto disable_ipg_clk;
>  
> +	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
> +	if (!pltfm_host->clock) {
> +		dev_err(mmc_dev(host->mmc), "could not get clk rate\n");
> +		err = -EINVAL;
> +		goto disable_ahb_clk;
> +	}
> +
>  	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
>  	if (IS_ERR(imx_data->pinctrl))
>  		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");

