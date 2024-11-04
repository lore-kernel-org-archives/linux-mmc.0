Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00A290F
	for <linux-mmc@vger.kernel.org>; Mon,  4 Nov 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717402; cv=none; b=ut7TCjfg8v9EB/SOIIAEMy34tEUeO7GYlDsLgzB12M5jflIyFYDLaB9g5/wu37oJUtPRMgFns8QGqR9s3UpWyKkpeb3r9wAfM4QaqYQXQxYYeo1eFXCKNRET54S3JMpjy91bzV8EbpitbLHiuHPgijDH9clH+CemG/OT0ybxs1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717402; c=relaxed/simple;
	bh=HjiluiYYU8ct9uzPa/9+3mrpL1aTF+xLCA8ImAoVnW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRrD/ezfHE2TXp4hpOXw5ErVfkfGpuYJYAU2CiMCX/YH5rJ3bCWocui/RtaQDr8RKr9/JjmRuomCpjNj225roieO49z1TwxkDIwUl/MQ+BU4JhDGIxv4mfceCn3OaarnLhSuTP+JbszgoN0nL6G8RWkg4Q4d96hLyVhqR+tEA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AU5V7fnL; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AU5V7fnL"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso30532221fa.3
        for <linux-mmc@vger.kernel.org>; Mon, 04 Nov 2024 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730717398; x=1731322198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeXQFy9Pj3a/4ODUXYJdySuoRgQr+QO7RlBYiaBrsZk=;
        b=AU5V7fnLPInUAccZmsYThZC/FIOOhHmW3PGKooWGVc9ogmaLvR0mCiFk64r6C9nLPh
         Fj0qV/ce132viVbNlqCheppIVYzRvsUTbLXzqoRxF4ISNpudn9vMefX9sNWoN8zSHakA
         gHzkfG5N8dR6JweS6kUqa+Y6Pksb/YkY4BPiQytYtUFEvtNNvCANe5pqoWoLw47H6YXJ
         /MJkWyRBxgaFp291ARQ62hRJxspi8XT2IAfIAmfmNMzr5JW+cdKltHBGK07vkB4uOKqm
         jlobwEJiLmCifTwuyXvRzDFgZ7kluOZWRefQIYkIBEB5NJt1uqljnKZQDaCXAmgrmLMo
         pS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730717398; x=1731322198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeXQFy9Pj3a/4ODUXYJdySuoRgQr+QO7RlBYiaBrsZk=;
        b=w1XowMOBnevMNzu+w0Rlg+ERgwtnIE7P58jT0driIvsfOrhQZKiGTaXCxH8Kocvxcl
         PvpXF/EkvSuFJDfHry+t4zbqShoumvku+q35t14bn+HmcKRpi2AZTu41tJqmjEiQTrO8
         U94bADGB2LHjmMyZZ2W6F5rInUVpHIuS37Isxs7iolg89kXxQFMEKDymVrruu3zQXFeL
         cC5QY3VNAX/xGXyVv9TdkEI2P1rk+vz9XtOp+OtMSBU1nxxD7jnDCltdju38QnF2/NLv
         ZIHDh3RDs2K0uetHoBzF5P8cYXbXq27oG/gpurAG2Sl0IEVzshcZHmnEdL1rh9AK42aq
         rOUg==
X-Forwarded-Encrypted: i=1; AJvYcCUPeZ0J/6B0DzSc97f26MqMTkJQSWdha0fE1phgRUtpx+m8fP3mrPz/vMYjQp7ZTKwpCagz1R1YDMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKX270zzKp/YPUqI4X6mOqtBaVxMmO1ZU/a/ceyFN/VGL9YLes
	fWWUsSvWiOopQ1kCKly9BZ10YKED3lHahc9WtcqlgYQ1SApK7I9IzHweULDIG3o=
X-Google-Smtp-Source: AGHT+IFkB+YOxqygY78jfvdT7ykV+NKLizBcQos+MO01VyMRIJ9LTRYILzClrQ7HWeqYmtT14mH4Sw==
X-Received: by 2002:a2e:1302:0:b0:2fb:5723:c9ea with SMTP id 38308e7fff4ca-2fd059d336amr70161111fa.30.1730717397626;
        Mon, 04 Nov 2024 02:49:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3b732bsm16206121fa.4.2024.11.04.02.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:49:56 -0800 (PST)
Date: Mon, 4 Nov 2024 12:49:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com, quic_nguyenb@quicinc.com, 
	quic_rampraka@quicinc.com, quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_narepall@quicinc.com, kernel@quicinc.com
Subject: Re: [PATCH V1] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for
 qualcomm controllers
Message-ID: <konkbi4hvd7qc4rhokwrymzqntroy7gijk3ndwv5rluswdrykp@xsafrtrjzmuq>
References: <20241104060722.10642-1-quic_sartgarg@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104060722.10642-1-quic_sartgarg@quicinc.com>

On Mon, Nov 04, 2024 at 11:37:22AM +0530, Sarthak Garg wrote:
> Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
> This enables runtime PM for eMMC/SD card.

Could you please mention, which platforms were tested with this patch?
Note, upstream kernel supports a lot of platforms, including MSM8974, I
think the oldest one, which uses SDHCI.

> 
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e00208535bd1..6657f7db1b8e 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2626,6 +2626,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  		goto clk_disable;
>  	}
>  
> +	msm_host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
>  	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
>  
>  	/* Set the timeout value to max possible */
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry
