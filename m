Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842B242927
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778713; cv=none; b=VBQcHOUhnQYQX53MUyer7lL6/KxSE09biSnsnFnrp29rfjg5e3LS21AsOcDHT5VnI/sZ4PhF/gsM5qyuOeu30BT/1H6uJO2Rrtq6DOsL5RmF6IaDmKECtC+fNrT1CXpVCfcnGTyXR5rimJpLw1flx5MYJ+ic/kASj7CBuQxUJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778713; c=relaxed/simple;
	bh=eMNaTVBD2fqB7ySPwtZP5MF+Dv++loMYLDhZTXVl2YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rq3yciKBh/d09dyT5ZjuciLHCSAL3K+XhtM8DOqFxKqHjBaD+qh/T1BP7geBfzWnedW8V7Ff3INJFiaNKWqJ/LG2y5E/EOhv8p1uNJriv5JIXbAhKzd4QcZnOinP+12QJfXHmwRvDtDgcI0pvYrOtS5MnwEDt4/FoXUiApuclOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ob4YJLUx; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ob4YJLUx"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6febbd3b75cso53994717b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778711; x=1742383511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j0IlTDOpzy4lszv7rlsIj2CbW2c2EXejHnSETwmF388=;
        b=Ob4YJLUxqqsBGEtSJa5wOyUJHwqEfX3GbPgtif+f29J/KJEbYrUCOmcaNR+pTQONz2
         CMEYlkDznLu78nMCtlGbcF3UVEgB6TihB48qTZP1zMmyVXd5Q7YjTcgPaRsGijEtMH3n
         zvRSmolLQAHec8e72/FTmkqW42TTVdW7SL5MVBzpEf0ZKFjgNlB6FlcreQq1YFqH0gHw
         GUFIpwraJpFz7Y4fRaJlNpqzklVSZc+ESoejUhk0CHb/diluefH8hySw804kVjiQXahZ
         OUGHR5Maf6RX2BptNLCil7bq1MHrKwfBbTFeFRmgtOiSVipQiG5aNlRZdF6iBE7TGQ4D
         V6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778711; x=1742383511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0IlTDOpzy4lszv7rlsIj2CbW2c2EXejHnSETwmF388=;
        b=RI2zhkTF8N2NQIrLOtSMPUBeUanz5tJKt6RXc4GOPDl33i1caLhUrD8E4wzNzVDdyy
         rSjnqjwuE6c4kul3IPMRx5h7ZAqgbpCAx7vCRDDFCyMEWioywHRLasgfjAQTZ8s4RkV5
         VwOs01d5lZ/7p2xUgXA/jQorU0Et72ikl8+0fToXrkA7HPXf5m/g0oeVX1OfsqF3AFNl
         Z4gRqyHVGt5+rypnVsGA4PmYMFX39cFZ2cXhTZJimiXp4IfF958z2pg24z6Qhoa69nRs
         EmQhMNI8JZdLCXGkcfIi/T9iMWad9GTZ3Pvc09cVE0k4pYDKHEduI6yuqf2LTs2/xTGu
         VZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXfiV/yPd0HdPyxfkgXQa61ZdraZldUHdKMbPXTd1EgDhsPFYXVZgwjkxu2qVQjB3r+ekdK1yLDMKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjuVym8jEkjmIELfK/8CNhpGUZHE9CX+dSiw3MMiJEvyDOX4o
	vt3U4RJ5mRArFc/YjqOncqDISzobtVVzp8R9unZZJ6WSvOwwJtLZHunaKj3SvuXpdi2U0r6gzE5
	QLvijLhFiUWfxAYsbKRxlykl1/EezIphgvf8c6w==
X-Gm-Gg: ASbGncvaZDbZnzNs69+upwvSn6Y2PsoCjt0IKwe2P7aPma4WoWB62LtzUqP9KsA94HL
	FcYVDGe6Yrg6JJELEO8E/BcvcXSd3UCnofceuOX9pTk3C93rcHwyjUWUqlfLYOyS+W2isHpreXx
	v4UIIoC268O1+Wveo5r4+yPjAaqm4=
X-Google-Smtp-Source: AGHT+IGtrpMRNM5pKWhW8HbHsUTbWskTVMFFv0bNbb8Q5i77eD95h1GkPE0yUgoUnQWO+Vh/tQK1NcyuMiJXHltawPk=
X-Received: by 2002:a05:690c:3706:b0:6fe:b88e:4d82 with SMTP id
 00721157ae682-6febf3c011emr268595337b3.28.1741778710783; Wed, 12 Mar 2025
 04:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225022856.3452240-1-gubowen5@huawei.com>
In-Reply-To: <20250225022856.3452240-1-gubowen5@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:34 +0100
X-Gm-Features: AQ5f1JqF8L87qOyyE1uiiOuDOx6g3k6bEVklrzfSeQy_O2wo1fZosXm-g9B9O0o
Message-ID: <CAPDyKFo4K9H82Wbupug3Str=18ekkrwjxQxSmw2-1eu3FZQwfA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: atmel-mci: Add missing clk_disable_unprepare()
To: Gu Bowen <gubowen5@huawei.com>
Cc: aubin.constans@microchip.com, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 03:18, Gu Bowen <gubowen5@huawei.com> wrote:
>
> The error path when atmci_configure_dma() set dma fails in atmci driver
> does not correctly disable the clock.
> Add the missing clk_disable_unprepare() to the error path for pair with
> clk_prepare_enable().
>
> Fixes: 467e081d23e6 ("mmc: atmel-mci: use probe deferring if dma controller is not ready yet")
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index fc360902729d..24fffc702a94 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2499,8 +2499,10 @@ static int atmci_probe(struct platform_device *pdev)
>         /* Get MCI capabilities and set operations according to it */
>         atmci_get_cap(host);
>         ret = atmci_configure_dma(host);
> -       if (ret == -EPROBE_DEFER)
> +       if (ret == -EPROBE_DEFER) {
> +               clk_disable_unprepare(host->mck);
>                 goto err_dma_probe_defer;
> +       }
>         if (ret == 0) {
>                 host->prepare_data = &atmci_prepare_data_dma;
>                 host->submit_data = &atmci_submit_data_dma;
> --
> 2.25.1
>
