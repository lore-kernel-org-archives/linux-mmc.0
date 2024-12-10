Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15722FDF2
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847022; cv=none; b=POHQq4lWfULi9qvDGfafsBFC1b2EcCO3qKfI92eTZoKH9necoQfSk56YYJ0DoULlZdvRnhxVD6VZQeYexkBObjGvBLHJkDvfB6QjJ9hbBEcV06i6bm8E9QF/5bSvhzSEZC6PJ4HI0RRqPMqvf8uCKY3Dvk88Qz96b0/xFs8Khwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847022; c=relaxed/simple;
	bh=HjOaVYH/vnGPQjPgYAKkVeTpJuDjDHCKlp+wD4KWDn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGrl0gzKVRuM1fbTE64Lnp+tglZLnuptKVXSgJf8HNryElLyx1qppoYJVgJNfiut6mFWplu0Mb6JAhd1CHi/cCcIm02o4vIW1u1+ivCvVrY0q3V51Hdi+Sf4g7SyeOXnSduZjWFDlLLLKtXxIL4pIOuMM99b6PgXvFLNJbu9hac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UOuO1qkK; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOuO1qkK"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ef81222be7so52385137b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733847020; x=1734451820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eJB/SWYjnjYMSTCbAVWWA+4e1TQQ536Q18yWwCgi9cI=;
        b=UOuO1qkKKeOmF0EEHuNvQszG/n9UU/Joh37mfGiFUaKbUr//MtwCjigiA1lLKnpEbx
         ck9VJs9JxxYd8fpZdrmdgDz7eF0nkQUPCVHr7SrI3wP/XzmvjK7gqf7aXLYj+GHrjJIe
         x9ia58mTR3VSJBitkqsJr1VyqvP/DWrVSt0u2+Ep1WxksuZowTQSjP2Vg/XJ7veMA+vJ
         R/il7xU1mP+4ti2JEUNqYTXD0m/gM15T1v4cSnVb/2TPVINVtmA+anXbJuney0eCPhc1
         JT73K1WyQWPg9s3n+QdRIVUuLmi6Rtw1+cr8dTjiIhHtj7MXBpJD9Fbq2y4gslUwl3Nc
         nYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847020; x=1734451820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJB/SWYjnjYMSTCbAVWWA+4e1TQQ536Q18yWwCgi9cI=;
        b=fBVnwSb+NK49whLXI5dEadi1Bu8ZMDW7ISZvU0Au2X3D1gsISENo0F1tsjFvZQYzPu
         S7rlpTolXT29MlUT2ToYbnT0RzudPcC9mNqdbuR1/xNCBb2oJOQDzYdPNF/4h8uJ4vCg
         hVckVoT+5ATs9rfmoe24aj2eefWoFS9hNHyktdWIIIq19PZqbo5dfrWVBArjOaAJrKhP
         fHfI2OchY2mMK29N9ZmmMnd+c9lKS7MSXDZ6sWCGYemMYORwL0vzqSNOa6M1PF46xSjz
         /3fHFNnTq48JUrqfOD1pSQ8QPXeu6vGyhsF1CKpDTzmS4fEpckK+ldu6f//8fTqyzbrO
         0ENQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjHs3xkFM59xoelyTH+ujuokXWUcDgQb5rR2HJBvC3u5zeXHDapCMWvUKAO8xK2iA5WFS2G3aaIaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPBKOpXezDJU6ZS7TnxvSzZDPkqvG2bnELV2rGhuvpXYdkw4Ph
	d/GfCR+HMi3t/UynSFGmIGU7iRDQPlNu9Iey7Yu6K/PmJvsfxTknwcWyggQVvfYfdI7iOZcqas9
	SUV5Bnc6kG5MF+TFL3HDBk4MRo+/F0jYIcrzZViZqN5zbJffL
X-Gm-Gg: ASbGncs+NJok7aiMyis3BIML8EjYUWCXwLLJMB6UEl3hAnbmm/zuYVVUn/gkWSxPNEO
	U7MprYa/JBv1oimM015O7uxGbkOm0FGzdpJU8
X-Google-Smtp-Source: AGHT+IHjJsKw4ovqb5WR05M5aa66SShdoIudD0yG+DIbNpeqYPiwp2Hqe2YuUFRbAuhYx7NDEU9d/1gJqDEBRTk4w3E=
X-Received: by 2002:a05:6902:2602:b0:e38:b512:2c1e with SMTP id
 3f1490d57ef6-e3a59d042d2mr3605210276.46.1733847019643; Tue, 10 Dec 2024
 08:10:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203023442.2434018-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241203023442.2434018-1-joe@pf.is.s.u-tokyo.ac.jp>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 17:09:44 +0100
Message-ID: <CAPDyKFrvs7gCVhgmOehxik-v90Wie6DBNOAPVbXwXVQHyJi07A@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: disable wakeup in .remove() and in the
 error path of .probe()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: chaotian.jing@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 03:34, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp> wrote:
>
> Current implementation leaves pdev->dev as a wakeup source. Add a
> device_init_wakeup(&pdev->dev, false) call in the .remove() function and
> in the error path of the .probe() function.
>
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> Fixes: 527f36f5efa4 ("mmc: mediatek: add support for SDIO eint wakup IRQ")

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index efb0d2d5716b..af445d3f8e2a 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -3070,6 +3070,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         msdc_gate_clock(host);
>         platform_set_drvdata(pdev, NULL);
>  release_mem:
> +       device_init_wakeup(&pdev->dev, false);
>         if (host->dma.gpd)
>                 dma_free_coherent(&pdev->dev,
>                         2 * sizeof(struct mt_gpdma_desc),
> @@ -3103,6 +3104,7 @@ static void msdc_drv_remove(struct platform_device *pdev)
>                         host->dma.gpd, host->dma.gpd_addr);
>         dma_free_coherent(&pdev->dev, MAX_BD_NUM * sizeof(struct mt_bdma_desc),
>                           host->dma.bd, host->dma.bd_addr);
> +       device_init_wakeup(&pdev->dev, false);
>  }
>
>  static void msdc_save_reg(struct msdc_host *host)
> --
> 2.34.1
>
