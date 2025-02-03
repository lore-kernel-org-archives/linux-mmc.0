Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C32205E35
	for <linux-mmc@vger.kernel.org>; Mon,  3 Feb 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591500; cv=none; b=Ahq7RbUkdtk1OGleHbZMupjcnLs/uga+r2TjdoFeN9+EzHWZFsOq1RnKK4NrDZaCKEXIQPYLqhocC9IXpJDbyxlKkVgqBls64QX5Uzh8QK+UxzjiQR/VE4swuKLs3XbdlHU2BfvbsvVMv/kDlvuAM9o2C4blWQLo53tLNNGIMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591500; c=relaxed/simple;
	bh=h6CWMX42b1q0GMAh+1qfTza+9TeJXgXvTvyYsur+MFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmyGgUjKw3GAUcJkIl9UvYma2mNf2H1JVFgHKGG9PQgNLfqjMpmffHlpl8SJkGQOXg6U1k+TT1EvIHaY8qU4DmMMOd9Pz/WdSW7n0WWoH0s6031C782I6TEfH9x02gNKOIMbZFhsz/WoqfeR8UZ3PZIN8idVUw6tOKZ6wEGZMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QLTHaeuH; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLTHaeuH"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e4419a47887so3881857276.0
        for <linux-mmc@vger.kernel.org>; Mon, 03 Feb 2025 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738591497; x=1739196297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Am0X09ccYm4uqIChn1Tko10AiRMYHlGQ0TVf8PEtNTc=;
        b=QLTHaeuHCKGqetCdGn595d9nC534v60plWYdPlxFE5N/EZL7uobirEeycwW5rmZOw5
         rWmYkTmNdXTDDNhApCj2tqh279tJZ7JidLnA/8f00GVTajfyLoO/AvAwMaZQq+Ltev4a
         tBkj6PYLlXKa/GQYo71iYgLt4PGg540PRnQDHfkwqGQh3EHz1dYab6jOv8NbU/wAq4KQ
         8A/HjwgWOviFBlZUE1MhNMd45G7WtF0OL6WMOKh4fvuTdP2+wPzHjqFS/1tZPXEptRdz
         TehY8kJFN3po2yrg56AyPRANKyBMJArEk2QT5itxX1IbFR7nWFpLfeXofXot3wlRjhn2
         WmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738591497; x=1739196297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Am0X09ccYm4uqIChn1Tko10AiRMYHlGQ0TVf8PEtNTc=;
        b=CLmozS2MBRhH0OaBg45HerJ96YVNoQReibu49BTrWHT6eQvTOnhXX4PWJ4RndLnV+q
         Wh+6iPSSlP2n5G8W3CAQHKtbetIQSSblGQm/bhYDHTthR6j+MNRwZEQnGcTFvKKHDfo6
         QeGZOHNdWVoQoZqZcW3xN8jzfYY+a7+OGOmyrfw1Q6NypUH2cSShOoV/x2g/szPhWAbn
         dFAP6cKmtqm/XQnPiMZPcvkbKNP/32bkQiFdQkOvL8cNeRh4J7j12VwDq7z7IbAKYmuC
         ToEXSzTYpgldUuWsLOU0+VoZONtK/zU8dcXdS1s/uQvIt8ZQixfjWYl2yZChjzrZyX95
         Ww1A==
X-Forwarded-Encrypted: i=1; AJvYcCWjGePb+Jlpwb5uIVk8lWdTjwiiwfSAZztgVwbq4hWs9C1Jlfgn26FbUvU2njIVLXTQva1CUlQphe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLuDkq0DNSlvhFEJ+YaKhLopkVu4HGnPscHSUT0JIoOP98p9n
	8/H3Ji3o1fHHd/y0Yg4B9bCsaEdtcnaP5PCh34x51RxYFuIhPCuhpxdiAUtqcGq1u7g+XX5zdE3
	kJ5ak5ugrAiAJGJ4fcxih9ZsInJjs2bB8RNtj/g==
X-Gm-Gg: ASbGncv29JA5ykm1Q8rH07Gm3mQLpfI5OJU73Mein78iUHgjO17zMc9ToSAp9UiRLip
	d2TqVV65Zh7LLGn/t6UoW7vWS14dgSDFcTqvi22+F4NHBCEAMKnCBV55aAU30M7zThQb3ZiPCHw
	==
X-Google-Smtp-Source: AGHT+IFwnbzyrxEukfl9ktPOhFtVST3/FONPbZt9n/IsJ/BCI9rREcADlK7HneW2NrgAPdGw7ypRtb7SFs72hQbzEUU=
X-Received: by 2002:a05:6902:2006:b0:e5b:111b:a8d7 with SMTP id
 3f1490d57ef6-e5b111ba9abmr284291276.41.1738591497654; Mon, 03 Feb 2025
 06:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129214335.125292-1-linux@treblig.org>
In-Reply-To: <20250129214335.125292-1-linux@treblig.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Feb 2025 15:04:21 +0100
X-Gm-Features: AWEUYZmZikQz2CrmOrzRKi5yrRTvk_iJYC_EFEjQ29bDOeCh_i1eh4bHMrvn-Yc
Message-ID: <CAPDyKFobzCJTaHV6rXwTr-hhzKgN7fAuiUQXjG20pRmBq5wsgg@mail.gmail.com>
Subject: Re: [PATCH] mmc: slot-gpio: Remove unused mmc_gpio_set_cd_isr
To: linux@treblig.org
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 22:43, <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> mmc_gpio_set_cd_isr() last use was removed in 2018 by
> commit 7838a8ddc80b ("mmc: omap_hsmmc: Kill off cover detection")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/slot-gpio.c  | 12 ------------
>  include/linux/mmc/slot-gpio.h |  1 -
>  2 files changed, 13 deletions(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 12247219e1c2..5fd455816393 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -159,18 +159,6 @@ int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on)
>  }
>  EXPORT_SYMBOL(mmc_gpio_set_cd_wake);
>
> -/* Register an alternate interrupt service routine for
> - * the card-detect GPIO.
> - */
> -void mmc_gpio_set_cd_isr(struct mmc_host *host, irq_handler_t isr)
> -{
> -       struct mmc_gpio *ctx = host->slot.handler_priv;
> -
> -       WARN_ON(ctx->cd_gpio_isr);
> -       ctx->cd_gpio_isr = isr;
> -}
> -EXPORT_SYMBOL(mmc_gpio_set_cd_isr);
> -
>  /**
>   * mmc_gpiod_request_cd - request a gpio descriptor for card-detection
>   * @host: mmc host
> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
> index 274a2767ea49..1ed7b0d1e4f9 100644
> --- a/include/linux/mmc/slot-gpio.h
> +++ b/include/linux/mmc/slot-gpio.h
> @@ -22,7 +22,6 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>  int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>                          unsigned int idx, unsigned int debounce);
>  int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config);
> -void mmc_gpio_set_cd_isr(struct mmc_host *host, irq_handler_t isr);
>  int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on);
>  void mmc_gpiod_request_cd_irq(struct mmc_host *host);
>  bool mmc_can_gpio_cd(struct mmc_host *host);
> --
> 2.48.1
>
