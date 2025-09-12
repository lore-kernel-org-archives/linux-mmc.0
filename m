Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0392FF665
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676609; cv=none; b=Dx6zLHc9CzHRYpwqExT3n/ySvlWQUdx+Ef52sGgWaYqlVLeYprIf/0yIB2cxLg6ePc1DEPUpBOGn8Y4IaVGzBYJMKTxTUxZf/FNfywx9b2TrWtmTQHwausVRcboIFFMBsK73vzvIfI6dDhzjIydSVA1XGQR3BPXdf5NM80IcxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676609; c=relaxed/simple;
	bh=0Pm0fkGkWoYqjXuzhKvNU5xsbdAFRjgObqKHLzR80II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAhHkGVrh01qDrpSVTNm7EXf3wN9sapcuygEGoCwuoK9K1jfmJILooiE6HFodqoK/IL1DHs5y9sXlvR7gwc6FYVkGKZKHkfA+iYUcaDP10B+zccLtGyT6iajYHw4/GD6nh8UM6+Pt540Pz9GHso8kcK1Y/VXQl/YibVhGqFJumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M5pbYMVy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5pbYMVy"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5608b619cd8so2191063e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757676605; x=1758281405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ba/lf2/V1l+GnTj8KKghQ3UjKo/P9CKd/RACGRLyBQo=;
        b=M5pbYMVy0QZe3U5fgphKObHXl4FEegACWrCRkEKE4rUmOmjfziFaonMEOtwVJvvLFD
         UArUiGM+leyN3nls7EJZDX4g68QRRCQvaqymtZVHVCfUMLO3PqrvTm8XX+oc4oVqmJSt
         5iyxbMdwK1lK99CD6Y0MeNpbOkbTKsQ2ARXhSS+Wi+g4FjRvcLG6HRGCc5V/OYb3EjP6
         w8bUWAk6RKjZ3M/e/46d/9+e1NnuuIe9wt1Maz0rdRY/rVeRJxiGXTTqeugfwuuOaz/o
         ef3tuQgNADpDgmvNKqJMXXXhajaSnEq9HcVherF5qow8CW17A6iaZ6ioxhdr9TLd3hxU
         85tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676605; x=1758281405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba/lf2/V1l+GnTj8KKghQ3UjKo/P9CKd/RACGRLyBQo=;
        b=wxAjbTN4ekzcwK5ff5ngwdOyeBA8wM3HFF5DGcYmPwSEWvKdOXFWmuyBs1BMX2PT2y
         VeyFMAoNTHR1K8I0iLsyLUh3F+7oWW2dB3HBynSp/DfWVTHdEXwOIo5n66fAX3K5ZsiH
         WAfPi59cTRzqO7GqAiagZ5SUwF5m+Yp2dvpdLy3c9QCqlRcLqvOuCWuMMO7my7Cx4vp1
         urPPjOvDUMso4gkN2ixh1Jt4/66EZee5v0Nls7kSHtm3gbgLGyamjt7dlsbC/G918JLR
         kCgW+oidimplSWWr1FrtO5OgxOysqiCiX3RHw41H+NOCB6rvLelj+En7KD/DDN11jJPh
         0Rzg==
X-Forwarded-Encrypted: i=1; AJvYcCVoC0HJA0CqLRRwQPBoswqfrt3CdvmWQ8eiz9P0zUaEolTRCZ+y8Kkd7sqHXIwXuvh2QzBFvHTShqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTcOIat35EJQxz/e8sEWhSWfVnjq/Ow0vYrc/hOkOmT2piuNu
	cnL2gGXBoWwJgD2dy2+2q60r9xVnaYzdtXLISsrMOFiEGR0vK4aMpY58EuKbaaOOIDw=
X-Gm-Gg: ASbGncsTOr2iO2ilnecSNabCtSbd5WlQBGJw8ss5oK9qzY9jxDWclMIG6XlvpQ/K1ku
	JZb8mlYkOQfmFlrmPFZLO7Hx8+5irb9UhDsS1ElUUm7AG0IeGjJu7IKSzNthBp3FumjrtP14Lgg
	GEV3y5Vi99wd5UU8JTa2hhyWQVKm6rcdz5nGqUfiS9CQT9zLOG1WPxP59txxrJLdudt5CrePUck
	uasJUyFvfh8rtPWWRO8eeCdvkujCjgxXuqukeKk30bFjxAnWx+iSevbpW3Lr8D9lj5LmVs1tRAG
	PriuXHw+QrsqtH+Qw0UzQvl0ko9y/BxEgiE3OKEuMFOmoEQvaeKUGcoUlDd7PWSdUnyLOOFiUrN
	cpXoUgXuQHEsIOJA2mg8EK3+x4l3D4cA/+4Yy/Ae9wLU61LVfRqze3UA=
X-Google-Smtp-Source: AGHT+IG7xrx6zvuY8X0aSFVq93lkYc31MyNpm2Z01J+LnnCkpwj4t9QRjRFVTrJ6sFrZzBRbJEwCUA==
X-Received: by 2002:a05:6512:32cb:b0:568:c51:e7cb with SMTP id 2adb3069b0e04-57051b65d1dmr1015643e87.52.1757676605476;
        Fri, 12 Sep 2025 04:30:05 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6167sm1117114e87.25.2025.09.12.04.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:30:05 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:30:03 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yixun Lan <dlan@gentoo.org>, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: add dependency to
 ROCKCHIP_PM_DOMAINS
Message-ID: <aMQEO7tmvSY5thC-@nuoska>
References: <20250911144313.2774171-1-mikko.rapeli@linaro.org>
 <CAPDyKFqLag_WkxqOCebvBCJy4TzZEqt-rFD_Z30sajUxgSpcaA@mail.gmail.com>
 <1813054.X513TT2pbd@diego>
 <acbc46c8-30df-47bb-9d3d-91ba477f6029@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acbc46c8-30df-47bb-9d3d-91ba477f6029@app.fastmail.com>

Hi,

On Fri, Sep 12, 2025 at 10:47:29AM +0200, Arnd Bergmann wrote:
> On Thu, Sep 11, 2025, at 18:05, Heiko Stübner wrote:
> >
> > Am Donnerstag, 11. September 2025, 17:03:14 Mitteleuropäische 
> > Sommerzeit schrieb Ulf Hansson:
> >> On Thu, 11 Sept 2025 at 16:43, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> >> > @@ -866,7 +866,7 @@ config MMC_DW_PCI
> >> >
> >> >  config MMC_DW_ROCKCHIP
> >> >         tristate "Rockchip specific extensions for Synopsys DW Memory Card Interface"
> >> > -       depends on MMC_DW && ARCH_ROCKCHIP
> >> > +       depends on MMC_DW && ARCH_ROCKCHIP && ROCKCHIP_PM_DOMAINS
> 
> The hard dependencies are usually only for compile-time requirements.
> 
> Ideally this should go the other way and use
> 
>       depends on (ARCH_ROCKCHIP || COMPILE_TEST)
> 
> after you check that this actually builds on x86 with COMPILE_TEST
> enabled, as there may be other compile-time dependencies.

Ok so a lot of mmc driver set this correctly but few don't:

 * MMC_PXA
 * MMC_OMAP
 * MMC_ATMELMCI
 * MMC_MXC
 * MMC_MXS
 * MMC_DW_ROCKCHIP
 * MMC_WMT

Maybe there are good reasons why these are not part of COMPILE_TEST.
I can try adding MMC_DW_ROCKCHIP. Did not yet find out how to start
the COMPILE_TEST build. Hints welcome. Which top level Makefile
target or script to run?

> >> Rather than "depends on", I think a "select" is better to be added
> >> from the platform's Kconfig. Probably drivers/soc/rockchip/Kconfig is
> >> where to put this.
> >> 
> >> Assuming that ROCKCHIP_PM_DOMAINS is a critical piece for most
> >> Rockchip platforms to work.
> >
> > I'd think
> > - arch/arm64/Kconfig.platforms
> > - arch/arm/mach-rockchip/Kconfig
> > would be the correct positions.
> >
> > And as Ulf suggested, this should be a "select"
> 
> I think in this case a 'default ARCH_ROCKCHIP' in the
> ROCKCHIP_PM_DOMAINS definition is sufficient to have it
> normally enabled, and still allows someone to try turning
> it into a loadable module later, which would be a requirement
> e.g. for Android GKI.

Ok I can test this out. kernel.org defconfigs have ROCKCHIP_PM_DOMAINS
enabled so they don't see any issues but when users/distros configure
kernels, then ROCKCHIP_PM_DOMAINS is needed for MMC_DW_ROCKCHIP to work.
To me a warning is sufficient from kernel config tooling since yocto
side tooling picks this up but enabling by default is even better.
These runtime dependencies hard to track down. Kernel modules would
be sufficient if support was there since in my case there is always
an initrd with udev and modules.

Cheers,

-Mikko
