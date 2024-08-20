Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6618EFD0
	for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154635; cv=none; b=NP965KD+AU6lN8GWBg9fWi5VTAKn4MmKT15xJe/F/CzkV7CUpf519cYwPEHEMm0RK3SYrvXH8/1G0zQAjV+0jDRRtre6hDUM7T8q5MAWTQys+5Wgj+eg4PtD1LQRz5EvJQ+3dNP/rAtceJReSbxLm1ah+5fpyvco2g9CSKRbEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154635; c=relaxed/simple;
	bh=uusF72PbLDFoREwFvvpywuv7JeR5nT3oiAS87fmO3BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIJsEFWKeT1v8iYuwUbky2h81tuHgl0v2yOBZn1FuhENjpYx/iZwzDCFUPicvyN4HXAv8aGd8+E7tvF0LXT/sL19IOH/uxqkxukS4/zy3F4wWpcknFB7y8awRBI+VwRsSP/2TjQHxxtEt4ed4t6bIhwAoci/mwbqO44y237zOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m1TdCgpy; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1TdCgpy"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso5620425276.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724154632; x=1724759432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VzLZnXPoqDrTo1OyWvxxv+efcSiWNKyKA+wTnD5Gpk0=;
        b=m1TdCgpyybq1yzvMf76OfvXUDqyObE/lCZXlBuTuBs9EV8VhQOLsFfH68RI+vdnwdc
         pXoqtM4RUyj3y9EKsYwZi1V+YEFo8SIwCaxY7Bwy+Pxs19lCp810JfumhLPWUoYJ3PbY
         007/8AvN0NPfZfFntlWpDg/RWQwAwLfJxZ2/IZW5hKI0CvS38NexFfSSNp6NPDMYwkpa
         MFllhjP/x25j9zhwe+3SFnJ5PPOPB4IPY3D5Qu0qWjox/ebA92Fjy092IVk9Z6MWg1GY
         9KyYCv1QbsqT1kLHFN+EtHD7VKE15l8pWR7rjHHSmu2IE3ZpvknQ0aZGl6V+ZwvGBzAr
         AJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154632; x=1724759432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzLZnXPoqDrTo1OyWvxxv+efcSiWNKyKA+wTnD5Gpk0=;
        b=bUACjejeb9x/EZH0LxpZ+T5iOFmBnlKdwO3QkkhjT2x/maOJddFzo9EOxnRNp09Khn
         qENdtqREvkI5niD4YuLWqH05DWDXUZx9rdtBhP0qN2wgUaqRtWSHgzENmYcWesMfcYD6
         yKPZfUlZzyjj9+7lBQ14U05y451dlRpK+F1aRo16zeeMm0ZHNb8IHIKDolJjYLqeA38k
         JhbugpuumkxZY0qS1M3k+2JDmkTRblis4NWFhvOTdT4qrqR2hLgTN43RHzTBB7lsEr4y
         1J28WkCh7Hk96gbhsjssnq8kGE8R9CPX4O34/bFSmgfmoqc9vRgvvqKbZdEsf9L7fg4I
         gUng==
X-Forwarded-Encrypted: i=1; AJvYcCUB082VhHYa6xQ9WKiJmqu9Dr1RQS0Cvaeiyf4rPXf1B9UhMwcdnLS7ey5ERBvF32nqJ17Aqol/tTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3aSkAW6rYi6YGflpVcydQXmbnlftGlSet6KDDSpZR1d9gUXDO
	XrdfgsZNJ5J5DeoKR8lePiQc5vyjRimDAiWwAqlLdOHEVF4b2g6pLUPduVyFL+sX4FWzSC0tsDr
	GijRzzXZ0W8CxHhrnhmd042XPM8bSxUcADwj0j+42mxlr3XwL
X-Google-Smtp-Source: AGHT+IHan5yI+BqVJCjNqFm/+Bd8yfej131gbJS5FJ0EOd0g5zSRJN7v+VFbAUTODUKmBQ76DXhsJZ07OlxiL6/2ZX8=
X-Received: by 2002:a05:6902:144b:b0:e08:5f0c:97c8 with SMTP id
 3f1490d57ef6-e1180fc610amr14678149276.57.1724154632329; Tue, 20 Aug 2024
 04:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818142300.64156-2-thorsten.blum@toblux.com>
In-Reply-To: <20240818142300.64156-2-thorsten.blum@toblux.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:49:56 +0200
Message-ID: <CAPDyKFpx6naJ2BD9xMyKbHdOAcT3v3_+fjmy+mCdU0=TNQ0swA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mtk-sd: Improve data type in msdc_timeout_cal()
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: chaotian.jing@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Aug 2024 at 16:23, Thorsten Blum <thorsten.blum@toblux.com> wrote:
>
> The local variable clk_ns uses at most 32 bits and can be a u32.
>
> Replace the 64-by-32 do_div() division with a standard divison.
>
> Since do_div() casts the divisor to u32 anyway, changing the data type
> of clk_ns to u32 also removes the following Coccinelle/coccicheck
> warning reported by do_div.cocci:
>
>   WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead
>
> Use min_t(u32,,) to simplify the code and improve its readability.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Address kernel test robot feedback and replace do_div() with a
>  standard division
> - Link to v1: https://lore.kernel.org/linux-kernel/20240815234602.59684-1-thorsten.blum@toblux.com/
>
> Changes in v3:
> - Use min_t() instead of max_t()
> - Link to v2: https://lore.kernel.org/linux-kernel/20240817170726.350339-2-thorsten.blum@toblux.com/
> ---
>  drivers/mmc/host/mtk-sd.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a94835b8ab93..edeab9a4a83b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -795,14 +795,13 @@ static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
>  static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
>  {
>         struct mmc_host *mmc = mmc_from_priv(host);
> -       u64 timeout, clk_ns;
> -       u32 mode = 0;
> +       u64 timeout;
> +       u32 clk_ns, mode = 0;
>
>         if (mmc->actual_clock == 0) {
>                 timeout = 0;
>         } else {
> -               clk_ns  = 1000000000ULL;
> -               do_div(clk_ns, mmc->actual_clock);
> +               clk_ns = 1000000000U / mmc->actual_clock;
>                 timeout = ns + clk_ns - 1;
>                 do_div(timeout, clk_ns);
>                 timeout += clks;
> @@ -831,7 +830,7 @@ static void msdc_set_timeout(struct msdc_host *host, u64 ns, u64 clks)
>
>         timeout = msdc_timeout_cal(host, ns, clks);
>         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC,
> -                     (u32)(timeout > 255 ? 255 : timeout));
> +                     min_t(u32, timeout, 255));
>  }
>
>  static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
> @@ -840,7 +839,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
>
>         timeout = msdc_timeout_cal(host, ns, clks);
>         sdr_set_field(host->base + SDC_CFG, SDC_CFG_WRDTOC,
> -                     (u32)(timeout > 8191 ? 8191 : timeout));
> +                     min_t(u32, timeout, 8191));
>  }
>
>  static void msdc_gate_clock(struct msdc_host *host)
> --
> 2.46.0
>
