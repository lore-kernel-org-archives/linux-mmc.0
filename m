Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E79C43334
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Jul 2022 23:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiGCXmC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Jul 2022 19:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiGCXmA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 19:42:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3F60D4
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 16:41:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so6551167wmc.1
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2KxyRrp3TRn/WaQ777l/5OLDpcxpRs5tZ2huVSaFVE=;
        b=ekkt/b+97PkfY5eoJHudZ29CeSCQonrAT7vVbbRds8jlg6Ef1ps8U3SAP0qTX+klTx
         UVXeOhhPr9VLO5xjNlEngyYvn08QWJvKkjVGSetGqbtp84KFRaitMDhIJrCXx3ly8jsz
         WfiLZnvvpz3fdHrW6Xia1qR19pCDt2eEm173WzPPwcy7OeTNEmhVknFIxwAoRTQ8ypKP
         RoDIXdB+8Wm1Yfc4Syv4vs052cve7kAgambBqvHUKqru4YrCLFx3xWdlPrLIZNqMYmzi
         zxZkKZDlyHd+/gqvtN0qzaMkHRnJVmnwnNVLatXDtM+Sbm6S7QtY2c2l3SWdsS731+SM
         G7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2KxyRrp3TRn/WaQ777l/5OLDpcxpRs5tZ2huVSaFVE=;
        b=jMu76RzSIum9UuUzER76dqDONItEtCdioWVghPPshmse5apArRh4mGNoC9Q4aSSF64
         XdQGifDZ9QFD5UI8rasVSfZ295TW+cN7QxX1Xc1SGG4dc6Iez1zTvmddz/w5/msMiI3b
         YCBqiYtuU2QYNfDEp4KYkAWNaBxvwIOeK1yFU6hdLTebqYbm6jd8uo2xFVR8/0lNUU9r
         XQws/MGbV8mOtW5+oOq5QDkw33LCbnNr8nksRiPlsEbqnyAGlVh0L1VXknMiDUVyPRBY
         A+z/gECX3I7OQh2ZAwDqcdWvG9IZk6yFNmuK55qoYlhAo0cSFcKjC+V048jtlEVROQxE
         4j+w==
X-Gm-Message-State: AJIora9TTMZJjZ3/hPnwFo1W89jYCeetfSSHlIy3alCpVTjWiDj2WdLv
        RCVfT99WVGT8smzE7I3jPA822a11rzGx16FXCE4c0Q==
X-Google-Smtp-Source: AGRyM1syKWyVQnRX+KNFIh0qO1Fu/FxomivNEho5XvS7NURPSvHX18dDHeMCypu0UAYUcGAn76afZcnBPtD9SJzuJfc=
X-Received: by 2002:a05:600c:2051:b0:3a0:3c58:6ff6 with SMTP id
 p17-20020a05600c205100b003a03c586ff6mr29223882wmg.98.1656891712322; Sun, 03
 Jul 2022 16:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-7-brad@pensando.io>
 <b42b197f-2b11-cb6e-458a-ed12b2eb997d@linaro.org>
In-Reply-To: <b42b197f-2b11-cb6e-458a-ed12b2eb997d@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:41:41 -0700
Message-ID: <CAK9rFnwj0c5fuWk8TxxX_RBXDCBpEa8f-rh3V13BN_j_U7Fo7w@mail.gmail.com>
Subject: Re: [PATCH v5 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Krzysztof,

On Mon, Jun 20, 2022 at 5:56 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/06/2022 21:56, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > Add support for the AMD Pensando Elba SoC System Resource chip
> > using the SPI interface.  The Elba SR is a Multi-function Device
> > supporting device register access using CS0, smbus interface for
> > FRU and board peripherals using CS1, dual Lattice I2C masters for
> > transceiver management using CS2, and CS3 for flash access.
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
> > ---
> >  .../bindings/mfd/amd,pensando-elbasr.yaml     | 93 +++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> ...
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    spi0 {
>
> Just "spi"

Changed to spi

> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        num-cs = <4>;
> > +
> > +        spi@0 {
>
> "spi" is for SPI controllers. Use generic name matching the device.
> Usually this is "system-controller", however Rob pointed out your
> inaccurate bindings and example.

Proposed the below change node in the reply to Rob.  The model I
followed for this was the Altera mfd/altera-a10sr.c

spi@0 {
        sr_regs@0 {
                rstc: reset-controller@0 {

        dw_i2c@1 {

        lattice_i2c@2 {

        flash@3 {

Regards,
Brad
