Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384C2C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 13:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388484AbiDUN6V (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388413AbiDUN6Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 09:58:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF61921E2D
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f5so5851707ljp.8
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzEPZD4SC3I9SVQDbsAF0F1Rh7CzBkbKno9SVHKNclE=;
        b=hVVJzRiOHbQ1DvCsfacjZTIvOgsTjjshIlvtvnLVwcm3Rrj8ItYANVLUNJGM3kBhYI
         qekT1/u9T/mx3cdf+pNK1CFnIeqpZ7ie1jYDHAkqx+IKRFtHH6LsKCB8AD7pglIGEr+k
         GeaVZzdNNyWf+6DGWeDJsfJiZvU5AKjZjz8VeoYvoLiQ+exa/uoIv7QkV43ibikf6Bde
         n/mrKC5vwc8tRe8BeqSsd78Ptwh5/n0+34RbJ2fo0lTLEW4jZrwrXlD02NbnoKljEPBk
         RlF1kya9OZdYIhF1Dda6nupcl263pICR0WEN3xhggWCE/cGgTHHFA+N8oV4ndBEDMR5A
         ys6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzEPZD4SC3I9SVQDbsAF0F1Rh7CzBkbKno9SVHKNclE=;
        b=DzkMGIOYP0/EA4X9+JkHDCy0jN/SvT4QvKklNtm5xgtV9LAfSewjUrjBl9dkjOTmBm
         Hv8pVO08OU3c9G4dwTGSVRBjpmoWvZiC8g2C64YhyYtFQF84Uf2xxEsncTqtXwVGb/IV
         zvcfHJwqPHdckYU7ZGqQMEFVTMlc/aTpHu8KaGhnACU66MIYpHY14SgJI4ZceaP6nDua
         bXhVA5D5f6YCrlZmgmh4bkowgBMhKix2Skunl/Wv/otLEHXijzDT6oFi8lQ0VEBzRSWk
         X7R1A0e7dSzn2fly/kbDeI9dXk4MdB6VlHZI3jwkZGf2HjBBKzzWJ/soe+pO0ucEvhni
         VmkA==
X-Gm-Message-State: AOAM530FeVCnyJ8+2ZD97hFGh3jFZPmlJpOc6ZJRZs/lK+XLc/ktiZFa
        MclW9eEl4wzyQiaDLIFGYMRr3ow/OEosuo+ruzCpxg==
X-Google-Smtp-Source: ABdhPJwdp7CwjJHxh38xo1mngfbcuKzywJgB4sJ2e01ZpDfXKMcYq4nHRTIm9dwvY/IUZLkqyoDgioE1u0ngCHX2XtI=
X-Received: by 2002:a2e:a552:0:b0:24d:c784:4b43 with SMTP id
 e18-20020a2ea552000000b0024dc7844b43mr8126261ljn.4.1650549323893; Thu, 21 Apr
 2022 06:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz> <20220419024611.1327525-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20220419024611.1327525-4-chris.packham@alliedtelesis.co.nz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 15:54:47 +0200
Message-ID: <CAPDyKFoPpWn+RNLRm02c2D779GeBW_rM2_jUprnD=jnKQT4xHA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: convert orion-sdio to JSON schema
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        adrian.hunter@intel.com, nico@fluxnic.net,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 Apr 2022 at 04:46, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Convert the orion-sdio binding to JSON schema.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Notes:
>     Changes in v2:
>     - Add review from Krzysztof
>
>  .../bindings/mmc/marvell,orion-sdio.yaml      | 44 +++++++++++++++++++
>  .../devicetree/bindings/mmc/orion-sdio.txt    | 16 -------
>  2 files changed, 44 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml b/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
> new file mode 100644
> index 000000000000..8a97ded15aed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/marvell,orion-sdio.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/marvell,orion-sdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell orion-sdio controller
> +
> +maintainers:
> +  - Nicolas Pitre <nico@fluxnic.net>
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: marvell,orion-sdio
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
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
> +    mmc@d00d4000 {
> +      compatible = "marvell,orion-sdio";
> +      reg = <0xd00d4000 0x200>;
> +      interrupts = <54>;
> +      clocks = <&gateclk 17>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mmc/orion-sdio.txt b/Documentation/devicetree/bindings/mmc/orion-sdio.txt
> deleted file mode 100644
> index 10f0818a34c5..000000000000
> --- a/Documentation/devicetree/bindings/mmc/orion-sdio.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -* Marvell orion-sdio controller
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the orion-sdio driver.
> -
> -- compatible: Should be "marvell,orion-sdio"
> -- clocks: reference to the clock of the SDIO interface
> -
> -Example:
> -
> -       mvsdio@d00d4000 {
> -               compatible = "marvell,orion-sdio";
> -               reg = <0xd00d4000 0x200>;
> -               interrupts = <54>;
> -               clocks = <&gateclk 17>;
> -       };
> --
> 2.35.1
>
