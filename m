Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A370DC433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 09:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AA12068F
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 09:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWYP0KD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgHYJ0U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgHYJ0R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 05:26:17 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA72C0613ED
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2020 02:26:16 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id i129so5966069vsi.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2020 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXBH4sOkqPl9zJcXTUASMt/Fu8TtonsFgui8Kl7kFVY=;
        b=TWYP0KD8mtsXXsDXuppZAwQQ67rPdc4tICCU7GvKYEWHxBchEiOadVBDgc3Z8BF4XO
         jgTMzMeNoBBJVXZQfk3AMdbGvkgTBbqlpoiA7C9nNtGeaBxLnx3jEK/vv9nFlnPh9/DJ
         TgJ990nDyVQNC1Kk3CDHNeM0HolTeK2JGc+JeKc0Asg0tf53T/j0z1oYXEUe3TmHHahK
         DMXwFbejlBBLFqp1266S1YpJxC8PokIgG47WLH6Q6IrqGhqIXC4/t/ES0j/TyzAtHMVh
         qHLuYP8F/xPcgPYas5khMHfmzHbhhXfPMw8lKgklue4eg9EkJZXUlSnL6zfYM93OJ86S
         K39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXBH4sOkqPl9zJcXTUASMt/Fu8TtonsFgui8Kl7kFVY=;
        b=RR0bkcegHtxnGDOqav8IKPrH/LEUhDiJmnd+MaZiMpKEH8E/RMzMYn5uPkhHmyCDlw
         8bFEXk3lInm7CyiiSXBU6sbKFdjW8U9o91t5x7HqoDcFG6g+UxLrk4DQVWI48JEAYsS+
         c3L/XOC56p/mV5cAXRfjQFPsmKInQ8gUIbaLmbRcSK3c4sf3CbtJeqxlglVF3ogXHafO
         RRgvJty3BeKm+wY/GRahipvKfOzD/6Pu84AH+xjC862kzmlAvAndIHQSUfpgOdo0YPlJ
         I0xvGaQSYfV2GPmBv4cnKzmErao4xIqXQmOZwzby9OIl6UxAuRa1O7N4LorohQueuiYk
         cQXg==
X-Gm-Message-State: AOAM532ey8ejzcYyo1x0ytfHNb2R2Iiy1NW/9X6sJ1hCoZqs+UnrxX8f
        ClSm0lRoeDgjaBRB19w0I43GvKmYmT8dC9FjPTXfRg==
X-Google-Smtp-Source: ABdhPJzPB9driK8H4qkeuT9S/aH4aByKHE7EXpTg6JCgldVacqxODAO1rUsFRonHGhpGwdxbkweJVIM8uPGeKAfsn/U=
X-Received: by 2002:a67:8c06:: with SMTP id o6mr5214822vsd.200.1598347574303;
 Tue, 25 Aug 2020 02:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200824151035.31093-1-lars.povlsen@microchip.com>
 <20200824151035.31093-2-lars.povlsen@microchip.com> <CAPDyKFoBom1n4AHniiukPiE_szskHrhcmVXfMpKTvNo9Xw9v0w@mail.gmail.com>
 <20200825084752.GD2389103@piout.net>
In-Reply-To: <20200825084752.GD2389103@piout.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Aug 2020 11:25:37 +0200
Message-ID: <CAPDyKFrCxmpfH9DQNyeWdGEgRVpB9B9qdowpTgSvF+f+MgQeSA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: <soc.lore.kernel.org>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 Aug 2020 at 10:47, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 25/08/2020 09:33:45+0200, Ulf Hansson wrote:
> > On Mon, 24 Aug 2020 at 17:10, Lars Povlsen <lars.povlsen@microchip.com> wrote:
> > >
> > > The Sparx5 SDHCI controller is based on the Designware controller IP.
> > >
> > > Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> > > ---
> > >  .../mmc/microchip,dw-sparx5-sdhci.yaml        | 65 +++++++++++++++++++
> > >  1 file changed, 65 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> > > new file mode 100644
> > > index 0000000000000..55883290543b9
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> > > @@ -0,0 +1,65 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mmc/microchip,dw-sparx5-sdhci.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Microchip Sparx5 Mobile Storage Host Controller Binding
> > > +
> > > +allOf:
> > > +  - $ref: "mmc-controller.yaml"
> > > +
> > > +maintainers:
> > > +  - Lars Povlsen <lars.povlsen@microchip.com>
> > > +
> > > +# Everything else is described in the common file
> > > +properties:
> > > +  compatible:
> > > +    const: microchip,dw-sparx5-sdhci
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +    description:
> > > +      Handle to "core" clock for the sdhci controller.
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: core
> > > +
> > > +  microchip,clock-delay:
> > > +    description: Delay clock to card to meet setup time requirements.
> > > +      Each step increase by 1.25ns.
> > > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > > +    minimum: 1
> > > +    maximum: 15
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +  - clock-names
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/clock/microchip,sparx5.h>
> > > +    sdhci0: mmc@600800000 {
> >
> > Nitpick:
> >
> > I think we should use solely "mmc[n]" here. So:
> >
> > mmc0@600800000 {
> >
> > Please update patch3/3 accordingly as well.
>
> This is not what the devicetree specification says. 2.2.2 says that the
> generic name is mmc, not mmc[n]. Since there is a proper unit-address, I
> don't see the need for an index here.

You are absolutely right, thanks!

My apologies for the noise!

>
> >
> > > +        compatible = "microchip,dw-sparx5-sdhci";
> > > +        reg = <0x00800000 0x1000>;
> > > +        pinctrl-0 = <&emmc_pins>;
> > > +        pinctrl-names = "default";
> > > +        clocks = <&clks CLK_ID_AUX1>;
> > > +        clock-names = "core";
> > > +        assigned-clocks = <&clks CLK_ID_AUX1>;
> > > +        assigned-clock-rates = <800000000>;
> > > +        interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> > > +        bus-width = <8>;
> > > +        microchip,clock-delay = <10>;
> > > +    };



Kind regards
Uffe
