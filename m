Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056EA26461D
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856252; cv=none; b=pcGzVONe7+PjgM3m4Jcl7QaDiEqSeKlNrylrv1dBQyx7l5xxfL/LNcWFw76b7HdbbQWK0yQaLgKrF1G8SIdkuVGzE+1LiOLTU38eG2eX4XK8tZd0Dp9Haj/mjYFIABXGht/ktfKDxdHyGpPrZczsFsybo5qfv0pIpP0u6UXzkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856252; c=relaxed/simple;
	bh=n9nMjXj5N7YbH/YIEdnaR3tVJ/pE4C6YOScPgM4/JTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skaDjypvSfx+wkI9s9coewGAMXYkxeupSuEufTvUoLzmpxezFg6hKKu79+EmEPTxo9W96iFjiv9hcqWoOvwxxKjGmO1uPQgd535OMIWxxUMbL8wcPz+DrrJC4Jf7rw10fdjYAS++UdMa5ZX9p7w9N+9vTtBMpVO3+41v+htvyCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KbACIsBC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbACIsBC"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ff37565154so42331397b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745856249; x=1746461049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UE+VSRR0aXVCM7DlA3pHcqbSvtI503SMsUXnenx1czY=;
        b=KbACIsBCW4N8eC6OCZCi1uf+M4J/xvMU29o26xzoV8aBnDAoohNN/b3hppTmMKH1jk
         VqIOwf5FhIMX99p1d1b+6NjlhzBmBzmmtLRP13vDh26X/cJ5u240vkt09FBSP16U9SfJ
         rQxMvGfMAWKfCz1WL9d5f6DAayWyenCXyh3R9y1IvgxcS7thCm0z1fazPxLBU2xcDJTO
         oTVihCzh9QSN+jHP4ZGOoX5/xi9KjjUfOVP9xheCf8cf+OO9QeQQP3X/pWaa86dpSEsS
         C76z8RTmZm8WhCkaBCKSJaomqP/nSJGsjy/WEpr+AE+8yW/O8hxgu8SZSiQYPyC3JAs7
         DdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745856249; x=1746461049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UE+VSRR0aXVCM7DlA3pHcqbSvtI503SMsUXnenx1czY=;
        b=L/aBjDZ0AIxYR7og7WzNnx1h99ik5kvox2qGn8NiRZfEq0kCvzuL68sqBIxkFI6B7U
         cJZL6fwNVekrZSQuCnSyOd5/LFsJLA1EU81WXGGUXWbfmKZGpIIMf4TX1PSmjFHMjfDf
         08KC7qhx1u2DjfuTpnEKJZDPUUiKthN9cdNSElc9zxWmpTMdDzhqHIBegLtG6/9dxfYX
         N4IvsRLnld2/X2FPGuF9EYuYBPmIxEDidFNOqDUTvCvZCqvdshh6jVAj9uN1oqAfuwln
         83HUa+x+jiA6ZHxtOF70Tuaxy65wyGdEeDVXylhMbCKhZPfNZQwJGn2lrV/mRxtFo8Ck
         VG4w==
X-Forwarded-Encrypted: i=1; AJvYcCVs/wyu2DRmB+l5jcWwpmZ2Hvm1YCUpwU101zTC/q06wCVBaignjFK9JkQctas1gF3HeJ8VLTaie+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7opDgaxlIYaQS3pI2KdH7b2uClLeyIp0exdTtIaksJkMd+nCj
	/OxEtmDPyst5r2+OERp/CmH2yZW6cNQb7mx2hUJnAtb64ZwExdM8CjVqrHaKKlqJaaZeX9DbEai
	EN4uVh2fk5rmVRWlojuMxbpBB27TGwC9c0CpofA==
X-Gm-Gg: ASbGncuSLkBGnK3dCfGekr3xNl6Qy382hOvgXY7h9h223LIT8+iTPhMkyDVDzLMY+pI
	gfX3miKpqml5c14bWiya7dRkOHfXhXSxgW2zy9YdawVeJBsmSgReg+Np944cNr7RUf1OSkWI1Ql
	58KiLepq6KovGBu86Tk8YQrJE=
X-Google-Smtp-Source: AGHT+IEe4e2bKMFH0Qv5k3UUQRKYS6KmIrckAv/PjqanYs3vBSyVeHEKf86JYrl5bWILrTc4mS0WghsuvCu1JR8ll2g=
X-Received: by 2002:a05:690c:25c4:b0:6ef:77e3:efe6 with SMTP id
 00721157ae682-708540eef1dmr170780547b3.13.1745856248608; Mon, 28 Apr 2025
 09:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421030008.1172901-1-ricky_wu@realtek.com>
In-Reply-To: <20250421030008.1172901-1-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Apr 2025 18:03:32 +0200
X-Gm-Features: ATxdqUFwOwlNfhzPJm5VwumsYDWg3s2VDAxHZvJ-wfkZ-VH1KiktKYebpg-39fA
Message-ID: <CAPDyKFofMbf2bfBVZ+3oH1N6rjstfF4NuSJRJOVSHPLqdX9hXA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: rtsx: usb add 74 clocks in poweron flow
To: Ricky Wu <ricky_wu@realtek.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Apr 2025 at 05:00, Ricky Wu <ricky_wu@realtek.com> wrote:
>
> SD spec definition:
> "Host provides at least 74 Clocks before issuing first command"
>
> add if statement to issue/stop the clock signal to card:
> The power state from POWER_OFF to POWER_UP issue the signal to card,
> POWER_UP to POWER_ON stop the signal

We should never go from POWER_UP to POWER_ON. Perhaps what you mean is
POWER_UP to POWER_OFF?

>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>
> v2: remove delay 100ms in power_on
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index d229c2b83ea9..1edfe2acf809 100644
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
> @@ -1014,6 +1014,16 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
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
> @@ -1029,9 +1039,18 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
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

This looks unnecessarily complicated to me.

May I suggest you start with a patch that converts the current code
into using a switch-case-clause and just check if ("host->power_mode
== power_mode") to understand if there are some actions you need to
do.

On top of that, I think the change you are trying to do should be far
easier to implement. Can you please give this a try?

>         return err;
>  }
>
> @@ -1316,6 +1335,7 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
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
