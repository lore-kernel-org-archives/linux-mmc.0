Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA303E3C74
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353005; cv=pass; b=KokKOJLfw2+KCbddB844AqV+DE+TsqNHS+ZlK+Jjfh4v0L9VZKEw9SQzTod7NLEg6PGl0aVMOtTc2t1JEHr93DxymceyBdfa5VkZH5D/jBU+qs+MqdrV72nRX+XBumgB/x0r5dzB6DF/tApfHNEyOlBvwsKcWpgC6bxfe6qTOpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353005; c=relaxed/simple;
	bh=775HUwlrSRES/j6M/bV81xb3CXFpWjhRl72V1BIvh/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwasU0UKUREDIs9mJUYF+1KZS4oXg4O3neggRqr/t6JL1FSXNusj1CRtzo7S2NH9OElKLDF20SP1zKV5JMKVYfQrq5JPsLQMxQVkpdb7q5H3+yBNqyzOj4n56CjQgE0HYWR+4pI3v1xMGSBQXn57Di4TynmRcEew6cZyATbeXZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MHcLwslp; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHcLwslp"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a1443780c4so5084424e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 04:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774353001; cv=none;
        d=google.com; s=arc-20240605;
        b=bPg1YSPdXFXlyoajmgt7XiEYqCmweka+9h1z8cNA28AJsReW1NoEaNB6frj9rRix41
         bFityjHgXZ0iZmpHWqaYHdozy8QCF+KZ0yOXkPMAMuY7aKYNOCJ/99WHKDwIsKMXss3m
         wAfc/qew+QcTAomXqxn9h6Qyx7GCehTaSXpSoS2yf8cFwPxnFYeRdG+gvYgEdwXFlXeS
         UQIXMIrwX3Gx3Pv+bVAGCjpTuHv5RSARJpGuGHaBqkA6HaFDy3+gRrRm7LlI0/qpbppk
         NLFCU8cd4fE4NASwtr7jRGWmZCh9R3MVrYInXHs2CDz7l2cMUOsTslLXczpH5ByKP6lb
         ujHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nMk48KIa2xRXF6fedPuomwys/goMY3HhmNPSrFLUhAw=;
        fh=NTAE6ejlPIdcKpnBqPkof5O30i8sOOs7HwZysRG1Mi8=;
        b=HFcqoKfEG+nJiGLlRq8s+MajZzPqQu9F5fWsv9CJWa00pwFPl1Aed7PCJtff2t6dZr
         Yaemjc/4IB9bjgodsDWbqDkMH9qzd690XbR8e+0R93ymr1j6kz4o00CNnYE2f8GQSiiH
         2OBYTt1i651CHDbCniVHgF1NZlqhboKgRqIk0fYqE78wXjCbaEJ3ch7Wtmrpy+m15qxI
         iFYfWqumqaPVqMH4B9y4pWXGFQjVhZIsZs9H5NqipqWsiEFzRRJ1EQV2XENxLag/MKZ/
         TE0jt0APCOkWVb1A89s4w200o44mTqQagOqKdMPcHriLT41O6PZPpog4noqrUafIl6Vd
         f+JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774353001; x=1774957801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nMk48KIa2xRXF6fedPuomwys/goMY3HhmNPSrFLUhAw=;
        b=MHcLwslpOmAQeBQCIIT+NIGOz7IhYyJxJTP6Yf8SyuJZ+FTdsKBRZcCBXVPNrGV6lB
         Qihd6f8BJgpAH8Bxq7a5eghZlWbU4l1kfra2mGuk1E6/iEcP0SvDbKF4PvWQ1MLItdZg
         NLI1RiR/iuh0cf0iCdevsIPyuD6LsR+qE6G/vjhCDrRbRjHABqEpI7ansVtw8HhbuXjy
         w7cyB81t0u4Knm0mXihbuVUA8V40PxKU6LRkN9K36nF371cbyKnEsJB6qCTZc+Qr6IzO
         IU6ZWoGGI6oSNqr94nvaRPF5xqj+/dMfAxuyebaVHbKSJMLvh1+cexEovBaK8XVaHJSF
         Wu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774353001; x=1774957801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMk48KIa2xRXF6fedPuomwys/goMY3HhmNPSrFLUhAw=;
        b=lPV/dFXXmpIIznBmxuM9ACZKauFXv/WiXe/SLCmgYGEhY1x3K5H8TQmQuB+DLx/h5G
         OYPD1VjJBfsx69OC+bXN3I+s9IJqYptTFf/3YP/Agxb4zHEN7dUaIxU1U3gd1Gx+DQID
         ktHcW42PxN0rPT06+PWJcRY1+gOPwNS31+CPlbXUksWr5TseJ/YPEhCsEpFG+kE+t5U1
         hCbk89juR/jm2WAoYK6JTRQ25l1qeQ6uB4P+w9ZTVF4+p8w4KYKrLy9+EGyQgp05ORre
         aSdKxLXbQka6h1GKHwEJiz0N8f5SgrnUy1dNKs27GTcQnWLLjS/8C1Qg1zJezlqpYYeR
         m64A==
X-Gm-Message-State: AOJu0YwR8Y4sanbINeypR+BJtyuH/A0HpYBslFukzC7u+Q5zv0STfa8I
	d8KrVAnX16XhGQ695sVlhWYoM3WSIcSTeaU6XLxTsdxJFs+YbSZJy2r/fdY4majjRq90ZUHqbWa
	3inNjBvrLLQSH1HC4nzPw2M5mwVsB7lMLvP5+IjoUdQ==
X-Gm-Gg: ATEYQzz7Gxp99dFSJ+/RiVqCumpNgj1G2RCoisv42ebjX2jsL85bY81o3eH6Jf6RLv2
	YxrDbOaPaUKxKjUNHPoQ/pS/7gRSz4AvUjzEHIpuOUSpK+UcjMrWdhwkkqK1JoKTrA2DSp04dQQ
	j+X4pBMIYfzTvTEWrTA/711Gb/9vAB541ZG2IncWqrNPvoBeOpl1KdDBPtryWsHOaaRdaoQQQ9t
	DxEuYAyl2FsMqOINTemf4SgEYZBHRI9l4vOen9uh9itTbNsHT1Sb8Yfdfzc8EgOPoNSsiQQigBc
	IQhiLNzG
X-Received: by 2002:a05:6512:3d20:b0:5a1:2e7b:d885 with SMTP id
 2adb3069b0e04-5a296220848mr1149126e87.25.1774353001431; Tue, 24 Mar 2026
 04:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-4-sean@starlabs.systems>
In-Reply-To: <20260312121559.19197-4-sean@starlabs.systems>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 12:49:25 +0100
X-Gm-Features: AQROBzCvflFLVCTHmicOB9bJ2cR2c86kKX_8u4sToGr2eok9SvcL_p1sTLWvVWI
Message-ID: <CAPDyKFom6TVhBBXf40FMj=bBHM8O78JKv4SMB2Lu=_=z0RmyMQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 3/6] mmc: rtsx_usb_sdmmc: advertise UHS SDR104
 and DDR50
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ricky Wu <ricky_wu@realtek.com>, Avri Altman <avri.altman@sandisk.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Mar 2026 at 13:16, Sean Rhodes <sean@starlabs.systems> wrote:
>
> The rtsx_usb_sdmmc driver already implements UHS-I voltage switching,
> timing setup and tuning, but it only advertises support up to SDR50.
>
> Like the old rts5139 driver, also advertise SDR104 and DDR50 so the MMC
> core can pick the best mode supported by the card.
>
> Tested: Realtek RTS5129 (0bda:0129) + tray + Lexar 2TB SDXC
> Tested: timing spec SDR104 @ 208 MHz, signal voltage 1.8 V (2026-02-24)
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 6be98926387d..8d5ebe92018e 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1487,6 +1487,7 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
>         mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
>                 MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
>                 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_SDR50 |
> +               MMC_CAP_UHS_DDR50 | MMC_CAP_UHS_SDR104 |

Please drop this patch from the series for now.

My point is that the series addresses enough of complicated problems,
so I suggest we start by fixing them first before adding new
functionality.

>                 MMC_CAP_SYNC_RUNTIME_PM;
>         mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
>                 MMC_CAP2_NO_SDIO;
> --
> 2.51.0

Kind regards
Uffe
