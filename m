Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A91ADC98
	for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852733; cv=none; b=num17A4YhXbgsVszwX+171txjuF1SndwBWqii4unYb/4tp78R8GA+Ir50RvWsj9hW3T1s6ZIZwkwd4wH+8X/OAbentuO3WWlFleP1XfjUJEbeIK4TPgC2MD8PMesVwyz8t0xHiUp3BbYJ7T9wGCnbJrTa+yxzwdEY49rc6UV3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852733; c=relaxed/simple;
	bh=Ao1M8fWgwhlNjBBrHYsQEEjB0sMi+JiBBgJJ0a1ol/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNAxAInn6eVrU6V24HfIpH1mJJf7kiRNH97hdHs1+9Biy+cU4kT6yoHmMLZX4DH84ba8qLopLjxai0GURT28LH5gakzNKzpp7D1xl5n99lciq9n2MNgriT8oySvq0YJ7oknl2mUf1Oah+gwyqk/HHE0OC3Z6cGyuHPqRSqJYjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=anTP6uWe; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anTP6uWe"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30227c56b11so48322441fa.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2025 03:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736852730; x=1737457530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejrLFnBwCatlY6r8hGkdoeYmYx+mLsb3T3ChK8QOogk=;
        b=anTP6uWepYXqib/lGwUTyu7rzN5So+gc8qNrdw6x4OSnsZgjnnMr0eUD0xiUG0Y09o
         Z+1P7QkOJAkFmmJmro7MRMUfGprjuc6CNOd0ExAv4JbcpTJyFUXKkq+7PJr8RBlphwJl
         ZKgOI/JW4Rv2+edEWDvk0/xkLkP+8ImlhHrWlnttWnYMcEr4Nf/qN6qg3eTa14K39Yy6
         t8E76XuvB0qwIiO8JQuOni6XzBEQ3HNHdE8IUa5j1viIvoA7i1y5v+/F/J6Lgzz6jn0d
         0if1ZJ4AiMkYTwgrIXa9qEhfBwCNKg1wQ4rNBafBN5I74Pu7Sn1Oew6nHVDSdw12DI3M
         E2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736852730; x=1737457530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejrLFnBwCatlY6r8hGkdoeYmYx+mLsb3T3ChK8QOogk=;
        b=g5tpEaXKwAkIDYU8nd+FLCWSVsWZ+y6zBpNS6wTvU7AR4K0HisnwIiSdoDil4YD0TW
         kdDPyJJ4TijiJcJQoikIlIAUriIZjiRwY4xLwPcgZZn8SpqzIqKFjL5JvZ2ongAK3dqe
         8o0Z4PjXFoXLqs8xOrv8JqqYUZaTC/9JDKiQSH2JTh0d8IZFvHTsV7L8OkbqKvK9oYnu
         vy/QLr7KFlWCz4clKou9RAponKqtz+HZBTV/buKtHeOO9rqVou3UlSfTitfcEF7ZMyeX
         LEUg1od8lwHaBiAxk566XqGJdDZNkDvSBTLj0zLmg4CJm+xD2JxjwT+umn66hppRDhTd
         TE/A==
X-Forwarded-Encrypted: i=1; AJvYcCWQcaIdTIYH+S5ScKhgvFtLoLEnyF3jExZZN8jM5XeKICipvWO6v5Jpe8D9j7uDOtQcDHZoFpZFLN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMMN/1ztS1IR+VT5dW5VO52AA6CaJmwKgFFzd1DcFEl6b3IFq
	bqI1BX1jbirz5zom8w3s3ki+3kX64CR1ousXlCwAaa5P96IHXhOocMbDZxq0ixk=
X-Gm-Gg: ASbGncsmKhi06QK3hcazsliGo9sNtgs1TDzoqHa5pBkUT0iC03YuIDRXKZAs/+NENSv
	ikzIMbhldt585SnFOqco/2Is0+LvpmOd4du1DVezKSTCK7k1JMkGJ6TQJUC63Bh0HMUzNgADU+9
	OlUbV+ga8j41k3zPlKncUYmuTrtmBh5NYdoAzBsaFCJWkinXOwxgPULKQ2IwJOVyiUCxeA6vRO0
	OgG7Er3C4jof/XM+4pCgkS/Zy5cpk50WfdDEwXxBE60St6umx0sW5HTBT29d/VTYEvSQOgbN8WK
	eLGjn7URQO9t+tVHsO5Qn1csLm/roIvFo5YD
X-Google-Smtp-Source: AGHT+IEBe/Fgxcaah4pz+mNPnU+GSP2+L82Jxcx6E5Sxu9sCuejCpiB8E9z0KxLtbFZbYLC+c8JKsw==
X-Received: by 2002:a2e:a585:0:b0:306:1524:20e with SMTP id 38308e7fff4ca-30615240283mr53003151fa.18.1736852730178;
        Tue, 14 Jan 2025 03:05:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-305ff0fa064sm17352351fa.66.2025.01.14.03.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:05:28 -0800 (PST)
Date: Tue, 14 Jan 2025 13:05:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andersson@kernel.org, quic_tingweiz@quicinc.com, quic_zhgao@quicinc.com
Subject: Re: [PATCH v4] mmc: sdhci-msm: Correctly set the load for the
 regulator
Message-ID: <3nwrp4myl5djj6eiz4h5lom4tdvx3aifbjq2ojt2uju2ctiwvu@jmihj5z56qwp>
References: <20250114083514.258379-1-quic_yuanjiey@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114083514.258379-1-quic_yuanjiey@quicinc.com>

On Tue, Jan 14, 2025 at 04:35:14PM +0800, Yuanjie Yang wrote:
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
> Changes in v4:
> - Optimize msm_config_vmmc_regulator and msm_config_vqmmc_regulator code logic
> - Delete redundant return in msm_config_vmmc_regulator and msm_config_vqmmc_regulator
> - Rebase on tag: next-20250114
> - Link to v3: https://lore.kernel.org/linux-arm-msm/20241226031845.2574669-1-quic_yuanjiey@quicinc.com/
> 
> Changes in v3:
> - Optimize the code logic and separate code for regulator vmmc and vqmmc
> - Rebase on tag: next-20241217
> - Link to v2: https://lore.kernel.org/all/20241127095029.3918290-1-quic_yuanjiey@quicinc.com/
> 
> Changes in v2:
> - Add enum msm_reg_type to optimize the code
> - Delete redundant emmc type judgment
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20241122075048.2006894-1-quic_yuanjiey@quicinc.com/
> 
> ---
>  drivers/mmc/host/sdhci-msm.c | 53 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
