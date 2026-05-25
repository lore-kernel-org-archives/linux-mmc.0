Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339593E63B3
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701820; cv=pass; b=hC8VE8q75CIILGq6xZtzM66jpQXYDVQBtFXYmkcLxO8p0VWqteScoqK3SKNvyOOeErX1Bf+CYrsjUsaD8MF4ysk5e04JyJTl9BhxW1qJfAuIa9aTFzN3z0qv5Hp9IqM5EftGyUWfPBD+QzQH7+fHX1p9UGNw8cccMQbixanalRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701820; c=relaxed/simple;
	bh=bG2lZTq0AlonyzQJsp3hruKHT4bKY6rEQmFhRZ/Om5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZcghT5xdFeplHReSkBvj/n8B+ZDLXLx9rILMsl5RTHQNafnbCJuRTKF/+8Vxcr8840MPm0NvOnMmNCvP8UvQ/fL7hdnR9S8KgZ/rR2xeU+boeJ85gAixkX58sJQoxtsvOrkF5bXqSZq17xNcmPH3OtI0+AS/UTsMxV+xbAVloo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8o0RsKP; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8o0RsKP"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65eb1b25c77so3864309d50.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 02:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779701818; cv=none;
        d=google.com; s=arc-20240605;
        b=e7Nh32nCWRmlALWGmEkFUrcRVEuRcgUcbFttEtzZ3YyYHQvR8JPpzVvmnaBS8DBuhP
         GTmj8HSBIhN2q5fjnxkV7YwkygZj+0rDJer6hECgD7ZsNRO9gb5uHGMJRHoW3161/jQz
         VQuT0/ZI+ty5CE4Zzs/b51rAU8L6Tjpnm3TVeMqXPD0HKsmj6LDM1uhWGUQSB1wXS6Gl
         zKmGl24ZB6fFSlB9FMyJjhUt1jOQk46m3k/0nv0OnEUA9Fs4O2J4YkyZkWvMEGHOr6Qo
         BvLo8wuNUHflHMKNypI8h0lixswgt3ryongBfd4Nn5mELdo1mf6cycBWV+QyjdA4SUNt
         QE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bG2lZTq0AlonyzQJsp3hruKHT4bKY6rEQmFhRZ/Om5Y=;
        fh=I9pnHt7Wnke4fsoViJukNKoLp5/qksI5qQ9gINVKKDY=;
        b=eBz0me17x34LwXK4OUk55KWc7JLOwLsSejKom0F5Cjp5QQN1DzK6xa7wxXMZXJZcVx
         mHokgm683M3c6wMiiOnawxVKSL9w+zETPDQAJDpM+y8t3uITTLKLpuhb3ZB8d8eZ+6EP
         1ZRGpe9zXeaFw4d0p5BwAv5cePAspdUQLTjoJK5qNakzO772UXpYaBn+sa6Xs+s/4YrY
         Eqa4TZnwcIa1XKbReXfxlCGROlH8M9uD89jCw2CXj3GQk95ZDwHmFuQ9SrOK1to6FuGi
         plxeEzrZos/4PPchbqWJYA2QQQDoh18+B9YXOm+pHzBv1UvfUC5S+FuM5ZSN/zoyCWot
         wPBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779701818; x=1780306618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG2lZTq0AlonyzQJsp3hruKHT4bKY6rEQmFhRZ/Om5Y=;
        b=L8o0RsKPN0cnIHtL1LC8UVEOx3Okug9D7cpGaD+fBdAnBtUUE6GrkEZ3yJI2NoPTyU
         cgQFbJmo4Lkv3zZ4uP2bpbmc+G53eX+w8M85wXGCBNPEA9exX4mU8elTsisgJ+BOBIHR
         kYWtDhBV5LxYqbF8BRvb+bTUGTwfaojETUxQQEk4JnEiu4/btCirFuqJnH1kMcOrRp+R
         rf98Z/lSNf5YtmClN75wICZK3OMP16CxgRPlzCt5ruCJ4K1HZWLRCSESTJCqQfNM6awC
         GtJrV7+ivjoeyB8RBXhO4rR2vc9Qd+fedLNi85AmB2rb+tP32ZPavJxvwYc1ejPq8UpV
         77xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701818; x=1780306618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bG2lZTq0AlonyzQJsp3hruKHT4bKY6rEQmFhRZ/Om5Y=;
        b=YtUx685qvijCe1o6LiNua85JOcNB/UPcEJcVNcSdgBy2+LLclhtPGKHu/z+qA7Ekq8
         sRSjTU8xvNccELqTiIpMwCPPWTJ1rmBab2KxIVUWyQ7BhLr74Jne1eYzMhHtIEOscbRq
         VsRHUyZ5+L1QpAYazfc08mgZaKCwXSR7b3PeKMeChi2IBPkudHqWSEgyq6eRHTb7lpPA
         DEAdRMtPqitFHVoQgKbVGlwAT1tpXkZWpimRwwi2k2n9/jvrC1RBx+SNCNJ4nrKNF+iJ
         j+EXyvwMEi17OcHvOjgueBMnCkOtCpV3pewRhpxROtrtf9RubMBwcnCpcf/pF2kpJn1v
         z6qA==
X-Forwarded-Encrypted: i=1; AFNElJ+rJ4w+ghsApeniehlJbOo4kozY2vqfn2eeRGsuMzwtKlOJbzVUZc7oDwXthOKv4Op8k5GIdX0t9O8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3aAlPZ93L2q6Ez/APj1DMEmgZSu+lRS1bH2nWe9TgSkywKB58
	zJF17A+088LCOogF7+aaWNpviGLSqwLvjWCdVWkqy6ds4sdLJxnMcrY4hyZF2iKEzs4LsKwJzmI
	E20NeZQcEID6RAgR+llusxHZytX8PwI4=
X-Gm-Gg: Acq92OEFqcajS5Pjodyyy2Dxw57zTgJOnmokmshYm03VehnOpr/kK6TY3Lz1/yCoF7x
	GAdQuBhHF8W9Y+fD/ERkjPZx8kIjuA6HSLwUDN9QDKlGhcW8fOVKc7N//2xmVVsl+yJehHtY4yS
	4Dmv3oVf7YKHpVpNpTNbw/cAbHO+5MpsSEpr9KWxePJwZzpRV28VuxAMuzzXtj+6UJzTfcPeyqP
	XoaPPeOHQvPgq7jps90wNGxGL3cZd2V4ndbZOPp26XE2brXiqN9rGbnzqZAF78CR6Ws8UcILsV7
	otpwCo5Ux3ERa3xjUJQFQl/Vrrz9Zw==
X-Received: by 2002:a05:690e:4383:b0:654:54f2:9e50 with SMTP id
 956f58d0204a3-65ec9775082mr9988663d50.25.1779701818177; Mon, 25 May 2026
 02:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
 <177889984452.2298656.1074391459031404894.b4-ty@b4> <7e68e745-0d70-46db-9475-38d3dd5b9cf4@baylibre.com>
 <6b945153-5a7b-415e-904a-1c350b7d52ee@gmail.com> <86ac46cd-b7bc-42cc-8c29-996ae21f3654@baylibre.com>
In-Reply-To: <86ac46cd-b7bc-42cc-8c29-996ae21f3654@baylibre.com>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 25 May 2026 11:36:46 +0200
X-Gm-Features: AVHnY4I_k1DJLPTVcDE4dQLLOOZPqA-S_Z9vI3VGZcAzyFnMwYf6XDaI2FWsQUo
Message-ID: <CABdCQ=M_E1uHU5WTXCn2mXaxf3-+7M9gXCL=tp1qBW50jf7d5Q@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 0/4] riscv: spacemit: enable SD card support
 with UHS modes for OrangePi RV2
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Andre Heider <a.heider@gmail.com>, Yixun Lan <dlan@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulfh@kernel.org>, Troy Mitchell <troy.mitchell@linux.dev>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Vincent Legoll <legoll@online.fr>, 
	Margherita Milani <margherita.milani@amarulasolutions.com>, 
	Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry, I've been on vacation and I haven't checked my emails.

El mi=C3=A9, 20 may 2026 a las 13:11, Trevor Gamblin
(<tgamblin@baylibre.com>) escribi=C3=B3:
>
>
> On 2026-05-20 03:53, Andre Heider wrote:
> > Hi Trevor,
> >
> > On 16.05.26 2:35 PM, Trevor Gamblin wrote:
> >>
> >> On 2026-05-15 22:57, Yixun Lan wrote:
> >>> On Fri, 15 May 2026 12:48:58 +0200, Iker Pedrosa wrote:
> >>>> This series enables complete SD card support for the Spacemit K1-bas=
ed
> >>>> OrangePi RV2 board, including UHS (Ultra High Speed) modes for
> >>>> high-performance SD card operation.
> >>>>
> >>>> Background
> >>>>
> >>>> The Spacemit K1 SoC includes an SDHCI controller capable of supporti=
ng
> >>>> SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
> >>>> currently lacks basic SD controller configuration, SDHCI driver
> >>>> enhancements for voltage switching and tuning, and power management
> >>>> infrastructure.
> >>>>
> >>>> [...]
> >>> Hi Iker,
> >>> I've picked patch 1-3, for [4/4] I think it should be merged after
> >>> https://lore.kernel.org/all/20260513071958.29574-1-a.heider@gmail.com=
/
> >>
> >> Hi Yixun,
> >>
> >> That makes sense. In response to your earlier feedback I had drafted
> >> a more
> >> complete dts after another schematic comparison, but Iker and I
> >> discussed it
> >> and opted to avoid changing scope too much. Andre's series includes
> >> the bits I
> >> wanted to add and more, so that works out.
> >
> > I have 4/4 rebased on my series anyway, do you want me to send it?
>
> If you have an update to make, please do!

So, how has this turned out in the end? Andre, will you take care of
sending the latest version for the MUSE Pi Pro?

>
> Trevor
>
> >
> > Thanks,
> > Andre
> >
> >>
> >> Thanks!
> >>
> >> Trevor
> >>
> >>>
> >>> Applied, thanks!
> >>>
> >>> [1/4] riscv: dts: spacemit: k1: add SD card controller and pinctrl
> >>> support
> >>> https://github.com/spacemit-com/linux/commit/2d77e577109967ef65f269c1=
fc1d6a659d4260fb
> >>> [2/4] riscv: dts: spacemit: k1-orangepi-rv2: add SD card support
> >>> with UHS modes
> >>> https://github.com/spacemit-com/linux/commit/2585c60ce2f977b13f14a67d=
1e3ed9c73fd7f381
> >>> [3/4] riscv: dts: spacemit: k1-bananapi-f3: add SD card support with
> >>> UHS modes
> >>> https://github.com/spacemit-com/linux/commit/c76e2f058cbcab84e4a703f2=
6857a58bdf6a0042
> >>>
> >>> Best regards,
> >
