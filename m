Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E0428B7EA
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465212; cv=none; b=oaS/qZfAYgUuayqWQuPMbLj8XXnWBhmm6gl4cf03fHib6IhYl1U8ldiwPjGsC3t8ipl3lWSzxJUmZ5JiaSMYC02P6tV5b2VrETDvUPwyPdeqfAoHWRlIfFM6VcdCT1Bl+STzT4tKhcemMAIkiL1OwncnIFZ5UYLVPEJq3lVrKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465212; c=relaxed/simple;
	bh=J9pqhe3rEd28EB+7QM4Mt7JtYR/l/3S7v8/M/aaqFQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dl1/nkf300uO+OwUAlMtNj24SyMor4wP042DtbmYk3ZgK3PYAp+w7gxwMvmXWcHrkJrU4B32raa4CFqe0xeAlU2GB5LERuLwLGEGUeel8BoqTPxYvKKFYL7VC8tSDTsOmzAiYKejMjbN+tYWmOMghhuthAN4uBn0pnw8ytpMoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-516d6402264so6778221cf.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 08:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779465210; x=1780070010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mat1V267K7OB4qn2fEb5sEkdQiWDnrER2vm5Q5jlK3U=;
        b=OZrEsuOlxr0gh5UDYmkzvqI1ZlCY8aluhvFBPRGkV2uMkQ9uNZYIgboTsf+BaDNvxJ
         s/MSKH1HXHpeI8XPTPxR6x4GVnL9StK5tj/JWpNRwZDDgEmnVRmulgqdzw3aVJOcb+n3
         UQbwyJqIJBtSOsajNkTgC63cmgX9PIyMwJLCaSxkg7pzLNtAQkPf6jU+F2+e76E0YSOT
         JR6/FNTfXuTcVxU1xoj8vzg70KDA2iv2QB6QgoEH4PaAmjGCbt1J3PryUUbm68ulcMb6
         uveVd3V6SUaw5J8RGr4lYVI0c/38ZGqX/2L4iBl0Kv8qoKHURdMwoUZrkM9VGLGyy6jy
         X1Ig==
X-Forwarded-Encrypted: i=1; AFNElJ94K53q7VdeIVQBM3CO1aU2k8HsouoOBLp+og/em9gPisEsBs7gSOQPBU+MRBYoeMXeD6haj0FmeSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxamYSS1z0sRA+Dk/B5B6ikQATyIEwyEPW76vcF/n7ToOujUwm9
	yOMzgnQO+39/J+LKBofusBFD8+1+z6r+oTmwtAu/aafPbw/TDpb57bgZp1ytqu3sx+o=
X-Gm-Gg: Acq92OHzQKEtsl1XuDy/NmMM6irRmfqII/NI+7omh6H4gcjpLZfUta7wu3ie/C5wPhu
	yTKbFlDzuQx/2/S1/RtYUjDF3p+aTCvt5VcoYP1K9pVT4csSWl/WnHHPVkE2/FTv4hNmknxaimk
	wwAtlvwgSPDHSp0LnhwCVIaPI8r/t721TZ8jQk+BtikIp9GAq7iRWbvGOFrJRo5A0+SeVeB+szQ
	CiGa++76bG+G36Uh6GaOHNdtBZ6kR4ZE6edIGkES/sGWhueEhQOOuu+3TgbZKj71wgQeuPA1eX4
	YRG6/yZu2nhZssyJb9GQu6Sb7/2lReZOAycPMg8h1LL7UOlWocRVZwbq7RZ7NU48p3ghMCDQehx
	JpHOCVx7tAHDi2hT9Uc5f496HoqOj6Z3VE0B4CmlPDcbuDGDU7FSE0MrtDtd6M9DV2VLmkmJ7WD
	ikx/uLupCFLid39dS2ks6kYNW7UcQc3Z7Yc7hfufClLbI9plmvmGZZxNCf3Y+VzDhJ0fLn9M8=
X-Received: by 2002:a05:622a:18a4:b0:50d:db76:55cd with SMTP id d75a77b69052e-516d43d9c7cmr58564511cf.52.1779465209500;
        Fri, 22 May 2026 08:53:29 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b00143sm16930081cf.3.2026.05.22.08.53.29
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 08:53:29 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b7105dfb35so96437296d6.3
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 08:53:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+NAaKrW4+zTHE5omDXXhpoQXyC6pTQnkgk9e6/zC66mv3jCnDiUXKrAupC0fKBiARBiZsD5Z65xQA=@vger.kernel.org
X-Received: by 2002:a05:6122:3402:b0:56a:fff5:b4d6 with SMTP id
 71dfb90a1353d-5865e2b5250mr2614239e0c.4.1779464839874; Fri, 22 May 2026
 08:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org> <20260504144534.43745-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260504144534.43745-8-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2026 17:47:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwantdbvPSFoYm=+_OoQQkKwz+K=qwWgy-7tSp1BNJBw@mail.gmail.com>
X-Gm-Features: AVHnY4IbX-4yvb6-_QqYAmKEvB5Pw7JiMigOp3rN1DUejXGr6NhPRl6ad5aF2d4
Message-ID: <CAMuHMdWwantdbvPSFoYm=+_OoQQkKwz+K=qwWgy-7tSp1BNJBw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: renesas: r8a779md: Add support for
 R-Car M3Le R8A779MD Geist
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Nguyen Tran <nguyen.tran.pz@bp.renesas.com>, Brian Masney <bmasney@redhat.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Mon, 4 May 2026 at 16:46, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> From: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
>
> Add support for the Geist board based on the Renesas R-Car R8A779MD (M3Le)
> SoC, a register-compatible variant of the R8A77965 (M3-N) with reduced set
> of peripherals.
>
> Signed-off-by: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> V2: - Drop CS2500 variant suffix
>     - Drop cells from rcar_sound ports {}
>     - Drop ehci1, ohci1, usb2_phy1
>     - Drop Salvator-X reference from commit message
>     - Split panel DTO into separate patch
>     - Drop FCNL node
>     - Add another memory node for the second 2 GiB of DRAM,
>       although the DRAM layout is patched in by U-Boot
>     - Drop FIXME from audio-clkout {}
>     - Sort nodes without unit address
>     - Rename regulators, use npmv suffix for n.m V regulators
>     - Rename x12 node to x12-clock node
>     - Add PHY compatible string
>     - Use interrupts-extended in PHY node
>     - Rename clk_multiplier/clock-generator to clock-controller
>     - Use interrupts-extended
>     - Reinstate port@0 to rsound
>     - Drop iommus from SDHI2
>     - Drop DU until it can be tested

Thanks for the update!

--- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a779md-geist.dts

> +&avb {
> +       pinctrl-0 = <&avb_pins>;
> +       pinctrl-names = "default";
> +       phy-handle = <&phy0>;
> +       tx-internal-delay-ps = <2000>;
> +       status = "okay";
> +
> +       phy0: ethernet-phy@0 {
> +               compatible = "ethernet-phy-id0022.1622";
> +               rxc-skew-ps = <1500>;
> +               reg = <0>;
> +               interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
> +               reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
> +               reset-assert-us = <100>;

10000?

> +               reset-deassert-us = <100>;

300?

> +       };
> +};

> +&pfc {

> +       pwm2_pins: pwm2 {
> +               groups = "pwm2_a";
> +               function = "pwm2";
> +       };

Shall I drop this while applying?

> +&pwm2 {
> +       pinctrl-0 = <&pwm2_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};

Shall I drop this while applying?

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
