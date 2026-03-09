Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B8E3D75B8
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068831; cv=pass; b=bHZtVPk6UA3yIIiqRkBLGjzLMB7XoxoMg+NPKO6JobyFVYmEkLry5i/NMUn2YS7Zw/v7OeNnAjXrFVAi+yi+sFsbrruVQ4oddTTa3yLhsYiuMeSVxNViQnxidZMAj35IInM21bbynQfvhrOCV86Ll3mNnNJqdXtHsH7dL9OSjes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068831; c=relaxed/simple;
	bh=esAbUIkFlHla0v0stivh1D9fNdDowuTHXrGsgEy9vs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZlDAOQ9w+GuSaXUVOWGGLZA4Rk78YFjBDqENKskLJsb6ZMm4IPxr3NGq0Ly/Q0vjHiyZRkpYuyqkmyMoosv5J1DlZ3Ermsb2mMDsYgB2AfvfiNXz0s7c854w1D2qBBjvFp8u1mkVyIFpWlFVgtbNhWHMbGlk6XH4D4Etp5SHOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SXZj1J7d; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXZj1J7d"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a1443780c4so2019198e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 08:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068828; cv=none;
        d=google.com; s=arc-20240605;
        b=QEDnPGjJatz+tLNpAXkTvXekBiPe5vFv/VvT+mKK2C3vGZGWT30m2kE5kzuukiGfxz
         DC+qG1wYgRj/JWWeCwRClS/P9tawKCOqgYMMZ43dVa9POr0IliP0FYId3Qr/A8fC2Tae
         Jp5/yok03A8zNHNAM9/j4GCUQ8GFq7mO84ScKcuxouzOyBV8FhmkHUwnua7IeL/xjKaK
         7TkoiuhFsOIK02dQkSQpQ8hAl9xSYusuEiQ/RskTnaF1uK78OV4UmYgjcB8ibintTJLg
         v66R7ICQmVNkXdHg0i3gIqa2NErhGp40gRHRr36qAvws2BHE0zTrBveTejCAZA1IhTMU
         JgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pFl2mL9rWXv78CsIkv+Buf2pk8K49GTmcLThRUwuW3c=;
        fh=jRn96mpLS2bSc3Y5a0kR0NwGimz0czXdcfnHts/+tyU=;
        b=Om3N7pOyTwvLVmRLubEKU7P+rbeqJDsewjaEtZcIsOHgrmI2DrkXdFF3qkTEqvDTzC
         NTwkEF7RmFRcSqTKtKLOE0kmKNOsBCyFpHmtmsDzSAYARyMG6WjedGSDeBB62Au62aMM
         YtEIzRgltmH7F+KsykHEcBQI/Enld6JG9TOHyXo3kh5/pJiASiCBe8f/I+A4VsEJs+yN
         P5ZupeauMgxR4UDC6Uryk/1eOcHCAA3Ve4kbGrInbLKW7XWSZL6iiLZGzgywvoeAxby+
         aCVaYqOqI5SnmLAcOPuwSJYrbnBOFgQr3BxWofmYQfDMH5d2375ch1l4QbcrVb2batdO
         J1VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773068828; x=1773673628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pFl2mL9rWXv78CsIkv+Buf2pk8K49GTmcLThRUwuW3c=;
        b=SXZj1J7dVMBOmAo2tCAp4rI2IeJKgDp+QRPPCa7pmAQuodJ7H/QJpoZrj9zDCNy//z
         PZ1DOCib3bQVmJG2+vc319IokvxeQEmiQFiaB3u8v7+5LhEAwpbWEeypJfbG8Pp1mYtI
         q3wm8xehKYdYYp1I9pukygoaRHlHR8tQC4+8ACf2cmY/LVJpYaM0Z5W9pFZlXx0CnO69
         HNvQJhYOuAP/MFLGjMEAH3g8o6PDx96V1yM28ZKNZU8BpJA3IDRUAsJYr2Yv+nNxyehO
         4gyTTfNeHypJBDM6SwvdMk4Vla8UHtmgdax2sDv3u1S3jegXDXHU6LT0896CcNn6Q1MY
         JkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068828; x=1773673628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFl2mL9rWXv78CsIkv+Buf2pk8K49GTmcLThRUwuW3c=;
        b=HeVIm9oiAOG4khcoMUsYMe9GRrTmZZqnId8P6o4IGf9z7KbjVMTue82uVKE1kr6WwH
         FzgScBWMFpbBPPie0mepCVIqKrSxY5vogGxmINIroj5W2zkmP3y+jyWsABzagstVDfe/
         6MkGiDgGhHCEHj3FxLvEfPex/B9KTIB3n0USK/ySKDWZYlqoBBwSbddd4hNDlNhUqxfN
         jVHOb+BKUM8xyKQk6eQdi4LhE1O52oKKMOED8SxjJE0/fM6536kZGjEZGvHfDIh1BZa+
         qLzZKUVT2wKmbns9hXUxt9U04rxI+FFxLDoIF9+BVzGhARpw3vL9nNw3h+t1jARJ11rw
         ZudQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdz+t7vH2BW9CVf31oJAcReAkCWfzVWsP8BdD72CFjRC0VwsHFxQ8kV5ETeu19mc9PjhOp/Bqsb28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvPcjYPjFMJDNmgKETyKHq8XidJ+znZKR5Pagbqci0Hq5767jy
	2QoCUOC4tXRtfNmxyylULhc+nqr+IjbMY0TfX6ovhBxvi4s0yyaBif3yvm6jA/8dje03cucqT74
	zcRsoi84ULSAY66mBquxrBb0Juob/Kxd/q/cjzdebMw==
X-Gm-Gg: ATEYQzwZIwNuvxeA0qLUc0R/OjUMu64HUhvk62LNqZfZsAYlwqM6BdUK4WE9raLxyrO
	v5LbcLhBIeFRg2zwR5QIwOC54CTuoX/9Qgpxx+OdDtpMsN1Hpw0folZpHrm73K6+3px45r4It5m
	CNGT4QyZYWMr0u8KaJ9U2gJPoDkfpTvLazU3zscd05PoxUjTyim1j94JmMLO0CSa3m+SMBFC0cQ
	OmlATYr9FGr4SqsQlYLIlJOONLr707iZt+6CV8qduMxdDKKfZSUzMnqck7qxligEos1cX0AxNgk
	udgzqqjl
X-Received: by 2002:a05:6512:3d9e:b0:5a1:18a7:e149 with SMTP id
 2adb3069b0e04-5a13c952547mr4753098e87.24.1773068827673; Mon, 09 Mar 2026
 08:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a72e532c7364cd64b5cb4fc63c94b2af6b22ad8b.1772701528.git.geert+renesas@glider.be>
In-Reply-To: <a72e532c7364cd64b5cb4fc63c94b2af6b22ad8b.1772701528.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 16:06:31 +0100
X-Gm-Features: AaiRm52T8KFr-HTXEr-PkPGvgwN3Xf2zDZhhHyOAQZlnEOOFWEyg9Brrq9M5di8
Message-ID: <CAPDyKFoU4nCCikE2NA=Tghm9hOPwcPykKcVkB_jsEq+81t+bKQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi_sys_dmac: Convert to DEFINE_RUNTIME_DEV_PM_OPS()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 10:08, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> Convert the Renesas SDHI SD/SDIO controller driver using SYS-DMAC from
> an open-coded dev_pm_ops structure to DEFINE_RUNTIME_DEV_PM_OPS() and
> pm_ptr().  This simplifies the code, and reduces kernel size in case
> CONFIG_PM is disabled.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index 543ad1d0ed1cff95..9215600f03a2340e 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -456,19 +456,15 @@ static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
>                                   of_device_get_match_data(&pdev->dev), NULL);
>  }
>
> -static const struct dev_pm_ops renesas_sdhi_sys_dmac_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> -       SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
> -                          tmio_mmc_host_runtime_resume,
> -                          NULL)
> -};
> +static DEFINE_RUNTIME_DEV_PM_OPS(renesas_sdhi_sys_dmac_dev_pm_ops,
> +                                tmio_mmc_host_runtime_suspend,
> +                                tmio_mmc_host_runtime_resume, NULL);
>
>  static struct platform_driver renesas_sys_dmac_sdhi_driver = {
>         .driver         = {
>                 .name   = "sh_mobile_sdhi",
>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> -               .pm     = &renesas_sdhi_sys_dmac_dev_pm_ops,
> +               .pm     = pm_ptr(&renesas_sdhi_sys_dmac_dev_pm_ops),
>                 .of_match_table = renesas_sdhi_sys_dmac_of_match,
>         },
>         .probe          = renesas_sdhi_sys_dmac_probe,
> --
> 2.43.0
>
