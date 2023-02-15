Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F07C636CC
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 12:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjBOMW1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Feb 2023 07:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjBOMWZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 07:22:25 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E534F6C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 04:22:21 -0800 (PST)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 07C383F4A8
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676463740;
        bh=Ys8CZojIwyiyHL3vfQqMFK60gwHNRkm+YvncjitOGyM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Dms7QUaYkTOjMjSg/LyTj8P/y0nIyJ99OhkzCDZWfPm6aVMgPBdpYegdpfVoPiTR7
         eCwem20n1KmiSDLhaMnKNMmUuvl2D3QMH8P/gpc5OA7l//aDLryi7r2Sdt3EkfwrZk
         8i5mmsdg+1N7vpiarI3qwmPGtwOqjb4bpXGCjUgxqVrMWefUvoltSbYXY7RTZ9z3Qx
         2Z6i9hhnM237d5ThAnCGvHrEJWbRFkASMn9A6/kyP7ndw8wCSv/WyaQxMxRUjiNk+j
         NArGIFqaJrnPMBCY5O+TyrU7u+CiC4O753TT0EF+kZLrFPL3dLkFDKcc7ISkrclZbx
         eAtqjBQu54rng==
Received: by mail-qk1-f198.google.com with SMTP id s7-20020ae9f707000000b007294677a6e8so11361984qkg.17
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 04:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ys8CZojIwyiyHL3vfQqMFK60gwHNRkm+YvncjitOGyM=;
        b=w/nmovebG3kGty0NKCD19anKf/Ls3p+QJPUZekHcqqxzSbzuPJpALZIChokdEOS2Lx
         s52BQf9BrVffwf/PmHWToV3TwseFsApUQDa4A9oObIokjLSHwbnTMpGgzONWzhKZfxPT
         DaxDOHv9me9RhoBX+ta0tE1kew6nlPlrP9idynVlptVbMB2oXSARqZlKrb4E36a9YJTp
         RjtMy0A72q7hLXbxTLP9PVKmluun18hZg7a3wineLy3EvLWZcT9/lFpG8h3CoSXbPJdP
         +lMYgRY49NXTXZD8mP9mjFKfmLgFBW/T7zDI0ezD4l+w2SFDKAoRgujfAZQatkdflcO8
         zMmg==
X-Gm-Message-State: AO0yUKX0oCuIRs95ztZHkgwmD2bI9PA+BVRBlKyvo+rBa7nzkdbGkFNb
        fWwpOjLQK6Qlj5B1WuGALAokqjll/Nb/R6cfFkcrkK3W7uDISnZZCXTUhCauSyCf+Bc7tHYqxlE
        mx3uUMFbR4xMZJDcUYobSGuZnH6hi3IYqdFAzh+nGDxnYgsz3MZGU5Q==
X-Received: by 2002:a37:4249:0:b0:73b:3411:48b1 with SMTP id p70-20020a374249000000b0073b341148b1mr99314qka.219.1676463737793;
        Wed, 15 Feb 2023 04:22:17 -0800 (PST)
X-Google-Smtp-Source: AK7set8VCvji9WHmh+GciDNEQcXCQUKLSVfuPNnOPdx+AWLSQHOdX7DU6aUZf6xJQbp70/suV8jyyvielU6wnwPhUbQ=
X-Received: by 2002:a37:4249:0:b0:73b:3411:48b1 with SMTP id
 p70-20020a374249000000b0073b341148b1mr99312qka.219.1676463737464; Wed, 15 Feb
 2023 04:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-4-william.qiu@starfivetech.com> <CAJM55Z8gVEZS4Ws2Gi7_JbdkS-4y3_8mQvR4ZxLCWZ4A1y9X1g@mail.gmail.com>
In-Reply-To: <CAJM55Z8gVEZS4Ws2Gi7_JbdkS-4y3_8mQvR4ZxLCWZ4A1y9X1g@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 15 Feb 2023 13:22:00 +0100
Message-ID: <CAJM55Z-h+CUmWtkn31Ek+qvxrOr5_Jz3QRRLqWYLz2A0E+h+rA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] riscv: dts: starfive: Add mmc node
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Feb 2023 at 13:12, Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> On Wed, 15 Feb 2023 at 12:35, William Qiu <william.qiu@starfivetech.com> wrote:
> >
> > Add the mmc node for the StarFive JH7110 SoC.
> > Set mmco node to emmc and set mmc1 node to sd.
> >
> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> > ---
> >  .../jh7110-starfive-visionfive-2.dtsi         | 23 +++++++++
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 47 +++++++++++++++++++
> >  2 files changed, 70 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > index c60280b89c73..e1a0248e907f 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > @@ -42,6 +42,29 @@ &rtc_osc {
> >         clock-frequency = <32768>;
> >  };
> >
> > +&mmc0 {
> > +       max-frequency = <100000000>;
> > +       bus-width = <8>;
> > +       cap-mmc-highspeed;
> > +       mmc-ddr-1_8v;
> > +       mmc-hs200-1_8v;
> > +       non-removable;
> > +       cap-mmc-hw-reset;
> > +       post-power-on-delay-ms = <200>;
> > +       status = "okay";
> > +};
> > +
> > +&mmc1 {
> > +       max-frequency = <100000000>;
> > +       bus-width = <4>;
> > +       no-sdio;
> > +       no-mmc;
> > +       broken-cd;
> > +       cap-sd-highspeed;
> > +       post-power-on-delay-ms = <200>;
> > +       status = "okay";
> > +};

These nodes are also still oddly placed in the middle of the external
clocks. Again please keep the external clocks at the top and then
order the nodes alphabetically to have some sort of system.

> >  &gmac0_rmii_refin {
> >         clock-frequency = <50000000>;
> >  };
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > index 64d260ea1f29..17f7b3ee6ca3 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > @@ -314,6 +314,11 @@ uart2: serial@10020000 {
> >                         status = "disabled";
> >                 };
> >
> > +               stg_syscon: syscon@10240000 {
> > +                       compatible = "starfive,jh7110-stg-syscon", "syscon";
> > +                       reg = <0x0 0x10240000 0x0 0x1000>;
> > +               };
> > +
> >                 uart3: serial@12000000 {
> >                         compatible = "snps,dw-apb-uart";
> >                         reg = <0x0 0x12000000 0x0 0x10000>;
> > @@ -370,6 +375,11 @@ syscrg: clock-controller@13020000 {
> >                         #reset-cells = <1>;
> >                 };
> >
> > +               sys_syscon: syscon@13030000 {
> > +                       compatible = "starfive,jh7110-sys-syscon", "syscon";
> > +                       reg = <0x0 0x13030000 0x0 0x1000>;
> > +               };
> > +
> >                 gpio: gpio@13040000 {
> >                         compatible = "starfive,jh7110-sys-pinctrl";
> >                         reg = <0x0 0x13040000 0x0 0x10000>;
> > @@ -397,6 +407,11 @@ aoncrg: clock-controller@17000000 {
> >                         #reset-cells = <1>;
> >                 };
> >
> > +               aon_syscon: syscon@17010000 {
> > +                       compatible = "starfive,jh7110-aon-syscon", "syscon";
> > +                       reg = <0x0 0x17010000 0x0 0x1000>;
> > +               };
> > +
> >                 gpioa: gpio@17020000 {
> >                         compatible = "starfive,jh7110-aon-pinctrl";
> >                         reg = <0x0 0x17020000 0x0 0x10000>;
> > @@ -407,5 +422,37 @@ gpioa: gpio@17020000 {
> >                         gpio-controller;
> >                         #gpio-cells = <2>;
> >                 };
> > +
> > +               mmc0: mmc@16010000 {
> > +                       compatible = "starfive,jh7110-mmc";
> > +                       reg = <0x0 0x16010000 0x0 0x10000>;
> > +                       clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
> > +                                <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> > +                       clock-names = "biu","ciu";
> > +                       resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
> > +                       reset-names = "reset";
> > +                       interrupts = <74>;
> > +                       fifo-depth = <32>;
> > +                       fifo-watermark-aligned;
> > +                       data-addr = <0>;
> > +                       starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               mmc1: mmc@16020000 {
> > +                       compatible = "starfive,jh7110-mmc";
> > +                       reg = <0x0 0x16020000 0x0 0x10000>;
> > +                       clocks = <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
> > +                                <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> > +                       clock-names = "biu","ciu";
> > +                       resets = <&syscrg JH7110_SYSRST_SDIO1_AHB>;
> > +                       reset-names = "reset";
> > +                       interrupts = <75>;
> > +                       fifo-depth = <32>;
> > +                       fifo-watermark-aligned;
> > +                       data-addr = <0>;
> > +                       starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
> > +                       status = "disabled";
> > +               };
>
> Hi William,
>
> These nodes still don't seem to be sorted by address, eg. by the
> number after the @
> Also please move the dt-binding patch before this one, so dtb_check
> won't fail no matter where git bisect happens to land.
>
> /Emil
>
> >         };
> >  };
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
