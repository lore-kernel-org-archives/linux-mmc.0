Return-Path: <SRS0=RtJ+=3D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AFCC33C9E
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 20:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B2524672
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 20:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RB4FekL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgANUMX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:12:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41808 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANUMX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2020 15:12:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so13145643eds.8;
        Tue, 14 Jan 2020 12:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vV+GJ0x1tGGP4SM4rLH+VCpE9DGndiHHm1uWDluzfFg=;
        b=RB4FekL2abu4zjxBeac2aIhtA1DQAYxku4TPR9xLduBUYzFIngDIvUVfWQl0NeSFGb
         foVcKgTtxAdlUNiPHyHsR3TAFANiNEknpe7Z+iwFIPR7H+VR8eBICh8MfO1KvRl9HoeX
         bT/JUkpT9TXwEW7Gzk+NAOXDtlxespc8KQULYfbJX4iYLAoNlpgMLtKt4cPjVl/td1Lq
         R18CdZfE713rmYAkkZEdn8xe33CUV55cn78GHb7YCcFeLce7T80FsBmt1lSBs2rMudRE
         MTDsrkBv7p68mTNKUayOrlvBGI62M7pnQB/x0T8UrOLSyWwa3SIhrlon2dWKpsGCAROq
         PTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vV+GJ0x1tGGP4SM4rLH+VCpE9DGndiHHm1uWDluzfFg=;
        b=rTiAMVh3GE8JkM9SB8uANx/N0TOn3QrX8437TPTpCztoNXl9hcolbTHIHAkBQuA0kT
         2/yGAFf0CMYoxmKKK0KXh3p/7p2YQUegBuOHXPARzWglqmEwaxWNAKekepIuyOLJDdzP
         Z1JB9pPvyjv6sesjqA+xGpqThYgVLirTm8vAUTgevpou1kqskm7ScXlhscPCnUm0lyXN
         8bWoYrB4WhdLwHMPXaRIjLpDHIFiVHH8CqZP5QR61fZ+A7ZKtAKz/jXyhe5z4116FeG1
         dPNVqaSqwvHG8EUNCOMOiPQHMb80cmS6W+iJfP1kigJqbUU9aRsYlguRD5Imx3OhUvVB
         Gjjg==
X-Gm-Message-State: APjAAAUiYOPdoqfH4QcZLoKHj/RNOC+rJlUMusKMPSwiPotXzrNv/YpU
        XDx7PHzS9PYHb+8S6oAQvBzGGBaNYKfURx0PVFI=
X-Google-Smtp-Source: APXvYqwHoUwmDQgURkLoCVvyH8XUPku3082WCJH6JAKtOp7e/sjyH/7MAV/ghZOjgmzWWNTr0yjJ3rWdoYSYd6hulbA=
X-Received: by 2002:a50:875c:: with SMTP id 28mr6886375edv.271.1579032741448;
 Tue, 14 Jan 2020 12:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20200112002459.2124850-1-martin.blumenstingl@googlemail.com>
 <20200112002459.2124850-2-martin.blumenstingl@googlemail.com> <20200113211020.GA12476@bogus>
In-Reply-To: <20200113211020.GA12476@bogus>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 Jan 2020 21:12:09 +0100
Message-ID: <CAFBinCAA1kGFqDbYXYVn9W9DRhOnk09WpjGqP5R9YTwu_5vSCw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: Document the Amlogic Meson SDHC
 MMC host controller
To:     Rob Herring <robh@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Rob,

On Mon, Jan 13, 2020 at 10:10 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Jan 12, 2020 at 01:24:57AM +0100, Martin Blumenstingl wrote:
> > This documents the devicetree bindings for the SDHC MMC host controller
> > found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
> > bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
> > HS200 mode (up to 100MHz clock). It embeds an internal clock controller
> > which outputs four clocks (mod_clk, sd_clk, tx_clk and rx_clk) and is
> > fed by four external input clocks (clkin[0-3]). "pclk" is the module
> > register clock, it has to be enabled to access the registers.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 83 +++++++++++++++++++
> >  .../dt-bindings/clock/meson-mx-sdhc-clkc.h    |  8 ++
> >  2 files changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
> >  create mode 100644 include/dt-bindings/clock/meson-mx-sdhc-clkc.h
>
> Fails 'make dt_binding_check':
>
> Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.example.dts:17:53:
> warning: extra tokens at end of #include directive
>  #include <dt-bindings/clock/meson-mx-sdhc-clkc.yaml>;
>                                                      ^
> Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.example.dts:17:10:
> fatal error: dt-bindings/clock/meson-mx-sdhc-clkc.yaml: No such file or directory
>  #include <dt-bindings/clock/meson-mx-sdhc-clkc.yaml>;
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sorry for that - I'll fix it in v5

[...]
> > +  clock-names:
> > +    items:
> > +      - const: pclk
> > +      - const: mod_clk
> > +      - const: sd_clk
> > +      - const: rx_clk
> > +      - const: tx_clk
> > +      - const: clkin0
> > +      - const: clkin1
> > +      - const: clkin2
> > +      - const: clkin3
>
> Kind of odd to put the output clocks in the middle of the list.
I'll have to re-send this anyways so I'll put clkin[0-3] at the start
of the list


Martin
