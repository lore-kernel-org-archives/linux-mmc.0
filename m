Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB8128369;
	Wed, 10 Jul 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614860; cv=none; b=l0id6vImmv7AQxlKOqavZFAWwD+eTlWXapAWN/G7FLAYDAdiJ0m0N0IMYQrJiKBBox6xSU9K05w5dmdjBikGjHYUyaDOqq7WEgZ4V6lopnTvQg+8Q3sh7W/XlNua3Yeibh5UxMy031uvYJLbajgdpoYWFCXR3WL/m5qGMiOt8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614860; c=relaxed/simple;
	bh=BFEunEcs5aC7iaDHnjDB4ntE9xA4uD5Oi8bIhDKbpc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZ8FhaDeF3LrUY73kAANLRLq3KlBZ68aea0ZtQXx45k1YD54iNey2WUocC2FKTJW7iwDYP0fY40QJqTWFve43TXLYfkfyhSdf8GnQV59uO4N+Itwetu61X6rxBAYWXjug1UfMjERcbKFBdtRnVO6SQnHeZSIi6pgPYxxyvAYpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJtdrsdc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJtdrsdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720614859; x=1752150859;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BFEunEcs5aC7iaDHnjDB4ntE9xA4uD5Oi8bIhDKbpc4=;
  b=NJtdrsdczb+XKWRDq1ZbDDrI4FrU2JQ+xS11w3mQcQXIK3b14IwQXEy7
   LL0VIzz3qp1vl0KB1R5tMkYfXRzD9N+UtJn0AfSwBs4zkzOkS70AqWOEH
   ppCXxrdr/7Skm2sTU8aTQbgipPA/UriQewkzrQiXsHIPJ6coopjcUi5D8
   Vrh8/yAn0dIq+y5p4F5QPzpzKh/S0D/8vxum1wOFl5K1gHzyisVQHGZam
   hbjO6iSF+6kw3zdkNONM9CoZbovVUTiluLlDUdNM1TL6BpNCvjNLrXYlm
   jE7ICl5tz5i7Gwr+XUGeL4zQTaCktX3B5IC4rpoeGEYqOp5heBxFVTUJx
   A==;
X-CSE-ConnectionGUID: pW7AEx2nRg+EVp1SQry2eg==
X-CSE-MsgGUID: LSl3BwL+TG6M9ZeuLrS4Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18136686"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="18136686"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 05:34:18 -0700
X-CSE-ConnectionGUID: xa8q9aYMQ1eK4DrvGkWfqw==
X-CSE-MsgGUID: puOcjTheTg+Cvxk4wOtLjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48082515"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 05:34:15 -0700
Message-ID: <6a577d6c-04ad-4c12-bfad-815e811deee3@intel.com>
Date: Wed, 10 Jul 2024 15:34:10 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mmc: sdhci-esdhc-imx: disable card detect wake for
 S32G based platforms
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, s32@nxp.com
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
 <20240708121018.246476-2-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240708121018.246476-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/07/24 15:10, Ciprian Costea wrote:
> In case of S32G based platforms, GPIO CD used for card detect
> wake mechanism is not available.
> 
> For this scenario the newly introduced flag
> 'ESDHC_FLAG_SKIP_CD_WAKE' is used.
> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>

Should have:

 - put the patch set version number (v2) in the subject e.g.
   [PATCH v2 1/3] mmc: sdhci-esdhc-imx: disable card detect wake for S32G based platforms

 - added Haibo Chen's Reviewed-by tag

Anyway:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 40a6e2f8145a..21d984a77be8 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -201,6 +201,9 @@
>  /* ERR004536 is not applicable for the IP  */
>  #define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
>  
> +/* The IP does not have GPIO CD wake capabilities */
> +#define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
> +
>  enum wp_types {
>  	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
>  	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
> @@ -298,7 +301,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> -			| ESDHC_FLAG_SKIP_ERR004536,
> +			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
>  };
>  
>  static struct esdhc_soc_data usdhc_imx7ulp_data = {
> @@ -1726,7 +1729,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>  
>  		/* GPIO CD can be set as a wakeup source */
> -		host->mmc->caps |= MMC_CAP_CD_WAKE;
> +		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_CD_WAKE))
> +			host->mmc->caps |= MMC_CAP_CD_WAKE;
>  
>  		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
>  			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;

