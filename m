Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BCC210F58
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737539738; cv=none; b=VuzN8/VdAwKLHlTCjrWroUk4J5oPWwML233y/xheDoL0ZLu/BYW4jip30VorUCrF2KQc9ZrKz42qAZrkXNc7kCm/aBBRBJtSskdor8zdWcy1jWh58tZQi89svUJPYtFU0+balHrY3WxZYsVD7IXCjHqxLNls1uOPXfOtsF6zR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737539738; c=relaxed/simple;
	bh=A7skF+DaxCykLOeAdbWIBEemfXQfKaF/hi2Lg/ra9b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXE3bdSIQ6nkZO8D7EwGHru+LLqfdeuuTcG+ChkvO8WQd1G2/Ou3RPRhVM8IG0g+1CoYyvNb3so1Pe4xYBx4eqhHx1GK4p4TOyEIVD21DPInLbxxcYW+2qk+5x/QKJoR8qnA8uSlmcYKeUZSrcOvwUi0mV78U7FKXFBoBwBmzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mZ65s2Fn; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZ65s2Fn"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30613802a59so71873461fa.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 01:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737539734; x=1738144534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=scV0mTsOi7ZzfUvIFazmqCl77AdAA0xM0waC6G2ecgo=;
        b=mZ65s2FnOLQS37AXtF5gwU9InMa9kgOJzws6pSdQt5jc77Ah0J8jq7DmAsbdTlRrIs
         wn+L1Ve8xc1aIymUv+ZOsfsN59h1FmIYfZQMOcegvxJJCzjXFF7718RUcTryHKXK9SIV
         9mbeo1MleUOnutEO5TgK+hiMOdPY1JaftpWtOEr1q8e4r/Z0ZXr2psEgvOd/BHQR+AsT
         7iEWY7+TMaSPIMVXPAHyV4ZRKcGRYiwzxVkG65JvjksIrnSZ+1SfyUH9ynwNF21W2RI5
         mX4CAGYdSVsWTGjVOJR62csqHV91/FStO5pqLz7IYJyW8Eb9/Lqh+nWWeGCU/hWI5IvF
         FaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737539734; x=1738144534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scV0mTsOi7ZzfUvIFazmqCl77AdAA0xM0waC6G2ecgo=;
        b=MMvy3vmmbfSnuINv8wClH5mMzDIJP8w+dTdAtQboq8SMMH1fytll8L0k1ATvvigTSK
         NfW9wXNOgPA2lF2yNalZhfkpTk9C97z53/AuKpSlbAuZdpAm+ChmTqOk7folFDo5NP32
         TWDTmV52ofMNOVgfyfIZ+SUzjeEPxtasGU2E0mdY6Lz5F9ylfu6Ni18V1PQbJqeyZtAo
         LiCGx+549sf7w2H1XhO8RddrnyT5o/DUtHThkPkM+W6UbhPQ5g1j/fm60GwE/cCS7yNY
         HBAxC/GlnbwTUHtDaQz8CUikD/Ejv1SxHaL3lSLD+hg1METphvdtbhOf4nEQW8IDJ3hN
         9OrA==
X-Forwarded-Encrypted: i=1; AJvYcCVxo5QgD1zYx6MjKoE/MxmXE3BOGRbrfb10KuH96+8ZnhV9lOcy4za6G4AhX4k5xKWLesf5ysxBaEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBy+E4wRHnid1UJ4SQgmX/6GGn7JjdC7ZZ5xZuuVMSSQOIxdtj
	Qx9C4BB9IVz3XsyNyxgXp15X8WIhWnB6GEX3KlE0oyjeUwQUhc1ujZNhJasZTQo=
X-Gm-Gg: ASbGncuPv/LHSPMktPG/1ebJ62xImD5CfLc1ceGRjs4+qJzqu4SOWf96bI3tlzEV5UF
	6nmALNQWzQvnx/xTJNym1WaYnaWyuXbqt3ZoTiwBrUt465O7cpQq3Pix5aarKDchLQ+QGzFqaqJ
	3UkqwS6Mqctj5bdD+PNm86sUzeKpJm7wbZkNAxaaAVyqQTaMBfqJ3q0mEFPPQKQw0BbXp4UlnMn
	S/CP5qefuGuyULf+dpGkRMGpqvugH166Di+e01tnYskZlr17rYFUp+79P4DcXBGwu7q0W22PIpe
	c50pfhU0m6l8ylF7WdkZUqXyeQadze3D+tFTQzJFh66WQ/z6qg==
X-Google-Smtp-Source: AGHT+IEyVRLyus5hXslfncouru7d589DBCXm5XQ6Y4wWqmqqzrIjL4zImkrlqZfNjmApRZhoecA7yw==
X-Received: by 2002:a2e:bd89:0:b0:307:2bc6:5eae with SMTP id 38308e7fff4ca-3072c990274mr76013791fa.0.1737539733757;
        Wed, 22 Jan 2025 01:55:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a5013aesm25703591fa.89.2025.01.22.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 01:55:33 -0800 (PST)
Date: Wed, 22 Jan 2025 11:55:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sachin Gupta <quic_sachgupt@quicinc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com, quic_nguyenb@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_mapa@quicinc.com, quic_narepall@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com, quic_sartgarg@quicinc.com
Subject: Re: [PATCH V3 2/4] mmc: sdhci-msm: Add core_major, minor to msm_host
 structure
Message-ID: <rvu75rn2m32eyjr4ogwz5tmns2bkv3mp4gaz562gjmxztnejsl@deslghsvjhmi>
References: <20250122094707.24859-1-quic_sachgupt@quicinc.com>
 <20250122094707.24859-3-quic_sachgupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122094707.24859-3-quic_sachgupt@quicinc.com>

On Wed, Jan 22, 2025 at 03:17:05PM +0530, Sachin Gupta wrote:
> This change adds the core_major and core_minor variables to

Please see Documentation/process/submitting-patches.rst, look for "[This
patch] makes xyzzy do frotz", then update your internal documentation so
that other engineers stop making the same mistake.

> the msm_host structure, allowing these variables to be
> accessed more easily throughout the msm_host context.
> This update is necessary for an upcoming follow-up patch.
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
