Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0743A5E81
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674180; cv=pass; b=ZR8GIze0e46p2YPLfDdYYkW06tFS/OV1al8BK4wVSRq1aXS12Ads/QZmbpAses++ROlqVdSNH9fV8BIk0VgwEv9pOVQzprgVN6yIqgiwJwQTpOctioBkVCgg0Xnud1lfOT1qtoO/Bw+4IybKSh45j5G3R3t3TjZWfR8/+UASSgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674180; c=relaxed/simple;
	bh=W3xI0co27+/OMb311suaehYAB5dKPN2jLUw6zN284vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa+XNQyZnnnFf5tiqYQ8/ahhEII7iDUCCgxPT7GhqX3KYWkGAavwMMH1ghrpliikpcmV6/dLOl8DaG1zTvZ3Z3FJrXYHUnmrMBL3yrTjrlI1NE64r6zU7qYMwDdJ3NtOZ/N+coJT7jU+X3y5D863sJvILhscddvR95nVLtDFJnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oCuwRC+Z; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCuwRC+Z"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a12fbbd9d2so7271967e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674177; cv=none;
        d=google.com; s=arc-20240605;
        b=WhLlzTgdApcXvl/VMrrfNaP1WXAQmX50//Jgn3syMxw6moaKjZOUyulmx73VKEceAC
         H67vGr5m9sZ6g+P8Lb2p5B5oVRNFpwzYRBqLy+Suy+R+A+Ym1Hc0uYjOBJ7bb3NB5S2f
         giH5whnYwphmmp++C9UaG6gY8IKxqAiWytrRRrHiKyi0ErHeRAuCAjvI7NoxwSSZaCSH
         /LPApvbeKHlw3apQASO4WToq3vTPUUA8sC2iwKTKtkkN4e4tXruu9zspKn8R7glvVbcO
         Y/Hvk9IrVYikUokDP+4hrMSZBY2z1LNVzxFhvEjUgtzaY3Jc8V4ZQLAbqUzE+6/vivQd
         cvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RfmS9UsPgTPMXyC6QLAQIz9yZtJBVekf+/MAtbCUFs4=;
        fh=vGV1Qlo2KvDyq1yWYwhHFq7jKT1rJ3LfnXRh9Jh9JAE=;
        b=asNJrLpzFWITlhXMD7BCE8s/Ottj3Kq5W51eF8QjummInSpX5LS94f8J08XpGU1ijn
         M2bpieHgO5ao62eug37FrcggKOBxcgCmvPNaUxsqhm9pMSOOdfx1CG7af9T9FBxZYLZI
         tOYIFTUECwmT9qMB9FoTlq8VV4wSsesvv96k6ybPC5Q2Kb7jdcjIw9dh4Jo6ZuWy5YmC
         f28DgZw2siuZw6KPvaJQXt5DzqvOZSF9o4MKoaQlKjyrCS0UVxKJXTg/rBh06dbk9tzP
         mG/FzBtY2eTUA/G5G8LvjXq2cFAJ2qF9vjoJxCPdeg9TFhpYIGCsxtABiapydrkS41Ve
         2qkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773674177; x=1774278977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RfmS9UsPgTPMXyC6QLAQIz9yZtJBVekf+/MAtbCUFs4=;
        b=oCuwRC+ZegrncysgYArPoDwP0Dr5dwtDjCNzKmXuWcS8eWb3rLB7dzD5oPGs1+ZQ1a
         PV0x+WR9z8tv2SAVX7spxO2+i3magTuntsoVroq0RxP6uZSvT7MaIiYukHG+vdHjgapE
         aK7B9zcv+uGG2v46dp68ZEWUrVQWUCQKNdl+DGMg9xIwo6Vt4RCTIekVFeZkRxO5svqd
         0p2gyad2PHWBfAB09WTyMseyvhwVvAPcRe41vEYmZo0npm6NT9eFSaVoZGjmgBbsCkBo
         q/zi6j4EysY9Yg2Vc8BM1U7m+eDEVVESw690EhJVzvjS9sWLvxPKDNQjJy5uGpMZcqMl
         /oAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674177; x=1774278977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfmS9UsPgTPMXyC6QLAQIz9yZtJBVekf+/MAtbCUFs4=;
        b=GlylgnKg8B5TK5+OoM6rYuNByCTOLLc672wbUqmiMRBDS/ZgoLfe86J+jBTRJ0kpso
         94ou2DxNJYxAFfTvykODutVgRhOB0k+BgHR6gJzNs4EQrvn123E6k+nA0DrrkEwz3QH7
         VoyXaC5mCn7I/CGPNG5BK5QgQjTVkI1TooqY0fNRkbezZfHWJp09epQ+dz0ZzEChHL8O
         PFuk+qaJpamJ5Zv3hWCXeAjyQkDF3iIJjj5SsCD9RNFXUeHI64LwtdrT5wAwzJt6mdwO
         POfi8Ww2ixM28n4HN77xBh/FWfdWcMbZ10m6w+Dx10Sd1ijuZi8o+g0C0seqOpkWiGwH
         Ye+A==
X-Forwarded-Encrypted: i=1; AJvYcCUvW99H2HmF9dJqdqUOIQWHhn4/QeEKAOiwk8hWfMr35XbH0p7s5PyCY3ApZp9Sb60FeMjijznzXYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUQVT1BAA2WAFj975Za0VJ1Fik3p88iy7jNV8M6wM5suLihqP
	bWJBrG8zYEsAPs7oz3FI3v1bL+eXyz/nl9vb0C5daixVvRRh3s/o1aEWRXjjaN9eB1wvaCs5Txb
	KZiLivSkyskQGOHdQO/0Lm1S9u1pcj3SZU1T+GrYlFA==
X-Gm-Gg: ATEYQzzxgcGZb1l0cLUyNguNAArQ39xCH8AtCBTwJTp+AEw/ESmwDJa0q8SOpRtuO8I
	J16zrADYBajjBKwsciAAcdigeShnzKN/73Nf7XMtjyw1vKhQFyuRvM0AKwgDTCT4arHRueuruzu
	gk28X++YejQYNSviaRmcUzA88ZM9lWR899xfLWOSac5GwMT0KfmSuH91NnRLtgMpobWY2EA3h8k
	3ibc+jvyASmrjq2pZ4kydKsB6MsvtFJUkCJZ1HZdUCY6y9GscrBLDI3tfBKYgpQCkkLG0F7nyzj
	1TWWHLSf
X-Received: by 2002:a05:6512:124b:b0:5a1:1e44:8682 with SMTP id
 2adb3069b0e04-5a162b0d510mr4888825e87.34.1773674177264; Mon, 16 Mar 2026
 08:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311095009.1254556-1-ziniu.wang_1@nxp.com> <20260311095009.1254556-5-ziniu.wang_1@nxp.com>
In-Reply-To: <20260311095009.1254556-5-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 16:15:40 +0100
X-Gm-Features: AaiRm51cPffNhAKRkrzoz3tQeIb3HHrML_LJWGZPPVi46bwXGd0VkLN3oL3c85A
Message-ID: <CAPDyKFpFoZZv7b9jGPpWAQxYiCdxVc4e6fYYj5=16UPFi7WzSA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mmc: sdhci-pltfm: remove duplicate DTS property parsing
To: ziniu.wang_1@nxp.com
Cc: adrian.hunter@intel.com, haibo.chen@nxp.com, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-mmc@vger.kernel.org, s32@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 10:48, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> The "keep-power-in-suspend", "wakeup-source" and "enable-sdio-wakeup"
> properties are already parsed in mmc_of_parse(). All sdhci drivers that
> call sdhci_get_property() also call mmc_of_parse(). The only exception
> is sdhci-of-hlwd, which does not call mmc_of_parse(), but its devicetree
> does not use these properties anyway.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pltfm.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index d4fb60c1ef69..933fafe0a0ef 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -95,13 +95,6 @@ void sdhci_get_property(struct platform_device *pdev)
>         sdhci_get_compatibility(pdev);
>
>         device_property_read_u32(dev, "clock-frequency", &pltfm_host->clock);
> -
> -       if (device_property_present(dev, "keep-power-in-suspend"))
> -               host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
> -
> -       if (device_property_read_bool(dev, "wakeup-source") ||
> -           device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
> -               host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>  }
>  EXPORT_SYMBOL_GPL(sdhci_get_property);
>
> --
> 2.34.1
>
