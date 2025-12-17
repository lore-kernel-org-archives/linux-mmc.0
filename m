Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0A33B6F8
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979159; cv=none; b=fff3bxvWTM96wkDYiVtEHy6t7qhesJWrnp1VEHjBSJwPHLorRbP+wIqkthXriNPDEnHYa4frhTNLRtL/6ysxVHmXmHVEnhzS/fqeDjyBeZL8ew0hXDwb+S06UBIVsO4etqzMUvaOEiKyprf5o3pXwgFqyM6Xvyz85BWnlSa208A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979159; c=relaxed/simple;
	bh=RulmqSaiOURezsD4cu1+MRR95cud3v1lRvrkSGGSSZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yes2liAAdArjcTvlJpmTeaKIEQINl/kvHs9gLrRwPa9ASEwt1P2hF8QiqYlK/Sy5LZm3sVJ/9LhwMPQjJm2ee0CgEANz31s3BqlA8srGhZQZej2L7/FCX+WCQRWzA32xtdNr96Qjn5gM2FotqZ7WapL8RIKoppync6oYgethaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uiyTxbhi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiyTxbhi"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59445ee9738so4650652e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 05:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765979156; x=1766583956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HeFvcwPuMBzJwPtY2IZ75UX9BR5Ij/OppFp2JBnCGZk=;
        b=uiyTxbhiQyHzir4bKqxNeNYkACmL+PZwUPT16pK3yrfxtY0Mug+oXPSbw8WGQT2ccP
         msL+8aSjDHG1Oi5Tp9DC1CimmwRnmVNoZGwCIQmTh1BXLpUnBCX0lyVffcwuJPxVRVzY
         7f3RYhYn0pd8gWwr/iOfqo8pHd02iiAoRj+pwzQC28Hvh+CqWmlPiNDnRdelZOe2qYI4
         cyV98j9ErJWu7Y/IblFawyCzldxbN8D1tbfzk57L++eR5pDLcllQU9jyY0ZmNv227UZ1
         E7tW4Le4KCB8zEGaE5EFcs1QD8npN84sMiW1Hy2d/ZRT+yYylHypACBpIMudMzKJpVna
         PO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979156; x=1766583956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeFvcwPuMBzJwPtY2IZ75UX9BR5Ij/OppFp2JBnCGZk=;
        b=rBxW5c9zQ7zWOHYB/isZR+9wlhbrA1cYT0XkPdfnF+0EwbeZsdLMjJ9qr9u9NeN7Az
         c3KDdZ8flm2Kgyp30K8A6sbmWPeui5ShF+kAvw+KGk3gw5suU0EJ9DFfimww2KqK7Sty
         f4S69yUs1Dd6Se5upMPgv85KOfeAGkWF9/3FSgePlaP94bWwGsv+yMdmeuudUAsfj+t6
         8j6HUZc9kvETEPW2O+hKxhnW3/ZqWwsnHpKHEu7u3pG0tRI7V0+3BAljpU28iGMUCBkj
         yGyiRx0C9xGshCw6MOq4H1nN174ukpb6/nWsYI+QxuvszPkhZm4A0d+iuXjFg5Ycjidi
         jK+A==
X-Forwarded-Encrypted: i=1; AJvYcCXes+vx0PfMkFxj1Tsw4kQcXNoXR7JPd2+X7hF9N5vL0WTdELbqiEsgbfuWU8/32iEbGtUDEtvEjYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRVXeE44IGHoqbTOEYLl00UKIGIOcAgj2DM8SfCA03Yf8DsWH
	ioBxb6iu4qWRZ3La38oPpLvtjW0iyLkfy7OMIln7oMlGaiPGhjiX2BjRlz3QpwYkZ3CvAhudQG7
	UefNrvuL95LxzqThtSJJsdLNAvUOKvp0LqdYeC2a0Kg==
X-Gm-Gg: AY/fxX6R3VyjlDSYy9Zr81PIIbX6t5W0ukLELfth2XgUARUOPVf67ugs2uJkHO3uQCf
	W4zI1Ahp3S+WPC1I+tHqtaogUICRVJC0KhuFK9ya5xM5KBFz0jfmrBZBbWLxeWxg5/5cl2LmDjJ
	fXwZFbZGBrA9AkrufGTlmWaX0VYk6Hir0vmZJt69VuBrQdqWXn0GarCKF5fGq4jx3K3I6on3PmZ
	oEr6CGkdKIMCaoSuuUTdd178VLq/TVWjphv3nMPQEmWwg716Sp6ZbzkQobvAG5NSg5Nexs=
X-Google-Smtp-Source: AGHT+IF8DUR3iFEJEHIZVoppRZ2LJ1i16lHQ3Olhnesdn9YtIYVJQ/fNEdH4vIoS5b8Lw4dMFXsWFN+VTySF0wVdcVI=
X-Received: by 2002:a05:6512:3b86:b0:597:d7dc:b7ce with SMTP id
 2adb3069b0e04-598faa3bd8amr6408543e87.30.1765979156040; Wed, 17 Dec 2025
 05:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212-s32g-sdhci-kconfig-v1-1-8e278c8d7f78@redhat.com>
In-Reply-To: <20251212-s32g-sdhci-kconfig-v1-1-8e278c8d7f78@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Dec 2025 14:45:17 +0100
X-Gm-Features: AQt7F2p99M9efU4Kabtz6odZdNhny0sq2J-1crHyiipLb65xYIkOxCPnes_s36Q
Message-ID: <CAPDyKFp++OQFxkY_zqkZSJz2R0sqxBnd-6U+VLsyZYDQ4H9MeA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: add alternate ARCH_S32 dependency
 to Kconfig
To: Jared Kangas <jkangas@redhat.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Chester Lin <chester62515@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, s32@nxp.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Dec 2025 at 16:04, Jared Kangas <jkangas@redhat.com> wrote:
>
> MMC_SDHCI_ESDHC_IMX requires ARCH_MXC despite also being used on
> ARCH_S32, which results in unmet dependencies when compiling strictly
> for ARCH_S32. Resolve this by adding ARCH_S32 as an alternative to
> ARCH_MXC in the driver's dependencies.
>
> Fixes: 5c4f00627c9a ("mmc: sdhci-esdhc-imx: add NXP S32G2 support")
> Signed-off-by: Jared Kangas <jkangas@redhat.com>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 10d0ef58ef493102d3586d7a31d755543297999a..c94ae4794545de1c818ad50be7f91331862b6acf 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -315,14 +315,14 @@ config MMC_SDHCI_ESDHC_MCF
>
>  config MMC_SDHCI_ESDHC_IMX
>         tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
> -       depends on ARCH_MXC || COMPILE_TEST
> +       depends on ARCH_MXC || ARCH_S32 || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         depends on OF
>         select MMC_SDHCI_IO_ACCESSORS
>         select MMC_CQHCI
>         help
>           This selects the Freescale eSDHC/uSDHC controller support
> -         found on i.MX25, i.MX35 i.MX5x and i.MX6x.
> +         found on i.MX25, i.MX35, i.MX5x, i.MX6x, and S32G.
>
>           If you have a controller with this interface, say Y or M here.
>
>
> ---
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> change-id: 20251211-s32g-sdhci-kconfig-585b6909f7b4
>
> Best regards,
> --
> Jared Kangas <jkangas@redhat.com>
>
