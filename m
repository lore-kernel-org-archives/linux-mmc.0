Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D301DA601
	for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2024 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232001; cv=none; b=o4jkJWLgpkCX8cJv81jiqqZqO6GtO7PE4KEtNILVAFjQY4fIdnCJGuycgDKbFXbvS9wjpWJ1Uss4Mmz5p/zGfroiEtuFgxZNnBGt4qaIzOaI1IyVNOWbUD9kNuw4X18LmtjsrHE3gEuaMKMMLv4idbVyMhvYkLNk0bozITN5Crg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232001; c=relaxed/simple;
	bh=C6SsqUkpTyfLzyYxGxgCFwe8trUiuCmZPYRrNQEXuRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USaOfXcC5lioaN6+8pyInpd/ZWyTYjKNhAk2mlxvy3sx7L+INjN5ggQ7tTkbmSA22Aqyrn2AhMqfFWuirKDTnGU4JEnwyTbMT1nBkg9fjIIAOpuyk75pgqk7yr5YuRcVhJ2RhL6tAptqvIAtQfKPLHjNKwckb3lEZduRsptDFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oC/7ZtWo; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oC/7ZtWo"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5365d3f9d34so1082045e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2024 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726231998; x=1726836798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulKGIPWaoiiyEGEWVD2HKaFFVOQIntGXX/Asbla3YVM=;
        b=oC/7ZtWo0dg9LdpFzgnrUMyy2wTeGf/imTYJmkCJyyYnFDdWVRXkfAjXOgBB9X3Al3
         fE1XnTZln+7ja2oDbt72GcBafquB8EJVer8vUngqeygoqXfdwFT75SYZd2IkZPWS4o9o
         8bPHpcMo5DV6ZhkVa8UXtcfmqSEKNCN1arJ5ntefLV3Pwq/ONbmQv1x/SRMEJQd7OhhL
         JJutA367edrexZHextWRTpHqxDaiSEYYUlrlmdj6fXVl5vajIikN/zQiObtdLtxJ7BVa
         z/ZfvGkvmgbMiZmnu/V8sptOKV4Nbc/apGG8jatbBOMda4eacLGDKexFgY8yfgeQnNpe
         LBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231998; x=1726836798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulKGIPWaoiiyEGEWVD2HKaFFVOQIntGXX/Asbla3YVM=;
        b=aKV5wi6/l+/2EXbcWLouJ6cm9WIwa1VsBKwY3vbWB3kR0wulibdc6kKKSyVALIeSuS
         Emsgt+u5totZcSxhEcDY4PFgtCE4iIEIosrNeuVpPjhCEYMCaTvsREWNMQUGsv015CpB
         p71q2FKCBU6LV6leAKIUguV160zLtHuxAkKt1ktDwEvNNFQE6fYT3GJVrdmAHXlE2cgE
         bTt8XCZvLRIkjlnbk5ChWYHsJ2lb4CYHdjyMJdXjTorTfPagkGJf0rWhhfTQJymla3IH
         xsRGDsjInl3FyPxbOaSF488g8ZKLKgf5xuU0g5f2/82ptFsle6bhCq1lgfrZsuYN6rTh
         kcrw==
X-Forwarded-Encrypted: i=1; AJvYcCUVSOehjnEhvNmX1L753awJ8t+0YH15QehjL6c/yOSuxcNlKJ0SnzSL4gdAzmJesnQfI0IHKHcohhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1FCdAKR6o/TW98ZczPUScu7EAncH5LXUhWjdyt2cEhGqw0bH
	dTJuiCskEBWdFZ8KiFdeuAqr0SUBVfhAjZI5afUh8eM1HqEtPcRbluFPrDkz9DOTV0ZAuQWSgBr
	d
X-Google-Smtp-Source: AGHT+IGMrI1iP0NSdtqsSAApfYvR65iW6wVAWhHwP/sGM4okfHDWoDQvz4JwneKed7XnN5mSPcy7Yg==
X-Received: by 2002:a05:6512:4020:b0:536:533c:c460 with SMTP id 2adb3069b0e04-5367ff295a6mr1358763e87.50.1726231998229;
        Fri, 13 Sep 2024 05:53:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f90d482sm2280238e87.262.2024.09.13.05.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:53:17 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:53:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	ulf.hansson@linaro.org, linus.walleij@linaro.org, catalin.marinas@arm.com, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, quic_varada@quicinc.com
Subject: Re: [PATCH 8/8] arm64: defconfig: Enable IPQ5424 SoC base configs
Message-ID: <4dxqbm4uuuuht5db7kt6faz2pdeodn224hd34np322divs22ba@dzmjveze3b4f>
References: <20240913121250.2995351-1-quic_srichara@quicinc.com>
 <20240913121250.2995351-9-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913121250.2995351-9-quic_srichara@quicinc.com>

On Fri, Sep 13, 2024 at 05:42:50PM GMT, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> Enable the clock and pinctrl configs for Qualcomm IPQ5332 SoC

Please name the device rather than the platform. The defconfig affects
all users, so it should be justified.

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Usual comment.

> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 81ca46e3ab4b..f1043a40846a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -595,6 +595,7 @@ CONFIG_PINCTRL_IMX93=y
>  CONFIG_PINCTRL_MSM=y
>  CONFIG_PINCTRL_IPQ5018=y
>  CONFIG_PINCTRL_IPQ5332=y
> +CONFIG_PINCTRL_IPQ5424=y
>  CONFIG_PINCTRL_IPQ8074=y
>  CONFIG_PINCTRL_IPQ6018=y
>  CONFIG_PINCTRL_IPQ9574=y
> @@ -1304,6 +1305,7 @@ CONFIG_IPQ_APSS_6018=y
>  CONFIG_IPQ_APSS_5018=y
>  CONFIG_IPQ_GCC_5018=y
>  CONFIG_IPQ_GCC_5332=y
> +CONFIG_IPQ_GCC_5424=y
>  CONFIG_IPQ_GCC_6018=y
>  CONFIG_IPQ_GCC_8074=y
>  CONFIG_IPQ_GCC_9574=y
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
