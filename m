Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAE1DE4FB
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747655461; cv=none; b=lJFUGfHu6nzQ5Hqn4dg+/xSYqOF9NHMhNGbH2r1J2UBhzuRJ7sX6THYorjTKz/Ho5kJizMs1+szarYvmF4+jIHeuHQW5xhox3+XcD8wmWJkiHBieZYCRi8ulY3Z55p2b8pthqtd8/IUqQJhb1eDsBBd6ZiAsR1ae9kkhFMM6bnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747655461; c=relaxed/simple;
	bh=dpJRnmVLChGWvt4AQM/yWD75C5YtTYcynlnQQeUoSlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGguu8DjUdrYKKDiqkSGUDrSiHRuEyzftPhbcz6tEjIDSIJMg2kI18gyX3bQ0euTTkuIGW8KWP/LBx6yOfh3cGUP7vgP+rayeNuEvC3RB94cQsPbfnea/kPnWORZ7SwcA0XhJx9FPhNM8JqtH25k/AI63q4fhcK25ijNsMT0378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kLOsFmOd; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLOsFmOd"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7c5d4709caso756456276.1
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747655459; x=1748260259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MVMQHjprUKNt5McI91v4XBFRYSelv3HhqviuSvNhLds=;
        b=kLOsFmOdpL70KMcUfYphfroi8SZWTZz1YpqHY/Bi/RymzlX0aEfR3j5tEiGZzdESye
         reSE8tH4pjfj2PHxWFkNjyB6jCpR2ut1BXwpp22cEYt62nZp8YXrRbPHJQhpDZOtxRhQ
         SPQYZmIofSRK7129AIjwsYMjmfXuKN5lKUro/1eK+KgQdmOdoP9NraSqGmmQhpfog730
         s6NQjq2GDuzA9ZUqSJC6jqsfSve3eX8wK8PdHVbjE2eg2H+rXOBgbvCVFB/yo8JAhCFE
         tmifwbeDv9jddkHfC5wIhzOSdcV/AGvraOdAGgqWKISfplmKMpg5gVhFLY1o/n0kiCKH
         RepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747655459; x=1748260259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVMQHjprUKNt5McI91v4XBFRYSelv3HhqviuSvNhLds=;
        b=P04zsrAqOZ04YxyyZLIw7N1t880zLss+fS6VDh4KHWeSNDgR9gzG6zK5SLlUpaBxKG
         zdSqUUVbK/mph8GkckyABlKUUu4b6QY+TzC193ad3sU7fqPE8h7KlpIwg+rXACtMRUOM
         CPPT0n+25oLe9FGFJZ5jFgKLbTDNdYwF/Ys8gD5pqSQQuqaKhavumHYr4wrW8+qqfAe1
         v8j2ekhB84+spwEVO/BCc+qGoKaQV7/Q6+W1FyXgYOmrfQTi4BFcQ63irVKLPB3VGLSm
         bjDiwcQuz1hff5vipMeinGgl19qek3oGLpp9OhoV/SkbkLaSeVbrB0knQn2OFFfTw1IA
         qGfQ==
X-Gm-Message-State: AOJu0Yxm77v8F0sPoXvATfNjzHJqjeI51jNo9S+MvUb8ar86+jII6CnD
	M2L3xf273Smo7b/0l6KCzGmMGkZSdcpVcSfuQXQw8K8qQWjfyKvYq1/IV7FgnJJm4fujNz6L25e
	S3rXFStovRmJQtm6AGJLpfRPMSxtvC1PCAyffBj8CfreB11HkAhLyHmI=
X-Gm-Gg: ASbGncsUY8UBmi44C99Lwx/C+uJXmYIPaVIpnG28vPVskcVhINXtMwsU+CnhtATa7WT
	QC01cifQIekpTLXsU6rC1f5RUbo8tk0pVKgOAsvvitVkY+5C5DSmFLBkJZ/x9H/iKBfshHc+SP+
	0h7PWaU9rC23aaHwrjpUckQ8G/Ljm8okR0sA==
X-Google-Smtp-Source: AGHT+IFc5Rjk43Q5CqfcR16hTCg/UaGxGF4dwCC5Wi1/pzTjKMkhoz07vwW5/85m/bp8Z0lui1opkNXUTT5E1CFGtXE=
X-Received: by 2002:a05:6902:2b86:b0:e72:bb4d:80d9 with SMTP id
 3f1490d57ef6-e7b6d32d2abmr15573514276.3.1747655458636; Mon, 19 May 2025
 04:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510031945.1004129-1-git@thegavinli.com>
In-Reply-To: <20250510031945.1004129-1-git@thegavinli.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 13:50:22 +0200
X-Gm-Features: AX0GCFujrUO4YL4JVjM2qtGxEaYPNjndTIDZUfA_94yabtg3vDTqmVEdIQdUrZM
Message-ID: <CAPDyKFq8evHyh_0QacZq=d36vXfrs3vFPsAuCyFdv3BKh0SP2A@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: rtsx_usb_sdmmc: add parameter to always poll for
 card presence
To: Gavin Li <gfl3162@gmail.com>, =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Cc: linux-mmc@vger.kernel.org, Gavin Li <git@thegavinli.com>
Content-Type: text/plain; charset="UTF-8"

+ Ricky,

On Sat, 10 May 2025 at 05:19, Gavin Li <gfl3162@gmail.com> wrote:
>
> Some RTS5179 implementations have broken remote wake-up, preventing the
> runtime_resume calback from being called and breaking card insertion.
> With the current implementation, the card is detected if it is present
> when the RTS5179 enumerates. However, card insertions after the initial
> enumeration are not detected, and a rtsx_usb_sdmmc module reload is
> necessary to detect the card again.
>
> The change to only poll when card inserted was added in commit
> 4dad599b8b5d ("Re-work card detection/removal support") to save power
> when the card is not present. Thus, this change adds a module parameter
> to revert to the previous behavior of always polling for card presence.

Moving this problem to userspace seems wrong to me. We should be able
to do the right thing in the kernel.

>
> Signed-off-by: Gavin Li <git@thegavinli.com>
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index d229c2b83ea9..246b0da1e908 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -30,6 +30,10 @@
>  #define RTSX_USB_USE_LEDS_CLASS
>  #endif
>
> +static bool always_poll = false;
> +module_param(always_poll, bool, 0444);
> +MODULE_PARM_DESC(always_poll, "always poll for card presence");
> +

Please drop this.

>  struct rtsx_usb_sdmmc {
>         struct platform_device  *pdev;
>         struct rtsx_ucr *ucr;
> @@ -1306,6 +1310,14 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
>         mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
>                 MMC_CAP2_NO_SDIO;
>
> +       /*
> +        * Some RTS5179 implementations have broken remote wake-up, preventing the
> +        * runtime_resume calback from being called and breaking card insertion.
> +        * In that case, we always need to poll.
> +        */
> +       if (always_poll)
> +               mmc->caps |= MMC_CAP_NEEDS_POLL;
> +

We should be able to detect if we are running the broken HW and in
that case, set the flag based on that, right?

>         mmc->max_current_330 = 400;
>         mmc->max_current_180 = 800;
>         mmc->ops = &rtsx_usb_sdmmc_ops;
> @@ -1419,7 +1431,9 @@ static int rtsx_usb_sdmmc_runtime_suspend(struct device *dev)
>  {
>         struct rtsx_usb_sdmmc *host = dev_get_drvdata(dev);
>
> -       host->mmc->caps &= ~MMC_CAP_NEEDS_POLL;
> +       if (!always_poll)
> +               host->mmc->caps &= ~MMC_CAP_NEEDS_POLL;
> +
>         return 0;
>  }
>
> @@ -1427,9 +1441,12 @@ static int rtsx_usb_sdmmc_runtime_resume(struct device *dev)
>  {
>         struct rtsx_usb_sdmmc *host = dev_get_drvdata(dev);
>
> -       host->mmc->caps |= MMC_CAP_NEEDS_POLL;
> -       if (sdmmc_get_cd(host->mmc) == 1)
> -               mmc_detect_change(host->mmc, 0);
> +       if (!always_poll) {
> +               host->mmc->caps |= MMC_CAP_NEEDS_POLL;
> +               if (sdmmc_get_cd(host->mmc) == 1)
> +                       mmc_detect_change(host->mmc, 0);
> +       }
> +
>         return 0;
>  }
>  #endif
> --
> 2.49.0
>

Kind regards
Uffe
