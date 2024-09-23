Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3B195B14;
	Mon, 23 Sep 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094308; cv=none; b=tKRaMhoWwqKhU2muh8AwmvdzlljZ6Bp/2UoXld2CHPnont7iOe96AWVsdlc4O5EFeskCxoTQPQT+jHXoU5BXbD6MDgLIMFHIY0btu3Sli8ZEekF/3iNzzYMontOAJgKitcnJ0QFru7P3D1zZ623hqQULkZ/Qn58cWy6fSvvwiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094308; c=relaxed/simple;
	bh=h4cH91m5em/5rDUKA0Cs9JpjBe/axcjRaRvO0Nm9gnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gROjkpkGyHb7eyphkbjpEphmK8yzXQF7q588oK96RtRB593gcFa2U1WwpwCQpnxf2AsKRHAlD/fOnHSV693ZEADE/T7qQdvYE+GPRqq/DUNDSC0xFFcbtG15IY7TWhJpzj3HcBlh8X5jdXxwnYpGp13k+jV37eEDYq7ZKHfPd6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/lWSkzt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/lWSkzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727094307; x=1758630307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h4cH91m5em/5rDUKA0Cs9JpjBe/axcjRaRvO0Nm9gnw=;
  b=Q/lWSkztH4gMdMGii3ok+sGSZa3ttFms65sTrYfbp/zpdIXihLcpengV
   2Bs4yTrZV5jACajlHG0haIzdUASPXqa2p1Xb5XNYaRSX9qo0UNi7eZg5p
   LHADyXH87mDF/K0QbcmIFtQNfqNG50ZlV+1r1QJzWDl7Ghx92Ar4ALRoO
   iTplSj7JidGyBR0H89MniDee4MowFXXCIl3Ce0+jOOTVhAcinki5TSLV0
   eNb433/0a6tQlOjPfKGvBGol+aiiooDPCgi2zcUX2UcVbv61vgpoLLFXS
   rxCTpNljMxjFgvDtojx3iGNJ2BjexIB27d/gXXI76uhnGT8v9wPAHWOm0
   Q==;
X-CSE-ConnectionGUID: MfNyBP68SlKwOcXHW0W8aQ==
X-CSE-MsgGUID: SR65dRoUTSa+hfAdmDAkTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="36609193"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="36609193"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 05:25:02 -0700
X-CSE-ConnectionGUID: zy+WpUlEQISDyo/3dS7Y2A==
X-CSE-MsgGUID: fhWCAP9yRgyxfhiTceYCrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="75600431"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 05:24:57 -0700
Message-ID: <63402e46-2b4f-43c3-aa9f-cbdc0b7a30d5@intel.com>
Date: Mon, 23 Sep 2024 15:24:52 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, haibo.chen@nxp.com,
 ulf.hansson@linaro.org
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, imx@lists.linux.dev, linux-mmc@vger.kernel.org,
 s32@nxp.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20240923062016.1165868-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240923062016.1165868-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/24 09:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Enable SDHCI_QUIRK_NO_LED for i.MX7ULP, i.MX8MM, i.MX8QXP and
> i.MXRT1050. Even there is LCTL register bit, there is no IOMUX PAD
> for it. So there is no sense to enable LED for SDHCI for these SoCs.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 8f0bc6dca2b0..ef3a44f2dff1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -238,6 +238,7 @@ struct esdhc_platform_data {
>  
>  struct esdhc_soc_data {
>  	u32 flags;
> +	u32 quirks;
>  };
>  
>  static const struct esdhc_soc_data esdhc_imx25_data = {
> @@ -309,10 +310,12 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
> +	.quirks = SDHCI_QUIRK_NO_LED,
>  };
>  static struct esdhc_soc_data usdhc_imxrt1050_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
> +	.quirks = SDHCI_QUIRK_NO_LED,
>  };
>  
>  static struct esdhc_soc_data usdhc_imx8qxp_data = {
> @@ -321,6 +324,7 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
>  			| ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
> +	.quirks = SDHCI_QUIRK_NO_LED,
>  };
>  
>  static struct esdhc_soc_data usdhc_imx8mm_data = {
> @@ -328,6 +332,7 @@ static struct esdhc_soc_data usdhc_imx8mm_data = {
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>  			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
> +	.quirks = SDHCI_QUIRK_NO_LED,
>  };
>  
>  struct pltfm_imx_data {
> @@ -1687,6 +1692,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  
>  	imx_data->socdata = device_get_match_data(&pdev->dev);
>  
> +	host->quirks |= imx_data->socdata->quirks;
>  	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
>  		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
>  

