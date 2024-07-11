Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069B16C87C
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jul 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713858; cv=none; b=AtktH179gd4ICrLxp8QhuCIZ3okvj0j1U35BhYjc5FeaGK8mJCBqznTNxSP4zJqbbOFs7lx24xRKWQZv6EFwteT/94yhl5Znm9vYq01+i42XjNxBcaldqBHU53o2PkFT97t6QJjG6UKozPA52CBjW6JZCO2EzLXxbphfad8C+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713858; c=relaxed/simple;
	bh=jpbKiqH3kKUvMshKxMYVc4OVLI4AOxtAZ5oJiNPJbLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpDaoxI+YNJnUy1TflCfmDvp/3kHHjNafQP+S6SKFza97/XnUyhuMh2LdZCIWWgkYPmQXVI5fQ9jMh9njU8ZTKGhTqsYUkRBZivgs2TpPhLoFAPURU+io8GI0labZg22FBXLtD1DdXwA3LaYvhrWp3A0GM5S6eCd4zvXCw0hgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J4msgGtJ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4msgGtJ"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e057ae1adbeso777440276.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jul 2024 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720713856; x=1721318656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9bFU5vBShjHpyztO92AZLYt9Y5qSP92FmSsQShXmlGY=;
        b=J4msgGtJ5HkZcOrYe1q23lGOybkVY8z/eph6v7bXvd9fvN6q/5+WOWAltRkj95LgG7
         0Hwi8t4B9y288wcJrzW3+XGa+OByb9X0XzfHUL0bwnYUQ8LjuT11XvENDtjLzDoYgq3T
         ouoxoYJZldz4zmmy6WsS5Rn3UeMQoTyC8QZveEvvg1Ud10uANAPZYnUG2ozmr+aOw20D
         yZ1BoQxJeBJ8/VSpYhktPAibN2OOem00+c8uO8+yvOCupyFmB9Ziy0ry9UMzEgAHAhqx
         vtVlGW6y/EK1oIat+RLRkJ6V1TDgp1qMsEDcvjp4IOWLKWtpAn6NyJ/aCJrTpWEAYco9
         nu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713856; x=1721318656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bFU5vBShjHpyztO92AZLYt9Y5qSP92FmSsQShXmlGY=;
        b=kyIKh2xDSqQBEss1jOPvmmrUva6+wIOoA4cKSls19Np/6hscgRmxmSjD+SC0+czB0N
         J016eNrRPneIESBVzS43Qcm+0vzCptHdS1Q5xl9hYK0KzMicJpVwM6ZWDzFT4easer3c
         Ouv5nuniOH8z2wF9coWQFEEkl4OrQMIZR3WuwrelHX3VTq8CKfAQyhbpkVDD5V+zdxa0
         xkiLFETNq3ccEV+b2OACDU1qViaK+RtodH/o1KHkBxpjDi9q3HBYJnNSYy/YlU03c6C7
         z0Af1i2jeIeJVlLxfBTmMp95mKCC5oJampCa3ATlbj0Yk5nBqM/tuAsZ19nlOxdOwZhE
         E19A==
X-Forwarded-Encrypted: i=1; AJvYcCUMYxZo6BvdO+lgaEpq6ZhFKr52ZbH5F+roOk5HOPB1byK/LggRh53uvUHvu98O1c+RQDzZiNTcRATrDryZRbg+mmJqRUpG+U//
X-Gm-Message-State: AOJu0YwL0vzOd5fJOxvEeFa/1qam0Jfk4Ibsr28cbMgB3hVQHvkLJgTk
	CzEgjTm661Us5Tlp9guSu1iF1iznfwfep7mYIIXU14OwdrQ7XSHj9297Pkbu+CtG9wC0h6JE9+d
	RnL6dOG+X2cLplKExhDCHkFK3C49l5AsUJFEbzQ==
X-Google-Smtp-Source: AGHT+IE4d6cBzpPVohcjaR5Xa/utvEbwflISMEB60yRcirDYtMeU02JdhTCn2YMO0gfrY8BH8Vv2cw6mFvXVO8qUmgc=
X-Received: by 2002:a25:8041:0:b0:e03:a439:c333 with SMTP id
 3f1490d57ef6-e058a49bf93mr114250276.11.1720713856046; Thu, 11 Jul 2024
 09:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711081838.47256-1-bastien.curutchet@bootlin.com> <20240711081838.47256-3-bastien.curutchet@bootlin.com>
In-Reply-To: <20240711081838.47256-3-bastien.curutchet@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 18:03:40 +0200
Message-ID: <CAPDyKFr5X9+sL7y3vCrb3P0vXnBM_56GEzX+eD9zL12VRbh5og@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: davinci_mmc: report all possible bus widths
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Christopher Cordahi <christophercordahi@nanometrics.ca>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 10:18, Bastien Curutchet
<bastien.curutchet@bootlin.com> wrote:
>
> A dev_info() at probe's end() report the supported bus width. It never
> reports 8-bits width while the driver can handle it.
>
> Update the info message at then end of the probe to report the use of
> 8-bits data when needed.
>
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c302eb380e42..9cbde800685d 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1187,7 +1187,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
>         struct mmc_davinci_host *host = NULL;
>         struct mmc_host *mmc = NULL;
>         struct resource *r, *mem = NULL;
> -       int ret, irq;
> +       int ret, irq, bus_width;
>         size_t mem_size;
>         const struct platform_device_id *id_entry;
>
> @@ -1317,9 +1317,14 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
>
>         rename_region(mem, mmc_hostname(mmc));
>
> +       if (mmc->caps & MMC_CAP_8_BIT_DATA)
> +               bus_width = 8;
> +       else if (mmc->caps & MMC_CAP_4_BIT_DATA)
> +               bus_width = 4;
> +       else
> +               bus_width = 1;
>         dev_info(mmc_dev(host->mmc), "Using %s, %d-bit mode\n",
> -               host->use_dma ? "DMA" : "PIO",
> -               (mmc->caps & MMC_CAP_4_BIT_DATA) ? 4 : 1);
> +                host->use_dma ? "DMA" : "PIO", bus_width);
>
>         return 0;
>
> --
> 2.45.0
>
