Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7237D26059D
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855591; cv=none; b=ddI53OT3tuxwGfL7nxFieE9rZh4czEWrm8hF5lX4/pfXnp80a8MFO87hnOAfhSefzgjUc5sq0gCWE75qKFSdyNvLqsGi6psVtvjvEJ6xKYQIPbK850N2pnsZYPIkeVAQM101n4K9OOYUBrXHESluwkLCH7pSyfxdxmGsBTXResY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855591; c=relaxed/simple;
	bh=uKe/lXCPQGq24nA7rp+Toa7FOiyyQGSx6ZJ25/LXCwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL5CElEw8+FrdLa0C71oM6ZARXlw604aApx6kwwZlRwYOXT2qGjJbkVAwjAQaQbes8FherBD99jGP50mhjs2gQjFecSxG85xAlBF/tcvg1RVS95nrGHZfV8PFfj8Jfnu97V1hV2sjH7m4ArTVbPx+pIjwHGQ3qDwMjTzaNiJVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=geo7a+Ck; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="geo7a+Ck"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so2751474276.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750855588; x=1751460388; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aj4jAhuCkHLc0MKXkhpZy35x/RLjZn6KIWkW8s4y+Y4=;
        b=geo7a+CksCTvrATNZg1AGdKiEW35SDXnVT4fwqM44cWUMCepSvW3RAU6+2D0e8QpKp
         yj7VgE+MoiLEP3evL6AWgczsHFwdGSAZHNSddn2GB2UPUg2AwFebSN7mNE+8wgWuJsrb
         RzUPP6MfEWL1w7U+ol9D376ePUHI4Je63Re4BG5U5zNNSYf3Fg+P/ws+9yq/a9P9+UMT
         mOhQQMnkxEf+pKDilFNtObRabkCseSdMZmFNXFyhkJWXU/hZMPPp05f3ysCb7X4j6t3h
         C0Zr7VNwX95BmmNKnR6a7f1Zndm5XeRCN3sOnghtkh9sjZrPJ3BBu9fY16ACTq3+okMr
         vlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855588; x=1751460388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj4jAhuCkHLc0MKXkhpZy35x/RLjZn6KIWkW8s4y+Y4=;
        b=P80bpnLXo/H9zw380tT9VyDopr6nitF7xisWXr5WqUm50J/uO1Q4nKSmqJNeCkQnmg
         fMtWCEktzbUxJKr0APCmt6WYrkE7d8U8YmXcF6DJuGzKqxWsXQcNGLdb7pIlghLGGM1m
         mAw2ukdgHLJtLAXqFqRFfL4ha8lULe7CprZFF+t9e8NCwxoPizNdLHWk0+KM+Re/EZOZ
         AU+5FIKW9Pt9yRvN4BtUD0qP6tmsIx7QJjPpG2ha0GawgXGKWb0qdQXeK+iaHRuwEsaB
         3/ud0DiN15YR5QYwbEq6iryTQ2DCXDoLUF0ZrBl9GoUpRT54qjGSJ6lFXG0EcZtoepNT
         eGpw==
X-Forwarded-Encrypted: i=1; AJvYcCXixhjgeU3g7vdqkXcfD7gMajqDdc42uAOcFevm9ToKVGlRu8g8I/q0KVeTffF1tRCOP4Bg8nHW7SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7YaHc+FtHKEVXRB5ieo8mUygBJ8nS3IuPBR3ntd96fmVqC9r
	i303EHqJNmrVQOxSRyZNkFqvKkmAFgK9fSNwEDE8NTM/s6nOiSpffGbL8ZnTxikSsBc8VYm2z3v
	/cmy9L698oof6+LK+f0vn99ikbS+2sP2+hWiAuTKT3Q==
X-Gm-Gg: ASbGncsoAzDKF8R8RGjXYk65QUw7PmrlNhGIOHH8RxNfyZTWIcrf4l0n7fPCwFIUlwH
	p4v4NbW4HGpBvAWLl2UrBRBRmf5evFLQQWURvlO2q+Dn9bC2GSXALrUW4Jb96Ne88FdoLWS9eAe
	lDZM8jSTWOqp8jZYW74rw1D3JcJwgfc96pZcRNm6La8Gs=
X-Google-Smtp-Source: AGHT+IHuqbs3+ZWuZkWAAPqD4OwhWYQ4/+DMgIxw4fLXOlRsaFo0LQlpSx2p1DV+41IMvrV599rDMZdlt1nY1Sc/mtw=
X-Received: by 2002:a05:6902:2782:b0:e84:2cbd:3212 with SMTP id
 3f1490d57ef6-e86018cf6afmr3027295276.20.1750855588294; Wed, 25 Jun 2025
 05:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
 <20250625052106.584905-1-senozhatsky@chromium.org>
In-Reply-To: <20250625052106.584905-1-senozhatsky@chromium.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 25 Jun 2025 14:45:52 +0200
X-Gm-Features: Ac12FXwFOrEcUFEsusjn1MoQ84IvAh5xPRaGYt6omrx5SZ03KEKKj6Opk4VwAGk
Message-ID: <CAPDyKFoYgi3bauUQ8xrc+0KtwmmXi9jNNzcOt_fmyP2pFQ9Jbw@mail.gmail.com>
Subject: Re: [PATCH] mtk-sd: reset host->mrq on prepare_data() error
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Tomasz Figa <tfiga@chromium.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 07:21, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Do not leave host with dangling ->mrq pointer if we hit
> the msdc_prepare_data() error out path.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b12cfb9a5e5f..d7020e06dd55 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1492,6 +1492,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         if (mrq->data) {
>                 msdc_prepare_data(host, mrq->data);
>                 if (!msdc_data_prepared(mrq->data)) {
> +                       host->mrq = NULL;
>                         /*
>                          * Failed to prepare DMA area, fail fast before
>                          * starting any commands.
> --
> 2.50.0.714.g196bf9f422-goog
>
