Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB84381B1;
	Mon, 16 Sep 2024 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467281; cv=none; b=fLwNY72CYGHa11EOocfaOboPGPERKJmAIkRpIyzvmklp2dkyyFQh0/mtrHAyLjdFW/FamRJV1t9hG+hRNCKEUb/AqEQtvD17kYxZUSCGEPnkkyUUAIZKH1qcvXrUrVurbeQ55J/u1i1kOUPRqbv1IrnX8j384HOIbQAUmiBbeKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467281; c=relaxed/simple;
	bh=u9HtB7G1aej2/1qKTIOY/GVnpLPVCv89gNSFOJl/2tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiduLn1XSd7Qm0xSLzRAUCS7VxrayR391JNsTg/iOjxMdHSBWTfAbqmhAz8uih5k+bIWj3uqv4XRZUt4M+PKtkFM1/Ofowu0c5SerM2y/tYqb8RSxbbhAcL/L8XrH1YQRr03oB1Ee4lhZGjN0HAW1ym/1p+CbyjowoYiYa7om+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVdNDIvN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVdNDIvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726467279; x=1758003279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u9HtB7G1aej2/1qKTIOY/GVnpLPVCv89gNSFOJl/2tI=;
  b=ZVdNDIvNVo1fabt1r3rNnG3U7nk4WHePFpWDGRF1SlNGKn+4uPrplrF3
   A/Qmiik3Fj1I5UBEKYvzyUjlJJwR3atozQ4zBq/9yBxGx8EDI0+emRW6J
   1Aah2moCWyJlQqxo2aJTejuH6SSvHKdddLodWt28ObXcm6zgBZKiTF3H/
   4ELSdApq1Uns4AWR5ImJWivL5JW5qt46stibOh48W3t9g4YguWqKO+30O
   NRMPgbApqWfeN50eFEaZBQDOkWoRRANaGWsb6jd8BG+4ZQWflmu6lyomM
   v4aCzwCJUFEjxZVCQ6SBaMjF3L/y2ycEQxrZ4Dqw7lE7Rra6usIxswj0P
   w==;
X-CSE-ConnectionGUID: okjPL7WIRCmF25LEACqFAA==
X-CSE-MsgGUID: cLQYKkS1T1ifs4w8EyD6zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25381533"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="25381533"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 23:14:39 -0700
X-CSE-ConnectionGUID: Gqz0449aTfarOfCAqvWr1A==
X-CSE-MsgGUID: RyykI/LeQHu0KE6QgMXlHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="73158561"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 23:14:37 -0700
Message-ID: <7d3fb0a8-96a1-48cc-97ce-c25d19ded4e7@intel.com>
Date: Mon, 16 Sep 2024 09:14:33 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240913185403.1339115-1-jm@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240913185403.1339115-1-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/24 21:54, Judith Mendez wrote:
> The sdhci_start_signal_voltage_switch function sets
> V1P8_SIGNAL_ENA by default after switching to 1v8 signaling.
> V1P8_SIGNAL_ENA determines whether to launch cmd/data on neg
> edge or pos edge of clock.
> 
> Due to some eMMC and SD failures seen across am62x platform,
> do not set V1P8_SIGNAL_ENA by default, only enable the bit
> for devices that require this bit in order to switch to 1v8
> voltage for uhs modes.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes since v1:
> - Invert quirk logic
> - Simplify sdhci_am654_start_signal_voltage_switch() and call
>   sdhci_start_signal_voltage_switch() when the quirk does not apply
> - Simply logic when detecting when quirk should be applied
> ---
>  drivers/mmc/host/sdhci_am654.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 0aa3c40ea6ed8..9ff07aadb2d91 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>  	u32 tuning_loop;
>  
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
> +#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>  };
>  
>  struct window {
> @@ -356,6 +357,29 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>  	sdhci_set_clock(host, clock);
>  }
>  
> +static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
> +	    ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +		if (!IS_ERR(mmc->supply.vqmmc)) {
> +			ret = mmc_regulator_set_vqmmc(mmc, ios);
> +			if (ret < 0) {
> +				pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
> +				       mmc_hostname(mmc));
> +				return -EIO;
> +			}
> +		}
> +		return 0;
> +	}
> +
> +	return sdhci_start_signal_voltage_switch(mmc, ios);
> +}
> +
>  static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
>  {
>  	writeb(val, host->ioaddr + reg);
> @@ -844,6 +868,11 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>  	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
>  		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
>  
> +	/* Suppress v1p8 ena for eMMC and SD with vqmmc supply */
> +	if (!!of_parse_phandle(dev->of_node, "vmmc-supply", 0) ==
> +	    !!of_parse_phandle(dev->of_node, "vqmmc-supply", 0))
> +		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
> +
>  	sdhci_get_of_property(pdev);
>  
>  	return 0;
> @@ -940,6 +969,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  		goto err_pltfm_free;
>  	}
>  
> +	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>  	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>  
>  	pm_runtime_get_noresume(dev);
> 
> base-commit: cf6444ba528f043398b112ac36e041a4d8685cb1

