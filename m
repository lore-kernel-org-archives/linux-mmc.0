Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C751990A7
	for <linux-mmc@vger.kernel.org>; Wed, 28 May 2025 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419324; cv=none; b=Sz26qaITPN2u/IwBO9aX3WVCrF5UoZO461jdgVT2l7CFKnDhxv2KckA6I5lyrgDFohLGfRJMGZfcD4dlFWpT8HN1DjiaZSYRcmr5vGG3wZT1iMpw4h6eDnQJCSleGu1CyPH4GYE5jsUMS+JtE2o2KknBYJ/gZLmyH2176hTWhnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419324; c=relaxed/simple;
	bh=bc5R7CtqjDni15rTJzYiribFx1+fT9lW5tyK1vXUIqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS//KhU8y6DTn4mrqyqH+8Uyu2y20w6AkGv/cILqdUZf2d6MbbW8LvsQxAgGJe5Zwzx6E1O+r7Kv2gwMZgML4CAK6+ticVg+rQ1Kw1S7PVAcJhKvWwrdinrsvBGIJZQag4wzkbNUq97vcg5+0/PvM3tlmlz7p5VCoHLllU08ZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JEQDHrfm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JEQDHrfm"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442ea341570so30336495e9.1
        for <linux-mmc@vger.kernel.org>; Wed, 28 May 2025 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748419318; x=1749024118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnyAhLgmCcQzs7N3JYb3LiG/9mWrQxUmPhbmilLtKA4=;
        b=JEQDHrfmnKoPBJWg3MB1aj4CugzOELOSxa4vS4/fKUgxblnlU+QPahM9xxewolWfEX
         cdy3U8YSMBlVYrOyFhj0bAGBzm4JmFFvRQDigg3647PrtndeyJG4f8Zb7mhddGSEJvS5
         fVvF68bnhWac+XP0MUJIT3UqjfoqOnCF9xK/4gd0TLhzCoFHhF1sSv/2jdPtAyTYOMsl
         bTZUlZbgXe04CkXA4XJOjvZQZYZhYsopAQ4TWp/e4Qglr274tr77hCYwqy/2k9mLDU/R
         NQSQhLAUxmBfcZ9SdIKA+YWytllrqhxQGJLEtexzV+uO+5fbqWNEk1tLFjkR0748iB/u
         PQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748419318; x=1749024118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnyAhLgmCcQzs7N3JYb3LiG/9mWrQxUmPhbmilLtKA4=;
        b=ga+u6exieDAVqrRIQE52XU2jgI2JF2uF8VvXbeq5KyyDxB3L1A2GGBrd/tEqHwQBxv
         Ec4FiZyvlDIddX9jEb79mvLnHwGTOBU8ZVsG3xWqrtCfwmGcf4rkHtvv4MOab2FL6WtV
         9NMqVQt5CQMjwBxFBBfM/f5J9Y4rM24tkfPi9EDmSwAN862evX6v2WLuQXCBnDO4RZXX
         9vDJElHClvFSQ3xKc2H/ET3hFbQggUMy7OaGE2MDfkExL1rO67gKid5damC8vnVXGVJb
         CmodIFPHJEMbyBuH64o5NDS7NOyx447+lziHu5TExbzLvj+pXJWahxTaZSxaGrpOTv0e
         0M/g==
X-Forwarded-Encrypted: i=1; AJvYcCUYR5oW+dM3GEYDz0nhjKEwwYn5qHYSFCRp+wg2zmP2D9WhNifZd88hkperqoMZHsxgAuU55Yevj/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDaNQV8QePwG810XwVLHg2Mo07MvbNA9VJBrXiVg520EShNSvt
	fMQWgy4tScazPMF1uR9FiMt5PcvUX3CIoUtrTVwPmFjStmVAA8DOvKSRKsifqU//7pdfI1vFlKP
	VR/NI
X-Gm-Gg: ASbGncsgd9690e9Z6U1k8cDgn4OzTdbb8oBGFhLqr9LmYIFHramq90kKmkMDi4evRG/
	6s2P1t8KwzPdIgAxVkNhVkYootp8HTOoroIH5FnLPWwov2bCdzmCe4H2OkvrNzKcbPmJeHyv/sT
	fW5qG3RJSNOU4rrTNPlJgVO6++kXZl0wsA/TNMBCouBIdtzmIUo5pkMwXoXksqXGUk3ExRzIOz1
	Lq60cRTUG3FGNUluF2fllAjx38Pgoqv1UEMLfVwPLz1Fa0u+cypoxatiloeMdtkC9E+kplTknDR
	GlKNUYUAW3UcDBLxhosDUKX3yeI9Ecj9yRPRzNaGPmTDB4uAIkpohVylIqK1R4Z+wgQcA2pi/33
	h+84uqcM8MzpeniVrhw0//Lnukjw0gw==
X-Google-Smtp-Source: AGHT+IGmIjWLucv2dt543kaybHa1IUnVu090TcC1W+dXpl47URiHvDfhSCSCuVgxSdXLgL+htrBm3Q==
X-Received: by 2002:a05:600c:a00a:b0:44a:b9e4:4e6f with SMTP id 5b1f17b1804b1-44c939c0f57mr180442565e9.16.1748419318516;
        Wed, 28 May 2025 01:01:58 -0700 (PDT)
Received: from archlinux (host-80-116-51-117.pool80116.interbusiness.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4507254b860sm9494285e9.11.2025.05.28.01.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:01:57 -0700 (PDT)
Date: Wed, 28 May 2025 10:00:37 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 13/34] mmc: sdhci-esdhc-mcf: Drop the use of
 sdhci_pltfm_free()
Message-ID: <i24svs5vleomzkyat7ve5w6nko2f2p4xutxnwc72ruojkkfehj@lxqzvnzfoc7q>
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

not sure to understand, where do you see devm_mmc_alloc_host() ("in use")
called for this sd controller ?

thanks,
Regards,
angelo

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
