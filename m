Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EF1FBBF3
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782685; cv=none; b=E0GeogXcOwdhzY/824hA5CTninEn3tF8CUriJIth/15vWJFWPYEPCKLvFBR8VuLSQBonsjFk1tfsSC29/1YRZ7oDKhVP549EARfbuD/M1wONMq3msAVl7KK+3yDvA8FucZskzU4Ob/iH1Bmx1iQi6DfDCV7mifJ7OyuR+onCZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782685; c=relaxed/simple;
	bh=n2GWWrpePzNulQeQ8lZLK2FaByIUzza7i9a/Wuwpvpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrQPnAC76AXOL0Gh+XxJ1l/FSY9kdwF7mxT4MuyGLDrTWmH0dp3nKvAKSCq6QrpRpzmz1ByJgeLd3jZboj6bT/vvEH+4U/upvQoKPQJwzdq7OB0EFEYtG4I22n5pnr96SBZ1V3U+JLHCWjbRDaMwW+nn3AoANL/3zo9FohCs2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i5Qpjj2Z; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5Qpjj2Z"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5447fae695so7601261276.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2025 07:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736782683; x=1737387483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VH4Ljw0lA5sqSWylbksASfV+tDTzuOkHLk1j+OVHBqk=;
        b=i5Qpjj2Zj6aQGZyZ04AZyJ/SGTLsYaHiv5c8TVR7J6My1EZGYm6OVjKGeAPMQrbYkL
         LKcEM57GIuMrAw+qG8SZh/UzrU51qz9aATw4MPgm86yumuhJAJyohJ1JwbSljpGgH5s/
         uCqqq4OGzXyKB9eYvOoGYbL77w9ztfQqFzUisSMepES10F/Ro2wKfZdPRAyqTL3HbmQ0
         quS7TWlLs7hiAx8kiqvOj9TjUPVfWE8lpWBP5FUWVkGbR91XM+FlMK6ZixE6+4XL/oLE
         x0/VKF2h3cPVX6YwCogja1Oiav2JDb0hcjhOn32uSlN/VDFksYT/hiSmZXiWNWIxlGvl
         9iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782683; x=1737387483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VH4Ljw0lA5sqSWylbksASfV+tDTzuOkHLk1j+OVHBqk=;
        b=N/sxb0+UxumQV2h3uQuNqBPFDMthfJlJlfcwZlRon6ZYj6Q1FnyZveCgOQtfrz+SPb
         ffhEQwbpm7BzjpOPZ7Nt7p3+Pb8AIg9EDXgEJvW2YLzkDc9j7gR/n26wnwx8BDuTq9fa
         tcng42EZyMxDx5O60U9bF09o+gSEabHCaxer5a+7br7qmBWWUX1HXGUwM/0T6ji0AcQ+
         0nbuG+pEVSOYkpgisaG9vOyCb60YjBX/g7fL14Qhr4JIfGzovVjlEfC2Ky0KrrT4z0i1
         SluSQozQeQuU+BDT3w34KINTKT9/n1I/j6uMtUdgdXqd32P/zyI+8a3zR1sG/Q2amhkB
         aiUA==
X-Forwarded-Encrypted: i=1; AJvYcCVGOMJqp8VjeD5KjtLTlhA2wJQKR4HvSJJFUCcgUUBhxiatFDZ6UdS5MQ4eqKKIZIidf6CAT+cBY4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHdNtCUcjWPJYWV6uaEwtnUD7zeL/uwGhY/pyWPy0CMyIoO4G
	sCnVNO4scojkimddhk6FlyzIesD6H2B+pRNEocDhKYOOS0f1ixc+ri0T580cDVrpOHYT2/UxkT3
	CJlfs+8VnhB2vjYhZ4NvEP7jtZU89OKMCE68ZdA==
X-Gm-Gg: ASbGncvViWWoy9mgQZSOHZC52nwbNZQS2AhvsHgGK+FBzCkSLuHv2iVPNYevequnK2N
	1XPkj2E7z2D4LL7ofjslJvgOrqashg6VBlVUk79E=
X-Google-Smtp-Source: AGHT+IFAIkS2Z8ev5ESTCzuaARgkLxMkSS7mawcnRpdDng9xAPRFBPJa8hXfaPAKe2aLptbdzrTd2lhyEVWCfYs6MeQ=
X-Received: by 2002:a05:690c:968b:b0:6ea:8d6f:b1bf with SMTP id
 00721157ae682-6f530eea554mr168333797b3.0.1736782682941; Mon, 13 Jan 2025
 07:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109155255.3438450-1-robh@kernel.org>
In-Reply-To: <20250109155255.3438450-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 13 Jan 2025 16:37:27 +0100
X-Gm-Features: AbW1kvYfxaP_KIAtRJ8ddiypXayufpQw7AFPlstt8F8TqoOMhlOX5qWAO8Gx8_g
Message-ID: <CAPDyKFrPB-Sw2Un1tx_POXc_wRD-A9B_6Syhgu7NNeK9qEomsA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: Use of_property_present() for non-boolean properties
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, s32@nxp.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 16:53, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
>  - Drop initialization of dat3_card_detect
>  - Rebase on next-20250109
> ---
>  drivers/mmc/host/mxcmmc.c          | 8 ++++----
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index e7a286c3216f..0a9affd12532 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -995,7 +995,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>         struct mxcmci_host *host;
>         struct resource *res;
>         int ret = 0, irq;
> -       bool dat3_card_detect = false;
> +       bool dat3_card_detect;
>         dma_cap_mask_t mask;
>         struct imxmmc_platform_data *pdata = pdev->dev.platform_data;
>
> @@ -1048,9 +1048,9 @@ static int mxcmci_probe(struct platform_device *pdev)
>
>         if (pdata)
>                 dat3_card_detect = pdata->dat3_card_detect;
> -       else if (mmc_card_is_removable(mmc)
> -                       && !of_property_read_bool(pdev->dev.of_node, "cd-gpios"))
> -               dat3_card_detect = true;
> +       else
> +               dat3_card_detect = mmc_card_is_removable(mmc) &&
> +                                  !of_property_present(pdev->dev.of_node, "cd-gpios");
>
>         ret = mmc_regulator_get_supply(mmc);
>         if (ret)
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index e23177ea9d91..ff78a7c6a04c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1648,7 +1648,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>          * Retrieving and requesting the actual WP GPIO will happen
>          * in the call to mmc_of_parse().
>          */
> -       if (of_property_read_bool(np, "wp-gpios"))
> +       if (of_property_present(np, "wp-gpios"))
>                 boarddata->wp_type = ESDHC_WP_GPIO;
>
>         of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
> --
> 2.45.2
>
