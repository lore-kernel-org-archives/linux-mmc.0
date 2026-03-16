Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6063A4523
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674174; cv=pass; b=IbrDuhEpWunptdry2JWDUX6qyGnu0G6Fe/RL52u61Vz6VsvacyqHmctgqgxAFFijcGxuH8RYaYoDn9wEkyF+HzPlgihcnaWBLJoRhmRbkCugzXt9BUREGyBCz8eeIH5kT0gi3NiWwmYImPVzCjOP6FX0rfxHXK5E5MipSOmq8dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674174; c=relaxed/simple;
	bh=2FQCxSJ/4hTYflwKI5bvbcXdiLbSbgtV9c+hs2wiqNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cryH7v9hgXC69n3mX3VEWL4tDK82lWYgZQ6TgFSO8FfsHA0wfK1JGzqJL/1dxjHkRGCqNsn8+3U5vA9rVAnRmls/akDc8eLqfWpp+znfOINW5QLX4dLk1PWwHyw9DYI8T3KzWUNLOWJGmZ6RjzHFW1CmL9T8CY8511RCD1R3J6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mNhkzTbk; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNhkzTbk"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a2a59baa6so38661201fa.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674171; cv=none;
        d=google.com; s=arc-20240605;
        b=jmp9dJUzxQI0PcXfY/9KenGq1W/yNHfEt8HEGfW4x6EeEmLdb2j7ZtasUHu6Uq2u2o
         UJULOFmsL0lxUaL5HKCyUNUQO3Kgeb+zYKQcSyUQSisTpmrhqPKToEF1RzWpCAo61mcB
         DNmcgdY9LMpEZTcHN6UHVldPJJLTBoIEa7zR5lsixwabY5UZyvpaEgiNnqzP7Jd0mFlx
         LYi3gGIkuRiJGtCTCeqnTsBB6xB1HoTxv/OjriqMJ3KvTtghUXUv09hM/TJo0JBLcD4q
         k5wLCVnIAIr2jR0EPnegnWdDf5qWUIh56Az/4GNlRyfGowBDicyrjve9fiVY+Qf2Q5NU
         15yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9Gq1eBaEcIEjNH/OfJcPwaRMPgUoxIYY1WJRFUp5FfU=;
        fh=8TN5pUivKlRAD2aSObLiC00+DRImOyP0yjaBwial/q8=;
        b=Jw6gPMpsaee2oAz3iSp+gSTkp7X9rF3/0EOCuIqMEC01A1fogNqgelA8UkMl/4zpTT
         LeUCGTqVgORG8808azsSOQ4zamUKIqIBLwAFdjHCkBgo8xVFWoZ6tazXWZ0vt1+78C8b
         G4QaaEiUOS5cMb/0nMi+1e9EaWDMBi/Xvw4HhoKntZ1ZXxh2Ah6i2ESOLxR2/wPQkKGV
         nXHctO143GlXaHOokjSePSQYmtauU4/odc3Av8oBCR/NvMx2Fjcbpm/hatcA4t3N7bPJ
         V+nN0HO8ClLtKMvUBtWSrvF9pPGJ8/JhWs3y09ek83Us2X5YQCq2FB1eA5CdgLG2ljH8
         qLLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773674171; x=1774278971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Gq1eBaEcIEjNH/OfJcPwaRMPgUoxIYY1WJRFUp5FfU=;
        b=mNhkzTbkRgb+JoYVTxjXNY+c9OWqSUBaSr0Fxp7g3HRlyg2dfbrLpA4KC/1RwXdAf9
         eUCo03mGRPveUs+OGSI+FehYF6nN9obAu3j4OWf0C80Pa+2UxGhniIMTIciq92g7CtZB
         RQijoj1yxD3yLhWi7gYc7ctGvHpfhRq5oV0Q/ahFSW4ZwH905UMnxbcLDRyonucc9Pqq
         ZAqi8VzTdLlKKvk3UL/k0u68fb8SaARhXyt+nwDcueawxXMTaGaqCOd6r7Xq4IfVtJ9K
         mS3E74UiJGcuTfGX6WCR1nbxV2ntGAh6mqMNIo9dQurMemdBkZvhGc34cBLTKiq8k5/1
         GHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674171; x=1774278971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Gq1eBaEcIEjNH/OfJcPwaRMPgUoxIYY1WJRFUp5FfU=;
        b=gfWUVT3mH3j1oethGOFv35R5iOSobX5m7upY+ykHfQH5bQ1KFzmCIx0yUigu85Fvbx
         +yoLCtSAcx6uEXKrog7CFhxXkQrCRXyTWYmoyvNfk/CQDS+b/QSAXMD2lQzVGNuZF5kt
         Qo7A5GXvpyTshOZnhu4rJW83i3Ka4PS/iFJbvEZzfligYZUIWMZZR1+CGURj2mZg0gfG
         tvCkbgCCXgmnfK2AOv60B1Vcrt1Dcdr0cBzt4NS2b+rQ4NOkazlzPlLvBUMvSnMyoOZS
         ZEA0g6PTGdQaomUtlQf2thhrkMEzsIyOPCNt+nhWF90p8DGuHUU3FL0YC89SmF1OZv6V
         2bGA==
X-Forwarded-Encrypted: i=1; AJvYcCWN6sNTZwBAPqJYs4w+pWo3M41YeWmp1Ry1O7wG32XYRql4uTUw22tlvRmvoIBJ0yDK2cS/G2rnsIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGLC90CQzIb3ai2brQWF69mmHhYbRgUFMg3xLkRXSnQWlZ+z8
	NYE917KcFehZNLW9uUhHnD9UfryRsUi7+Axgo+nZ6GYhrg2pgIErRDa7mtaRvF2lFFRnSLh/1xx
	6RONvW9ogK7GAgH++D2e6IQn7fGz0VJKLCi9AgcXLpQ==
X-Gm-Gg: ATEYQzwgiyZJnFTnrqQ5+1I7Rs3lrtVetkEqMPe6GykA0uKbmqKzLU5pVbjeiX8/p0T
	u2PQVLntCNCpUwyzqyNS+BNhcvXImQ7g9TyBBIWgBUp0yYj02G736a+B0EjOFt8fr8g99LHORE8
	6JEtBxfKPdQ882rwZmCNITEjgVG7wQ2rJynsV7H5YraFK2q/9bPkXRLKSJu0lfxPBFvGBp1MokD
	CgHuAmRm7nzXHoeMkXJeiPKcGazW1nLOy1F/V4A98B3iJNvDq+DrjNk4etHZcGNRiqMD4L1udrM
	A3+0On3y
X-Received: by 2002:a05:651c:544:b0:38a:aba:9c0b with SMTP id
 38308e7fff4ca-38a897d365dmr43927571fa.27.1773674170737; Mon, 16 Mar 2026
 08:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311095009.1254556-1-ziniu.wang_1@nxp.com> <20260311095009.1254556-3-ziniu.wang_1@nxp.com>
In-Reply-To: <20260311095009.1254556-3-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 16:15:33 +0100
X-Gm-Features: AaiRm52yvrWjzyiC1WQIkEheabNUD7pScP7tLn4Y188s1jdcCNFrCPgRy13YRRo
Message-ID: <CAPDyKFoU9hE_ZRbiK8m6Hso-xGQEdTpaTvJshTdSbpD-Kqra1A@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
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
> Add sdhci_get_property() call to parse common SDHCI DT properties,
> including "bus-width = <1>" which sets SDHCI_QUIRK_FORCE_1_BIT_DATA
> quirk for 1-bit data bus width configuration.
>
> Remove the duplicate "no-1-8-v" property parsing since
> sdhci_get_property() already handles it.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 97461e20425d..b607d4ffc562 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1813,8 +1813,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>
>         of_property_read_u32(np, "fsl,strobe-dll-delay-target",
>                                 &boarddata->strobe_dll_delay_target);
> -       if (of_property_read_bool(np, "no-1-8-v"))
> -               host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>
>         if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
>                 boarddata->delay_line = 0;
> @@ -1833,6 +1831,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>         if (ret)
>                 return ret;
>
> +       sdhci_get_property(pdev);
> +
>         /* HS400/HS400ES require 8 bit bus */
>         if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
>                 host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> --
> 2.34.1
>
