Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C317255226
	for <linux-mmc@vger.kernel.org>; Wed, 19 Mar 2025 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384442; cv=none; b=SzK8D5x5wryggb0g3U/Z5ET8+HKjU98Pc6zZqiGgxjgFP28da/ldEzzWTOwV+W4XO+u7AFuE+4WwuZPTSUhg8wN/aox67joHTuxoZrjsKPPMeXy5qxYt8DJK1WKJcqLRamuXwJRe0rnmK4z5WqyJmRGmaeIDCGDtU1Wxz9ub3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384442; c=relaxed/simple;
	bh=nqIrR5gsf+WAV1exZh0bkciSxO/FVA36+RLDOmghAPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNHb+bIDq4LSE2LXVH+ikXbj4JYKjTRLtRM3/K8gqSas89RpAoKttsXfFO2FJb5O1gxXIONWJO6VT4UR1vfGIW9XblJr+DA6SNlubRZMc0kn6aa9OoAjAUZyFW/XOgWcs5a6EkfjvzfPUJTvh08psHY36IdOlMmt1fkt17nXqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IqtzeUX/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqtzeUX/"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac29fd22163so1198291966b.3
        for <linux-mmc@vger.kernel.org>; Wed, 19 Mar 2025 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742384438; x=1742989238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mnFp/IlyQSmTN11coM6CacS2HH63qWF1P6HQesyvvvY=;
        b=IqtzeUX/xMCj0BV6NwRCRHv5/5FOdcGlFwp1s6bgmE2w4+wMDhmHTKw/fCS04x9wd9
         PEWFC2SQNq7CkoN7cl7DiToNOlTGJ4Bml3XpwNZzuRjZqBoo9+pyL7hDCX2oJPrfXLc/
         /3NX8TYi2yjyEO+5/7C1YhIpbJElQ3zUCmNho61/AezMtVgYXcXkRPWQb0Hfw6tqaJLn
         1hYA/Uju1QwF6A0Z/RIrHkByWzm+7SyveKW8Zoc1Hc6K/Wau7SZ2jflxl2Jd3bUAt8sI
         vUC++ikd5QQ55VNXxiWt4GKJIVLT6zNsxZuT48GBlPAI+plUXuG0hCWOlo1Muzs3Zh2Q
         g9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384438; x=1742989238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnFp/IlyQSmTN11coM6CacS2HH63qWF1P6HQesyvvvY=;
        b=iBkNBkO5FJ/icOcYwYaP6atQVflxr68e7iNWASXR227SL/jN+1qijn5QBsRnWD4KeD
         8+l0Joi2Hhi+cm3Tr0riUjf6d0UgV9GbAnVeUJ0n7wfAcv2pN+ZEKo8lWd1l2XY2GdhK
         8xoY4kLDPPjtCZe8IRQAIqKCSVOZmfFePVmqni2XLU3Gl6d6n6UgLuFiYUB+CtKLY1Ww
         zhe3n9KJ5IKGYsKwWj0+eCJf63JaOLgfISaJWT2cpN7jQy4FX/7OPhtbSeZxyAJ+h/m1
         p/7nBbNOqOQKbyT09QHbhbEkp8OEfjwh3U8exIYpYYZxgLo6KVmqHULk0BfPsrFmKOZP
         BOlw==
X-Forwarded-Encrypted: i=1; AJvYcCXdd144kezOGA8+c8ItDhK3mZWgiOmsHP1SqywTRHz26iesx6Nk8FF88hUI9YOKZ/SBF3RgHgVUybw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJ2s7YpSEAVK5mZuYMwTChSezm0uUOrnOGRBX2NAzzz7MhgtN
	B3Kxpn8eXZHp79k4Xlq61SRlORKYvOuUOp3OEJcYqrVL+ex0I+3eL+AjQRGPUNuMFjECjaSTn5k
	s/inKlSj6R+DfUbzDXQ7NEV7kK18cx/VE+fd+eQ==
X-Gm-Gg: ASbGncuegtd7bgh/eKGuMnhJHQxu0DoGiNB5zAWMGJtm/0iJH8Pm3DqgMoTrCWTDhHX
	AeepTeguEPvgQfq7JSGYf7k7EzntWLWPjrniFllXnpFmtVjrMAXdcho2DIZW+JqUNga+jIPQyXE
	1bMTXw70arwDoyPjtu+PQ0IRtVqL4=
X-Google-Smtp-Source: AGHT+IF0PzKaNKAL7SPqWhs9UxBZVmDcGAhQ39w6MNvnxwI7NAxBaxdfkqg2A7NnvQaWeAw8MONWf7mWrGQhnF9ndlg=
X-Received: by 2002:a17:907:3e1d:b0:ac2:aa51:5df2 with SMTP id
 a640c23a62f3a-ac3b7f91d17mr235997766b.47.1742384438476; Wed, 19 Mar 2025
 04:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318140226.19650-1-linmq006@gmail.com>
In-Reply-To: <20250318140226.19650-1-linmq006@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Mar 2025 12:39:58 +0100
X-Gm-Features: AQ5f1JpZhZOJWrjReMX_ekwAE_r0NF0Q1GA_lYDgPOQJ7eXkzTyG3252h8Kv8jI
Message-ID: <CAPDyKFreSxNRF7ZuokqjxJQQsAxHOvX8VBS8C5usyDJuvT4p+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: Fix memory leak in mmc_omap_new_slot
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Aubin Constans <aubin.constans@microchip.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Christian Loehle <christian.loehle@arm.com>, Allen Pais <allen.lkml@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 15:02, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> Add err_free_host label to properly pair mmc_alloc_host() with
> mmc_free_host() in GPIO error paths. The allocated host memory was
> leaked when GPIO lookups failed.
>
> Fixes: e519f0bb64ef ("ARM/mmc: Convert old mmci-omap to GPIO descriptors")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 62252ad4e20d..3cdb2fc44965 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1272,19 +1272,25 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>         /* Check for some optional GPIO controls */
>         slot->vsd = devm_gpiod_get_index_optional(host->dev, "vsd",
>                                                   id, GPIOD_OUT_LOW);
> -       if (IS_ERR(slot->vsd))
> -               return dev_err_probe(host->dev, PTR_ERR(slot->vsd),
> +       if (IS_ERR(slot->vsd)) {
> +               r = dev_err_probe(host->dev, PTR_ERR(slot->vsd),
>                                      "error looking up VSD GPIO\n");
> +               goto err_free_host;
> +       }
>         slot->vio = devm_gpiod_get_index_optional(host->dev, "vio",
>                                                   id, GPIOD_OUT_LOW);
> -       if (IS_ERR(slot->vio))
> -               return dev_err_probe(host->dev, PTR_ERR(slot->vio),
> +       if (IS_ERR(slot->vio)) {
> +               r = dev_err_probe(host->dev, PTR_ERR(slot->vio),
>                                      "error looking up VIO GPIO\n");
> +               goto err_free_host;
> +       }
>         slot->cover = devm_gpiod_get_index_optional(host->dev, "cover",
>                                                     id, GPIOD_IN);
> -       if (IS_ERR(slot->cover))
> -               return dev_err_probe(host->dev, PTR_ERR(slot->cover),
> +       if (IS_ERR(slot->cover)) {
> +               r = dev_err_probe(host->dev, PTR_ERR(slot->cover),
>                                      "error looking up cover switch GPIO\n");
> +               goto err_free_host;
> +       }
>
>         host->slots[id] = slot;
>
> @@ -1344,6 +1350,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>                 device_remove_file(&mmc->class_dev, &dev_attr_slot_name);
>  err_remove_host:
>         mmc_remove_host(mmc);
> +err_free_host:
>         mmc_free_host(mmc);
>         return r;
>  }
> --
> 2.39.5 (Apple Git-154)
>
