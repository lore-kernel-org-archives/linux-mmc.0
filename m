Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68292857C6
	for <linux-mmc@vger.kernel.org>; Thu, 10 Apr 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292722; cv=none; b=p+7imaflvU0dDT6gM4HYqPebJ6r3PMzjoBdHrRh2iCpKsoFaSjmp+G2ZLlXBJXRH5jo2utUOhOnBBXAl+CNSpc9NxfGpwF2OsKHk+RiSpuQrM68AOzPeqHsO33QhW74oVf7fbinOzopWzEukKV6eoaPsecQ0mJ7SvdSJ10S8Nwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292722; c=relaxed/simple;
	bh=Qy4A44c/RUvu7fFmy6yUlwQUkMFAn0x5PmE7E9huMpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shcOQOFFrTmR1FzTMRRN9UJ0s+NciOMK25Z62q3wVCuotasZ8h56VMv9OPa9iK+Lf4fb30vM9D2Bpgr7u9HnyboGLj4gMeuyqSyaTENikOYjNjXvAhlENwh1GDYcie7s5KlKKfPqX7QW4gawai9Zt1D6i53SEHm6YSsSIjhG+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wSOXgyJL; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSOXgyJL"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fee63b9139so8242347b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Apr 2025 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744292718; x=1744897518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K+ML5+lZkclfARYXwoJaLLimWYhbRg0TFmxZrKOY/4A=;
        b=wSOXgyJLD8DeFcpCJ7O/GkemrQ+ymByDbF0VdSsbQZlp+9syoogW/RsK16pGhgEh+q
         l4WShOVOzWbR2abM0Tb51RjyYMdyQ6Juzt/NC5/ttuI/M56NgjWbie6WGG/IuklQqBE0
         iavP6pQQS32zKtCRo1GSdbmHGN2v/YPksjilIKsLRyHxxA7agcIfOilq7LLSyWw6DhL7
         IJvcMOLgpHqHWl2IeSSGrnbscKzeOmwq4/43+5qc1Dq1kbGpgj5870KMK+mbMQEOMRnM
         pbSRKZDaonO6gxQCGIfhH9ZzpNT53eii3CtIZBIKDl8ajcLQ/a+TAZdCtO73e/fA8ZHV
         LGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292718; x=1744897518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+ML5+lZkclfARYXwoJaLLimWYhbRg0TFmxZrKOY/4A=;
        b=uGRS1Tuhm7t3ol31SoH+yzk9voD+DjxC0t8FTSElqqFcECbir2uBv3+EEFz0l80IaU
         xOPmRwMtbJmTHAsVaxirmhPFdHes8rVt7KqFaztoA6xO/b1AlH52yqa+AC6iflabT55b
         /TvxiP79IfromZYiw0BaIZyNG8CfLrLOnAjefvd+r7FoMrTlN1btOGP1tGHrpoxUEEYY
         L6Uh/c27valILPF9VQQxXk9xaUTwPFPMotVQ2Z0ta3a7+chrWv12zDrBMxO0D3kHqO8d
         t8zJ8ZTWmbx9E+PkHjjJamfU20HSYNPiHg0Bm40h4WRq4kqPy/lcWK1e8J+hMIneBg7R
         wOgw==
X-Forwarded-Encrypted: i=1; AJvYcCXz2LLwsKcMk/AHZzCm0HvBC1+KH18iUWcBAHL42r5J2CQLcmftzrYIp51ZuKt5p9ITDBU1IlJkZp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBbv85UYGbHWB4AMsRBJ4f7f4ARpEciNVY8K57fzTG+VzKWVB2
	nbTSSkhm8lOfKTXkF/fYPhSL9qPjfQ8lG1dKbNY6Xb6bN/rdjRPCEDB1Qs/8koKGrMZAhbFWx9+
	R+5nhMNswZrdUFUFgZgQvnA0nkowZBbI+vtQIbA==
X-Gm-Gg: ASbGncsJ/e/gi30WiG8WNiI4CWilteRdOl7tEfEfvP30+UIYHGMO5TPuKxVylwY1Z44
	A+5OMEcDgsM6sy3+0QrXH6ClsTvVIz3+weVm+2q2/OQt2/J6IOsKEmCJKSBqQCeMJXinPNz+TmM
	rEFfMWG61Tz0i3OrSym4CXtkI=
X-Google-Smtp-Source: AGHT+IE2qGO+aWnlhjPQiT/O43/hZDTamK5QL+DvU9HYVV80mmAiaWCo3u69VnRe4rEoCDGKj9VAlvn74x4/vc9IqS0=
X-Received: by 2002:a05:690c:7485:b0:702:66cd:10be with SMTP id
 00721157ae682-7054a13ca7dmr46930657b3.14.1744292718557; Thu, 10 Apr 2025
 06:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401025123.895307-1-ricky_wu@realtek.com> <CAPDyKFpn5xB50eTomNM=4LbFDX4r154iY2Qk8GBiYb+vor0kbA@mail.gmail.com>
 <1fde0217fa544560888c3e6f4f5963f9@realtek.com>
In-Reply-To: <1fde0217fa544560888c3e6f4f5963f9@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Apr 2025 15:44:42 +0200
X-Gm-Features: ATxdqUF1Zp1od8RzcSBLFqjvlDhawwyc1n6aNdWRiQDIFPeeRIziDeAyT0ztL2c
Message-ID: <CAPDyKFogPwixHGdmUy_z_udrUpU36mi_9cqdo1bPdM88OL1Erw@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: usb add 74 clocks in poweron flow
To: Ricky WU <ricky_wu@realtek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Apr 2025 at 08:37, Ricky WU <ricky_wu@realtek.com> wrote:
>
> > >
> > > SD spec definition:
> > > "Host provides at least 74 Clocks before issuing first command"
> > > After 1ms for the voltage stable then start issuing the Clock signals
> > >
> > > add if statement to issue/stop the clock signal to card:
> > > The power state from POWER_OFF to POWER_UP issue the signal to card,
> > > POWER_UP to POWER_ON stop the signal
> > >
> > > add 100ms delay in power_on to make sure the power cycle complete
> >
> > Why 100ms? That sounds a lot to me?
> >
> Hi Ulf,
>
> This 100ms delay is to ensure the voltage is below 0.5V before power on during a power cycle,
> The delays in the mmc core is not sufficient for the rtsx usb device.
> Because during the card recognition process, the card power will be toggled once in 1ms.
> If the card power is not fully discharged within that 1ms before being turned on again,
> It may affect the card recognition

Okay, I see. So 1ms isn't sufficient for your case.

Is there a regulator described somewhere? Could this delay be part of
the regulator enable/disable instead?

>
> > Is this fixing a real problem or is just trying to better follow the spec?
> >
>
> We found some cards not be recognized if not issue this 74 clocks

That still doesn't explain why you picked exactly 100ms as the delay.
Assuming we are running at lowest initialization frequency for SD/eMMC
at 100kHz, then 74 clocks are:

74/100000 = 0,00074s.

Kind regards
Uffe

>
> > >
> > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > ---
> > >  drivers/mmc/host/rtsx_usb_sdmmc.c | 28
> > +++++++++++++++++++++++++---
> > >  1 file changed, 25 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > index d229c2b83ea9..e5820b2bb380 100644
> > > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > > @@ -48,7 +48,7 @@ struct rtsx_usb_sdmmc {
> > >         bool                    ddr_mode;
> > >
> > >         unsigned char           power_mode;
> > > -
> > > +       unsigned char           prev_power_mode;
> > >  #ifdef RTSX_USB_USE_LEDS_CLASS
> > >         struct led_classdev     led;
> > >         char                    led_name[32];
> > > @@ -952,6 +952,8 @@ static int sd_power_on(struct rtsx_usb_sdmmc
> > *host)
> > >         struct rtsx_ucr *ucr = host->ucr;
> > >         int err;
> > >
> > > +       msleep(100);
> > > +
> > >         dev_dbg(sdmmc_dev(host), "%s\n", __func__);
> > >         rtsx_usb_init_cmd(ucr);
> > >         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07,
> > > SD_MOD_SEL); @@ -1014,6 +1016,16 @@ static int
> > sd_set_power_mode(struct rtsx_usb_sdmmc *host,
> > >                 unsigned char power_mode)  {
> > >         int err;
> > > +       int power_mode_temp;
> > > +       struct rtsx_ucr *ucr = host->ucr;
> > > +
> > > +       power_mode_temp = power_mode;
> > > +
> > > +       if ((power_mode == MMC_POWER_ON) && (host->power_mode
> > == MMC_POWER_ON) &&
> > > +                       (host->prev_power_mode ==
> > MMC_POWER_UP)) {
> > > +               host->prev_power_mode = MMC_POWER_ON;
> > > +               rtsx_usb_write_register(ucr, SD_BUS_STAT,
> > SD_CLK_TOGGLE_EN, 0x00);
> > > +       }
> > >
> > >         if (power_mode != MMC_POWER_OFF)
> > >                 power_mode = MMC_POWER_ON; @@ -1029,9
> > +1041,18 @@
> > > static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
> > >                 err = sd_power_on(host);
> > >         }
> > >
> > > -       if (!err)
> > > -               host->power_mode = power_mode;
> > > +       if (!err) {
> > > +               if ((power_mode_temp == MMC_POWER_UP) &&
> > (host->power_mode == MMC_POWER_OFF)) {
> > > +                       host->prev_power_mode = MMC_POWER_UP;
> > > +                       rtsx_usb_write_register(ucr, SD_BUS_STAT,
> > SD_CLK_TOGGLE_EN,
> > > +                                       SD_CLK_TOGGLE_EN);
> > > +               }
> > > +
> > > +               if ((power_mode_temp == MMC_POWER_OFF) &&
> > (host->power_mode == MMC_POWER_ON))
> > > +                       host->prev_power_mode = MMC_POWER_OFF;
> > >
> > > +               host->power_mode = power_mode;
> > > +       }
> > >         return err;
> > >  }
> > >
> > > @@ -1316,6 +1337,7 @@ static void rtsx_usb_init_host(struct
> > rtsx_usb_sdmmc *host)
> > >         mmc->max_req_size = 524288;
> > >
> > >         host->power_mode = MMC_POWER_OFF;
> > > +       host->prev_power_mode = MMC_POWER_OFF;
> > >  }
> > >
> > >  static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
> > > --
> > > 2.25.1
> > >
> >
> > Kind regards
> > Uffe
