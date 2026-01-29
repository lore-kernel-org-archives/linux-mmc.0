Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29393309F1C
	for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2026 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699575; cv=pass; b=WfFN+8FDjwpDNX50COgEOWVuQbUJSlkSwKVbfaQxbDW6VG09JssPKy6NuOsxuUTIM4VnLosmls3ikFkW6edWGJBYABMJlNOMbj1Bx50rZ/bIdud6jgRVBXUM3ELTO6qaxsgXwG89OwR0Uwej7pHAtocdxotOj8QbqD+QyLKZsvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699575; c=relaxed/simple;
	bh=btU6p/cAx95ZB/bW6mTN1vQpA/QMxZ6zfB3embU1BuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6E0IesNsPdQkRPbPLl6P8bJtIiXmcyfqQWCyUWuSWhY6+cWnSXD7c8/QSHg9K/uGknRqXxxe1iJ1pGrlQO2aAbApYkVFC9vOuC4RGC+s8jOWV00LX7sYVQN8x2Q4KIycbWyLDcc3L9t9ay6KJgbj6xK7W2PQ77Kxkx8X3V/4BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fG/ojv+V; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fG/ojv+V"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b6c89d302so1167641e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2026 07:12:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769699572; cv=none;
        d=google.com; s=arc-20240605;
        b=ZA+o4vkGgFuoNr43dyUvb9osrboAz3+/JUuFpY2iJSiXgsjqQcmE0k88IAXWjx/Iiy
         /k+3Wq+9jvRoKbF8Jst67UzTkCgbR9WGmLZy+Ax/lAc4kTwFl2e53DUcuCDe+U7lyQ22
         mVjCbgCGRuMQYT7iKSLPdqtfuxlwZA4hIdg1mcycqiddt20e/yEOeSdpbbjzLXFwHQTG
         hPrI1EWNVicpDKqJ9ghOsScFvD2QwXS9IdkC7MI1+tHt9yJB930SfkgiZDob0Z0RNffg
         3BMsN2On0NEH0Ng6VTVYozvCMqvwmPpSDkcueaNy7H2ELLoFwu7S3l5tOQ/rxTQTNOST
         q5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zarVZwRAzIc54++hb+y/zY2ZfGNGu4YRoEk4cVKgt7w=;
        fh=wIN5xJNKDwhPbh0ZY9RiNSBmTXRjFtqF3GyAb1l8zGg=;
        b=Ad8i1cQz0limBnoMDw6zc3Sx09ZFoflVlHOSs4Kihypw/1gnr1N5BIN+BqzfJc8m2r
         7uwfDa5NtyZAum7EoEUpeE/h4joGg6AlvH3hVNU5RylFLBJTfqefiBxqbFqxTam0xhby
         eJifK+xXbp+tGFaWbHRVlVEzvoGQsfPtc+DnFn3qxo0ii7FHpGfxcinTJloWrBcf+RS5
         d/pdtdsVe8iVSQfmU7COuMDSTDU6IbhRrj/37a0X4a9skoUjZEzgSNesIF1Ek6ZNcjmL
         nzhQYAUJrYcXCfDHQF9LXlWd0m3D6RXW/lVEVQAz9ibPIP16erOZiqz6ItYiT/w/m/bC
         7SfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769699572; x=1770304372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zarVZwRAzIc54++hb+y/zY2ZfGNGu4YRoEk4cVKgt7w=;
        b=fG/ojv+V7Q+8EzNvLLL7dld9y3E1S9hoUbAzeP6Qs3NQbfNS1iJsdQhuxwsOUJUrJa
         Yd4mo5orK6DvnXzsutWDHw2ItL2bZg88mZOIaVppj+f0nq86pqqeB3Nx1R/zYkjCo+EK
         YICntpKsF1tnp1bFSrxn46BaKrhy4eEoSSkhS+1SKRLSujoVKrrSibUJ67laDJq0cj7G
         8cc64kBSj4Y+JE12rv99ISrsD+qA2XTg2WkTnSeRoFE6E5tK5mR3eAxsDby3Sf6fED0E
         Y48qclGHj5hGBHm0Xshv1nX26XAdtcyecN80Hdll3prwyBjz9NSr9IpzpgWn05cAK1/p
         gevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769699572; x=1770304372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zarVZwRAzIc54++hb+y/zY2ZfGNGu4YRoEk4cVKgt7w=;
        b=IQLPGpRFkFOaKbbgY97KxXWN6ZOSFGlzl7u7MpNqGRqvhwgrH1fDBe4l9/uoLYOcPY
         Z1JWOu58RB9LqaZdXpOs/otcBYrfbdTMZm5qm9jTbIW4vvdtlIDLLZWc7NtQfbDBFE+V
         oW5xEOzcCi6QqBxsaQItenvAW7CEOnErKEgbMYAPnCkWBqxZ3ByD5bRJGAu0Nsy2o8Kt
         2Sh5N9O8ZIxZAc6kXuJb4he7D3dXC2eOGDQ9eWEcA1T0zVmpIk6/fANcSn8GAri5hDfr
         aqfDAt1GE+TZftrUDwIiCL3nG1Wu272GSvEa68AXHpcrtVE6qDv91hJDeaXC+bhwlMwf
         5gRg==
X-Forwarded-Encrypted: i=1; AJvYcCV3tIjo5XvHVFlHiI/on7jWgbc6cT+fSt7B6nQ/fO5d6/LL8J4iJHtllASIjPHc2EjZLvhb6POVOGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4muPibeMtORTBnG1aUguoHQWM+WbDUvAlcn8b1b2TwrDLh0Yc
	xO8//xNdHqtbu5LDio3KQlXOLyDndpxBAWM/tffXZVdTfZNvwnQ6pTi0SSkKA0mhCulqxIS76jH
	nmpXbFdO71kC7H0yDRTMIJc7R1+rHumAQR5gEH7aRE0b53ZYt3jHGjhw=
X-Gm-Gg: AZuq6aIfwBIpJ3353GIQlDpg6x1SUjq100059ctVacNsw6sFr/nkgP0fSVSCHp54wsf
	4xxTIKyp1wDVFTiO6OCFZB4FfliS/XBB74nR3n0/UUUSO5EA729rK5DFJo9k97r2q8iGTUaFe/n
	x2t8mnfwkWTYITMA7g2nO7tpaWETaBei1eWXAhUoIIFsl77B0/iPBu6TX3mokZ8RODnR1omAW16
	jQC715GLUQ020Z8Jl8XxDmNNF/iokq7cmlo7FsAT6pjqCJppEj6Ty9H7xkfz6tX2wXTqrqS
X-Received: by 2002:a05:6512:3b27:b0:59d:e03d:1cf9 with SMTP id
 2adb3069b0e04-59e041311damr3411452e87.38.1769699571985; Thu, 29 Jan 2026
 07:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129035917.48080-1-andre.korol.dev@gmail.com>
In-Reply-To: <20260129035917.48080-1-andre.korol.dev@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Jan 2026 16:12:14 +0100
X-Gm-Features: AZwV_QiVSBu_bV3OoqsrxwUC86wc0U3CXT2Zol5RV1PEHi0YnKXir06UMKnzkyc
Message-ID: <CAPDyKFpBq=UNLnMmW97Y0jLvu8eRwt_Y6gf3ZGkd8RBqS79yZg@mail.gmail.com>
Subject: Re: [PATCH] mmc: loongson2-mmc: drop redundant memset after dma_alloc_coherent()
To: Andre Korol <andre.korol.dev@gmail.com>
Cc: zhoubinbin@loongson.cn, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Jan 2026 at 04:59, Andre Korol <andre.korol.dev@gmail.com> wrote:
>
> dma_alloc_coherent() returns zeroed memory, so the memset() immediately
> after allocation is redundant.
>
> Signed-off-by: Andre Korol <andre.korol.dev@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/loongson2-mmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
> index da3daab5f3d6..026cbd80f114 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -846,7 +846,6 @@ static int ls2k2000_mmc_set_internal_dma(struct loongson2_mmc_host *host,
>         if (!host->sg_cpu)
>                 return -ENOMEM;
>
> -       memset(host->sg_cpu, 0, PAGE_SIZE);
>         return 0;
>  }
>
> --
> 2.51.0
>
