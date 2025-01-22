Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816001C3F04
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540011; cv=none; b=k9A/LOB/BRxa6qNnuZs5JfLZeQ0/9ecilqXGYbwJ6ISM6I1BsSsXmmUXnQ0vLRANGjZdu4jQZnvkSpeR07ASI9WGNitvIGbluXhprnOkIHfdFhXm2tUiHy6XNNj74Rut08kyppEjd5CsBrZ5IjEbTYjBeiWdNs1TvSQ3fs+qTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540011; c=relaxed/simple;
	bh=+wsrOd0qHRtyMX2kOTNMRykr4F2eirOjoPKRdQiARJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieCBHi4hZ/tD6qjyYGcIlbo2oMTBynCjh41264e38ow8WZNC4dthYKJwvrwsQeVWlFfWdo6CKpL1GoRX9R1oJjbkd1KllFoR4Eq/B/7fQSu66XN8rsDMOnIDZ6BZKcgm1ClEz6br8WVtAEGGMucd2YEu9oklD3hMGruV7utGCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luOw1zXT; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luOw1zXT"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso7174734e87.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 02:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737540007; x=1738144807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEFQawktjxbGhtjeAIH260ijjFGtUtPD1lmxQwfvD70=;
        b=luOw1zXT1F7KxHO1ToC0yFFPbSMR8TVXnyiywiUeZwQtKkdsxF/ZrcEltd/La8pxxX
         q5MxMYDPJy2WAHmVrO0Yj0kvddomuP7WngshQTzXgcGkvsrN5ck4PjODH8cm+9krO4FQ
         r/SGKjttQf777mZhDLN2M1NIwOT+ySExWttO6wsy0G3HrsHbd0Zc4d9AIKPE3En7CVeT
         VZapBnH/tUzTweswJxXpPlTYZ8r3SA5d/yWdf6Y67RAuBXJiZeXBW+LYEAXylbYtk7py
         /psgwPVxb7u3TK4sxBhmOBjD3MmBfNQ9+PXKD2af2Ll7JbmXEkQ+ar/CFeEiHDAMEunp
         xomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737540008; x=1738144808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEFQawktjxbGhtjeAIH260ijjFGtUtPD1lmxQwfvD70=;
        b=s+MjjaR8zjFanHRoikeJoimaHAWFDscq7UmJIE8yCrJdGhk6Q3JzPTTxRRWUfA5AF/
         q4/keje2s9e7kdBwGL+NUvvyc6AogDDmFIVrcmMBkOdwTliKfywA73y8djXhPeopA7zf
         RPNGMSBBT7owLitfi8jA9gRCqU3Dq6WHy0aM8zuSyhFNqWl5DukhZKMAF0Mvv9wxud5I
         TJUe1HRYZvNd+HtrPSJoo2d8Ek4tbmSscdJ7G2C138eoNioQGaOOx9MA5ODcvwAIjpW4
         Dd38CXWOABFCyikNL0Jbd5YIWmSNXi+UzJ7wnpphfcKStIJs0+Zjp2ZyyIBiT5xv08JM
         P7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXxvfJ5m9Fy7w93K0NgWWsHO1AMS6MdhAiPM/y5/qbG4yqSmZ8akJT+0jpFw0aVPUiz0jwDeIP1xoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfoC6baCtQg/YnHo3H0jumZXjWU8GhYOQ0/tiD5A3uOlsjwDhZ
	4EJXQ7YdhMH/+yN9tH24emWVgSBXILhHYXsJ5+Pv5G7gglVaqj2NXjzMqcVLNPM=
X-Gm-Gg: ASbGncvBRyXuQUqHoVHOdnaG82M69qeG8tK5HLvNYAUHW2F9KXAzCRj2itjtye8Ankp
	oTEOmf++qnmtjvfH/RdEyTCC8aIXyne3Yrkrka1RCheu6DOIr2W6wRisWVeRMjvXqwEO87staVr
	wXa/WnC+a+EhviP2ly0vCRVXQuhdDdeNUidAeidM69K2TSX/0z+W2+9UxWTWAnj0S4qV2mx62VP
	rsxLmAcIi3X2EyMYyKL1qDdsWelonpvQt7Gs9YG/8EAMxwy3n69MP5tLYtNsXviMHfUGlIqsm50
	s6ugP1InW5wjKWrysz1PJqzbAa9ADztudKpwxhQSuIODZeBEnA==
X-Google-Smtp-Source: AGHT+IEzUj8d1CjaJ2+hjasjv+g9ctm8BlZOjITBAX5i3FJQn+c/3JTOFqKIBY7RUuTDcdqTjs92zg==
X-Received: by 2002:ac2:5497:0:b0:542:2a20:e699 with SMTP id 2adb3069b0e04-5439c21f31fmr5489633e87.9.1737540007532;
        Wed, 22 Jan 2025 02:00:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af0e8ffsm2174384e87.59.2025.01.22.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 02:00:06 -0800 (PST)
Date: Wed, 22 Jan 2025 12:00:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sachin Gupta <quic_sachgupt@quicinc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com, quic_nguyenb@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_mapa@quicinc.com, quic_narepall@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com, quic_sartgarg@quicinc.com
Subject: Re: [PATCH V3 4/4] mmc: sdhci-msm: Rectify DLL programming sequence
 for SDCC
Message-ID: <nmsm6bb5biptmzruggs4f3mweq7d7hcmwqjdidf6bi7gyoliw2@x4yitguzz6zx>
References: <20250122094707.24859-1-quic_sachgupt@quicinc.com>
 <20250122094707.24859-5-quic_sachgupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122094707.24859-5-quic_sachgupt@quicinc.com>

On Wed, Jan 22, 2025 at 03:17:07PM +0530, Sachin Gupta wrote:
> With the current DLL sequence stability issues for data
> transfer seen in HS400 and HS200 modes.
> 
> "mmc0: cqhci: error IRQ status: 0x00000000 cmd error -84
> data error 0"
> 
> Rectify the DLL programming sequence as per latest hardware
> programming guide
> 
> Signed-off-by: Sachin Gupta <quic_sachgupt@quicinc.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 270 ++++++++++++++++++++++++++++++++---
>  1 file changed, 252 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index cc7756a59c55..17f17a635d83 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -28,6 +28,7 @@
>  #define CORE_VERSION_MAJOR_SHIFT	28
>  #define CORE_VERSION_MAJOR_MASK		(0xf << CORE_VERSION_MAJOR_SHIFT)
>  #define CORE_VERSION_MINOR_MASK		0xff
> +#define SDHCI_MSM_MIN_V_7FF		0x6e
>  
>  #define CORE_MCI_GENERICS		0x70
>  #define SWITCHABLE_SIGNALING_VOLTAGE	BIT(29)
> @@ -118,7 +119,8 @@
>  #define CORE_PWRSAVE_DLL	BIT(3)
>  
>  #define DDR_CONFIG_POR_VAL	0x80040873
> -
> +#define DLL_CONFIG_3_POR_VAL	0x10
> +#define TCXO_FREQ               19200000
>  
>  #define INVALID_TUNING_PHASE	-1
>  #define SDHCI_MSM_MIN_CLOCK	400000
> @@ -309,6 +311,16 @@ struct sdhci_msm_host {
>  	bool artanis_dll;
>  };
>  
> +enum dll_init_context {
> +	DLL_INIT_NORMAL,
> +	DLL_INIT_FROM_CX_COLLAPSE_EXIT,
> +};
> +
> +enum mode {
> +	HS400, // equivalent to SDR104 mode for DLL.
> +	HS200, // equivalent to SDR50 mode for DLL.
> +};
> +
>  static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -793,6 +805,211 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>  	return 0;
>  }
>  
> +static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
> +{
> +	return SDHCI_MSM_MIN_CLOCK;
> +}
> +
> +static unsigned int sdhci_msm_get_clk_rate(struct sdhci_host *host, u32 req_clk)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	struct clk *core_clk = msm_host->bulk_clks[0].clk;
> +	unsigned int sup_clk;
> +
> +	if (req_clk < sdhci_msm_get_min_clock(host))
> +		return sdhci_msm_get_min_clock(host);
> +
> +	sup_clk = clk_get_rate(core_clk);
> +
> +	if (host->clock != msm_host->clk_rate)
> +		sup_clk = sup_clk / 2;

Please resolve previous discussions before sending new versions. Just
sending a response and then sending next iteration of the patchset is
not a proper way to communicate.

NAK until the discussion is resolved in the previous thread.

> +
> +	return sup_clk;
> +}
> +

-- 
With best wishes
Dmitry
