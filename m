Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92909281341
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401119; cv=none; b=FUZwuy647qHIObegHrjDpj6T5viHtkBl79rUDLlacepSuOjBYCv6GOl3MGD2xz04aj8hw5S/fQQsw1maTD4jPCZHWbD4pxD2KG90Y/F3MZh/wFJ4og3mj2ASFB6xTMngEalru2WJsMQhCr/lxeYM/d0TVodXAdMZqMrnFF5+Wi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401119; c=relaxed/simple;
	bh=2RMd8TOLVHxevxDxNC2hXQNvxO8qy7FJKq0tM4xFWDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5gT+rR6WXxeHwHRtXN3cJll1/NkgPi2R2LvYlI1MQuBehZ7KcUcpdR7OkVO7aMJfjIlKoWzKcPBgX4j0P4Z3vwAu7pGzyEuzmV3+uaiqAwdeUSwrHbbVFo1rJJ5/12AlKI99H3s3qM/sS4iVCbbQpQT6bz2c8XkwFEs1tUXNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-9371f6f2813so907304241.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 02:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766401116; x=1767005916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZvGT0H4XrwC6oZYNGXDbHChZKorQ8JtBsqLTAqv8b0=;
        b=qnAAjdv/fmkEvzxGAwRH2Ysl7N/hv9JZXMLrKt2ncRUnOmASA4HILEpnLPSiaTsIzu
         9FRSYX4wl6KHu27cNGoa4t8/ZjK7ft5Dt+HOLOX3x/h/n2SSrQwX+RLvIvaL2PilJt8D
         nPvmzBpNGakXo+SO5emOxMH57yQeuQjzt04eEGyD4/roi524kmsS2w9m//myTDhISDtx
         Q9zTiN89h2kDhiIiG4lY/iFzCq8DYLdC6PG6gDTT3R5IazRhpfbM9LDt8DjXJhZY3Snr
         AM9Q7yxc9K6c1oUoAle+clZ4G5v8JyLSVCPjna0W1Sbc+cf0dvQ8JpfMM2VePHOMqCcg
         8bjA==
X-Forwarded-Encrypted: i=1; AJvYcCXiTovHDAYUapcgzE5W7bZeq8dceY4d2hXoduk7ugEO39Cr4vk8Hu2xPVpV/Qcel9hVyx5TiWmNVKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2ID0g01FmkYnt6zrgQ8O1GQMviX4Hwjv3DiV8ZvW44FecKZb
	BaAUIGpd7nD+w96mY/lUigmalBBT6Hlmdiu4ETaWAf8U+0FxKy9zgWCgrMMCeJDt9Zc=
X-Gm-Gg: AY/fxX6irpUv2y44V74/tpok4wa12BF1kyuFt86XfqTSbsfXE8tsl7ZtUAamIOxl3zr
	UXcGk7hA5yxrTUFe1vBcOych8Zu5kRB9bsDIlyWxOev0c4lX7qEIq7QJxRia/xm8ZpQ+Cn5V7vQ
	9Z8K2I9B0iwoopWcNStCzIwjpgjX7Z7IiPEdNS4TDICJeklBtkQVRVcs36oA/I4Vp1a44k9BsJ8
	Y1c/nTq9422gGwhHdkANr7KTUumPpLeLpD01HHWxZhNRa0BQ9HzvKDC8dEudrk6CzBCLKlNKKqs
	RcIyGVMo/rUyWTztUZREuESMvjYYDMlfSA6LnR310Mt7fy2L9rqsShyhgL6pDz9Ithj+nPn13VW
	kpzNoS+lxgF1/3A855E+ZvaPqPSqMQpEi3JXq9sXu53f7+GVA6td/KSKsou3r450Gfy2GF30udF
	QtTYChb70S4vqOgfphgSHGNrL37pHPv+g/YiBogf1LBdIyZDlHxW46KujF+AY=
X-Google-Smtp-Source: AGHT+IGM4wgjMJXx4QlC8BwSf5yTZAYnOr22ZCVuU3AdIxs+qGCMbHJUyh9xbwK8EC7xa/hFcbKxeg==
X-Received: by 2002:a05:6102:5493:b0:5db:fb4c:3a89 with SMTP id ada2fe7eead31-5eb1a6b77ecmr3297751137.19.1766401116260;
        Mon, 22 Dec 2025 02:58:36 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-943415169cdsm2907364241.0.2025.12.22.02.58.35
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:58:35 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9371f6f2813so907299241.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 02:58:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDv4UHDZBs6f8lvK3yB52SN3mfLQejH6ip7nOJ8ZMOnLiRemGeLmUGorvVkGQufkDUCUDuRNhaZYU=@vger.kernel.org
X-Received: by 2002:a05:6102:fa3:b0:5dd:b318:8a6 with SMTP id
 ada2fe7eead31-5eb1a656bf6mr3126682137.12.1766401115588; Mon, 22 Dec 2025
 02:58:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com>
 <20251201-rz-sdio-mux-v2-1-bcb581b88dd7@solid-run.com> <TY3PR01MB113465581E5F8BD6C45FB7DCB86DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113465581E5F8BD6C45FB7DCB86DBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2025 11:58:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV52FEGdW3Jqtn_=yhZ8h1hf5h9nn8d15Pkgmq7VJwnSA@mail.gmail.com>
X-Gm-Features: AQt7F2q0YOJcyHYc-yKCfd0Zxy7zMhTJdHjRwxfC8lQ_tc7MS1WxbilS5iTx4Xs
Message-ID: <CAMuHMdV52FEGdW3Jqtn_=yhZ8h1hf5h9nn8d15Pkgmq7VJwnSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: renesas,sdhi: Add mux-states property
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Josua Mayer <josua@solid-run.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	"wsa+renesas" <wsa+renesas@sang-engineering.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
	Jon Nettleton <jon@solid-run.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Mon, 1 Dec 2025 at 14:03, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > -----Original Message-----
> > From: Josua Mayer <josua@solid-run.com>
> > Add mux controller support for when sdio lines are muxed between a host and multiple cards.
> >
> > There are several devices supporting a choice of eMMC or SD on a single board by both dip switch and
> > gpio, e.g. Renesas RZ/G2L SMARC SoM and SolidRun RZ/G2L SoM.
> >
> > In-tree dts for the Renesas boards currently rely on preprocessor macros to hog gpios and define the
> > card.
> >
> > By adding mux-states property to sdio controller description, boards can correctly describe the mux
> > that already exists in hardware - and drivers can coordinate between mux selection and probing for
> > cards.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>

> > --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> > @@ -106,6 +106,11 @@ properties:
> >    iommus:
> >      maxItems: 1
> >
> > +  mux-states:
> > +    description:
> > +      mux controller node to route the SDIO signals from SoC to cards.
>
> Maybe describe 0 - state for SD and 1 - state for eMMC ??
>
> > +    maxItems: 1
>
> > +
> >    power-domains:
> >      maxItems: 1
> >
> > @@ -275,6 +280,7 @@ examples:
> >          max-frequency = <195000000>;
> >          power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
> >          resets = <&cpg 314>;
> > +        mux-states = <&mux 0>;
>
> On R-Car mmc/sd mux available only on SD2/SD3, so I guess you picked wrong node SD0??

What do you mean by this comment?
AFAIUI, this muxing is board-specific, and not related to the on-SoC
SDHI controller instance?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
