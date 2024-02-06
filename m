Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF9412F5B3
	for <linux-mmc@vger.kernel.org>; Tue,  6 Feb 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219750; cv=none; b=ccKqAkYC1YdX7WiAVBxRWa6g5Tam31Wm9q6hjLgMGUZavYT6HWdxZPE4V0hVO23CwtaEU7aOtqoxcGtG1W4vcJxs7cYR0iDAnu0c1YiTeYv8z4cbZdI2xMZh8HTinkV//7pGBv7FzXVqZYHS3FAq4CcHNvRZ1DOTCvMFXV4z+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219750; c=relaxed/simple;
	bh=5Vgc0uYHlhst7DchUFN6lwXlyMms5TYQGLsuXVjkjsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIke76hl27TDiNXeQrTx2S8uQZoAeZN7LxwLNnaxz8kGczkuC+10/k1VTgBtOd/te3ePi6X0clnWtoTZvG7hGpD+Dzm9Y8SVY903TTzjSYv1ci5Rxwblse7mwnBhuUGBiPxpGTKC9QPaNPnHZ2I8XPQQpIS3PnxNtY2pTd520jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ztCcUbs4; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ztCcUbs4"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ffdf06e009so48432937b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 06 Feb 2024 03:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707219747; x=1707824547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UgTJAr5S2csCtLzkG1j48wdxEg5NqUywyx+JiDcY0ow=;
        b=ztCcUbs46NAaNwvcmWkD4jgXiTW7xaUAxDjHBiGjZmZRnjGMHPE01D+JgOhuyTGucN
         NwZAeJYLGTUx9WjNIf32vFyqFGtYGxyKfn6zUHL8UL00fFSDW/4RBsK4ZrFGek76K0w+
         LH3jf62Cob12w7lVzSx2/pjwW1sxmgMl6hsCzx01qoZ4hLshLNQhf+cVfL48DGvKJ/qo
         3yMZnThkuNLOohXSikml9h1m7nWoMW/6RsqYBK8qkHrm/pdTqSmmuhWfrboeI8OoMrv3
         VrGoIT7RvDJmpNnAEgASQ+2gcAseT2gOn3vsSG5pF4cruJsfpSBqer+eXNQy/rgegfzf
         6CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707219747; x=1707824547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgTJAr5S2csCtLzkG1j48wdxEg5NqUywyx+JiDcY0ow=;
        b=j5YAdTLO7QFfvKCSNOf2s9r3AV8+gExhOceK6hmMWemXH6zfEc95Gf42LKcDoBaMG6
         eFKYOn1eBg/avleBPCx+UGAgkyZKEtkaF7f2/D9N7eeCsaYvRFIaOVN5tIPclTt+I+oz
         01PPpnYnhEvXri08pLdRw0fSMmZrH/Ugpa94gF/xyKEggwz4id3jeatRE1M1IUFfBXhF
         d1YPUS8PbtxgAaxuyiV6FRQDQ7Z48c+pqvgta/5pi09BFqiCrseumN2lGECugkP07Mr1
         MseHn05QbF4CTB5CGWcs2enmiuDXc7PPrCQgFyOsRYPHwC2996lXJqXJphZIKUF4zllq
         vGKA==
X-Gm-Message-State: AOJu0YwQ+V4sd2qtBbxtKUbu7DhOTqzyJi0eDDZS5GkuUUAcByZnAcIo
	nykem+ljCGi4Gls5pN25aWueZS1leAeVBxlxYqNjBaM3IUGNXxv9tK/HhcUZnZVC6P4bq462hl4
	VdyvLHFHg9Iic7vPKpD3QbWvrE+s6+otlobuP4VCe6SwG5xc3bUQ=
X-Google-Smtp-Source: AGHT+IHWronsCzyHCVtY7Q4z7jXag6ku/uieAvaWLpn4Vu+yPGrxgLyzYQbQQDCjpAFafaD3H9HdyAbk4ZwkoIBV55w=
X-Received: by 2002:a0d:dd0b:0:b0:604:3f5b:5508 with SMTP id
 g11-20020a0ddd0b000000b006043f5b5508mr1345177ywe.9.1707219747410; Tue, 06 Feb
 2024 03:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206083912.2543142-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240206083912.2543142-1-alexander.stein@ew.tq-group.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 6 Feb 2024 12:41:51 +0100
Message-ID: <CAPDyKFrfAZCQ8OT9u=t8QQv_=yEpo0pTopUoMmgfz05B03arbg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: slot-gpio: Allow non-sleeping GPIO ro
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 09:39, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> This change uses the appropriate _cansleep or non-sleeping API for
> reading GPIO read-only state. This allows users with GPIOs that
> never sleepbeing called in atomic context.
>
> Implement the same mechanism as in commit 52af318c93e97 ("mmc: Allow
> non-sleeping GPIO cd").
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> With commit 5d5dfc50e5689 ("gpiolib: remove extra_checks") thw following error
> is showing on my imx8qxp-tqma8xqp-mba8xx.dts platform:
> > BUG: sleeping function called from invalid context at drivers/gpio/gpiolib.c:3740
>
> The reason is that mmc_gpio_get_ro() is called from within atomic context from
> sdhci_check_ro(), which uses spin_lock_irqsave().
>
> The problem was always there, so I assume I didn't actually deadlock cause
> nobody was using SD card with a sleepable read-only GPIO.
>
>  drivers/mmc/core/slot-gpio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 2a2d949a9344e..39f45c2b6de8a 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -75,11 +75,15 @@ EXPORT_SYMBOL(mmc_gpio_set_cd_irq);
>  int mmc_gpio_get_ro(struct mmc_host *host)
>  {
>         struct mmc_gpio *ctx = host->slot.handler_priv;
> +       int cansleep;
>
>         if (!ctx || !ctx->ro_gpio)
>                 return -ENOSYS;
>
> -       return gpiod_get_value_cansleep(ctx->ro_gpio);
> +       cansleep = gpiod_cansleep(ctx->ro_gpio);
> +       return cansleep ?
> +               gpiod_get_value_cansleep(ctx->ro_gpio) :
> +               gpiod_get_value(ctx->ro_gpio);
>  }
>  EXPORT_SYMBOL(mmc_gpio_get_ro);
>
> --
> 2.34.1
>
