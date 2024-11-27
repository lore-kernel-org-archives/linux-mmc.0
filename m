Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7C28EB
	for <linux-mmc@vger.kernel.org>; Wed, 27 Nov 2024 04:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680041; cv=none; b=fCMZFkas0r8qAoWERZSGOwX7rpQ7/wuev7D1ubGNXZ4V2U5oG2i2J59ZyDUJnY5YtFGzZ94tcOFVVtrj6MZeKTvs4baClLnU6uI53EULlXrKTbuUXfdRhnXjQnCMMzYMFhATKSzKjoL0IDxee5gSQ70gVcscO1rGM6K5zL828hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680041; c=relaxed/simple;
	bh=HmL5KghJhyA1NHfNg2xF4U1baArdo1wSpfGkfHDUK8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U57WiyN2caBFWuXJhMh5RkrkX1jI/fA5jkqrpmZNBixyd/8sPhWvqrv+x+CGnUGxcCri7MvRD6scELZ7fxqoayAYNwLXQ5zmjN1QAen3XAm09Vg9fqh/54a1hpO+Kan035ZbWUm1CS38kQ+PPsBjWQ11g51uNT2rkf4JJmjX8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypQEskSa; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypQEskSa"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53ded167ae3so1587321e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 26 Nov 2024 20:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732680038; x=1733284838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvYaGtKoOy0NaIKR2w9foJlILqskaLFgzQORKPCUl0k=;
        b=ypQEskSanMKrjKGW+ixrojbbc+vVCzBWsMpVL9nTjtGn0gSHwPPaavt4VHF20ZmSwX
         IbTmSLkhVs6yLZjQNzZMLmoIfazgBalrwYORLw3PaBV8G8ycTYpdhcQ+fj420ZQVDtaU
         gtNayyC8GZtMAO9MsSbffhU9WKvNiq4fp8WSCszq3vqHZnN2m7XzeBm0XsANRG/RKtJW
         308N3TCiFYqer2ZLFB2GT7wxnSoNhc8fy+g3h6Aw42zA59SLgY6f1NL96eEi9mf1xD/t
         d5WmTxZ7dC+u+ushXiWlYNc/bIxxr2ernOD42FKPAr4PHpFPPuWBg0+HjyNT2UuL2DkU
         7Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732680038; x=1733284838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvYaGtKoOy0NaIKR2w9foJlILqskaLFgzQORKPCUl0k=;
        b=Wh2m8Htv1Xk//z7cHvabt4MvQ52uUkemphRBT05T9SCJ5JO+dLPkEy/m1OphQetnzh
         +VkDgp2PJpJMbECMc9v53xzV/m0E5W4kyTZFwttRVw53SniMAe540KvaFBjzvfoEXWat
         RA+YgGBvoFpHxKGeA3Uq4up0ngXioigup/Z019O0F3cI/QkPaHwAtnG0wT8A3HsW+0Lj
         Aes3rzL52snuYklmprOUOzeGg6AbFfnbpPcb0BGh38WabAH2a6oRh15eWxUkoeJhujWl
         IjMGKo7nLlh8KQiCwU6ISNzHYGcvHbqCK0Z/AgkPbFTyq1MkvKWAIwkcwWOxefBH5C8g
         YYRw==
X-Forwarded-Encrypted: i=1; AJvYcCUenSJEp5Izgby3x0j/O3arrbeFEn2xmxyeTqugmYbPuNLa9UCOQFsLk58vUVfK5K5/SlEcq6wVBh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM8dbX9/cwJK5oZqJdQ5cLXMurwy98Jd/9MyYBX0GTs8rpmgyb
	9UqgENsMmoPJd5bQBK+aiImV9JD+7ArVmAeQ6rsudDRAiJCHX7Eb2e58wcCCBgY=
X-Gm-Gg: ASbGncsNEKPkvdmNlMYabe4Ez4ldmjCLIfPG3gCsTg5KiG83pNZwjRNN0VlZyMZRpHr
	sMDSsutbR/i6B8nnMedXj8bhFrw3vVcOzFF9tu+TfVbVsPGJEqxKxb/v6Tb0/mPTBom1nOMDeFJ
	IDY1RsweTN14morShzqVPkQhjoYZOMW9/vosNitP+t0Oc0mEQ6W9P1dWJ4RNsyeXg3tbl8W+Ae4
	PNL6BkOfeA1Je1TlRCksXrJj1DdvJNNzD4oBNJqWiXnVpg4E8j4KWzSAMcRbKCmrKMXq54GFiYL
	j81pmBqdri12ebrAwV5DRUBqMecnLA==
X-Google-Smtp-Source: AGHT+IFe46Ut3ixzrDaftB+74Cb5uVfPJwBiur6xDbxeHzU02v/b8vYaE19Gaapdwhhc1BJVVfN3HQ==
X-Received: by 2002:a05:6512:b15:b0:53d:ed4e:e5af with SMTP id 2adb3069b0e04-53df00dce8amr636846e87.33.1732680037797;
        Tue, 26 Nov 2024 20:00:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd88b54cbsm1914492e87.214.2024.11.26.20.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:00:36 -0800 (PST)
Date: Wed, 27 Nov 2024 06:00:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_tingweiz@quicinc.com, quic_zhgao@quicinc.com
Subject: Re: [PATCH v1] mmc: sdhci-msm: Enable aggressive PM
Message-ID: <zrqcbghhhpmr2dknipkmqxcxcxnlqr4ury4haqq4n6xja5lc7p@6gh56cndcwjl>
References: <20241127031708.2343727-1-quic_yuanjiey@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127031708.2343727-1-quic_yuanjiey@quicinc.com>

On Wed, Nov 27, 2024 at 11:17:08AM +0800, Yuanjie Yang wrote:
> The sdhci-msm driver supports the device in both RUNNING
> and IDLE states, when eMMC/SD are not reading or writing,
> eMMC/SD are in IDLE state, the power management module
> will suspend the device(power off and reduce frequency,
> etc.), putting the device into a low-power mode. But the
> current sdhci-msm driver cannot put device enter into
> low-power mode.
> 
> Enable aggressive PM capability to support runtime PM
> functionality, allowing the eMMC/SD card to enter
> lowe-power mode.
> 
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>

What is the difference to [1] ?

[1] https://lore.kernel.org/linux-arm-msm/20241104060722.10642-1-quic_sartgarg@quicinc.com

> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e00208535bd1..e3444d223513 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2627,6 +2627,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	}
>  
>  	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
> +	msm_host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
>  
>  	/* Set the timeout value to max possible */
>  	host->max_timeout_count = 0xF;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
