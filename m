Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93244247285
	for <linux-mmc@vger.kernel.org>; Wed, 28 May 2025 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419597; cv=none; b=mGVYZR9hgxzeLuTW8ZEv93W5gjfnD7MNq9v+HnkkzhxhpPQ3FLkOoHMRrxZ9ethC+6PAtnKFyGO0zh4C/bo4xqbnlbyh3slhRFsd6Ii3jWW9uWRp+a2IuHmFTZEsCh4Co6d1USNAoeQM7qe+NMom+/telHfhYxnn+VQZnj+4E08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419597; c=relaxed/simple;
	bh=9aS71v4MqdOX4d+3h/cp+qDxSVUNo3PgLpdj1Xmp59E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKWaFg0UF5PR4Vm1ZghMOGEauAbnxgw9Y+3fzfT3w0dAGV0dgOOHDLG45WIrZduC46OmhmIFfZs/LIrWwiVRyfDqNMhIWVOklTZUIu9XdjWELuV/ADOfUdphQsjaaEHuiYbHuA/hUXuWoN8tSVZY3NJADa2kqLfiLNro+d/wUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pNDdVYDs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pNDdVYDs"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a3771c0f8cso3012191f8f.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 May 2025 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748419593; x=1749024393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDvKODaueiqUuQ2WNdyFZMJz1MoP1CVSh6fEWb3gbU4=;
        b=pNDdVYDs0FW+BbJscZyxEEtpwGxdJnokIUApWeWKs1WICs7zsTKBGVUUomi1GfPaz4
         0dh7CxWkbtVW12KFtSuEJVG1B8+AomqQ9amczGADhlXhekHM4URJ1obN5tp7M5b7NPXc
         ZSIx4C2cBnGcWcFQCi6eN0eg9tU+Uw3eyjN78EeNdvYikOLNUsTgHPdV9gWYWui9CdWU
         lEC4LH035drOd8ZvmpcASe784zD6ywLKl9+g5GCmSZ6hxAy2ntq0hO2mqvbS9Aga17HT
         rqLQJxpmHTyzJ8nCYRPW068Z1Xy0IeyixBwK661bKdjP+JuAQsvSwMUxCfzUZfg90RL9
         BdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748419593; x=1749024393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDvKODaueiqUuQ2WNdyFZMJz1MoP1CVSh6fEWb3gbU4=;
        b=ApZ8NStz3/STCokAXaLbJlo4wJO7opWYeiVsxRWRS7DnGfbpAi8MLDP3zTB3vPI2tN
         HV3k4UeIeDtZAtA8QB5bNn7qWfrC0Hdp1SBN7gwNcwEucCMgfPWGiSllGBCA6fb/f0dC
         PGya+zrpqg/DOMD97xILp2s4onPmRGpSl1J5F25yfFRxfrswipdp+en2vigLr5EXGDFI
         qlqogDiugdRsr1Qf5m8petYMvqeb6my3WtlPE6wItopzW8mFdDEEhBGCBVlkZ5v9LERH
         n0IFWlVGxBV922yZ2Jz/BupE41umF8ZOWxwXa4hmFRIUw9XQPsrRhrQ43GwWBfKkYDa8
         gHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcYkkxgYa9NQczai/Sp2OnLgP+1KNUQ7rN3gbiZyxYqb0mSzecibBCkEMlTUGu25K74jo7gnqzkPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9mCVdaxutfonODg40alga7qeaudey8dkaGc2oETDtd2+n3ex
	YM0R+z8+K/v43jvIvLqWUDhKdV7CBJIEXGn6NV6xnQGxB9uPtJVy4yPqIYspPC0Ev9JiGY4rlQb
	RH5/U
X-Gm-Gg: ASbGncu0bHPYi5hlfZETVVdIbauE+7JrKs82HTYAPHlQTbcsIPmWCE7ei+q+jHZ7kht
	+M1TNOKTAoPQdfpEaJzoXTzN0QOvdC0G/8hvIBF85HDxKygRoIVDEJfWaV3kQDPeUo/IwJqBT3R
	Ye7Pv872j+blkEDfob6fWjU9zcwTU9t4h7xF9jKRPtY0HXhoXXJrMuIRGu+SJmbUpT08+hBkITd
	oC2l6SrPDiLn7BV4lRljQqM1Lr4J7huZWHH14KAaaBg+CRVRdYpBeTm61I3d0iXlc757Hgd+T7h
	UOTjnMYxgk2RnFBCMYo/ojTI5oHyDLItp9hvFuY/HgiUIbN/TWg1/rs9mIiDhtgzWwr3vW50NBU
	Rwc9zLHkYWvydnxB902jdFWT1x8vAwQ==
X-Google-Smtp-Source: AGHT+IG9h5NYLd00vQcPJEz8Z49Q+NpFyTMSUOAWWfRaPbJu0cJF1dNPnKrf5+abwKYX43wp/t6HsQ==
X-Received: by 2002:a5d:5846:0:b0:3a4:dd63:4ae0 with SMTP id ffacd0b85a97d-3a4dd634d88mr7660802f8f.35.1748419592810;
        Wed, 28 May 2025 01:06:32 -0700 (PDT)
Received: from archlinux (host-80-116-51-117.pool80116.interbusiness.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac8aeb2sm784003f8f.58.2025.05.28.01.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:06:32 -0700 (PDT)
Date: Wed, 28 May 2025 10:05:12 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 13/34] mmc: sdhci-esdhc-mcf: Drop the use of
 sdhci_pltfm_free()
Message-ID: <3d45oxfr4okjn4wyevt2kot6ahvv3xba77yo44637pyo3jhc23@6z6ofqu5nmwk>
References: <cover.1747792905.git.zhoubinbin@loongson.cn>
 <15e9ab28d6b5caa6e34f343b146fc2201f4a848f.1747792905.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e9ab28d6b5caa6e34f343b146fc2201f4a848f.1747792905.git.zhoubinbin@loongson.cn>

Hi Binbin,

sorry, seen now it was invoked in 1/34.

Acked-by: Angelo Dureghello <adureghello@baylibre.com>

On 26.05.2025 14:06, Binbin Zhou wrote:
> Since the devm_mmc_alloc_host() helper is already in
> use, sdhci_pltfm_free() is no longer needed.
> 
> Cc: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 327662ba5bd9..375fce5639d7 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -426,28 +426,22 @@ static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
>  	host->flags |= SDHCI_AUTO_CMD12;
>  
>  	mcf_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> -	if (IS_ERR(mcf_data->clk_ipg)) {
> -		err = PTR_ERR(mcf_data->clk_ipg);
> -		goto err_exit;
> -	}
> +	if (IS_ERR(mcf_data->clk_ipg))
> +		return PTR_ERR(mcf_data->clk_ipg);
>  
>  	mcf_data->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
> -	if (IS_ERR(mcf_data->clk_ahb)) {
> -		err = PTR_ERR(mcf_data->clk_ahb);
> -		goto err_exit;
> -	}
> +	if (IS_ERR(mcf_data->clk_ahb))
> +		return PTR_ERR(mcf_data->clk_ahb);
>  
>  	mcf_data->clk_per = devm_clk_get(&pdev->dev, "per");
> -	if (IS_ERR(mcf_data->clk_per)) {
> -		err = PTR_ERR(mcf_data->clk_per);
> -		goto err_exit;
> -	}
> +	if (IS_ERR(mcf_data->clk_per))
> +		return PTR_ERR(mcf_data->clk_per);
>  
>  	pltfm_host->clk = mcf_data->clk_per;
>  	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
>  	err = clk_prepare_enable(mcf_data->clk_per);
>  	if (err)
> -		goto err_exit;
> +		return err;
>  
>  	err = clk_prepare_enable(mcf_data->clk_ipg);
>  	if (err)
> @@ -485,9 +479,6 @@ static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
>  	clk_disable_unprepare(mcf_data->clk_ipg);
>  unprep_per:
>  	clk_disable_unprepare(mcf_data->clk_per);
> -err_exit:
> -	sdhci_pltfm_free(pdev);
> -
>  	return err;
>  }
>  
> @@ -502,8 +493,6 @@ static void sdhci_esdhc_mcf_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(mcf_data->clk_ipg);
>  	clk_disable_unprepare(mcf_data->clk_ahb);
>  	clk_disable_unprepare(mcf_data->clk_per);
> -
> -	sdhci_pltfm_free(pdev);
>  }
>  
>  static struct platform_driver sdhci_esdhc_mcf_driver = {
> -- 
> 2.47.1
> 
