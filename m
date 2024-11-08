Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A651A2631;
	Fri,  8 Nov 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055603; cv=none; b=NaFGmoeNXwO9nI6s8PIiQ2xfnYYEsRagics/kbfccFu1/do6xZ6JPg7obOU7RYMScA1IbgGlsjHKG/tdWs9Sv0HxmuGAaFStTMC3XfeKXtLPaRJUk2VfSsobggwFndCGTV/Vrmn7KgUYapVHoh0UhdQ1hkeRsoPXabAC8rmn1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055603; c=relaxed/simple;
	bh=9yxF5v4ewKOwB1ig1+7/AMlEc1rvebHe5gr3Q238ou0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSWSXJyfbefe0xeofQJldZoRN5xtp2dGKwCHJ98330Z000WEBq69iQEVGOvX1rgQL+sExdvE8NgiljwVTeCSWICrDhoazd+ttbMiu/EEv+uyUrD+ATbahj3/1qcCltLsdw1xYEJJ7fi+OOsd0W+Uj6R44rC9oWoKSkf+U80MuoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7mWQSfd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7mWQSfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731055601; x=1762591601;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9yxF5v4ewKOwB1ig1+7/AMlEc1rvebHe5gr3Q238ou0=;
  b=S7mWQSfdPz45uBjT2soqZDtt7g5lbdJgLmXPBfGsOQ77tTs5JFiz4xDQ
   TvlVg4q0fXRsuJ2v8sFoFjuJMIzamxuWWh+5LSyNoGGrio/ILSfIom2zA
   ZlHmWTiVgOx8v42gFDTM3ijoKAxBilgKQls7O3MN6FBDL4Fmd9WQywO78
   P8Dt4sokowp66uYTwW667jPKwPNN1rlIR61GwBhDJhwaygy3ttUEoCNB5
   +Hu/+R0ZoDd5Nko/h3bBshn5KPCNxGaO1UrI3L2uGORrZr1CZ/B1AVbgI
   QVFJRFlhu9vhRRFo3ikk3AXd1pBz3rAXSg4vV8tZvamIy/n80e+Ecx6cs
   w==;
X-CSE-ConnectionGUID: Mi4XPwQLRpG4Vg4UTvnF0g==
X-CSE-MsgGUID: I3+gsEE6RI60eiACUdaMrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="41538914"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="41538914"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:46:41 -0800
X-CSE-ConnectionGUID: Mt7p5NSnSEO0XYpMYf0S0A==
X-CSE-MsgGUID: 9tna//0bSZChN+ImPOd9Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="84980240"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:46:36 -0800
Message-ID: <333a5a4c-06d2-4465-af28-3dac607190b1@intel.com>
Date: Fri, 8 Nov 2024 10:46:32 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: Use of_property_present() for non-boolean properties
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Haibo Chen <haibo.chen@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, s32@nxp.com, linux-arm-kernel@lists.infradead.org
References: <20241104190707.275758-1-robh@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241104190707.275758-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 21:07, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

No longer applies cleanly to mmc next, and one minor comment
below otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/mxcmmc.c          | 6 +++---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 1edf65291354..dcb1a7336029 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1048,9 +1048,9 @@ static int mxcmci_probe(struct platform_device *pdev)
>  
>  	if (pdata)
>  		dat3_card_detect = pdata->dat3_card_detect;
> -	else if (mmc_card_is_removable(mmc)
> -			&& !of_property_read_bool(pdev->dev.of_node, "cd-gpios"))
> -		dat3_card_detect = true;
> +	else
> +		dat3_card_detect = mmc_card_is_removable(mmc) &&
> +			!of_property_present(pdev->dev.of_node, "cd-gpios");

dat3_card_detect no longer needs to be initialized to false

>  
>  	ret = mmc_regulator_get_supply(mmc);
>  	if (ret)
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 8f0bc6dca2b0..cda1872769e0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1629,7 +1629,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	 * Retrieveing and requesting the actual WP GPIO will happen
>  	 * in the call to mmc_of_parse().
>  	 */
> -	if (of_property_read_bool(np, "wp-gpios"))
> +	if (of_property_present(np, "wp-gpios"))
>  		boarddata->wp_type = ESDHC_WP_GPIO;
>  
>  	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);

