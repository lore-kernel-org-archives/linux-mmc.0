Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B71AD3E7
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891476; cv=none; b=d4I4e4SkHDIcNWPkkOo+8DUaPO7fwwgiVcfwiHOlMzgg+u57z6e69vaypLD8YPPIlae7Ykocf3fW+OEdLceqzM1VrFJ9YhDP4iQUlzVmaIh2BCtuT4ODw6khuAacSAOXmWVYRDfuoIUzhw4VLhZFVSyDTbKf7cBMCSGG/8m8//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891476; c=relaxed/simple;
	bh=psegsX7eHQY+7SGubXM3pPWga3YM9KObaNnOOBDFYXg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK+ll1xBWP1ppBojX4tzC6xc4I0fMZcCJmiIchmYOkkY4hEo2x0GVaq9cCOdXMZcDn7SSa8+sC1wM37fvVzZel/jyHdY5XfBiuDIqsdrw9i6PjIx4nkFkW+KZfi+w9vJyITV7H1X1hURzogS1f6RRux5KjPahxH1cMCiwf78x98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WtG/w92F; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WtG/w92F"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6ef46d25efso104813266b.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718891472; x=1719496272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqsi9qnvPCk79o56nDIyXdhHN2/QFEYfZQFVoa4G/j0=;
        b=WtG/w92FkuUOb1nprAQ5uhcdMkC36vCgzFaVfkX30RThXVHMTkF9LoPUNUBBfSNA0d
         Z10L13AqhOLAjhL0I4OA//vKSHjIfKu4Zb9Ybn7DoDJyrqOUWPojt3RiJ4UDTLkOt4lB
         0Fm/fTY7CZtxwoi/l1RFT+OS3JK7UlOyZQgr/FT2o+/sRoXc9Y49uJ1oONx+Mml5x9Rt
         dHTGiFtIwpahYRcNCyyAoi8p3L3Ws2EJaKeWZE74eEAX/IFEKC9jYxPNKt02oMPuFyL6
         iY+HDzbC0nN2ujl/vmdVTsFitISf3katdIP04o6rnS3P3hHAlcbR4btxllnyu2S6uhLp
         FfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718891472; x=1719496272;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqsi9qnvPCk79o56nDIyXdhHN2/QFEYfZQFVoa4G/j0=;
        b=vRg2rrq9n8XxsUml+qh4wWqs2uP5IX+q64/lNVItRnqpiP1X3L+86+768+6KthpGVQ
         78u8IN+EmrVRV+WopccpSLxXX712byKi+OFRqc/+RRPxuj+ERIj7uxElyBD3xuJTo/Gf
         /sXE4eCoDNns3/jmdaSpEmIUJ13wewZx+NxNnjiOJsXFZmjxBAB8pSrRw/Au7sMTLcVP
         DrKf30vMgqMPAQdyMBkpmRaVY3RPIjsKfaNVRjrNfKNP4yHC8CB7He5yJYR01vKcwDbh
         s3zSeH4SulC1/3M6rxsc1tPfUBRXKA+47nEP4lfEHp6XpvmvpnAyRUZ20umorUeZvbDX
         sULQ==
X-Gm-Message-State: AOJu0Yw7f3lnt7qp0U5AirGupJaN5O3j7xO2K9sHXyEkhjjk0+BiXMCL
	iS69/uOL3XYieQWpa2jyk5RFPpTxWw47w0du6XeiJD58XvO+eZGeV4r4dX8DdTM=
X-Google-Smtp-Source: AGHT+IE5jerJZbzOUvnEpMeR2czL4WhpOzuNLlS++fQFBabmCqGB+P2VBHXXPSP6UleN9txaWmB3Cw==
X-Received: by 2002:a17:906:6db:b0:a6f:1785:d18 with SMTP id a640c23a62f3a-a6fab648baamr312120866b.44.1718891472386;
        Thu, 20 Jun 2024 06:51:12 -0700 (PDT)
Received: from localhost (host-62-211-197-135.pool62211.interbusiness.it. [62.211.197.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da40f6sm766850066b.43.2024.06.20.06.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 06:51:12 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 20 Jun 2024 15:51:28 +0200
To: Peter Robinson <pbrobinson@gmail.com>
Cc: linux-mmc@vger.kernel.org, Andrea della Porta <andrea.porta@suse.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add ARCH_BCM2835 option
Message-ID: <ZnQz4LhFDyMlDKvS@apocalypse>
Mail-Followup-To: Peter Robinson <pbrobinson@gmail.com>,
	linux-mmc@vger.kernel.org,
	Andrea della Porta <andrea.porta@suse.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
References: <20240620074248.152353-1-pbrobinson@gmail.com>
 <ZnQb1_K1Ctvhtngy@apocalypse>
 <CALeDE9Oub0=wCd7s1Nx5fwU94cFbUKdmXu1GTb4cKu8fMiqOAg@mail.gmail.com>
 <ZnQguA8P81h3MsQX@apocalypse>
 <CALeDE9N=AytMGrA4=U_Y-M0JF5P==tAW1qLsYSj87GTpMA=Atg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9N=AytMGrA4=U_Y-M0JF5P==tAW1qLsYSj87GTpMA=Atg@mail.gmail.com>

Hi Peter, 

On 14:03 Thu 20 Jun     , Peter Robinson wrote:
> On Thu, 20 Jun 2024 at 13:29, Andrea della Porta <andrea.porta@suse.com> wrote:
> >
> > Hi Peter,
> >
> > On 13:22 Thu 20 Jun     , Peter Robinson wrote:
> > > Hi Andrea,
> > >
> > > > On 08:42 Thu 20 Jun     , Peter Robinson wrote:
> > > > > The Raspberry Pi devices have to date all used ARCH_BCM2835
> > > > > as their SoC arch dependency so configurations that use this
> > > > > and not BRCMSTB won't end up with this module in their config.
> > > >
> > > > AFAIK the BCM2712 (RPi5) is the only SoC of the Raspberry family
> > > > that has an MMC host controller that is more or less like the one
> > > > present on the STB line silicon. Adding ARCH_BCM2835 to the dependency
> > > > will then allow RPi<=4 to use this driver for which they do not
> > > > have the relevant hw.
> > >
> > > It won't use the driver due to the different compatibles, it just
> > > allows the driver to be available. The various different gens of RPi
> > > now have around 4 different types of MMC controller in use.
> >
> > True, so why make a driver available if I can't use it anyway? No other
> > SoC served by ARCH_BCM2835 have that hw, but as you said, every one of them
> > have different controllers best served by anything else but SDHCI_BRCMSTB.
> 
> We, at least in Fedora, don't enable ARCH_BRCMSTB as it brings a lot
> of HW and drivers we can't support.

I see the point. It makes sense to me and after all there seems to be no
drawback except maybe including some drivers that cannot be used on all platforms,
but as you stated they wouldn't be loaded anyway unless put into devicetree.
After all those drivers will be compiled in anyway due to current default config
options, and on several platforms won't be usable still.

Thanks.

Reviewed-by: Andrea della Porta <andrea.porta@suse.com>
 
> 
> > Thanks,
> > Andrea
> >
> > >
> > > > If I'm correct about the aforementioned point, I'd be inclined to
> > > > avoid this change, then.
> > > >
> > > > Many thanks,
> > > > Andrea
> > > >
> > > > >
> > > > > Cc: Andrea della Porta <andrea.porta@suse.com>
> > > > > Cc: Stefan Wahren <wahrenst@gmx.net>
> > > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Fixes: 40f22df5269e6 ("mmc: sdhci-brcmstb: Add BCM2712 support")
> > > > > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > > > > ---
> > > > >  drivers/mmc/host/Kconfig | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > > > > index bb0d4fb0892ae..eb3ecfe055910 100644
> > > > > --- a/drivers/mmc/host/Kconfig
> > > > > +++ b/drivers/mmc/host/Kconfig
> > > > > @@ -1016,7 +1016,7 @@ config MMC_SDHCI_MICROCHIP_PIC32
> > > > >
> > > > >  config MMC_SDHCI_BRCMSTB
> > > > >       tristate "Broadcom SDIO/SD/MMC support"
> > > > > -     depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> > > > > +     depends on ARCH_BRCMSTB || ARCH_BCM2835 || BMIPS_GENERIC || COMPILE_TEST
> > > > >       depends on MMC_SDHCI_PLTFM
> > > > >       select MMC_CQHCI
> > > > >       default ARCH_BRCMSTB || BMIPS_GENERIC
> > > > > --
> > > > > 2.45.2
> > > > >
