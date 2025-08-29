Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C92FE06E
	for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2025 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458969; cv=none; b=PMQCaaaurnWfQibQelYTjnBJvjmIa0UbZ2yGdHdeEhq0jau2mEuNhtl+8ELFaXkIe/gjuZn1lwHilACTtDUvT9bOVOVjpu+xD8N5xkGJKoJg0PTFpfDu8tPoeDZyy0t3i/FNgD9uP22vCgpHbeEVcG1ODzzfQFukOnmN8+jVbB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458969; c=relaxed/simple;
	bh=cu6FrOL/sCoOgyl2T9Kd2v0r7CRxft9rcw5dMWCRLCs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF1QBY1Q7C0yX2i3RhrMH4ubjtj1bE3Qz50mMDa8L2+J4PhLN7c2h4DC986NKVH6c7TK0IJecEl6Z8IFjgPHt4ZOn7bdxtwg+QDvK6E3Od682mX73e4YGayrzCmxD45tRwUWCWuSfPSoy4xKelwMDOXaP6QYnXxmLkT7Ifj9bNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CVvL8WlP; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CVvL8WlP"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-61cbc8259fbso2667266a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2025 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756458964; x=1757063764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMCKh6ebU0u4Z6oifWcZMdJi/zOPW0SlqzJnGxsRIpQ=;
        b=CVvL8WlPwKXn0x2qEjaOLRHOB6ls/bIm9K6qwt3eVqADAPVhZgwzOXaflSEmVgbX/o
         uhAU3WZnEmC/OBFoEcHc+GyQy1KJHwHP882mXGXy6Mhl1Ri58nsPP9Xmelux8hVEnvwX
         l/pvyK9HOuPP4iXMoMHTKaULG9R1KJhrxqtcvQEcL1Qx15xWivADZ0y6ao40R9Vl6ynt
         tCPJPeOKTVuIx4SH9qOm2HSXUui/hm3/zt9bd0SkMSNhgTdxB63k9xE3F8TGnimuzYZt
         m8NCs6SVDNPnnErtN0tAMfQXq1lXIl2coV4zmuzcqpQbsvuBJGWRBsRzsVcOaDTGskPA
         EeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756458964; x=1757063764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMCKh6ebU0u4Z6oifWcZMdJi/zOPW0SlqzJnGxsRIpQ=;
        b=l4YTZHfoPY68YWP+fJSWPzKoOd9camh3rERI0gSnFWcMi/Z+0H8ppBVf0UqJW5nsb7
         RS3URNbbrEpdz/CItggGS0/cGfMoAoGBwaAqd99oouPpoVSi3J+yionsojd6ZRR4PyKD
         BTJJnjRaCPVIa1Wohp8YcfTBRJZ3lNqbYjp5TGXRmT0Ca44t+XdElvg5hz03IDhsIEHF
         +HqvWh5itITh12spNYDlM1pMfpJ6czEhlXGLZ08i0YT44Y2xWEs26icTP4Q/0aKNB3Aa
         Gs4X/Xvykv6P51BQ9H7xx23OvehJ31S9qCFVLAX2oqX1yCJWUkfHSj9aDm8COqZwZgg7
         dbdw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Wy/fitiH++dMf7GhEnRVb/agLAW0ylyqc01i8QBqdxAjLSDlujp90erA1ba795FpMdWIAcCbBfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlamHQEb9OK6t64j+XSkTLOiv7iVHoxDu7r1Bhiun1tYNSaVuW
	+iCXz6J1sOnpycTiTarrRxmu4hzMvO7kGahtn2PqZmulP388qCA3rYltQfqk79h+F+c=
X-Gm-Gg: ASbGncv4p0Ym64njshKh7RU/5p3Aikdfn4t4sfXu9++Dajae8RQGX/d5xQt89qGgHOx
	2a9Pdixs8psUXXGxzdU83jf2b54LnlEcsbKSY6muZuuYHjDJtuMyCVhtSYKDTGE58/hUSodl6Zo
	uZN3n7clRJkfqWmjXWGz0TYK3UOwTgzE+mSena9/n049odgl0v4QQ9/9btR/e26lTCrw+mJsRwu
	ASpFflC0uSvgW5jva+FAndvIETRoz4GAE96hsjzfcex1SJ10mK28muDyNaQCV3hhObovNKmpaEe
	EdciSPXwA5j7sCvi15wiR6MHooB7UKPk+Kngif76xUjtBaxJtJ+BubMNwwr8ELXNl6GcVlihfG8
	u83az1a6dzA0jRh2wyl8cO/+QB2cz1RcwQ5ZjgMCHOGzbk8XDSQ6+ILaq60g2ZFOmkli9lVnIv3
	baEgZpKYt1ylfPdjkR
X-Google-Smtp-Source: AGHT+IEHgFynTh/fqQXSlnQVx/CrD8Li2R2KkbetyhBA2XZxZI4OAUkno3CLyIily5/Z/tnr+qqhWw==
X-Received: by 2002:a17:907:970c:b0:afe:ae6c:411e with SMTP id a640c23a62f3a-afeae6c4776mr1267829366b.30.1756458964378;
        Fri, 29 Aug 2025 02:16:04 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c397sm161585666b.81.2025.08.29.02.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:16:04 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 29 Aug 2025 11:17:58 +0200
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	linux-arm-kernel@lists.infradead.org, florian.fainelli@broadcom.com,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>, svarbanov@suse.de,
	linus.walleij@linaro.org, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>, conor+dt@kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jiri Slaby <jirislaby@kernel.org>, krzk+dt@kernel.org,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	wahrenst@gmx.net, iivanov@suse.de, mbrugger@suse.com,
	Will Deacon <will@kernel.org>, Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v2 0/5] Add peripheral nodes to RaspberryPi 5 DT
Message-ID: <aLFwRrfjmq1wU8-b@apocalypse>
References: <cover.1756386531.git.andrea.porta@suse.com>
 <175641306018.2175061.15558471823903740794.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175641306018.2175061.15558471823903740794.robh@kernel.org>

Hi Rob,

On 15:31 Thu 28 Aug     , Rob Herring (Arm) wrote:
> 
> On Thu, 28 Aug 2025 15:17:09 +0200, Andrea della Porta wrote:
> > Hi,
> > 
> > The following patches add a few peripheral DT nodes and related pin/gpio
> > nodes for Raspberry Pi 5.
> > 
> > - Patch 1: Amend the bindings to avoid DT compiler warnings.
> > 
> > - Patch 2: Adds core pinctrl nodes and defines SD pins as a first appliance
> >   for the pinctrl.
> > 
> > - Patch 3: Wires the gpio-key for power button and related gpio controller.
> > 
> > - Patch 4: Adds DT node for WiFi.
> > 
> > - Patch 5: Adds Bluetooth DT node.
> > 
> > All comments and suggestions are welcome!
> > 
> > Happy hacking!
> > Ivan and Andrea
> > 
> > 
> > CHANGES in V2:
> > 
> > --- DTS ---
> > 
> > - bcm2712.dtsi: added a proper clocks node to the uarta serial
> >   in order to replace the legacy clock-frequency property. As
> >   a result, the following patch from the previous patchset
> >   has been dropped since it's now useless:
> > 
> >   "dt-bindings: serial: Add clock-frequency property as an alternative to clocks"
> > 
> > 
> > Andrea della Porta (1):
> >   dt-bindings: mmc: Add support for capabilities to Broadcom SDHCI
> >     controller
> > 
> > Ivan T. Ivanov (4):
> >   arm64: dts: broadcom: bcm2712: Add pin controller nodes
> >   arm64: dts: broadcom: bcm2712: Add one more GPIO node
> >   arm64: dts: broadcom: bcm2712: Add second SDHCI controller node
> >   arm64: dts: broadcom: bcm2712: Add UARTA controller node
> > 
> >  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +-
> >  .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 133 ++++++++++++++++++
> >  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  55 ++++++++
> >  3 files changed, 189 insertions(+), 1 deletion(-)
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
> This patch series was applied (using b4) to base:
>  Base: attempting to guess base-commit...
>  Base: tags/next-20250828 (exact match)
> 
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/broadcom/' for cover.1756386531.git.andrea.porta@suse.com:
> 
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dtb: /soc@107c000000/pinctrl@7d504100: failed to match any schema with compatible: ['brcm,bcm2712c0-pinctrl']
> arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dtb: /soc@107c000000/pinctrl@7d504100: failed to match any schema with compatible: ['brcm,bcm2712c0-pinctrl']
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dtb: /soc@107c000000/pinctrl@7d510700: failed to match any schema with compatible: ['brcm,bcm2712c0-aon-pinctrl']
> arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dtb: /soc@107c000000/pinctrl@7d510700: failed to match any schema with compatible: ['brcm,bcm2712c0-aon-pinctrl']
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dtb: hvs@107c580000 (brcm,bcm2712-hvs): clocks: [[28, 4], [28, 16]] is too long
> 	from schema $id: http://devicetree.org/schemas/display/brcm,bcm2835-hvs.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dtb: hvs@107c580000 (brcm,bcm2712-hvs): clocks: [[28, 4], [28, 16]] is too long
> 	from schema $id: http://devicetree.org/schemas/display/brcm,bcm2835-hvs.yaml#
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc@107c000000/pinctrl@7d504100: failed to match any schema with compatible: ['brcm,bcm2712c0-pinctrl']
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: /soc@107c000000/pinctrl@7d510700: failed to match any schema with compatible: ['brcm,bcm2712c0-aon-pinctrl']
> arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: hvs@107c580000 (brcm,bcm2712-hvs): clocks: [[28, 4], [28, 16]] is too long
> 	from schema $id: http://devicetree.org/schemas/display/brcm,bcm2835-hvs.yaml#
> 
>

For some reason I've dropped, from the previous cover letter, the
phrase mentioning that this patchset depends on this patchset:

https://lore.kernel.org/all/7ed0f2779829f4e63b69d8cf5cedda9f849996bc.1756372805.git.andrea.porta@suse.com/

which contains the schema. If you apply it as prerequisite, warnings
should disappear.

Many thanks,
Andrea
