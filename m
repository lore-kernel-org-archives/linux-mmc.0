Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E53D552
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886136; cv=none; b=mviD8AJhqEA7YD+rkJ94G0qLiqxAXhfz6+oShVoTK4dJpUUT3lXNaTAihqFw9qynHcY19Vx8KZ8/zy71NpMTAsUjVX22XkmsS/c0GYbU4pi3hhcno+XG3jwn26bM/8pi4bQud0XPHyeu+p0CpDq9tCVUdhX+b4xPf1H4MO4q7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886136; c=relaxed/simple;
	bh=33v+qUnIgVaNNjoPjvt8O2PlcAhwHcm1i4SglBbRGr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PTf9WRGaMNYKkybmmT+fLkqqoivWd+D1u4rsuHJ6u9f3aVBPQJbmfokrpshdzFBvfWXapushJt6avHn5XJ7U1IlEVemegJdAqhVKksSwMWHPdtuaBvi84gwUVC7tJrJs2sFptBM8ku+DzNucuBwb9qRupknEOoxZvC7H0aT3HuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDYCUjD+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDYCUjD+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6efacd25ecso43865166b.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718886133; x=1719490933; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Br9G9gWOQ0ngTc8vHien9AXaoLi0qOe8Sy1DBcV135A=;
        b=WDYCUjD+vbJlLtsGbD9lfv8x/V3g7DZhx5b8EnrWk5nruum8Swlma9Q4Qzi6s131xD
         UbIqFL5jhkDt6mUqpf2UZ0bGc19oIHMZrUprU9z3+s76v/1oF8fxy2KIeC4qh3HL/H8z
         4EZC1lSKglnrEilkK5i+STyodg3z4Uu2SX552JImH+LCnjDpxftajpGlX1Hpv5Qynzmi
         MZSQnx+Cum0KfNZV5sdT/NH5T/YDCllJqrKV+ot55B7TLU7qZJQUM1iQT58bORtY6Wvg
         Oat2M1erk100VCdXXlwaJCyTius7JDBuJREmpYSweJjtD2R2k+fjUAezkGZgkZ8nSHC6
         bxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718886133; x=1719490933;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Br9G9gWOQ0ngTc8vHien9AXaoLi0qOe8Sy1DBcV135A=;
        b=dbT/bp6vsam23I4Wf4F+7P0na74f+g17l7xO6aZUD8O7PXFzhMmMSawS3Gigg0Qona
         lo0kYYYfMsjGc01vj6lA5xAIEediQag6ludT+9TYxnN02HPD1bhm1hA4Sn5YPntlZ9lq
         +4+2tGZseqBwc9bOmKkDhn9Y7EsMjQURQcniawRs5De8I/6DEOCVjp0K2yrm6h82ja8Y
         pJUXXBKpjoJvCoC7JXOe20o3A/YsAYQfecKYAC3rvHWEt15K0z5fCfFtrzInVZyjDydh
         3wwf/6kXgX1Vh7IOrSql/DXnkseIFKTNkkp9vmW3y2RAVGzf4paUIGkwWXMeQMdHgVw4
         C4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxCO2SCau30FfXoFVSt3XKK4+KzWEpaLuhhR+YoPkE2ENNriYfOwDD5874wlnuXz5/hcxikjH0ERBf4zR/aOxLvy3aY+khDR1u
X-Gm-Message-State: AOJu0YxSyzyMKx+TWb140K5MIwCXfEm+VMMYXAXx2iFYvLWvhWOwSkg+
	6KafMftinhfxDzO8vVK0kFWDr9++O9SwVRudPZ75ZQTDpBlqKUOLRM9yAsLoLHsNpl+BTtbFR7t
	MmlnFVoRBe6UfWIpcPMd4fWJ/fLE=
X-Google-Smtp-Source: AGHT+IFVEC7Gt/DAIflXVQKwxgYBwwufsOnieom7o2eU7XDmKYlbTWS3eAhbehk8akSdBqi9GOZmvx0pQ6xVv45YuPk=
X-Received: by 2002:a05:6402:947:b0:57d:10c7:96b0 with SMTP id
 4fb4d7f45d1cf-57d10c7983cmr3113566a12.38.1718886132579; Thu, 20 Jun 2024
 05:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620074248.152353-1-pbrobinson@gmail.com> <ZnQb1_K1Ctvhtngy@apocalypse>
In-Reply-To: <ZnQb1_K1Ctvhtngy@apocalypse>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Jun 2024 13:22:01 +0100
Message-ID: <CALeDE9Oub0=wCd7s1Nx5fwU94cFbUKdmXu1GTb4cKu8fMiqOAg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add ARCH_BCM2835 option
To: Peter Robinson <pbrobinson@gmail.com>, linux-mmc@vger.kernel.org, 
	Andrea della Porta <andrea.porta@suse.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

> On 08:42 Thu 20 Jun     , Peter Robinson wrote:
> > The Raspberry Pi devices have to date all used ARCH_BCM2835
> > as their SoC arch dependency so configurations that use this
> > and not BRCMSTB won't end up with this module in their config.
>
> AFAIK the BCM2712 (RPi5) is the only SoC of the Raspberry family
> that has an MMC host controller that is more or less like the one
> present on the STB line silicon. Adding ARCH_BCM2835 to the dependency
> will then allow RPi<=4 to use this driver for which they do not
> have the relevant hw.

It won't use the driver due to the different compatibles, it just
allows the driver to be available. The various different gens of RPi
now have around 4 different types of MMC controller in use.

> If I'm correct about the aforementioned point, I'd be inclined to
> avoid this change, then.
>
> Many thanks,
> Andrea
>
> >
> > Cc: Andrea della Porta <andrea.porta@suse.com>
> > Cc: Stefan Wahren <wahrenst@gmx.net>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Fixes: 40f22df5269e6 ("mmc: sdhci-brcmstb: Add BCM2712 support")
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  drivers/mmc/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index bb0d4fb0892ae..eb3ecfe055910 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -1016,7 +1016,7 @@ config MMC_SDHCI_MICROCHIP_PIC32
> >
> >  config MMC_SDHCI_BRCMSTB
> >       tristate "Broadcom SDIO/SD/MMC support"
> > -     depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> > +     depends on ARCH_BRCMSTB || ARCH_BCM2835 || BMIPS_GENERIC || COMPILE_TEST
> >       depends on MMC_SDHCI_PLTFM
> >       select MMC_CQHCI
> >       default ARCH_BRCMSTB || BMIPS_GENERIC
> > --
> > 2.45.2
> >
