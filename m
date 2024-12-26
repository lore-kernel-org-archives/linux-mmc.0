Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E84189B8F
	for <linux-mmc@vger.kernel.org>; Thu, 26 Dec 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735247059; cv=none; b=dG9+KF5zityBkYFXdEt1BIQLjEkNQR15W0qqzy4+G4G5YM7Tz8eQLQ4nk3iMAMdawafdTUKVtMOL3Khqd0ijqQyiqzvrQa1Op+hmH9aic37UUJt52p+n1PYqeqGtg8vO/OnYcEDvi36woI/IvSY/QId/d2KQbF1zHdy2Pl0GPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735247059; c=relaxed/simple;
	bh=w5LPUHK4LvFCZM0G2OA6ufsHRsK6Q16qHrgCK8A5E8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEhled19INSxLfBg+t0+MY/coE5MMPPu15kyHEucbVOss4JyUv4j8hy0vZHidcOWNlqEEluUpFAUpdZBd1nbIIFBm2sa6EHwWa01zGxC1RpacLuIJ5jt0eY4ZLLHx9sC0aQzgFK/jj3Xst5dy0jVQIZR0duo0E4GMPDQHFue030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjuUZmd2; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjuUZmd2"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so7259807e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 26 Dec 2024 13:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735247055; x=1735851855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOwf980uHA6/rXG31emGACIj8be43/3tzDSjlpZoroI=;
        b=bjuUZmd2dq1xFHXAG5BZCuA6fM5Vt0SDfxPyW9JKspW/gBMrMiMu+cU01/qPdnUDcD
         +fwFP64Ik61c4bbg/sJ389HxLYvwuf5wCgYp23b9EL7pREVNxez3ymME5eDwzVb/h7zg
         pse5ihY1aty3NHuWjfC/XjtE/9baVZTyLZqpkcfHriOeE+0UtYMEDFfUbe5GX3VNQZ3i
         cVcHqTDmEBHhwyej1D6+VttR2PaefIEXTVVxW7oTKgJzlzZhMHRzN0zWc7bP7u5HuA5K
         i/X4AfzUXT+1+kv2jdUN1UUikVAQd4zRzbVu9UsNnp3NrGVUALWLwbgQUPoo+ix7HuCv
         t2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735247055; x=1735851855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOwf980uHA6/rXG31emGACIj8be43/3tzDSjlpZoroI=;
        b=kWzYfacsvfZcKbpFNfOqlBwUbS6ii5Zg0NTQgmBHmEKMHS9MBX4lTbSOuRLAOJV9Zi
         w7q4Q8QjhawFfRdBp1OivpidO2uu/wksGk4Gd1mt4VgT+Vlmb7vLTCIlxoJEHfBlofYi
         kPH3ficB3I9EngbUMZZwY2be4xbaIuDQ4Vm2a6mbGrxUVmJJVJFlBeE4Tpeejjl5nrl8
         EvWFXLqNg9POzz1skqI2vmax5L5A8N+xP9a+kdRxPlNJvaKDBLmGNzMRfQXDGjJv5DJX
         dF37MAPKtyAu7b3SnGQBEVxzGP6P4RPrrfzteAzaLl2pKQpDMztuab31ha8RRResJnRn
         L0/A==
X-Forwarded-Encrypted: i=1; AJvYcCV7of6XDCipqhvuUHLwQG2MpL6oQnevAUYSruynIq9qn6FfPZpbbB7dZ2VJeND8c9rpo1AaPd5jNoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Y31iYHCg/DFQm0ZR3/vS6MBiIOb9AnYuI0PD1yzy2UJ3f5Qv
	dssgKyqKRHU3ZleI76M2Y/Qar9Oa3EtHhFz+7EekX444GsQAKjm7SBwMqb4EARk=
X-Gm-Gg: ASbGncvW+5iuDib0svO/6AHVea7yh9PYBDNxcsb0KPCVbVtLdNVJC8YdmrzVmDXjYWx
	xGQC7zI2RMgG/+CWFWm5GR9IlXQC8rnqlw/hWPSVgGKZ7+Ci1k3K8VD1Zl0iXlOOfbE57oLgJrz
	IR3J0+GHlQx/Hwr5CXTCydX+Lwl9ACnte+v2VgqNklG32y1xnUZKBQi8D6USgF8XBLiAkNvJy+L
	GcDMzBPQFPJT3B5XrmtYJetj3Gz3CcFbSUwvtIhD92tr7sJfkgsYgCGDlUmFxoVqYMjeyBmkTEx
	nEz/R0Gp9NXwm4IzG9fBrAyKYAiPPDdX4axi
X-Google-Smtp-Source: AGHT+IFDzAcuGSZ7nNZvfRLyI+DWmKNLOa1eIbqZ8rhaJ3AWR0XJoCKwXjst6+yPjQDefJtkdGntGg==
X-Received: by 2002:ac2:4e04:0:b0:539:f630:f233 with SMTP id 2adb3069b0e04-54229586f00mr7613430e87.57.1735247055082;
        Thu, 26 Dec 2024 13:04:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238136f5sm2236642e87.116.2024.12.26.13.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 13:04:13 -0800 (PST)
Date: Thu, 26 Dec 2024 23:04:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andersson@kernel.org, quic_tingweiz@quicinc.com, quic_zhgao@quicinc.com
Subject: Re: [PATCH v3] mmc: sdhci-msm: Correctly set the load for the
 regulator
Message-ID: <5q4wxz52mq6b73chi3o3xtspqbczycboeqiqsqnse6qg3vvbya@ih5rac2jqsrb>
References: <20241226031845.2574669-1-quic_yuanjiey@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226031845.2574669-1-quic_yuanjiey@quicinc.com>

On Thu, Dec 26, 2024 at 11:18:45AM +0800, Yuanjie Yang wrote:
> Qualcomm regulator supports two power supply modes: HPM and LPM.
> Currently, the sdhci-msm.c driver does not set the load to adjust
> the current for eMMC and SD. If the regulator dont't set correct
> load in LPM state, it will lead to the inability to properly
> initialize eMMC and SD.
> 
> Set the correct regulator current for eMMC and SD to ensure that the
> device can work normally even when the regulator is in LPM.
> 
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> ---
> Changes in v3:
> - Optimize the code logic and separate code for regulator vmmc and vqmmc
> - Rebase on tag: next-20241217

10 days old branch

> - Link to v2: https://lore.kernel.org/all/20241127095029.3918290-1-quic_yuanjiey@quicinc.com/
> 
> Changes in v2:
> - Add enum msm_reg_type to optimize the code
> - Delete redundant emmc type judgment
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20241122075048.2006894-1-quic_yuanjiey@quicinc.com/
> 
> ---
>  drivers/mmc/host/sdhci-msm.c | 64 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e00208535bd1..22811964ba61 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -134,9 +134,18 @@
>  /* Timeout value to avoid infinite waiting for pwr_irq */
>  #define MSM_PWR_IRQ_TIMEOUT_MS 5000
>  
> +/* Max load for eMMC Vdd supply */
> +#define MMC_VMMC_MAX_LOAD_UA	570000
> +
>  /* Max load for eMMC Vdd-io supply */
>  #define MMC_VQMMC_MAX_LOAD_UA	325000
>  
> +/* Max load for SD Vdd supply */
> +#define SD_VMMC_MAX_LOAD_UA	800000
> +
> +/* Max load for SD Vdd-io supply */
> +#define SD_VQMMC_MAX_LOAD_UA	22000
> +
>  #define msm_host_readl(msm_host, host, offset) \
>  	msm_host->var_ops->msm_readl_relaxed(host, offset)
>  
> @@ -1403,11 +1412,59 @@ static int sdhci_msm_set_pincfg(struct sdhci_msm_host *msm_host, bool level)
>  	return ret;
>  }
>  
> -static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
> +static void msm_config_vmmc_regulator(struct mmc_host *mmc, bool hpm)
> +{
> +	int load;
> +
> +	if (!mmc->card) {
> +		regulator_set_mode(mmc->supply.vmmc,
> +				   hpm ? REGULATOR_MODE_NORMAL : REGULATOR_MODE_IDLE);

Can there be other users of the regulator or is it an exclusive one?
Because if there can be other users, you could have pulled the power
from them.

> +		return;
> +	}
> +
> +	if (!mmc_card_mmc(mmc->card) &&
> +	    !mmc_card_sd(mmc->card))
> +		return;
> +
> +	if (mmc_card_mmc(mmc->card))
> +		load = MMC_VMMC_MAX_LOAD_UA;
> +	else if (mmc_card_sd(mmc->card))
> +		load =  SD_VMMC_MAX_LOAD_UA;

if (mmc_card_mmc(mmc->card) ||
    mmc_card_sd(mmc->card))

> +	load = hpm ? load : 0;
> +
> +	regulator_set_load(mmc->supply.vmmc, load);
> +
> +	return;
> +}
> +
> +static void msm_config_vqmmc_regulator(struct mmc_host *mmc, bool hpm)
> +{
> +	int load;
> +
> +	if (!mmc->card) {
> +		regulator_set_mode(mmc->supply.vqmmc,
> +				   hpm ? REGULATOR_MODE_NORMAL : REGULATOR_MODE_IDLE);
> +		return;
> +	}
> +
> +	if (!mmc_card_sd(mmc->card))
> +		return;
> +
> +	load =  hpm ? SD_VQMMC_MAX_LOAD_UA : 0;
> +
> +	regulator_set_load(mmc->supply.vqmmc, load);
> +
> +	return;
> +}
> +
> +static int sdhci_msm_set_vmmc(struct sdhci_msm_host *msm_host,
> +			      struct mmc_host *mmc, bool hpm)
>  {
>  	if (IS_ERR(mmc->supply.vmmc))
>  		return 0;
>  
> +	msm_config_vmmc_regulator(mmc, hpm);
> +
>  	return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, mmc->ios.vdd);
>  }
>  
> @@ -1420,6 +1477,8 @@ static int msm_toggle_vqmmc(struct sdhci_msm_host *msm_host,
>  	if (msm_host->vqmmc_enabled == level)
>  		return 0;
>  
> +	msm_config_vqmmc_regulator(mmc, level);
> +
>  	if (level) {
>  		/* Set the IO voltage regulator to default voltage level */
>  		if (msm_host->caps_0 & CORE_3_0V_SUPPORT)
> @@ -1642,7 +1701,8 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  	}
>  
>  	if (pwr_state) {
> -		ret = sdhci_msm_set_vmmc(mmc);
> +		ret = sdhci_msm_set_vmmc(msm_host, mmc,
> +					 pwr_state & REQ_BUS_ON);
>  		if (!ret)
>  			ret = sdhci_msm_set_vqmmc(msm_host, mmc,
>  					pwr_state & REQ_BUS_ON);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
