Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06F1AC229
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886572; cv=none; b=FIAw88wYJMqSJcc30zzp5XdzLfBN0LtZk/dSN6oPBM01l5ODL+KT+VVhKLhv8rKuSZUHalgCTQF7s6v+FzwFrOxlFx30um+0J1zKDU+Szapb+4jvGUWXFp4dTvYrYlzxpPodeenZnQ/KV7WHbalt377CUnC8l37W6BtPjPF5c+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886572; c=relaxed/simple;
	bh=38qWKyVoWoDAeaYRBfca/el/bUnwJnMh4XRLXYw0OEI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZMhgZgqwady69Bmvv+7F8LbW19kgB9FvEDX4XU9dagLmFE4eHx1Uir21EfWzMqTpS/nrlOfBirybiqNfFe9veBbs/ZbVUfcymlpnY6NPNEa2czLnivOoe/W9X5ElYL/0zfjfI5HpwEnmkRZEKWGGAbHs6L0vIavtulI3xB/ztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dH+BE3nI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dH+BE3nI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6fc30e3237so75840166b.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718886569; x=1719491369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=812oi9ttGdSZvdMnnqNdJPwV4ZnipqaADPcKVJvQSFI=;
        b=dH+BE3nIoM6j/MPFdYhR0Hls9iPcjRiph85fO66J1Fy6Q6Jr6SfiSeRFPZB3buzmsG
         /mPAzhrD0+wpHHRDt2dO2Uj2JkUAXJYcfH5w2fidmJmruKvNzHhWIm+cF80pljeHkPGh
         +GZHn1so+kkNL5dq0oAtdpWEsIfNNmTr0DFKbcaXEID0thOEqi24s27n/JxuMofDd8Hm
         gDDR8hXbqMRSPcE+QrF7cDigs4U6GAd1jApLDvf/oSUiEWqHYh7zjkmvjfADgVXwgu8W
         xLqxFDWBeyhBplPzHxOkMwTLFz5Hbrtvp3drFsXCxMr74VIbdm4LbJpDa/YG6l69A3ry
         VgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718886569; x=1719491369;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=812oi9ttGdSZvdMnnqNdJPwV4ZnipqaADPcKVJvQSFI=;
        b=tBMcbBLR0hl03HEFQXb14PbhKnp40iIJq6ny1Hbkhz0SkbAtRPF6dIG8q62ruYldIV
         vTKEwMPUx78++SaMJSVemu2Rq5f4jj+yoM2TtHylhmOQi8amw6ViahOEdf5dZgBWXYsj
         +DVB+fFjaSrNNLDD0WEVM+UzoIkuD1Q8Sz97riCyZgi3JxY8I/5udr7GS5GFwZMytX3a
         8ihkUuPfXu/DOvbF+rjXKjqeB5jupF8tZBPp8sdlzo2GNWQNk+0kFOlWWPlC7mC97g3P
         AiDk3JgL+EKrcd7GhD2fzDWqjb5MnGEmygyuZNbOsO0KySi6Yq6t+HXoNeU0dGQzAn3A
         USlw==
X-Gm-Message-State: AOJu0YzpYlRnmka0Dv/6WLe397sryORWsyKtLs3z0GaabO6Kt8J98PcT
	RauNmDlV72Sxl2q3UbzDun7ApspwtjbNih1n/ZXuGFInjdZbI1ED11mCxs5gyb8=
X-Google-Smtp-Source: AGHT+IEcb44WWVE0fUrpL5V8J52hlNsEKUwTphFUd3zrDyWyC67nuuTnnM+POuLf4yuOG9Mv+4ORAQ==
X-Received: by 2002:a17:906:7253:b0:a6f:4f3f:e6d8 with SMTP id a640c23a62f3a-a6fab617aa6mr347004866b.20.1718886568544;
        Thu, 20 Jun 2024 05:29:28 -0700 (PDT)
Received: from localhost (host-62-211-197-135.pool62211.interbusiness.it. [62.211.197.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41071sm777420566b.149.2024.06.20.05.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:29:28 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 20 Jun 2024 14:29:44 +0200
To: Peter Robinson <pbrobinson@gmail.com>
Cc: linux-mmc@vger.kernel.org, Andrea della Porta <andrea.porta@suse.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add ARCH_BCM2835 option
Message-ID: <ZnQguA8P81h3MsQX@apocalypse>
Mail-Followup-To: Peter Robinson <pbrobinson@gmail.com>,
	linux-mmc@vger.kernel.org,
	Andrea della Porta <andrea.porta@suse.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
References: <20240620074248.152353-1-pbrobinson@gmail.com>
 <ZnQb1_K1Ctvhtngy@apocalypse>
 <CALeDE9Oub0=wCd7s1Nx5fwU94cFbUKdmXu1GTb4cKu8fMiqOAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9Oub0=wCd7s1Nx5fwU94cFbUKdmXu1GTb4cKu8fMiqOAg@mail.gmail.com>

Hi Peter,

On 13:22 Thu 20 Jun     , Peter Robinson wrote:
> Hi Andrea,
> 
> > On 08:42 Thu 20 Jun     , Peter Robinson wrote:
> > > The Raspberry Pi devices have to date all used ARCH_BCM2835
> > > as their SoC arch dependency so configurations that use this
> > > and not BRCMSTB won't end up with this module in their config.
> >
> > AFAIK the BCM2712 (RPi5) is the only SoC of the Raspberry family
> > that has an MMC host controller that is more or less like the one
> > present on the STB line silicon. Adding ARCH_BCM2835 to the dependency
> > will then allow RPi<=4 to use this driver for which they do not
> > have the relevant hw.
> 
> It won't use the driver due to the different compatibles, it just
> allows the driver to be available. The various different gens of RPi
> now have around 4 different types of MMC controller in use.

True, so why make a driver available if I can't use it anyway? No other
SoC served by ARCH_BCM2835 have that hw, but as you said, every one of them 
have different controllers best served by anything else but SDHCI_BRCMSTB.

Thanks,
Andrea

> 
> > If I'm correct about the aforementioned point, I'd be inclined to
> > avoid this change, then.
> >
> > Many thanks,
> > Andrea
> >
> > >
> > > Cc: Andrea della Porta <andrea.porta@suse.com>
> > > Cc: Stefan Wahren <wahrenst@gmx.net>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Fixes: 40f22df5269e6 ("mmc: sdhci-brcmstb: Add BCM2712 support")
> > > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > > ---
> > >  drivers/mmc/host/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > > index bb0d4fb0892ae..eb3ecfe055910 100644
> > > --- a/drivers/mmc/host/Kconfig
> > > +++ b/drivers/mmc/host/Kconfig
> > > @@ -1016,7 +1016,7 @@ config MMC_SDHCI_MICROCHIP_PIC32
> > >
> > >  config MMC_SDHCI_BRCMSTB
> > >       tristate "Broadcom SDIO/SD/MMC support"
> > > -     depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> > > +     depends on ARCH_BRCMSTB || ARCH_BCM2835 || BMIPS_GENERIC || COMPILE_TEST
> > >       depends on MMC_SDHCI_PLTFM
> > >       select MMC_CQHCI
> > >       default ARCH_BRCMSTB || BMIPS_GENERIC
> > > --
> > > 2.45.2
> > >
