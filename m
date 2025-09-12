Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79909305948
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678438; cv=none; b=dYs2y1h/zPK54zqsqlpY0D+DCywOnmrnW0bSQ8Vakf8YxJQXX+oNX4LDjeKFGNjql1drXF+PBhxsr4eJ5nvooSlWBJEhyNjiafdXbJoP7m7nOsp5JG/39Fx9ZHl9nAj4ffYtXjg++BL8abosMzD3+FHtpDzlk+tp9mNfJf6eaI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678438; c=relaxed/simple;
	bh=3nTc43UfwhDlB5f2y+NhzyfRNx+d7QAFQony5HWpITw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7TWkkD5QALLMu6purfiXtwCcowdENN3Cwv45447PcLGYppOw/WJDSNIwg+C+lkolAZk3hT6Aiz5dCrNo/8okHnsJk2vQj0l0VsURdcWaVxkKtKerNVJyBjrSaIaQJDYctcyysQpp/n+mBjhGz5JfqdhZL9IV+ig6E69zcXYme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eY0x7jbQ; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eY0x7jbQ"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e970acf352fso1308182276.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757678435; x=1758283235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oLiQpVNuEuebFxLQdOc1EYSB2MXN5lx5cNF3hHLl4U4=;
        b=eY0x7jbQKkJHlZCiNZKaKhsumnvOdxfyvN8zZNgbuTO3Cz1k9EThAFwXoNX7hIn5NI
         pyGeI7eVgG/i4ccTZu1IDXq03gTZMpLXaZkNv+2TwoC9k9hxi9R1fqI84hvDss36HICF
         BEfmC3lSR1gJ/1Ttmoj5ykaOCWhS0UHAfFfdObAU5VEg7KhKA43i/0YE/7j0n16kGKkg
         hOB+NFLwXBszc1FoI5+/zeyGPj1asJr61XEft29AnVPUHndUgSZD4xKDtlPhONP9vvXZ
         p/+QWsWMRPQh4gI0KY13es5UjaE4zR1ymKwF9/Qt7EysBIrbojK6/sNJTXiDp8C9pK8T
         OR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678435; x=1758283235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLiQpVNuEuebFxLQdOc1EYSB2MXN5lx5cNF3hHLl4U4=;
        b=sx0URcE+Nq9wBgFkG8lPlnvhqeHzGn3Nk6CtsxeTbpVvESKHwPyIqhiiQEJJmx5FYK
         ZmpcSENlA0jjxQUBk7rLBL3rUjzrQlYHDYZEahI65imK2vws57wYqPINxG/ImRFTpH31
         CtR+VE7oFyyT+akWOT1e/B8rmNWbiRXvkAJgyFfBB6mo6TfMm25toiRsJUwHaVyFSUyO
         Gv+YIp4CrfXjbpSmu/R8aLlQXbE+QPNBeFcK5yZ9FRtV8KZLOVbmOQSI3sp2U9y6vllx
         P5/2M8qkEV6ze1kzJ6Jmp24mv5MF6YeXqBsbrNoZNtsNxqISz7yrFK3if0xvPJ/jA/2/
         3oIg==
X-Gm-Message-State: AOJu0YyXTDbJi5NX9yBQ/nLyVlHmxR6VVFF4jxfL7Chxmt/8rkuRgeE8
	92ynqiyV+BTuGtBoLCI6PpSqduxKYF+B0hKMzeOYzBQSpOH9R6b5cd6HEwpSN62pyvSoqZOuNX4
	q3rWsNbFDHjv/1KO+/7VJ4U2KChTK4AD9JG/A3xGgBbsIAkJfBTUOXMo=
X-Gm-Gg: ASbGncseurKw6uUxE/Cvunhhv9o9X+I/fQOrAZ9muUstVqR2cYgIVlTRHAoVVNbUBkj
	DqddJEI53rq/L76ykzmBPXwl6qSV67ytbUwYPyuAvaUs2vDnWiG64mQ4dCGcKts9o1VepnrdJwQ
	O13EsSax/cdheI2kCaEO6xR4Mu/CnK2/V9x93HAW3NuHc0x51GeH8lreO5J8t+zi25BCudrMc0E
	2RCf84q+dHZd7ZqvXQ4afsI1rXeyg==
X-Google-Smtp-Source: AGHT+IH+6wqg6UNyPtF8tZNJMg+eV5hNZORK73XhPqDp0LpwjPrdP3ELaOWiY6CFEMl1VPhYQVDgY8aGOqflZgUshaY=
X-Received: by 2002:a05:6902:6d15:b0:e96:db07:d089 with SMTP id
 3f1490d57ef6-ea3d9b2a922mr2027292276.46.1757678433465; Fri, 12 Sep 2025
 05:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824084736.172222-1-dexterkidd@gmail.com>
In-Reply-To: <20250824084736.172222-1-dexterkidd@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 13:59:57 +0200
X-Gm-Features: Ac12FXzLr-UtKMT28C14ksII7Ik-ryV3tsFAX_VnYurp5OzAJyd_uWPKuOGLBsg
Message-ID: <CAPDyKFpobot01WBzvMUH0_85aUELhtijF9Yv9giEJSworObnbA@mail.gmail.com>
Subject: Re: [PATCH] mmc_spi: Fix cd-gpios for SPI SD card insertion/removal detection
To: cuu <dexterkidd@gmail.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Aug 2025 at 10:50, cuu <dexterkidd@gmail.com> wrote:
>
> Previously, SD cards using pure SPI protocol with mmc_spi could not
> reliably detect card removal via cd-gpios. This patch fixes the issue
> by extending the card alive check in _mmc_detect_card_removed() to
> include cd-gpios detection.
>
> Additionally, mmc_rescan() now includes a status probing function
> specific to SPI SD cards to ensure the card state is correctly updated
> on insertion and removal events.

Sorry, I don't get this.

What is so special with SPI cards here that makes the regular card
detection/removal procedures not to work?

Is there something wrong with mmc_sd_alive()?

>
> Signed-off-by: cuu <dexterkidd@gmail.com>

Please use a proper name for your sob line. I assume "cuu" is an alias, no?

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 15 ++++++++++++---
>  drivers/mmc/core/core.h |  1 +
>  drivers/mmc/core/mmc.c  |  8 ++++++++
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 874c6fe92855..e028ec8fbf46 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2123,6 +2123,11 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>
>         ret = host->bus_ops->alive(host);
>
> +        if(mmc_host_is_spi(host)) {
> +               if(host->ops->get_cd){
> +                               ret = !host->ops->get_cd(host);
> +                }
> +        }
>         /*
>          * Card detect status and alive check may be out of sync if card is
>          * removed slowly, when card detect switch changes while card/slot
> @@ -2238,9 +2243,13 @@ void mmc_rescan(struct work_struct *work)
>         }
>
>         /* Verify a registered card to be functional, else remove it. */
> -       if (host->bus_ops)
> -               host->bus_ops->detect(host);
> -
> +       if (host->bus_ops){
> +               if (mmc_host_is_spi(host)){
> +                       mmc_detect_mmc(host);
> +               }else{
> +                       host->bus_ops->detect(host);
> +               }
> +       }
>         host->detect_change = 0;
>
>         /* if there still is a card present, stop here */
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 622085cd766f..5b48c50b5bb5 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -78,6 +78,7 @@ void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>  int _mmc_detect_card_removed(struct mmc_host *host);
>  int mmc_detect_card_removed(struct mmc_host *host);
>
> +int mmc_detect_mmc(struct mmc_host *host);
>  int mmc_attach_mmc(struct mmc_host *host);
>  int mmc_attach_sd(struct mmc_host *host);
>  int mmc_attach_sdio(struct mmc_host *host);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5be9b42d5057..e73de34e072b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2316,6 +2316,14 @@ static const struct mmc_bus_ops mmc_ops = {
>         .flush_cache = _mmc_flush_cache,
>  };
>
> +/*
> + * Export function for mmc detection
> + */
> +int mmc_detect_mmc(struct mmc_host *host){
> +       mmc_detect(host);
> +       return 0;
> +}
> +
>  /*
>   * Starting point for MMC card init.
>   */
> --
> 2.34.1
>
