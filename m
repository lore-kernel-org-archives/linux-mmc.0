Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316C2C4320A
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB196104F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhHDLZs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbhHDLZs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2021 07:25:48 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A8CC0613D5
        for <linux-mmc@vger.kernel.org>; Wed,  4 Aug 2021 04:25:34 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id y1so817990vsc.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2021 04:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRcASZ3r4m78SiEn9llZCC+xHa2OVesqEZ2kZNcyF+0=;
        b=R5Z8/Oydbv1DFgn8j2y86z75E7K0sgshC0AiuLpz/gXjctZZXH98alk93grLkC+3Yb
         ArE5iD44erF8OU1rN9zUSUYjtOV1CxMzrnO9UBK560P43Y0I5+vAv7wS6fn0Q25NLDHn
         XE98JEAWNsXf9e0jyyDj8c4kXptlXMPdmnABFMIT7kC1ZklVQ3x6ENHmzoLi+eok3rKA
         ChUJtFlanWvI4SGnSdBxpEOJIZuwCjgLtbaRTYIN6At0Eb65aVArjqMN0gW/3LAoeQIv
         Vu+6cBjo+nTXivlzHoACFPmbjg3ToMlHmDiaeAZHbJbW+xK123H+r+XWI12WZ23bmOcx
         b82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRcASZ3r4m78SiEn9llZCC+xHa2OVesqEZ2kZNcyF+0=;
        b=ZmPYcQ6++ss8VgPFFYPMKVc27CQyr3KK7ew/JkFWWhKqM20QQpEjj7uYJUWdoNXtz7
         3ent3/eP12cSu5NwVoEfcbqr/b+nOxXQt+0Fcvl9eGixvpfgdOs/HXNTsxoKD2ZGi1oa
         DzCOOkRSQNpACshYZ+kw7yiwo+cbPYN27LcvNpgVPJCKBwoP3IywU++QVlNviMpTAviR
         9iUXqYoj9lFr0RwYEmcVyy5GTjD53/tCV9ZThblK99UMge4QfFw8qMvwkLJO+6/lY1h8
         Fm3EIeIDtp76dMMhT2HQ4jh/UYPCnzDe+VTpQW0c6GgTAjsP7vA5gy/hQPZA2a2SMGjv
         XSqQ==
X-Gm-Message-State: AOAM5302O9x4JEvcLnO7SPRcDyAAEFygPzu3KwC5RmFUCbEPcBE/D/ix
        IATzbSiAMgMAWoLwrXt0z6FUF4eQabV3e5hQRylxyA==
X-Google-Smtp-Source: ABdhPJwig6I24W8HDdZeZnOfWowvG1PB4luybcJODAJTfb7WUf1LZR2JsC2EWkttRkxulCzH4iNjnoVBAiBF7Gz/a58=
X-Received: by 2002:a67:f6d8:: with SMTP id v24mr18645111vso.48.1628076333900;
 Wed, 04 Aug 2021 04:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210721140424.725744-1-maxime@cerno.tech> <20210721140424.725744-26-maxime@cerno.tech>
 <20210723215724.GA2661499@robh.at.kernel.org>
In-Reply-To: <20210723215724.GA2661499@robh.at.kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 13:24:57 +0200
Message-ID: <CAPDyKFr8-+zqhZfALux8p6XaDbR2T-DSP=_Kx_6p_LqdCrmCAA@mail.gmail.com>
Subject: Re: [PATCH 25/54] dt-bindings: mmc: Convert MMC Card binding to a schema
To:     Rob Herring <robh@kernel.org>, Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        DTML <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 23 Jul 2021 at 23:57, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jul 21, 2021 at 04:03:55PM +0200, Maxime Ripard wrote:
> > MMC Cards can have an optional Device Tree binding to add
> > non-discoverable properties.
> >
> > Now that we have the DT validation in place, let's convert the device
> > tree bindings for that driver over to a YAML schema.
> >
> > Some of these properties were already described in the MMC controller
> > binding, even though they are not generic and do not apply to any
> > device, so we took the occasion to fix this.
> >
> > Cc: linux-mmc@vger.kernel.org
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  .../devicetree/bindings/mmc/mmc-card.txt      | 30 ------------
> >  .../devicetree/bindings/mmc/mmc-card.yaml     | 48 +++++++++++++++++++
> >  .../bindings/mmc/mmc-controller.yaml          |  6 ---
> >  3 files changed, 48 insertions(+), 36 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt
> >  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
> > deleted file mode 100644
> > index 8d2d71758907..000000000000
> > --- a/Documentation/devicetree/bindings/mmc/mmc-card.txt
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -mmc-card / eMMC bindings
> > -------------------------
> > -
> > -This documents describes the devicetree bindings for a mmc-host controller
> > -child node describing a mmc-card / an eMMC, see "Use of Function subnodes"
> > -in mmc.txt
> > -
> > -Required properties:
> > --compatible : Must be "mmc-card"
> > --reg        : Must be <0>
> > -
> > -Optional properties:
> > --broken-hpi : Use this to indicate that the mmc-card has a broken hpi
> > -              implementation, and that hpi should not be used
> > -
> > -Example:
> > -
> > -&mmc2 {
> > -     pinctrl-names = "default";
> > -     pinctrl-0 = <&mmc2_pins_a>;
> > -     vmmc-supply = <&reg_vcc3v3>;
> > -     bus-width = <8>;
> > -     non-removable;
> > -
> > -     mmccard: mmccard@0 {
> > -             reg = <0>;
> > -             compatible = "mmc-card";
> > -             broken-hpi;
> > -     };
> > -};
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> > new file mode 100644
> > index 000000000000..aefdd8748b72
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/mmc-card.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MMC Card / eMMC Generic Device Tree Bindings
> > +
> > +maintainers:
> > +  - Ulf Hansson <ulf.hansson@linaro.org>
> > +
> > +description: |
> > +  This documents describes the devicetree bindings for a mmc-host controller
> > +  child node describing a mmc-card / an eMMC.
> > +
> > +properties:
> > +  compatible:
> > +    const: mmc-card
> > +
> > +  reg:
> > +    const: 0
> > +
> > +  broken-hpi:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Use this to indicate that the mmc-card has a broken hpi
> > +      implementation, and that hpi should not be used.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: true
>
> Like what? If there's other properties, then there should really be a
> specific compatible.

I agree.

Maxime, thanks for working on this. I assume you will be sending a new
version that I can pick up?

[...]

Kind regards
Uffe
