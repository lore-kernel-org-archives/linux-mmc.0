Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5438C43334
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Jul 2022 23:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiGCXak (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Jul 2022 19:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiGCXaj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 19:30:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5044A60C8
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 16:30:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso6977055wma.2
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0i7LHTpr0Qs02RYvQ9FK25ZUcGAVk+CMPhPkGyyYYc0=;
        b=j7Cmflw53KduiV35so5cn/H+v2MNimUPIwYB6wsv6zgwd4ruUhjsO+mAWd0WB0VGCk
         D/ZcVy0CFw1UWNHXkVmrY3i75IPJ2JS/afY52cOU8XgDjhgg/e4VPRDnUbvry2ZndDC7
         qGr9vjL5SzwPqHjNiYJl5YH2UeldkdAAOdhGOViAohPa8Piwod3U5LiVIIJVYbEXgq0R
         e1TdFaJuQkb1hZDm/zHqB1ytmIouhMBMNHXYK8TXFbUMHJRj5B3xC5Z3i7XbqjExJefX
         VV8UoPqfQyt1sAd0hoo+GHqqhRPSaBYZ/tCNG/MSWq0zNjyUvfHezwTftBhRmEl32gg0
         E2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0i7LHTpr0Qs02RYvQ9FK25ZUcGAVk+CMPhPkGyyYYc0=;
        b=V0jXnRqTxfOP4k7LCtlVVNK3V9qCMFZvnAfQjhCo2ES2Q4dUw0Uqv0BZtO/AgatjIM
         123KIRrwn062czLbcsoRrzhO5F3tEG3FpT+/+QUoPmczTBp7lrsdLisYWAng2LzCu1Dl
         M9UsUQ4nV7CDjS+teRLAal+t+J7sEGNaccc7KfcOevXTW+iePwcZmqHms7FOygClAVDr
         clPDzwpfriOx80R7DiM/CP3uPp6iy3Vs8X8Y3qvG90xd+FkvvaBI8UP/v3PL+YioH4Yo
         LHp33+NLvRwcL+CLpP/dgRRnn5fDMXMH8LPkFScO/vdX+oqYBQ3TBrTHGDfQveVxZzbk
         RhbA==
X-Gm-Message-State: AJIora8jJBnCmRVYep09mKxWOa+Zi4UHNis0bKGztzjyFQWroUpaGhqq
        JUud6cAZ0CV9t+8SeoRKvq5q5bR9HkLbCF2ASY18fg==
X-Google-Smtp-Source: AGRyM1tMZmiXO90YVYtu4pSInZXF086cJpn/vm6bxdUWdK+8vIdFOCPpmeeMu9PaNCmghLGklEhRSKTstzUf942tBDg=
X-Received: by 2002:a05:600c:3505:b0:3a1:9fbb:4d59 with SMTP id
 h5-20020a05600c350500b003a19fbb4d59mr4530172wmq.165.1656891036902; Sun, 03
 Jul 2022 16:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-7-brad@pensando.io>
 <20220614213036.GA2660642-robh@kernel.org>
In-Reply-To: <20220614213036.GA2660642-robh@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:30:26 -0700
Message-ID: <CAK9rFnzyKz3BHfMp8ENu+BxY4xyp3iNvnMW_M2KTPyPrfL_RNg@mail.gmail.com>
Subject: Re: [PATCH v5 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
To:     Rob Herring <robh@kernel.org>
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
        Randy Dunlap <rdunlap@infradead.org>, samuel@sholland.org,
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

Hi Rob,

On Tue, Jun 14, 2022 at 2:30 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 12:56:49PM -0700, Brad Larson wrote:
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
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> > new file mode 100644
> > index 000000000000..13356800b1cf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMD Pensando Elba SoC Resource Controller bindings
> ...
> > +patternProperties:
> > +  '^reset-controller@[a-f0-9]+$':
> > +    $ref: ../reset/amd,pensando-elbasr-reset.yaml
>
> /schemas/reset/...

Changed it to
       $ref: /schemas/reset/amd,pensando-elbasr-reset.yaml

> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    spi0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        num-cs = <4>;
> > +
> > +        spi@0 {
> > +          compatible = "amd,pensando-elbasr", "simple-mfd";
> > +          reg = <0>;
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +          spi-max-frequency = <12000000>;
> > +
> > +          rstc: reset-controller@0 {
>
> Only one child does not make a MFD...

Looking over the approaches for other SoCs with an external
required controller (cpld, fpga) this appeared to be an
acceptable choice.  This device is accessed by several
different utilities/programs via /dev/pensr0.x, CS0 registers
for a variety of control/status, CS1 designware i2c master/slave,
CS2 lattice dual i2c masters, and CS3 for flash.

> > +            compatible = "amd,pensando-elbasr-reset";
> > +            reg = <0>;
> > +            #reset-cells = <1>;
> > +          };
> > +        };
> > +
> > +        spi@1 {
> > +          compatible = "amd,pensando-elbasr", "simple-mfd";
> > +          reg = <1>;
> > +          spi-max-frequency = <12000000>;
>
> 'simple-mfd' implies there are child nodes, but you have none. Is this
> complete?

This function is a designware i2c master/slave for board peripheral
access.  Removed simple-mfd.

> > +        };
> > +
> > +        spi@2 {
> > +          compatible = "amd,pensando-elbasr", "simple-mfd";
> > +          reg = <2>;
> > +          spi-max-frequency = <12000000>;
> > +          interrupt-parent = <&porta>;
> > +          interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>
> This one has interrupt but the others don't?

Yes, this function is a Lattice dual I2C master for transceiver
management.  The spi to i2c driver is not included in this patch set for
essential Elba SoC support.  Removed simple-mfd.

Regards,
Brad
