Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFA0C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 15:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbiD0Pnz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 11:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiD0Pnv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 11:43:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9564DC;
        Wed, 27 Apr 2022 08:40:40 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y2so4098557ybi.7;
        Wed, 27 Apr 2022 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LunjZ5CB5KTt5EtvVwtJm0bqy5erFaX/HOlxVgLsjJk=;
        b=fm1FDWTCSUZcXwP6iai9T/Ms5eK051gTDDDgmJYYA5X2uu2lfGJ0plw/6M0qbzG3zG
         x1CGP34Rj4AIx4I3CSKSe4z/1hIZaM7v0r+RuI4ohf0bCJ5JzrxdykhrCOc0JPQa3iwB
         gSELM4hbMFOA0K8KGirfVL4unIx+9SnHwNnZ8Tr2YoYxrUd1aiO6KCXwkuPa+FVccgsW
         wlvqZrumPKaiQYL9BPEpjJeO1dXB7igtjYQq1o0PCKmt0EZPmj7h20s4xWxSHfvb9ZrD
         V/f5RY4B9QDxPQpgBkGdFbF9ld922s/Ru3Ddt//HAJLfPi/4SzAeeVmMEQJSQ4dyMitk
         nhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LunjZ5CB5KTt5EtvVwtJm0bqy5erFaX/HOlxVgLsjJk=;
        b=JAWkwfHPl4/7QWqcJKf45rT2Cl0+AYuzqDTLmWhrDlqRXKkZqqH3RThlQ0I9wOYNnE
         ORG9SUHevjO2g9LJxzvcw4K0mkqX9Q0v9GYgBTDnDyhLCUziTgKTAQOj02mgSl6/Uq1k
         oqB7toDaGfLgcpHxLWGxQbPj3Xb3lOqfYMQdCzM17XQvS4Hk2b1YHb+wHqy43rrv6KUC
         Gc4EYoSReIYp29GHd0AnhRDxIFPIFKm1Rw1IqYoTj1JDwCYtrkduKXoI7ZY3loXLQTcG
         BiJkni51sbSqMQgJXiji9rA4gHOTgHEHMD0GYh/wEimqgyzuMWXT0yJkmyS07UTNxPxf
         05qA==
X-Gm-Message-State: AOAM531b+9rNU0V99WFGrkb6HgvF9x1Edh9dqEIor/DBKQf6b7V1TfMK
        IL14TL19mZamyJlYaK3AcJmM8fdt4o3Gczmrasc=
X-Google-Smtp-Source: ABdhPJxEM6FU9G+ZUeC6TKae8tD1r4cUbc36QcF8D8lCficfFuleOcpKJBEcOKkLDNEGBFR44k4I+MdxfFsbxzbTBbQ=
X-Received: by 2002:a25:9309:0:b0:648:b52e:4a63 with SMTP id
 f9-20020a259309000000b00648b52e4a63mr7543035ybo.503.1651074039575; Wed, 27
 Apr 2022 08:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220421182803.6495-1-kdasu.kdev@gmail.com> <20220421182803.6495-5-kdasu.kdev@gmail.com>
 <857e78dd-b8e8-d55e-3b3c-cbbfb7c98505@linaro.org>
In-Reply-To: <857e78dd-b8e8-d55e-3b3c-cbbfb7c98505@linaro.org>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Wed, 27 Apr 2022 11:40:29 -0400
Message-ID: <CAC=U0a2np9x3QGU8uqwu4RMQXBzvG5dTa91GOLfSh_+96LTPYw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: mmc: Add Broadcom optional sdio_freq clock
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        krzk+dt@kernel.org, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Apr 22, 2022 at 1:07 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/04/2022 20:28, Kamal Dasu wrote:
> > The 72116B0 has improved SDIO controllers that allow the max clock
> > rate to be increased from a max of 100MHz to a max of 150MHz.
> > Optional "sdio_freq" clock is used to drive the bus clock if present
> > optional property "clock-frequency" specifies a base clock frequency
> > in Hz that overrides the base clock frequency in the CAPS registers.
> >
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 29 +++++++++++++++----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> > index dccd5ad96981..1b45a918400a 100644
> > --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> > @@ -10,8 +10,6 @@ maintainers:
> >    - Al Cooper <alcooperx@gmail.com>
> >    - Florian Fainelli <f.fainelli@gmail.com>
> >
> > -allOf:
> > -  - $ref: mmc-controller.yaml#
> >
> >  properties:
> >    compatible:
> > @@ -42,23 +40,44 @@ properties:
> >      maxItems: 1
> >
> >    clocks:
> > -    maxItems: 1
> > -    description:
> > -      handle to core clock for the sdhci controller.
> > +    minItems: 1
> > +    items:
> > +      - description: handle to core clock for the sdhci controller
> > +      - description: improved 150Mhz clock for sdhci controller (Optional clock)
> >
> >    clock-names:
> > +    minItems: 1
> >      items:
> >        - const: sw_sdio
> > +      - const: sdio_freq # Optional clock
> > +
> > +  clock-frequency:
> > +    description: Should be the frequency (in Hz) of the base controller clock
> > +    minimum: 400000
> > +    maximum: 150000000
>
> Why do you need this property? The mmc-controller.yaml already has
> max-frequency, so maybe that suits your needs?
>

Yes I can use max-frequency, I will make the changes to patch 4/5 and
change 5/5 and send a v2 patchset.

>
> Best regards,
> Krzysztof

Thanks
Kamal
