Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A61AD400
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888643; cv=none; b=fMI+fCUMf0m602C3Jg8W5BYGr7P+DGJX0CJ87p+TGQ/9/+/tiwk4X3tbr7ti58lNeSl7qfUh3606RypYeVkqtWvV5pYySJq8rXZR2zZJuBy8zTCXtL8hYTNeh9V7YEUutSXakRUFgD/r2eaHYaJy/8ZViHwtHwkha3+snTdeeiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888643; c=relaxed/simple;
	bh=/XMKOe3Y/+AmUXmACNc1/eOrps60aM7AgQ3cFKjdS/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YOozX4KoHofLoVkTb7nWEgbjcThgqS19/CeqifQGKhK7GvCwiMIGAwYSPev+dYRTa1ba6Fq3qvEkS5ekV3g0X7ncXuJnmH4E3qDTmV6X7WT38DYE9/sN30+mwdBL5lyJhY10/YN2Geikyuq6u0RBDPnZrqshlNB6GrH2SXJboUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HstdL6sN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HstdL6sN"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f1f33486eso42264166b.3
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718888640; x=1719493440; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ccjz8jdLRqFJLiqgCsXW6fV8F9VX9u8YcU2P/oQaV4o=;
        b=HstdL6sNxtvBcldlCqX+t7aCSHdNE9Jgtfw0SnYzK1IK3n1Q2R0/QT2moQOjV1P6V6
         haixSoc+T5IGEdvETtmj+Lr91leqwDq1an+NIyvfAei3nzHrspmZ+1JPzLw7+f56/tZi
         SonLjWY6Pgtz9Z6dT9PwVKYeS2hYkKzA9MgKDcXxFEgBoDj816jU/TE3vgtbSaq2zmBd
         AAFt5ZfGWcywFJBL2SWtwVScbi28AGWQT0DJdpDK4Ubeh75AxTeknYNAE3+pd4lfJbaA
         L4wWccLPMQ6Yp7ofMtjr8lDDI3tP3tr2Ajl89FpA5AJ+YhIxj32OK5JVB1Vd1uDMgwjU
         +S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718888640; x=1719493440;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccjz8jdLRqFJLiqgCsXW6fV8F9VX9u8YcU2P/oQaV4o=;
        b=A+DfHsPpQtCLbTX6MecfMzCy35xny7XEME7x4qVZo2JCbtFZFk1EmFga4Kd+7FGHgY
         VsHxOTY9lzYSSYhGR8LqcRP2vZJFGo1EUyzWWiBCpASMv70m3jUZv20P9c/Xr/HWLy2y
         uB1mzFfkUW19aBBb5wV+YPxcGOfSfoVhRjGH26B4wsH5/L7A0+CIndPQzw4IWQ2o8zZg
         Sq/9f52IG4pzLYNsazh7EneVMXuzwQPQsS6OU3DS3zA4AoSqQY181szNZqBbxOIrgGq4
         7XjIZKsousC4rHfLC75+wcC7NR70o6HfOJNUi3HGZriOn0Uvouvxdbfiya1rZK5KtDkY
         jWYg==
X-Forwarded-Encrypted: i=1; AJvYcCXp3iDJpdQgDXDiHGZRHtORQ/OUUuHVAUXfNEbYQMvOVY6Y2qxDE7ZeWEiwS0zrU3xPciwGyYCAKzAi3tF9OLC6apa5z+iHdQNA
X-Gm-Message-State: AOJu0YzXAGMJW4lvjQ+L06+rA7g4b7EQvfqgYiNjN1g3hXjQb7TsE1Gc
	26AJNGY96W/Q1VNYIa+QpPWnpsiTmWJ4p9zaoThpx/J69nnbxyZieBsOI4yaXRu4pE/HbG4uR/c
	9nol3JIketpJljvRZaKPuXC3997c=
X-Google-Smtp-Source: AGHT+IHnSbOe8AWgs8dM3wnjWQKYAxfvmiKQ6sbCzGLXsKrz3FYjBcDy+pzBQwYbwL/ZU7OA5VDLwQgZGLRFR7QSLFc=
X-Received: by 2002:a50:d593:0:b0:57c:fc75:408c with SMTP id
 4fb4d7f45d1cf-57d07e63da5mr4170156a12.19.1718888639534; Thu, 20 Jun 2024
 06:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620074248.152353-1-pbrobinson@gmail.com> <ZnQb1_K1Ctvhtngy@apocalypse>
 <CALeDE9Oub0=wCd7s1Nx5fwU94cFbUKdmXu1GTb4cKu8fMiqOAg@mail.gmail.com> <ZnQguA8P81h3MsQX@apocalypse>
In-Reply-To: <ZnQguA8P81h3MsQX@apocalypse>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Jun 2024 14:03:47 +0100
Message-ID: <CALeDE9N=AytMGrA4=U_Y-M0JF5P==tAW1qLsYSj87GTpMA=Atg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add ARCH_BCM2835 option
To: Peter Robinson <pbrobinson@gmail.com>, linux-mmc@vger.kernel.org, 
	Andrea della Porta <andrea.porta@suse.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 13:29, Andrea della Porta <andrea.porta@suse.com> wrote:
>
> Hi Peter,
>
> On 13:22 Thu 20 Jun     , Peter Robinson wrote:
> > Hi Andrea,
> >
> > > On 08:42 Thu 20 Jun     , Peter Robinson wrote:
> > > > The Raspberry Pi devices have to date all used ARCH_BCM2835
> > > > as their SoC arch dependency so configurations that use this
> > > > and not BRCMSTB won't end up with this module in their config.
> > >
> > > AFAIK the BCM2712 (RPi5) is the only SoC of the Raspberry family
> > > that has an MMC host controller that is more or less like the one
> > > present on the STB line silicon. Adding ARCH_BCM2835 to the dependency
> > > will then allow RPi<=4 to use this driver for which they do not
> > > have the relevant hw.
> >
> > It won't use the driver due to the different compatibles, it just
> > allows the driver to be available. The various different gens of RPi
> > now have around 4 different types of MMC controller in use.
>
> True, so why make a driver available if I can't use it anyway? No other
> SoC served by ARCH_BCM2835 have that hw, but as you said, every one of them
> have different controllers best served by anything else but SDHCI_BRCMSTB.

We, at least in Fedora, don't enable ARCH_BRCMSTB as it brings a lot
of HW and drivers we can't support.


> Thanks,
> Andrea
>
> >
> > > If I'm correct about the aforementioned point, I'd be inclined to
> > > avoid this change, then.
> > >
> > > Many thanks,
> > > Andrea
> > >
> > > >
> > > > Cc: Andrea della Porta <andrea.porta@suse.com>
> > > > Cc: Stefan Wahren <wahrenst@gmx.net>
> > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Fixes: 40f22df5269e6 ("mmc: sdhci-brcmstb: Add BCM2712 support")
> > > > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > > > ---
> > > >  drivers/mmc/host/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > > > index bb0d4fb0892ae..eb3ecfe055910 100644
> > > > --- a/drivers/mmc/host/Kconfig
> > > > +++ b/drivers/mmc/host/Kconfig
> > > > @@ -1016,7 +1016,7 @@ config MMC_SDHCI_MICROCHIP_PIC32
> > > >
> > > >  config MMC_SDHCI_BRCMSTB
> > > >       tristate "Broadcom SDIO/SD/MMC support"
> > > > -     depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> > > > +     depends on ARCH_BRCMSTB || ARCH_BCM2835 || BMIPS_GENERIC || COMPILE_TEST
> > > >       depends on MMC_SDHCI_PLTFM
> > > >       select MMC_CQHCI
> > > >       default ARCH_BRCMSTB || BMIPS_GENERIC
> > > > --
> > > > 2.45.2
> > > >
