Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51995A4FE
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640913; cv=none; b=j5sRiZ4VKb22pcdm1hbnaDchBMd0KjqbtagsweaGwe9JtftVWNT5eFeJAXzr2rhrkJf35+9QviZroLd4R0UP935uwx9nLGtQrfBR4lShkt4dwWewbhR2zyrvhtp+IbVqTJ/2kAZ4NMSUi9wzkhDZEw7qVHPN3K/owDVP+pOttGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640913; c=relaxed/simple;
	bh=m2XLzbTrVi/fBCh2IbtLEuHFob/HQaZ+4VoWQFYrgVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6JKXzoQgof163kfz/jZSu2fSRRu1RF7uPUSXt0/axKDcEVPVqb+xK7vdHW57EnN5OoK43+wUn25BBzf3nkXrmkK/bGmnGTMXdmJLYSM40XxSJXSEPUtO0ehaEZA+9L1eI+rQHVRadOCSDMjF6g6glXgjWT7xJVgfaNLJM811sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wLOGT55Q; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLOGT55Q"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso5374364276.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 Mar 2024 04:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709640911; x=1710245711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ACz/8EKu2pqQ60QwCisE00yzmLGt/nj9yGvDIzzvWK4=;
        b=wLOGT55Qjr5AwUrQIQa21h3quBYh7+bv83zSPAkWpl36UTgqToWz+hxwXIRMqS4UOM
         /sB964u+JJ3umnW7T81PFGSMRl6DP+utGeFPx+duAU+RiV4pv5/xP3Lqtr2OqHGucRk1
         xeng3v5bOfkVfVpUNy6HXz39Zswx4yrD6Tt34Gr9rtI//UvFk39QUwaQGgwo/lkIdfwU
         Wd3lcEvQtT2iXhXcexk+xDVdlqbfyIYdpjKX8Ydc6HnsENeNoUMnLJD0Tj7PKvwTwI/0
         E5W8kRqPLmaL6NvEa+2pEoLqFtEKZqAYDJIdbAY+gXlH0yqCPlBZyao30U4z/iSP4DB4
         aZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640911; x=1710245711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACz/8EKu2pqQ60QwCisE00yzmLGt/nj9yGvDIzzvWK4=;
        b=xCAehVUjlIh18IDNHYVrCC/+mRoSEjh9Eo25zUnXLMM8RobW/9nNnsDgumvDSK/ISs
         GkDvsRpxFVvA0pIQ6rXfX6hFto/TBJRpm1wHEgys1ObV6Bukhw3Kp0A4wD6bacFaQRS5
         MWYr85643fsOa5xwtkN2jHJHAY0yyfa7NVGmKkNe8+xS6I7Bp8XopSHPWL7dtcwh5y/F
         trQ2JtR+mAN4xFDFb6c/lgUloc+VKjbN7X/Xk0EDc73n2xNosS/y4lSNU3hM6XikAm8p
         OfY9jg0IPdZOPqLKvOH9N1+Vc4zCbRGNrnvxjYq1VV5NcPX+JF60lz4xC/fGtZ0vvQx0
         O1qg==
X-Forwarded-Encrypted: i=1; AJvYcCX9EfVvGhtZ6J8E+yBYlZtBhACmcaIfBkzFtddLCbWlkaWa3/+MjwIdxyl89HxxfYQH1UOvp2yUgOXZhhCHXM8ceEwQhtiKdhb+
X-Gm-Message-State: AOJu0Yz4BBFXtKmBJipXQ7aTlv4V2onmd6duS/4ezMlIcJi9qczQPz6J
	Tl9Fom4iQ138wy39vxSJ3p/+sQCEOecUfB/s3FN505g4talOyR/Fxtx99gV+oGyQ3V9DH6AHnvo
	qDVJc81fCYakitgfP9H3A6I1EQ/prME5880botESefST5cY/3
X-Google-Smtp-Source: AGHT+IE3VvLHkTZjsHbESyjaoia0k5m27DVB+/PFifZl/dghz8naoPYwRD7/1H8nf7a1HryxQ+jy/j7swWzpKe2ban4=
X-Received: by 2002:a25:2648:0:b0:dcc:7c0f:2222 with SMTP id
 m69-20020a252648000000b00dcc7c0f2222mr9133998ybm.22.1709640910540; Tue, 05
 Mar 2024 04:15:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb0bb1ed1e18de55e8c0547625bde271e64b8c31.1708983064.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <bb0bb1ed1e18de55e8c0547625bde271e64b8c31.1708983064.git.christophe.jaillet@wanadoo.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Mar 2024 13:14:34 +0100
Message-ID: <CAPDyKFpp3ODa+7z-Nx+ZLc2fqe6-=4MRQsQbKNVWb99u5-WasA@mail.gmail.com>
Subject: Re: [PATCH] mmc: wmt-sdmmc: remove an incorrect release_mem_region()
 call in the .remove function
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: cjb@laptop.org, linux-arm-kernel@lists.infradead.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 22:37, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> This looks strange to call release_mem_region() in a remove function
> without any request_mem_region() in the probe or "struct resource"
> somewhere.
>
> So remove the corresponding code.
>
> Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

> ---
> This patch is speculative. Review with care.
> Compile tested only.

It looks to me that $subject patch doesn't make things any worse.

Potentially we may want to call request|release_resource() (or
similar) during probe/remove, but as that isn't done during probe
today, I decided to pick this up as is.

Kind regards
Uffe


> ---
>  drivers/mmc/host/wmt-sdmmc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 77d5f1d24489..860380931b6c 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -883,7 +883,6 @@ static void wmt_mci_remove(struct platform_device *pdev)
>  {
>         struct mmc_host *mmc;
>         struct wmt_mci_priv *priv;
> -       struct resource *res;
>         u32 reg_tmp;
>
>         mmc = platform_get_drvdata(pdev);
> @@ -911,9 +910,6 @@ static void wmt_mci_remove(struct platform_device *pdev)
>         clk_disable_unprepare(priv->clk_sdmmc);
>         clk_put(priv->clk_sdmmc);
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       release_mem_region(res->start, resource_size(res));
> -
>         mmc_free_host(mmc);
>
>         dev_info(&pdev->dev, "WMT MCI device removed\n");
> --
> 2.43.2
>
