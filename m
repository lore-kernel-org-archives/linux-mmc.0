Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D43E7BC0
	for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781357377; cv=pass; b=r8rhzso0mAJSxd+qo0QqUYw8y7o5hQM9hbQV5qd3Yboo0RYcp8Ej/Po2YbSW2HYVL8twQkEc1bJqgSPbf7MQmSR/WQ3knUOqyz2aGmrpEZz2n2CKVAUdEfqjt/WhJ8LVHPQ+N7M6YgjhiPmBJ7PK+QsRAx+GcM8AKYWroqocUCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781357377; c=relaxed/simple;
	bh=wsQQihnWIaC9bVsScBSqsXKP42m3O6jphB6W8rtbIis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGQrlYN93VxKUdM8Q/v49Lrq3Yxu1ycWeIo36TMKSDlUahjaOrwYmZEuJuRmub8/JDFzKN9MSQTveYfCE7AB2LcYjcLc2x3G9NPeOFHU3oTJSIW+oZM22mHoTPV3HGolikOGmXcaKT3YJevZVxdF1RzikzxFFQcb0EkhXlVlKSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mtes44qw; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtes44qw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c27fc587ebso8102615ad.0
        for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 06:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781357374; cv=none;
        d=google.com; s=arc-20240605;
        b=WRZvxfil4PwKQQqWFmDYUVEnzvcGdNLRbeWEE4TD9Wd1vgKTfYTpcH65tDtgWRRoU2
         LrBN13otFTv50/867YWpCL5LMj3yooIfGzwaS49rW27WkxWa56n4aK7K8WkITRAm7c/p
         Vvk7vGQYWihgrVIXNnVpwTU8BPDZdGx2bHweEvm0HZLoktJAIUPGG79RovfodrMBvgKe
         Da3F8u5zkWjb9/CwfApkyjXH5qPTfJdN222uYdCqZiSjrL/3HLoI9cesaxiwE9dy5apc
         9OTqsrHdYt1SHscda2ixI9BqAMS7u1CCtQ5mZrU+DoUiyae6X41LrTjciKVoLCQIH7XJ
         gjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kUReiSsThHaQ8ouVdRpvuZtdgMCKvSl0l2ZSq4rDSXY=;
        fh=CSfdMuMwBk+89XuL2wabdWOwr1v9DeL+N5W7QAEY6DI=;
        b=dIIFzw3OnEIOncqeVq+gP+s3qh5XWJgX+J/5UbTb30Xsn8LT0Ot0qPARgIiCL8nNEO
         Y+Taa/GghPIDZJZswfYgCsbnJj3izVZRiiIcMjPm7vNtLgjqCf6QZubVDZO9lqW+NxAo
         3R/SXX729hHiZ3RcOejIrFPc7W3FxEFol3OzCJ+aSeovJXk7MyOfrbQZEPiTiv0FOz9c
         +IzbwMO4usWnKXDIGGdxd/rmnSP3OoOHb8k0eChS8Qdov4pHcXTlMhHIkOmEYPAcpFAL
         myw5ohrzrHXFAj/o7c+BqkGG8f9M/IZOby6Gz5PYDE4iDC/v35XldC0MxTk3hwRs2sHK
         uxiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781357374; x=1781962174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUReiSsThHaQ8ouVdRpvuZtdgMCKvSl0l2ZSq4rDSXY=;
        b=Mtes44qwrugkgCS6aRsvqfv6YZTHKg/jzMCd5taAipY/UHWh7JlupBvBJp6YXyW/Bt
         t5zJUSx5fOtZ/nR9Mv8Uu11JJdgVPK5VD96sn55UY2DDBX+U/7Sorp+rDneLEuVi4NII
         Fx3G9BXc9sHpJpXfYk5wUh+I4uNGnXP/Ss+mKdpsNy5r5pSBjBbJeAYpzCgbd4kNgFfH
         jJdV925cbJ98W/qBwghsdddVsr2Rm8OD/lhuLxP3xqykjLbs4CSdrw+1ef89TZgX7Hez
         otv2NFVhtlzQ5hQkB74vo3oAdqnLbYwVNlV5lX7DFf6n/2KT4G5SVjEubhFyTfdEzM3t
         7yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781357374; x=1781962174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUReiSsThHaQ8ouVdRpvuZtdgMCKvSl0l2ZSq4rDSXY=;
        b=H5vuvVFJFzOWTkV591fCwsexy6iBkb4PxPSNXC357W2DCh4OZUG/jX3Ev/oSPivgXo
         Mt5OCZ1gUkoOb7ZdCiPYlTFMOrhutXhEeqWXDfzr3Hgaq9uPmNvbF5hRJVFoy1Cb5IjG
         BLK3D4Gzso1AnjAHPKI0WY0sy44DQ3Hk/EnY9401FBwDFmVrjtOoBGnchKfhohIeddNQ
         5BUISyYoEstx6RDPpBrY6egXtsuKrxTBV+rZAeuzHeoIH2bOpfQHaNWdkAfOr1SimXZE
         kiB0iJVCgNVbXbYCG9SmsFzRgyuVNCHMizmQWORHUc8JFDCfftQbZIJcOipgI92U1EJO
         0FqA==
X-Forwarded-Encrypted: i=1; AFNElJ9k7rFvw5Na3JqGKeffNwt8KqT3qvUQ+upbuiCIqkWzopvYQzD+slkg/qO7s0yNYICCfaX6JspO8JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZ5J0N6LwAH78QP+21TUdpGLxLXFNlVs/weHChbtnJOAXYp5I
	yHdsRjKEqJMiapVhZ32mrISvCHldBl4d+DjCE6mSIJYIZmNG+MvlBs486R8t1dZ/Lv+J8LAhoeC
	wk7/aGPxAfhXqvvAUYKMfnDcwAGiElXVj1jbC48Q=
X-Gm-Gg: Acq92OFA3rcxh0ovWOtuEjGYv4JlGF75uJYwGPn9RfrYt7Cqo+4lZqv/dVNBCl15/Rm
	fRZfg/Gp4tRK1oRQl15olkAI0aOE7MDuYa3P7Sjss1RH348vsIP181Cfzx8VXQUVM0+jsdOjDte
	0NJ1ZVnDz8dTzOcb8L54zaHTbXLCL53UL/YcbWcuko8tbgFqZ+2QujQm/qss4apOcbSlRny3yGW
	yVRnyllQjbTM86chot0HtxFBL+6DDvSZqmewG2dD0IbYPClgwUMGugMlmCGwzzqwuKJsJ0IVFZJ
	XKSk
X-Received: by 2002:a17:902:e80a:b0:2c3:bab9:4961 with SMTP id
 d9443c01a7336-2c413eb775cmr83686445ad.34.1781357373928; Sat, 13 Jun 2026
 06:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
 <20260613-a733-dts-v1-public-ready-v1-4-7787c94681db@gmail.com> <yDDIdJcZRCmL2YwI2Wv_ng@gmail.com>
In-Reply-To: <yDDIdJcZRCmL2YwI2Wv_ng@gmail.com>
From: Enzo <enzo.adriano.code@gmail.com>
Date: Sat, 13 Jun 2026 09:29:22 -0400
X-Gm-Features: AVVi8CdCVOnyKliNLOkMVxlnWD8AwCxre4GYBDVtf8SuvuvseqhhiKAPW8eLEzc
Message-ID: <CAHWUu5HKy6g5aFbrriBz1cC7dQkss7x5pTBQ1qXe2NA=H2aejw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: add Radxa Cubie A7S
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

Thanks for taking a look.

> Besides sashiko bot comments, these pins should go to main A733 DTSI,
> like it's done for other SoCs.
>
> In any case, it's a bit early for DT. At least clocks should land before.

Agreed on both points. I'll move the UART0 pin definition into the main
A733 DTSI for the next revision, following the other Allwinner SoCs.

I will also hold off on sending a v2 until the A733 clock prerequisites
are in a better state, unless maintainers prefer a different ordering.
For now I'll keep this series as a checkpoint and continue tracking/testing
the RTC, clock and pinctrl prerequisite work.

Best regards,
Enzo

On Sat, Jun 13, 2026 at 7:37=E2=80=AFAM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Dne sobota, 13. junij 2026 ob 11:42:16 Srednjeevropski poletni =C4=8Das j=
e Enzo Adriano via B4 Relay napisal(a):
> > From: Enzo Adriano <enzo.adriano.code@gmail.com>
> >
> > Add the Radxa Cubie A7S board description with serial console and SD ca=
rd
> > boot support.
> >
> > Ethernet remains disabled until the GMAC210 wrapper, clocks, resets,
> > MDIO, PHY reset, PHY power, and link behavior are proven.
> >
> > Signed-off-by: Enzo Adriano <enzo.adriano.code@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/Makefile             |  1 +
> >  .../boot/dts/allwinner/sun60i-a733-cubie-a7s.dts   | 48 ++++++++++++++=
++++++++
> >  2 files changed, 49 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/d=
ts/allwinner/Makefile
> > index d116864b6c2b..824cc35152db 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -56,6 +56,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h700-anbernic-rg=
35xx-2024.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h700-anbernic-rg35xx-h.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h700-anbernic-rg35xx-plus.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h700-anbernic-rg35xx-sp.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun60i-a733-cubie-a7s.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun55i-a527-cubie-a5e.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun55i-h728-x96qpro+.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun55i-t527-avaota-a1.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun60i-a733-cubie-a7s.dts b/=
arch/arm64/boot/dts/allwinner/sun60i-a733-cubie-a7s.dts
> > new file mode 100644
> > index 000000000000..453761a96323
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun60i-a733-cubie-a7s.dts
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> > +
> > +/dts-v1/;
> > +
> > +#include "sun60i-a733.dtsi"
> > +
> > +/ {
> > +     model =3D "Radxa Cubie A7S";
> > +     compatible =3D "radxa,cubie-a7s", "allwinner,sun60i-a733";
> > +
> > +     aliases {
> > +             serial0 =3D &uart0;
> > +             mmc0 =3D &mmc0;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +
> > +     reg_vcc3v3: vcc3v3 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vcc-3v3";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             regulator-always-on;
> > +     };
> > +};
> > +
> > +&mmc0 {
> > +     vmmc-supply =3D <&reg_vcc3v3>;
> > +     bus-width =3D <4>;
> > +     no-mmc;
> > +     no-sdio;
> > +     status =3D "okay";
> > +};
> > +
> > +&pio {
> > +     uart0_pb9_pb10_pins: uart0-pb9-pb10-pins {
> > +             pins =3D "PB9", "PB10";
> > +             function =3D "uart0";
> > +     };
>
> Besides sashiko bot comments, these pins should go to main A733 DTSI,
> like it's done for other SoCs.
>
> In any case, it's a bit early for DT. At least clocks should land before.
>
> Best regards,
> Jernej
>
> > +};
> > +
> > +&uart0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&uart0_pb9_pb10_pins>;
> > +     status =3D "okay";
> > +};
> >
> >
>
>
>
>
