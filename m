Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8C25DD0B
	for <linux-mmc@vger.kernel.org>; Wed,  9 Apr 2025 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203916; cv=none; b=ZxVwnEJj295WaYqaIVixzgnH/S0KoQLH+Ji7U0noS26bHZ5tlyjutkV3JMkHrD07KJpPY+nIOwBqfnW8w6g0zeCOUn+P4AIOvJfydtgFD0bw3IIeFnBAHL2/X0qk1Fc0gcemJ5PIawa0h5dBYuDYLBXwvSfhSci4bgncJW3lem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203916; c=relaxed/simple;
	bh=8qftagvfjmoYt1+fDk9WXpvjMtDWwgn0O2decNVAM3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtON0NtiI00VPVOhBK7hPPqZNbxvIdwS+jeVZ3ur+ezsJs+dGCz1UP2Kk3IE5g1t/jHtU4XdJ3My2ndZ+JCHJ3bZ8j0asNOnkQ7lK7kse43NOGXrQFVffyp8i/rC/6HnuoeLRPbmjnfFMPik2qrnPPLOPzOO7nbRhLahiIIu0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8I8sRHb; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8I8sRHb"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70433283ba7so17594287b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 09 Apr 2025 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744203913; x=1744808713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1d4Kj/+jBoQ/lsWd2+1iruPICBj1Kd2s6XSogc2V8og=;
        b=O8I8sRHboUes3ol5Jp//pRoUSmigdJdhN9DDk2mhfdvStKr0VZdCGU625E9e4z61Eh
         lQ7xf2D0uFz9jYwJS05l/MeakDRmYIvDs9D8JzTjHG6hoFhsx+kPz4+g1x9d4PwglWEf
         Sm2unEdOIOi+b8xQZa/7P6FcYKH52/7nU9e3acGBk0OUEqfRs4ZfEjo2OJKRnYuWuhRX
         n9zsiPQTdDi1Owm0Zn7I12/LjG6onMnIhB2M6ucRXcA/AvKX6aPGa6QdzKtV5z4zEKaB
         NT9vyFpHUiihUv9wUJzHy2DFf5pcGuvitohtH+UZtm5Qkgk/tWHnLid7n0KIJqczIDSi
         nrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203913; x=1744808713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1d4Kj/+jBoQ/lsWd2+1iruPICBj1Kd2s6XSogc2V8og=;
        b=AXHLwTavXPXDHx03OSqGaFEdKxVHDWLJd7vcu10YtlOcE4lQdRvLCmWCOEV/Vc9AO/
         /bH97h+k1GgYWgzd8T5q15v2YjVhl/teSZR7qjXTjJ4uvXMXNXRbcB2RTFNHzEt1Rj1c
         B/bX/5YZAnNW8JMA7VqU44DEdoER0XXc5AhlYbadLn4jDOfMyhhVvOB0RsPd/eac40Xi
         mtuFchGDoWpUc2tpS+obR2td+hUzKeSsoWhO8+A6c6V7t1+3CUdkOPaGOEWUzQqbE/3p
         n7u1JxOmrBTMqwqRbWrQ4KxESIxnF+qCv3M1DfUr20VwlWdPQeZNl+UPFDIK7rOWEDYD
         Jfcw==
X-Forwarded-Encrypted: i=1; AJvYcCVGFuIuUTGbSL0W0zTko7Y/nDj72hGW1lhA6oM/an31hXc3BSGTNHluRyoDKMYU3wbKdLXivwAWYV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyv/srIHvhGXjVGFIZVYOSfCtFnqDOLja4LBle5NcD/kxb5iHE
	bl8DDo1UAr94Qf9iuy2G32TD+BsrDTMEpEobmHa29Sj3dZ+tK0dO637xVkpWiG2HZ94as6MCVbN
	VMHPL0HUTYzGO2iTUe11zxeUrS1yc0SsqaZYNN6ZoxByfP801
X-Gm-Gg: ASbGnctWTdko8Co2P/YRXano304oap/wjPI6mRFmGvMpIKXNJnYomwr1sF1ASEnOtDb
	KE3aAF0uOTppRtcWt6dEj1npS0iGyAgcaI3WCQPFViteFjxArfyB/Bz384xqbmoQ8809Wyxicmg
	IsswbQheflnU3fRgOv1530SzE=
X-Google-Smtp-Source: AGHT+IEkEr688RqWZk/UFW+aFLhEVhnfHLhnS63mtOdasqviB60kL6L24sWq99KSc0ZiD+dQHcM2wGgQ6T0FmR5eTuw=
X-Received: by 2002:a05:690c:6711:b0:6fb:b524:48bc with SMTP id
 00721157ae682-705388d5192mr58242347b3.35.1744203913024; Wed, 09 Apr 2025
 06:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401025123.895307-1-ricky_wu@realtek.com>
In-Reply-To: <20250401025123.895307-1-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Apr 2025 15:04:37 +0200
X-Gm-Features: ATxdqUFnxqtQgEeY9G3rMVrdTwVyrrp85v3mAMPpR_PXa_Z9J8dJz3PUBElpDoY
Message-ID: <CAPDyKFpn5xB50eTomNM=4LbFDX4r154iY2Qk8GBiYb+vor0kbA@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: usb add 74 clocks in poweron flow
To: Ricky Wu <ricky_wu@realtek.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 04:51, Ricky Wu <ricky_wu@realtek.com> wrote:
>
> SD spec definition:
> "Host provides at least 74 Clocks before issuing first command"
> After 1ms for the voltage stable then start issuing the Clock signals
>
> add if statement to issue/stop the clock signal to card:
> The power state from POWER_OFF to POWER_UP issue the signal to card,
> POWER_UP to POWER_ON stop the signal
>
> add 100ms delay in power_on to make sure the power cycle complete

Why 100ms? That sounds a lot to me?

Is this fixing a real problem or is just trying to better follow the spec?

>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index d229c2b83ea9..e5820b2bb380 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -48,7 +48,7 @@ struct rtsx_usb_sdmmc {
>         bool                    ddr_mode;
>
>         unsigned char           power_mode;
> -
> +       unsigned char           prev_power_mode;
>  #ifdef RTSX_USB_USE_LEDS_CLASS
>         struct led_classdev     led;
>         char                    led_name[32];
> @@ -952,6 +952,8 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
>         struct rtsx_ucr *ucr = host->ucr;
>         int err;
>
> +       msleep(100);
> +
>         dev_dbg(sdmmc_dev(host), "%s\n", __func__);
>         rtsx_usb_init_cmd(ucr);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
> @@ -1014,6 +1016,16 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
>                 unsigned char power_mode)
>  {
>         int err;
> +       int power_mode_temp;
> +       struct rtsx_ucr *ucr = host->ucr;
> +
> +       power_mode_temp = power_mode;
> +
> +       if ((power_mode == MMC_POWER_ON) && (host->power_mode == MMC_POWER_ON) &&
> +                       (host->prev_power_mode == MMC_POWER_UP)) {
> +               host->prev_power_mode = MMC_POWER_ON;
> +               rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0x00);
> +       }
>
>         if (power_mode != MMC_POWER_OFF)
>                 power_mode = MMC_POWER_ON;
> @@ -1029,9 +1041,18 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
>                 err = sd_power_on(host);
>         }
>
> -       if (!err)
> -               host->power_mode = power_mode;
> +       if (!err) {
> +               if ((power_mode_temp == MMC_POWER_UP) && (host->power_mode == MMC_POWER_OFF)) {
> +                       host->prev_power_mode = MMC_POWER_UP;
> +                       rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN,
> +                                       SD_CLK_TOGGLE_EN);
> +               }
> +
> +               if ((power_mode_temp == MMC_POWER_OFF) && (host->power_mode == MMC_POWER_ON))
> +                       host->prev_power_mode = MMC_POWER_OFF;
>
> +               host->power_mode = power_mode;
> +       }
>         return err;
>  }
>
> @@ -1316,6 +1337,7 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
>         mmc->max_req_size = 524288;
>
>         host->power_mode = MMC_POWER_OFF;
> +       host->prev_power_mode = MMC_POWER_OFF;
>  }
>
>  static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
> --
> 2.25.1
>

Kind regards
Uffe
