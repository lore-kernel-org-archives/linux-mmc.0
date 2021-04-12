Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1DAC43470
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983AD61369
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhDLHxC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbhDLHxA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:53:00 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3032C06138D
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:42 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id x14so1473808vsc.5
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5tAIOEut2G3054EIg7bCkBctd6yDH8+rLtfOUTR48o=;
        b=cduuulxv3IgOu/JFsYqCWwmrm4ce7vjhwSGEoKc4uIlkMddY+8BkXOeKKSpaSU47vf
         2O83a1wjyYwcssEZ/JMduP3zZy2mANCZWRr3RxBn70eJo//NFRB2CxWWlRJqjOXotiyU
         cYRW+Pe+yDEYMiAqA1HOHRO4Ta+JkT1D63LFBMoR/RnUtFqZBwynWPv84NO4nbgCQIyh
         tm2XnzbnkxtTAqh8vGdwvwRI3kwl1fHatXFJR+qG+lti91uwj+T042w5Hr22N2H9RuCl
         berBPZUNKVsulEF7gof4UBGQvj3Yc6JvFUQF4XpclNCZcXxGiSGGWTNWjuMK+XiHBuXw
         EoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5tAIOEut2G3054EIg7bCkBctd6yDH8+rLtfOUTR48o=;
        b=m6k4LfdDwh6RP9lVphONnegogUfKd7OGDiwcSpai/vT6GUDIYMTPp6T0sA5kvKT4nf
         oBnpTRn/yITNOmww0qQ7AKLnn6XdcgpAL0whg9jaVY2wmyrfKJe8MWTTN6YOce0jUTdv
         ll+pPNJiX3QRKNhIZ/Zsgrlq4DPp4yh9klIUU6WFZk23zwvIarWrpWESHdOecfsLT+qU
         5B8oLb6oQvM3Q3R8CxFU6OeG9WEY8ya2P3mAz741gwrspBZkLTWl60CiTi0IPdSCy5SM
         uqumAxT8hPftzAtKS9zllimLPtM1jxiKvLrIg25I7CJMv/UP53go8lkUC9zuPcXv5HuS
         s0iw==
X-Gm-Message-State: AOAM5320pgOeF0RlZwUI3voUwLBEKl0hPBohIivpIwfP2IhJKpw5KLe0
        fIkLn5VJzteTE6q9WuS3BRod/RRni7tsL20f9Jh1DA==
X-Google-Smtp-Source: ABdhPJzXQko4Oa+rMCddcEjm7TcxUwBYD8Kc0TwBwRCdXEiz6L/2LDfgzl6WaOH9+tda91Ys1YWRlU/NO9d4qZtoooM=
X-Received: by 2002:a05:6102:21d1:: with SMTP id r17mr18456961vsg.19.1618213961994;
 Mon, 12 Apr 2021 00:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210406104802.20898-1-nsaenz@kernel.org> <20210406104802.20898-2-nsaenz@kernel.org>
In-Reply-To: <20210406104802.20898-2-nsaenz@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:04 +0200
Message-ID: <CAPDyKFrBSVooaNNiVgr12o9OLZ_3_0OExKBoW+QyLXftzR+8cw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: iproc-sdhci: Convert to json-schema
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835..." 
        <linux-rpi-kernel@lists.infradead.org>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 6 Apr 2021 at 12:48, Nicolas Saenz Julienne <nsaenz@kernel.org> wrote:
>
> Convert the brcm,iproc-sdhci binding to DT schema format using json-schema
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Applied for next, thanks! (I guess patch2 and patch3 needs a re-spin?)

Kind regards
Uffe


>
> ---
>
>  .../bindings/mmc/brcm,iproc-sdhci.yaml        | 63 +++++++++++++++++++
>  .../bindings/mmc/brcm,sdhci-iproc.txt         | 37 -----------
>  2 files changed, 63 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> new file mode 100644
> index 000000000000..6f569fbfa134
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/brcm,iproc-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom IPROC SDHCI controller
> +
> +maintainers:
> +  - Ray Jui <ray.jui@broadcom.com>
> +  - Scott Branden <scott.branden@broadcom.com>
> +  - Nicolas Saenz Julienne <nsaenz@kernel.org>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm2835-sdhci
> +      - brcm,bcm2711-emmc2
> +      - brcm,sdhci-iproc-cygnus
> +      - brcm,sdhci-iproc
> +
> +  reg:
> +    minItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Handle to core clock for the sdhci controller.
> +
> +  sdhci,auto-cmd12:
> +    type: boolean
> +    description: Specifies that controller should use auto CMD12
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/bcm-cygnus.h>
> +
> +    mmc@18041000 {
> +      compatible = "brcm,sdhci-iproc-cygnus";
> +      reg = <0x18041000 0x100>;
> +      interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&lcpll0_clks BCM_CYGNUS_LCPLL0_SDIO_CLK>;
> +      bus-width = <4>;
> +      sdhci,auto-cmd12;
> +      no-1-8-v;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> deleted file mode 100644
> index 09d87cc1182a..000000000000
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -Broadcom IPROC SDHCI controller
> -
> -This file documents differences between the core properties described
> -by mmc.txt and the properties that represent the IPROC SDHCI controller.
> -
> -Required properties:
> -- compatible : Should be one of the following
> -              "brcm,bcm2835-sdhci"
> -              "brcm,bcm2711-emmc2"
> -              "brcm,sdhci-iproc-cygnus"
> -              "brcm,sdhci-iproc"
> -
> -Use brcm2835-sdhci for the eMMC controller on the BCM2835 (Raspberry Pi) and
> -bcm2711-emmc2 for the additional eMMC2 controller on BCM2711.
> -
> -Use sdhci-iproc-cygnus for Broadcom SDHCI Controllers
> -restricted to 32bit host accesses to SDHCI registers.
> -
> -Use sdhci-iproc for Broadcom SDHCI Controllers that allow standard
> -8, 16, 32-bit host access to SDHCI register.
> -
> -- clocks : The clock feeding the SDHCI controller.
> -
> -Optional properties:
> -  - sdhci,auto-cmd12: specifies that controller should use auto CMD12.
> -
> -Example:
> -
> -sdhci0: sdhci@18041000 {
> -       compatible = "brcm,sdhci-iproc-cygnus";
> -       reg = <0x18041000 0x100>;
> -       interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> -       clocks = <&lcpll0_clks BCM_CYGNUS_LCPLL0_SDIO_CLK>;
> -       bus-width = <4>;
> -       sdhci,auto-cmd12;
> -       no-1-8-v;
> -};
> --
> 2.30.2
>
