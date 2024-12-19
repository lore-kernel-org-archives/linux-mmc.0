Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D603B1A1
	for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2024 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577752; cv=none; b=q51oQ8Hecujds5ZI7XRaTIo2RwOKb6Ua10MA7BPUXYfXMtaCxa4VrdBGOiz0QCWqaNAxeZiEq8dn7lbsnLSeDRngtcmIyVm6goiLvEYEVVyQfbZtmjfx/3qgV+22tXh/eAY2IAiJL0COm2gTCQILT+Pl1BfZrdlP468SCcboulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577752; c=relaxed/simple;
	bh=h6rtXx6E/Ub/8ntDL7SsxJGNcDe7moZzv+DgjbG2H/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8riIotVcvHvJVkeC+TgogGt6N8sKq0tBOFjub4YY8MLTzaxB/nZui7zv/PvdyYcylm336su8rNI8EXHqQZQk5oqTBToBMyWvRs7/t6BA0ZunKnnGLNPJ4RIQSU88k42G7I+c2cOImbA8YoemHOhquVUZILkJmGIgDQh3iC09Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VG5U5OBA; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VG5U5OBA"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53f22fd6887so226382e87.2
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2024 19:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734577749; x=1735182549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAWj/RXMsp39rYtlPFugVfFgIik5mQ56vTtEiy6K898=;
        b=VG5U5OBAO1/0c2NoAS8EgOPyS//UMo4tfFgffo+3ZP81uSqnaGfj5+TqUJN4sQ9MlY
         cWtrJ6dZwZ9oHy6P97/OnLK7klSPmTfz7QYyzp2+/lzzVPGBk1VJ7OWeVU/LInw76jUV
         m1yazrzBQEphZks3dvcr8NiKcFAttpR8y9OTkdZ/JVPeSPyVQJyLcCK1sKFkYBBONyYx
         b7hqkLVj+uVo2odihWXh+g2AeYZCjRrPpSNnqWJJSxf4Xfpj8xY70fl0ynaGxtMRGKD8
         UeCGkpvAj2vjeIrAMkv/yjnn2YlC8+snVeM18UlFWFVmkXeN3Et32qzPwt/BXalTBAv1
         /7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734577749; x=1735182549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAWj/RXMsp39rYtlPFugVfFgIik5mQ56vTtEiy6K898=;
        b=upU42LcAfdRp/Ihcawjsumi5puNKQU76TgNbY422XF+zr0H6X7neqbBON5/nOFuLsT
         H3QAcBdjsQd4dEbmUvp7rvyIOucVbr46Bw3rhXbQf3P1EC4trZQZI9Te4sBrJPotl1Cp
         TtxGRwHimdtzysB3tU8EtH9FspUiIXuAPZjL55HaP4HxR9lgWnGATnRXxw2y2N6YY8vz
         GCOzSqX3KhaBf9P7NYm0hiSU55eVTQeeUEWEy39DTMnXTeWZHMqSew4txWwXKxJlzCrN
         A5Vl+Ox2Ilc16YzYnI1b3GbixCo52vKxvukvvbpTRALVKD99lLyAcjJo0OD2jkRS62EY
         7f9g==
X-Forwarded-Encrypted: i=1; AJvYcCV1CuvafpAbIQmUhctnxuq6S8uJt7wlMo/KWHCcif4Ppv0awvBxm8hcrLBMw7Ro0hsvgKgPA2U4t2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVhfpeUQ+vrjfnlpiJBVMyThAlbOKcDNS2WNkUtdiRTfCfRUO
	O5atJHNaDJieUqstjqXca133FHZeObp55THqWchRR7mzOajeNjBAP81tjztyOB0=
X-Gm-Gg: ASbGncsh+ehgfQLJo0xCsb/AxHHLJs2wTq7zlJqUXeakYhKHkplznA0V8YZOK9fbEg2
	iRpAFQJ5gXQsNbSrbBsEIXgTIf4XJmvmYk9zEpy0dNpHF+og0mTAaM8X7sJm9GhiAadtc32PrJv
	67IWdtedQ1FZFjH9I/6VeTsnbhG2eykFshzku0fFWD46KFYphP/SUvOQ7/wb3TiFTWcf4y5bMu5
	Ov+oUj85EHpJJTJB6vO0M7s0wDbTrGQq/P4LMy/rUWsVqgA45wd9UlgAjjoghZp/e9Un8kCEMbV
	TyDv5C8OmhWxUzI1zIJHFZ3DV61qsdHHBQB2
X-Google-Smtp-Source: AGHT+IHy+maYGCy3dtwKHO7L044QpVaiEZ8uB8NFDb7ONkLj7lNRSAMbMHNVrRm+1ULsyRJjtFsZuA==
X-Received: by 2002:a05:6512:3190:b0:540:30df:b3ea with SMTP id 2adb3069b0e04-541e6747036mr1574039e87.15.1734577749125;
        Wed, 18 Dec 2024 19:09:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238215ccsm47821e87.215.2024.12.18.19.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 19:09:08 -0800 (PST)
Date: Thu, 19 Dec 2024 05:09:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sachin Gupta <quic_sachgupt@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com, quic_nguyenb@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_mapa@quicinc.com, quic_narepall@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com, quic_sartgarg@quicinc.com
Subject: Re: [PATCH V2 1/2] mmc: sdhci-msm: Add core_major, minor to msm_host
 structure
Message-ID: <emdc6nq3z7z2zimkbut4hknhksoyzsemnna7iyrdvkfxpvbkvb@7vxdyoams4ky>
References: <20241218091057.15625-1-quic_sachgupt@quicinc.com>
 <20241218091057.15625-2-quic_sachgupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218091057.15625-2-quic_sachgupt@quicinc.com>

On Wed, Dec 18, 2024 at 02:40:56PM +0530, Sachin Gupta wrote:
> Add the core_major and core_minor variables from local
> scope to the msm_host structure. This change improves
> the organization of the code and allows these variables
> to be accessed more easily throughout the msm_host context.

It doesn't improve anything, it is necessary for the followup patch.

> 
> core_major will have information related to sdcc controller
> major version number.
> core_minor will have information related to sdcc controller
> minor version number.
> 
> Signed-off-by: Sachin Gupta <quic_sachgupt@quicinc.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e00208535bd1..2a5e588779fc 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -273,6 +273,8 @@ struct sdhci_msm_host {
>  	bool tuning_done;
>  	bool calibration_done;
>  	u8 saved_tuning_phase;
> +	u8 core_major;
> +	u16 core_minor;
>  	bool use_cdclp533;
>  	u32 curr_pwr_state;
>  	u32 curr_io_level;
> @@ -2557,6 +2559,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	core_major = (core_version & CORE_VERSION_MAJOR_MASK) >>
>  		      CORE_VERSION_MAJOR_SHIFT;
>  	core_minor = core_version & CORE_VERSION_MINOR_MASK;
> +
> +	msm_host->core_major = core_major;
> +	msm_host->core_minor = core_minor;
> +
>  	dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
>  		core_version, core_major, core_minor);
>  
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry
