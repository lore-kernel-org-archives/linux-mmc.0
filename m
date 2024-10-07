Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69AD1714D7;
	Mon,  7 Oct 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318878; cv=none; b=TMYW4dMpYdhIaHQHUiL5BTOlSCazPj16ZYz4748AR/Sct0qvrUBJgFBJAOPL8i4Sxk2+5PCs42utofEnq0ftNJUwGDOSS3hHG2R+bfOqD6ifrnKJ0ea+2oz/e4QZI6ypW7EElu4NrQrQnN155pMhfACeiRHB9h1h4Htz7cW+zxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318878; c=relaxed/simple;
	bh=80eAqYkNKW/OFeJZu+HxKcNGHWj96jywLFcSMlmhwRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+4t2ObwyHNTnCHjDN+AqzPa0nobEkuKJyyWJ70CRyD3MPY8kVZ3PBN7kLSPJzpiMagRLVRuxIwxpiaM+Yso5mfHEqxShcVVci32itbtmoLlLwO0z/zqI6Mc2iSg6eqVG6jD92sYG8j3FJp7HWHCmhwtwBs/c3SnuZnFAdzjuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l88pJ/ZP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l88pJ/ZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728318876; x=1759854876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=80eAqYkNKW/OFeJZu+HxKcNGHWj96jywLFcSMlmhwRM=;
  b=l88pJ/ZPjYI7RXBGgEhKkdZqSeMinHZzRCXAB3UtKME1IAPD/RwFDSgH
   iUH6F8eP9aZh0miSOUxg6CL6PDXLC4RShv0OSYcuKkoTAkb56Sl4n3d8u
   ZnTmYsyPaBpSx5UEpAajEmrIRywr3ISNfOR04sdPQf7b9gBCau/p/Y/nU
   8FcVg5PEj8iFxWUupoY5qNY8dDdhWHkHqT7JNmthaDOobTsX+Ox4IUebc
   wLQYNbz4QN9B2OWhtew2ig+pvXNyO5CDdeaw9m/ZcJwhz3NeLILjudPIn
   ge1U2MiS7UekP+LxN6GK6o1NeGjdHI0KxM/UErwCQtMTZCjDhNvuhPmAh
   w==;
X-CSE-ConnectionGUID: j27nKZxCTHyTLi6eDUemWw==
X-CSE-MsgGUID: DhC1rq5qTuu3ypaA5hNdxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="50012855"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="50012855"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 09:34:36 -0700
X-CSE-ConnectionGUID: TmB1TY5IQDKPoKRjqu85BA==
X-CSE-MsgGUID: UX4CXJUgThmvDtAw51rKJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="106289039"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 09:34:33 -0700
Message-ID: <c721ae77-f06e-4928-be99-1daa78a83be0@intel.com>
Date: Mon, 7 Oct 2024 19:34:22 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Support for emmc hardware reset
To: Paul Alvin <alvin.paulp@amd.com>, michal.simek@amd.com,
 ulf.hansson@linaro.org
Cc: git@amd.com, linux-arm-kernel@lists.infradead.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241007095445.19340-1-alvin.paulp@amd.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241007095445.19340-1-alvin.paulp@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/24 12:54, Paul Alvin wrote:
> Add hw_reset callback to support emmc hardware reset, this callback get
> called from the mmc core only when "cap-mmc-hw-reset" property is
> defined in the DT.
> 
> Signed-off-by: Paul Alvin <alvin.paulp@amd.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v2:
> - Updated the CC list
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 5edd024347bd..0cb05bdec34d 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -76,6 +76,8 @@
>  #define FREQSEL_225M_200M		0x7
>  #define PHY_DLL_TIMEOUT_MS		100
>  
> +#define SDHCI_HW_RST_EN		BIT(4)
> +
>  /* Default settings for ZynqMP Clock Phases */
>  #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
>  #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
> @@ -475,6 +477,21 @@ static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
>  	}
>  }
>  
> +static void sdhci_arasan_hw_reset(struct sdhci_host *host)
> +{
> +	u8 reg;
> +
> +	reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +	reg |= SDHCI_HW_RST_EN;
> +	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
> +	/* As per eMMC spec, minimum 1us is required but give it 2us for good measure */
> +	usleep_range(2, 5);
> +	reg &= ~SDHCI_HW_RST_EN;
> +	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
> +	/* As per eMMC spec, minimum 200us is required but give it 300us for good measure */
> +	usleep_range(300, 500);
> +}
> +
>  static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>  				       struct mmc_ios *ios)
>  {
> @@ -505,6 +522,7 @@ static const struct sdhci_ops sdhci_arasan_ops = {
>  	.reset = sdhci_arasan_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  	.set_power = sdhci_set_power_and_bus_voltage,
> +	.hw_reset = sdhci_arasan_hw_reset,
>  };
>  
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)

