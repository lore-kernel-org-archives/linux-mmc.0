Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D5188CA5;
	Thu,  8 Aug 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101538; cv=none; b=kM+57KqdbtNK0hp6auNhb6Fa/JnnqYY8ohL3wSn4Dsn7TZqDdaWI49RlVjq7/WsjS61X2+9fXML2K4s4h7Nsx3cBI8uC046S8DY399SE8fFqIUgiImuo3Ik7AnFRw8oJfKDTgj64i3kMM4gp/TCJspWj26gB2hRvK8TnuCzQVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101538; c=relaxed/simple;
	bh=O9EZaWrR7lNuaqrZDuypfiO/KHWaclbwiwKXa26AQEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kl4xoleYmc87zggqy/+s0sNK8Ithn3WdErVcXO1euSNQaF/tDwEPXDZ4tFubB1jDT+Iw8g9VlREBtPLv31CbSEbkMggq4IUx51WBSOGK+S9RcRyM+Ky3i6gczRIYMrcwcSI58dFsrom4TT3Sff8rtsuibGvraUwtha/lsUOlvPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dK8luZ64; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dK8luZ64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723101538; x=1754637538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O9EZaWrR7lNuaqrZDuypfiO/KHWaclbwiwKXa26AQEs=;
  b=dK8luZ64b2543lp+uJJX7mq4r7sno8SGgPmkCsLt4psVke1wZ4w2cEnh
   CIRE7F+C4ZtNtjkLwTTAgifgIjaNilDsf3y+tgpstAM0ZAhGeZqIS4yoR
   zBRN5P3hgzNH+8DeqG9/tsbCLMtmpuwojBJujASbVT34M7cPsW4cmyPg/
   npd1x/h/TZPQsa+RAYciduE/mkfHrau5cpRpBXLdEMahllG6gQow1e9gH
   Kg67Z9dWfwI3nFpZCHvEFftB3XkAHrMfmuQ/R4vJQbrIbXvtCRTSZxYqP
   n9J8CHFVXHSEUsZTtXDDcGVK5ZxK3XjFEulY39WdufdNBGPY8fTjLlM7b
   Q==;
X-CSE-ConnectionGUID: kWVBN2h6TjGFvD0zRdIu9w==
X-CSE-MsgGUID: hRm594DOQGykDMrry/Rt2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21352183"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21352183"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:18:57 -0700
X-CSE-ConnectionGUID: 0qYkdXa/TDaj7eKCGJDHow==
X-CSE-MsgGUID: ipnaZQBPQ26KZpo/IBK4DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="80357202"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.150.149])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:18:48 -0700
Message-ID: <bb92e3b0-302f-4e43-9905-2d9fa709ab25@intel.com>
Date: Thu, 8 Aug 2024 10:18:42 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] mmc: sdhci-of-dwcmshc: factor out code for
 th1520_init()
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>, Drew Fustini <drew@pdp7.com>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
 <23c6a81052a6dd3660d60348731229d60a209b32.1722847198.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <23c6a81052a6dd3660d60348731229d60a209b32.1722847198.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/08/24 12:17, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Different socs have initialization operations in
> the probe process, which are summarized as functions.
> 
> This patch first factor out init function for th1520.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Reviewed-by: Drew Fustini <drew@pdp7.com>
> Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
> Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 51 +++++++++++++++++------------
>  1 file changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index a002636d51fd..b272ec2ab232 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -830,6 +830,35 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	}
>  }
>  
> +static int th1520_init(struct device *dev,
> +		       struct sdhci_host *host,
> +		       struct dwcmshc_priv *dwc_priv)
> +{
> +	dwc_priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
> +
> +	if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
> +	    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
> +	    device_property_read_bool(dev, "mmc-hs400-1_8v"))
> +		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
> +	else
> +		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
> +
> +	/*
> +	 * start_signal_voltage_switch() will try 3.3V first
> +	 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
> +	 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
> +	 * in sdhci_start_signal_voltage_switch().
> +	 */
> +	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
> +		host->flags &= ~SDHCI_SIGNALING_330;
> +		host->flags |=  SDHCI_SIGNALING_180;
> +	}
> +
> +	sdhci_enable_v4_mode(host);
> +
> +	return 0;
> +}
> +
>  static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1231,27 +1260,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	}
>  
>  	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
> -		priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
> -
> -		if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
> -		    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
> -		    device_property_read_bool(dev, "mmc-hs400-1_8v"))
> -			priv->flags |= FLAG_IO_FIXED_1V8;
> -		else
> -			priv->flags &= ~FLAG_IO_FIXED_1V8;
> -
> -		/*
> -		 * start_signal_voltage_switch() will try 3.3V first
> -		 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
> -		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
> -		 * in sdhci_start_signal_voltage_switch().
> -		 */
> -		if (priv->flags & FLAG_IO_FIXED_1V8) {
> -			host->flags &= ~SDHCI_SIGNALING_330;
> -			host->flags |=  SDHCI_SIGNALING_180;
> -		}
> -
> -		sdhci_enable_v4_mode(host);
> +		th1520_init(dev, host, priv);
>  	}
>  
>  #ifdef CONFIG_ACPI

