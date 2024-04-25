Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2414D2A7
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062140; cv=none; b=NjMC7Pl2wOAlYIPsrfLlql0WMCjCbWz6313y16C6zuMRD1/GMFhvoQxPCTb0wkxQKfeplADaU4tjsQ1BhLm7GwbL5ni9y5co10hTZEYxPim//Vf5lrdtemC1CFSu9Dl+DfoSntfOed4Yp5bNm1kmdx7iQzkJWxYdbaVqgf5plCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062140; c=relaxed/simple;
	bh=ieQm+pX9ecLlYdE6XA9WVavDiEeCE981RVxr7pvK7dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoDca1ja55J5jjbsuz7vrND+d5hQXGraFW4mYGOJMks4DUzjNADFeH93cmx/eoqkW4AJsHlAxM3Jo74BJYqrsDwjwUGfOQeW78H10AR2gLIJnY0SOsrNfqbnnBYPhun3Scn7rZLjN7r9SAJe4R4BnOUtNLbsc7zKZP8aCw3O3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uOAxSmAM; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOAxSmAM"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de59d7f2928so459245276.3
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062137; x=1714666937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rT8CtB6u0TXgJ8oVknrhHpM21jHgaIduXHq4luZbdGI=;
        b=uOAxSmAMIf5P0Bh2TTi1QvHnOHZx8YQ+p22It6c/7xS3zUVej5a6Fu+TgaF8LHbahL
         OVThoZ/2s5urHC6fZhKo3dTDHg60LmhJInS3W781fTkpHkPz6+ySC4wIfY/MYQU7sQVZ
         J8HJAishJ2x1qufq7wF75kQqKF3ajiK7ifoKs4Bhri51qwqaEfutx5xrCi9P4Sc82TQb
         8rX0Z01ksCp9uSAEAW4iz8X1+eiiZymceyPzcQ6oYE1775kK0hQS8zTCIdipqGqw5oyg
         gUdPUc4kf4C4t5ir++xAqvZAJeZQAsRrDtOdoKt0YXFVpvD+SWtyUKA/8gzdNowjnlZ1
         A+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062137; x=1714666937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rT8CtB6u0TXgJ8oVknrhHpM21jHgaIduXHq4luZbdGI=;
        b=uB3YeNLZU5FeY/CVfKjulLodBDBetSVCPPKRxpr9MTufy85Q7Wk8ptIlAUlc0d+XuB
         mEnaBn30L3u9qB/5soGbD0iwg1dJcIhgqrOzuqM5tkh1hjlMCZLoOCA744Xmf8lG9wI/
         7hzr43MH55t7UnH7wMJST9CZJcj0M6rDsHanv+0I2VoR1eJzOt4RAot/ra40lPpJ9xSH
         xo40mtrKJUNu15MIYVPl11T6LK3DEeoOn6TQqZW3aO91Lq787B6VkkkJDS8rW/DIotsb
         O9JfNr3633SLVBQf7WFqiXFkBmk+iI+mgeehZxDixxxClY9GZFxGWj1GpfR+ZIAA0GRT
         RCGA==
X-Forwarded-Encrypted: i=1; AJvYcCUWCqxMdln1xM8gugkEJ6zBkT5/ZIcfojI7Hp9U7LYCgJ05fJg4paV4OuHKDHNfqirk6lolJowWf7eVs4muRdW4EYUBqMMO7jgG
X-Gm-Message-State: AOJu0Yx2nlt4/dPvjrLYZea86w9lpWz1hMUcOGEvsY6qwuJ4XW8C7Hwz
	Ahx7afSNvGmXPMR90QTEFig/a4tEIDO08i6DrZfzoaKnhxziEnQTdpPY7ZWe34922XiWAm5RhDj
	4OeDU8o5WfnJ+13KdcDPXiH4OJ+L64mlPm3exTQ==
X-Google-Smtp-Source: AGHT+IFGFpz8NUcmngKe2j/efRClh3UKrfm6xwT5VVEWp2uX1W5JdiP8Rvm3CEsEcWTSAQExtQt3FdMEpkaO1GcsGc8=
X-Received: by 2002:a05:6902:546:b0:dd1:40cf:942b with SMTP id
 z6-20020a056902054600b00dd140cf942bmr119986ybs.48.1714062137592; Thu, 25 Apr
 2024 09:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410195618.1632778-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240410195618.1632778-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:21:41 +0200
Message-ID: <CAPDyKFoHQos4=+JUE-+=Sgr-GiVyF3HWiEHrCrdKNtcEsTPEGA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: slot-gpio: Use irq_handler_t type
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 21:56, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The irq_handler_t is already defined globally, let's use it
> in slot-gpio code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/slot-gpio.c  | 5 ++---
>  include/linux/mmc/slot-gpio.h | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 39f45c2b6de8..8e4750558101 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -19,7 +19,7 @@
>  struct mmc_gpio {
>         struct gpio_desc *ro_gpio;
>         struct gpio_desc *cd_gpio;
> -       irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
> +       irq_handler_t cd_gpio_isr;
>         char *ro_label;
>         char *cd_label;
>         u32 cd_debounce_delay_ms;
> @@ -162,8 +162,7 @@ EXPORT_SYMBOL(mmc_gpio_set_cd_wake);
>  /* Register an alternate interrupt service routine for
>   * the card-detect GPIO.
>   */
> -void mmc_gpio_set_cd_isr(struct mmc_host *host,
> -                        irqreturn_t (*isr)(int irq, void *dev_id))
> +void mmc_gpio_set_cd_isr(struct mmc_host *host, irq_handler_t isr)
>  {
>         struct mmc_gpio *ctx = host->slot.handler_priv;
>
> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
> index 5d3d15e97868..3e4d4836a2bb 100644
> --- a/include/linux/mmc/slot-gpio.h
> +++ b/include/linux/mmc/slot-gpio.h
> @@ -8,8 +8,8 @@
>  #ifndef MMC_SLOT_GPIO_H
>  #define MMC_SLOT_GPIO_H
>
> +#include <linux/interrupt.h>
>  #include <linux/types.h>
> -#include <linux/irqreturn.h>
>
>  struct mmc_host;
>
> @@ -21,8 +21,7 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>                          unsigned int debounce);
>  int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>                          unsigned int idx, unsigned int debounce);
> -void mmc_gpio_set_cd_isr(struct mmc_host *host,
> -                        irqreturn_t (*isr)(int irq, void *dev_id));
> +void mmc_gpio_set_cd_isr(struct mmc_host *host, irq_handler_t isr);
>  int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on);
>  void mmc_gpiod_request_cd_irq(struct mmc_host *host);
>  bool mmc_can_gpio_cd(struct mmc_host *host);
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
