Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268E13D280
	for <linux-mmc@vger.kernel.org>; Thu, 16 May 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855525; cv=none; b=UmYBHLHCh+T32hmFUzXnxuzjCisFjFVk9S80uz5W9WzoD/G7EnMxE+gk+yku4YSAcAVhOTiYWMAnPPI47zu/XNhvofIsekquFXbu+l+63+xo0G05nhYBg7z0mChR7ukpivJRDYXUUtn8gTj16opBroHrx7zrzIy5X6CNIFOk7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855525; c=relaxed/simple;
	bh=TKC1ecUmBG2r52Lx+99Gq3JPyNh3t3Hn2QjNdaK6G8g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkVEkIU84Cv6QF96EvrggSbGH6ZjrJRIg6iNPowlvsXKAKe5EghvVlYbgnmCS1vRXrfxUGIAYHjTxczCVUqLQIVV3ciFoMdARCGE8hB0q2jcG1sXzTOvzNGFlsKvd1YLVdLDYX926jMvn5Fsbncx0AKztQvPh8jX9gyGW3sDMTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MX5qVjYr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MX5qVjYr"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso3567397a12.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 May 2024 03:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715855521; x=1716460321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFfEH0nLFM+O/JJvf5HTtYGZMvNxTcGxwhqubZ4Dp1o=;
        b=MX5qVjYr/bwYG9URbrjzNOG/H6LIXdP3ZledrGK2a+W0lSYsdYqKjc197Ms8ahUSRN
         ZadqvCSLWjC18N+CaqnItNtExVXwybuPGs1CGN/SW7FaACeG5XGMdUdYtsue9aoZk375
         fBUZruI5oiYjDJmKV5pU14E77haf1ybFzkYwgTQaiFdA+0asCqOon/V/wVWBN+JpFNve
         NNx6Kuaf14/iblZB2Xg0r1j3c4tZ3wVpiT6OV/WQ7NpWI6azW5HqbttFV+0SGknMgC3v
         LamOGS0T0MbgV6wK5r6KLUApTKfgtoYYRqVTy8r4452PSD94kkg4QdkHYQfxNh8LbYyQ
         HdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715855521; x=1716460321;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFfEH0nLFM+O/JJvf5HTtYGZMvNxTcGxwhqubZ4Dp1o=;
        b=SvdO5J7nz9Yqv+jEkckNeftTFvIyU6VbpmzgleLrc3oze0vZijJACKiAkyWoAL9RyD
         uT/bli/gPWjugPJNs6feuvjtmbmUQTxfSsuMFJKVKqRAFwV/c5i7xHXIy9zMaDiDHlMt
         whvOVHeZTaqV13XZd8aC8f3obgFimMYHOveSD95tgKLGuEiJdTWSgc8TAbXhZk6x8rBT
         bwLzuRhEw/JcxvhhyzhsZdWooxyGhrco3Y0SONplclHPHEzBQkWJLuz+NMoFPSXvZuRs
         foaJz0YgCrEaNOAuIcVWfHgO1NDf7c30ZO5ZT9yODklshHRfHCV0l7FBUUdUNJ4mMqR/
         xw8A==
X-Forwarded-Encrypted: i=1; AJvYcCUsJ2tMXgo++tyt6jZzq13XKPR0a3BUwbNn6LrlirbPHhRcAzsJpqgF2IYJP3kVtIJq2Fy/1QzC+tpsjfLLcnOPrNy0IV5QgiSC
X-Gm-Message-State: AOJu0YzBT15XzpegZf4HWEHImgZ2Gk1LdjzGfxfG4GZmXvaUyJvyV0m9
	VqI7y/p1csNNkZuN/Sm7aiJTLlSk75HN7RjGHYO1vAgpetv7FnCoejg+yyfjDPM=
X-Google-Smtp-Source: AGHT+IHSBsoYuE4woB/zAs3ODpON7rgmUZR2UwQV7pcu6xvLv6oTld2p+F7Pt7tXuJlHbtXbGlL+pQ==
X-Received: by 2002:a17:906:394e:b0:a59:cb29:3fac with SMTP id a640c23a62f3a-a5a2d68aad7mr1284605566b.65.1715855521454;
        Thu, 16 May 2024 03:32:01 -0700 (PDT)
Received: from localhost (host-79-19-230-33.retail.telecomitalia.it. [79.19.230.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a7a944664sm377064866b.37.2024.05.16.03.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 03:32:01 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 16 May 2024 12:32:10 +0200
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>, Eric Anholt <eric@anholt.net>,
	Scott Branden <sbranden@broadcom.com>, linux-mmc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Al Cooper <alcooperx@gmail.com>, Ray Jui <rjui@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] Add minimal boot support for Raspberry Pi 5
Message-ID: <ZkXgqjr89wCH__-k@apocalypse>
Mail-Followup-To: "Rob Herring (Arm)" <robh@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>, Eric Anholt <eric@anholt.net>,
	Scott Branden <sbranden@broadcom.com>, linux-mmc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Al Cooper <alcooperx@gmail.com>, Ray Jui <rjui@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org
References: <cover.1715332922.git.andrea.porta@suse.com>
 <171560671443.2464066.440073842827214763.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171560671443.2464066.440073842827214763.robh@kernel.org>

On 08:27 Mon 13 May     , Rob Herring (Arm) wrote:
> 
> On Fri, 10 May 2024 16:35:26 +0200, Andrea della Porta wrote:
> > Hi,
> > 
> > This patchset adds minimal support for the Broadcom BCM2712 SoC and for
> > the on-board SDHCI controller on Broadcom BCM2712 in order to make it
> > possible to boot (particularly) a Raspberry Pi 5 from SD card and get a
> > console through uart.
> > Changes to arm64/defconfig are not needed since the actual options work
> > as they are.
> > This work is heavily based on downstream contributions.
> > 
> > Tested on Tumbleweed substituting the stock kernel with upstream one,
> > either chainloading uboot+grub+kernel or directly booting the kernel
> > from 1st stage bootloader. Steps to reproduce:
> > - prepare an SD card from a Raspberry enabled raw image, mount the first
> >   FAT partition.
> > - make sure the FAT partition is big enough to contain the kernel,
> >   anything bigger than 64Mb is usually enough, depending on your kernel
> >   config options.
> > - build the kernel and dtbs making sure that the support for your root
> >   fs type is compiled as builtin.
> > - copy the kernel image in your FAT partition overwriting the older one
> >   (e.g. kernel*.img for Raspberry Pi OS or u-boot.bin for Tumbleweed).
> > - copy arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb on FAT partition.
> > - make sure you have a cmdline.txt file in FAT partition with the
> >   following content:
> >   # cat /boot/efi/cmdline.txt
> >   root=/dev/mmcblk0p3 rootwait rw console=tty ignore_loglevel earlycon
> >   console=ttyAMA10,115200
> > - if you experience random SD issues during boot, try to set
> >   initial_turbo=0 in config.txt.
> > 
> > Changes in V2:
> > 
> > - the patchshet has been considerably simplified, both in terms of dts and
> >   driver code. Notably, the pinctrl/pinmux driver (and associated binding)
> >   was not strictly needed to use the SD card so it has been dropped.
> > - dropped the optional SD express support patch
> > - the patches order has been revisited
> > - pass all checks (binding, dtb, checkpatch)
> > 
> > Many thanks,
> > Andrea
> > 
> > References:
> > - Link to V1: https://lore.kernel.org/all/cover.1713036964.git.andrea.porta@suse.com/
> > 
> > Andrea della Porta (4):
> >   dt-bindings: arm: bcm: Add BCM2712 SoC support
> >   dt-bindings: mmc: Add support for BCM2712 SD host controller
> >   mmc: sdhci-brcmstb: Add BCM2712 support
> >   arm64: dts: broadcom: Add support for BCM2712
> > 
> >  .../devicetree/bindings/arm/bcm/bcm2835.yaml  |   6 +
> >  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |  23 ++
> >  arch/arm64/boot/dts/broadcom/Makefile         |   1 +
> >  .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  62 ++++
> >  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 302 ++++++++++++++++++
> >  drivers/mmc/host/sdhci-brcmstb.c              |  81 +++++
> >  6 files changed, 475 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> >  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> > 
> > --
> > 2.35.3
> > 
> > 
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y broadcom/bcm2712-rpi-5-b.dtb' for cover.1715332922.git.andrea.porta@suse.com:
> 
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc@107c000000/timer@7c003000: failed to match any schema with compatible: ['brcm,bcm2835-system-timer']
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc@107c000000/local-intc@7cd00000: failed to match any schema with compatible: ['brcm,bcm2836-l1-intc']

Those two property come respectively from:
- Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
- Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt

that are old style txt bindings. So unfortunally they will output that
kind of warnings: converting txt to yaml schema wouldbe great, but I
think a little outside the scope of this patchset. I would say it is
a good cancidate for a separate patch.

Many thanks,
Andrea
