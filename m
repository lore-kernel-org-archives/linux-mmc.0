Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216EB19306F;
	Fri, 14 Jun 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360294; cv=none; b=RtWyfNQf+yhQg4/j1uRMYTOjQTG8eDfymXTgEytDEexa/C6+zg42x1YqqH9/n9Yw+uMvp2o3es/AjCcCJld1DjCWZ/RygmEGwerYYvpcbNDQI87Np9lCu/8nRa8+O9yLVUuKoGBwmoRGAZ3J3+ig0T70OkWIlNqvDGlslunaq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360294; c=relaxed/simple;
	bh=rsjNKga057lxo1XVRcy2gjW1eYFbc5euagAfaj+eo1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfwG61XEXszTn28woMaBZqk3mWZs9Uq587BftHvGrBSl0lXc7txZ/QRZxKQWsyzLdB1NHHDyLQJgSHt9GRqLOsz2jPDHQmk6mBlWQl6aHfo+tLfXaMrPxF+E9+w/lLdV9SRO7RZO9x09SmTkmuhuyO5m5OnRPwoVjsAStFJU8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNn9FC6X; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNn9FC6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718360293; x=1749896293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rsjNKga057lxo1XVRcy2gjW1eYFbc5euagAfaj+eo1o=;
  b=lNn9FC6X7PlsloO9HQP1w4CAfmIApXoscoynpZsGAXFljrNdLTXSJR+s
   Bsf0yCDFPseSNoxx5x/NsRD/BC/FWqkZzzs1KPy4C96qAhQabck26q++g
   5T65u+adt2489VwsSIuz9NExx1eIWAV25iH0J8Fr3s45nDOHHL/mFt+9e
   NH/25qdG8aGUGgfi+ulyUx53EONmDi17xBcaPkLLbJvvkhvYZTBXhxkJ1
   Jd75Xtz9svUyefUF9CvpzuFygGZ60YF5eKZTpUpPWzmonIjajiuyv+r7a
   qVQBZglTnF4oPmYKT/FOGlcVUovRBdbs0GArOoM3ZEeoGt5LD4QAm/UDX
   g==;
X-CSE-ConnectionGUID: ymFEY7fQTHeB8TF41W+5Jg==
X-CSE-MsgGUID: sMNHZiCTTz22upuhwj/sXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25814555"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="25814555"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:18:13 -0700
X-CSE-ConnectionGUID: IxGmMnBWTwCqgjP42e+cfw==
X-CSE-MsgGUID: P7V4Y22hQCugBq6u7VIyzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="71228888"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.10])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:18:07 -0700
Message-ID: <aff10a8c-bac8-49ba-af0b-3681961eff80@intel.com>
Date: Fri, 14 Jun 2024 13:18:02 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mmc: sdhci-of-dwcmshc: unify the naming of soc
 helper functions
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
References: <cover.1718241495.git.unicorn_wang@outlook.com>
 <91adce8d020faa22a97719e8774dda01a58333e7.1718241495.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <91adce8d020faa22a97719e8774dda01a58333e7.1718241495.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/24 04:42, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Continue another patch: "mmc: sdhci-of-dwcmshc: adjust positions
> of helper routines".
> 
> The helper functions at the dwcmshc level are all prefixed with
> "dwcmshc_", which is easier to identify, while the functions at
> the soc level are more confusing. Now they are uniformly prefixed
> with the soc type string, such as "rk35xx_", "th1520_", etc.

This does not seem to be necessary.

Unnecessarily churning the code makes backports more difficult and
complicates the code history, so it should be avoided in general.

> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index a68818f53786..346d2d323a05 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -193,7 +193,7 @@
>  					 SDHCI_TRNS_BLK_CNT_EN | \
>  					 SDHCI_TRNS_DMA)
>  
> -enum dwcmshc_rk_type {
> +enum rk35xx_type {
>  	DWCMSHC_RK3568,
>  	DWCMSHC_RK3588,
>  };
> @@ -202,7 +202,7 @@ struct rk35xx_priv {
>  	/* Rockchip specified optional clocks */
>  	struct clk_bulk_data rockchip_clks[RK35xx_MAX_CLKS];
>  	struct reset_control *reset;
> -	enum dwcmshc_rk_type devtype;
> +	enum rk35xx_type devtype;
>  	u8 txclk_tapnum;
>  };
>  
> @@ -621,7 +621,7 @@ static unsigned int rk35xx_get_max_clock(struct sdhci_host *host)
>  	return clk_round_rate(pltfm_host->clk, ULONG_MAX);
>  }
>  
> -static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
> +static void rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> @@ -749,7 +749,7 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_reset(host, mask);
>  }
>  
> -static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +static int rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>  	int err;
>  	struct rk35xx_priv *priv = dwc_priv->priv;
> @@ -790,7 +790,7 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  	return 0;
>  }
>  
> -static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +static void rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>  	/*
>  	 * Don't support highspeed bus mode with low clk speed as we
> @@ -1062,7 +1062,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  };
>  
>  static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
> -	.set_clock		= dwcmshc_rk3568_set_clock,
> +	.set_clock		= rk3568_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
>  	.get_max_clock		= rk35xx_get_max_clock,
> @@ -1243,7 +1243,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  		priv->priv = rk_priv;
>  
> -		err = dwcmshc_rk35xx_init(host, priv);
> +		err = rk35xx_init(host, priv);
>  		if (err)
>  			goto err_clk;
>  	}
> @@ -1300,7 +1300,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	}
>  
>  	if (rk_priv)
> -		dwcmshc_rk35xx_postinit(host, priv);
> +		rk35xx_postinit(host, priv);
>  
>  	err = __sdhci_add_host(host);
>  	if (err)

