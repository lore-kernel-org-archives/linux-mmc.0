Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE2C433EF
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Jul 2022 23:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiGCXee (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Jul 2022 19:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiGCXed (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 19:34:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0055FF3
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 16:34:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k7so11030117wrc.12
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 16:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyFcgjkxOJqhlIzFnDHCHXwpu/03I5/j46jEIBLpRDs=;
        b=ZGf1/ulEaAH+Amg0nAPAOaHgkQlWrSyAiM+Prhsz0T1foJ8ANwub12V/A+LPZUwpyO
         Qm2bJO4UpHYZg7LUIzqCLoKmSLA1iOWerLHLIYue3Y9xasf3lEbZSK+omcIIRJXGuxVr
         dCYLiFVUhfWrxHeRw6R99JMHC7wz0qmDb9ns9xkYFmFgriCQmf8gE6exYjDU1Z5W8Gxt
         nsaOCSLdj4x5IwwSCctppOlQxAYUe89IHIFCwNdury+d+RMTwahrW6zqQSdtxAyIvsvb
         KWNYJzDCfG/JfJ+XfX9jo9C9T9y6vhyYinS+v0YDLt9TYsD1zRuK3ATHlJ0ThcSgUJhq
         V7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyFcgjkxOJqhlIzFnDHCHXwpu/03I5/j46jEIBLpRDs=;
        b=XSsv8QbvEuQISy5wMR6LXBDDpLC36EF10oW79Q8dJTOPZM+gDc7pFv7dq/bukuBgfv
         cvze2xpwCncv77u4AL+0YCJ8RVe3hHbNlBSAzpau+F4sC1fJXSQobdZkaBQHnhuvM+Fj
         Q+qy582HFgDjtFO3jNbFKSfAks/R0/AnRhfg/52NFG43A88nC62V/bT/Ubm2gsK9BurM
         gMPhH16hwFwQK3cMTW2M3CI7ybciA4xZMOMtp8TWB06dxlCkgbJAhe0QZnlIMwuobdBK
         HpI+5UE6NapgM/Kt1JzK+92vGOn112spColxwNUM/NOa0efdJyteOpeGqJE21+dXE3H4
         cVCQ==
X-Gm-Message-State: AJIora/ZaeNB7p142HWvEHAa0sga2mbHehiWwKej4LgY7XRODKyoiIqe
        xiTlwiPLuIfkONYRS0BpggJN/Ux2QuZ/Mhfh5ymgUg==
X-Google-Smtp-Source: AGRyM1vBzH5KKASiEpCnhYCIMgsVi8wnrjqFtVHwFp235I5ofJlHH0/H1PEpPyz/dhYQNQuA9CG7IsbhiWquYliE1Q0=
X-Received: by 2002:adf:fb08:0:b0:21b:af81:2ffd with SMTP id
 c8-20020adffb08000000b0021baf812ffdmr24574990wrr.685.1656891269995; Sun, 03
 Jul 2022 16:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-8-brad@pensando.io>
 <20220614213212.GA2682090-robh@kernel.org>
In-Reply-To: <20220614213212.GA2682090-robh@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:34:19 -0700
Message-ID: <CAK9rFnwn6xA5VvgnBaDgEw3DTFukj9o_i-degV-F8wAHUmAm5A@mail.gmail.com>
Subject: Re: [PATCH v5 07/15] dt-bindings: reset: amd,pensando-elbasr-reset:
 Add AMD Pensando SR Reset Controller bindings
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

On Tue, Jun 14, 2022 at 2:32 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 12:56:50PM -0700, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > Document bindings for AMD Pensando Elba SR Reset Controller
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
> > ---
> >  .../reset/amd,pensando-elbasr-reset.yaml      | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> > new file mode 100644
> > index 000000000000..03bb86ebcfd3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/amd,pensando-elbasr-reset.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reset/amd,pensando-elbasr-reset.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMD Pensando Elba SoC Reset Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Brad Larson <blarson@amd.com>
> > +
> > +description: |
> > +  AMD Pensando Elba SoC reset controller driver which supports a resource
> > +  controller connected to the Elba SoC over a SPI bus.  The Elba reset
> > +  controller must be defined as a child node of the Elba SPI bus
> > +  chip-select 0 node.
> > +
> > +  See also:
> > +  - dt-bindings/reset/amd,pensando-elba-reset.h
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^reset-controller@[0-9a-f]+$"
> > +
> > +  compatible:
> > +    const: amd,pensando-elbasr-reset
> > +
> > +  reg:
> > +    const: 0
> > +
> > +  '#reset-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#reset-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
> > +    spi0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        num-cs = <4>;
> > +
> > +        spi@0 {
>
> 'spi' is reserved for SPI buses. I thought this was an MFD.

Looking at other drivers/mfd files the naming convention could allow
the following, how about this?

spi@0 {
        sr_regs@0 {
                rstc: reset-controller@0 {

        dw_i2c@1 {

        lattice_i2c@2 {

        flash@3 {

Regards,
Brad
