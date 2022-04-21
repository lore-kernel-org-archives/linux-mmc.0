Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57715C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 13:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388425AbiDUN6X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388444AbiDUN6V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 09:58:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210892F3BF
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f5so5852006ljp.8
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3q2L8qOa7E4CbmnWZ1IRjjqAGmAdBrIckl8Mvt7mq0=;
        b=rxKikIg5b+QBYUKVXiXKKsSGckta0fLxfg6TPyjZEiT0Iq5Ve/htbWEo19FXKNcm4C
         MhHtqhGwOD+1MEpZMHXIhqdoZmgDXqyabtxruNOt1fxUBxCK9Gwi/Q9b+LnPaoAfh1hA
         h/Z6gE1V1j8uHFsMOqXupSYGU7znTsr+rm+93Sel0G+80yNI0OIW5rL6wd/6j7U7kyd2
         mnvHui2nq5vUdIfG+lM4f0Cm68sl2FT7+v4JlLgTgw7BHsggqH16svZsvsgf8fZkECMD
         EnIkuQPtlv/Lvs9oHgEWuCOd9ZlnqLCgekx0cfaLlL6GQXdwbl5OpblI6eFrFFnC72y0
         UcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3q2L8qOa7E4CbmnWZ1IRjjqAGmAdBrIckl8Mvt7mq0=;
        b=TYtxKhphp92/63B3AW3oEpB0kZfVTugVH9Osaav0B3cPyWQa5lTDl+vBnBzwYO5HdV
         MPJzvHRxDABR8sk2J8UmxTn/LuKT9BCGIWpWHQQUA1Y62Ao9l9lKCEsiX7BEO89uqHXe
         q9e5QWXNCydItyNxehKRNqBokSZAPyDwbqFPYuB9SShCb9CfOAw7ctbDQI3q962Gr+o3
         dQ1Fs7zsQyNAQh4X6fG5oXtWg8cx3yvRFu3V5hnXZKsaisvZE7vo1N962xFiyzXwz9Dw
         fJW25+9LfzstvWmTB3sLJxkKAn2+1l5rA3gHIJFgU8Tnw7cAKFzcxchTOaHg4fu8NdMw
         /XJA==
X-Gm-Message-State: AOAM5323qW3hhDfWY+VwpKtlH40xlbc+HGcoFv0nVctvKWDarTdRvKiZ
        r/F29W9vdznbUD8asZnJWoIR1wVziTlGcLjKgpEsPQ==
X-Google-Smtp-Source: ABdhPJwXl5xankIhHSa/qr30MA+Ny7MT0iK7ss+aISZd89rCgZFc2m3LHuGi5tJdDrRbU1eKh9W0FfdEo24NQP8u980=
X-Received: by 2002:a05:651c:988:b0:24a:c21f:7057 with SMTP id
 b8-20020a05651c098800b0024ac21f7057mr16896861ljq.16.1650549328412; Thu, 21
 Apr 2022 06:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz> <20220419024611.1327525-5-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20220419024611.1327525-5-chris.packham@alliedtelesis.co.nz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 15:54:52 +0200
Message-ID: <CAPDyKFq0HzTAMs6TGyisUs4Yv5mtCAvpv_B8y_FzhbF-ctn7-w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: mmc: convert sdhci-dove to JSON schema
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
> Convert the sdhci-dove binding to JSON schema. The optional clocks
> property was not in the original binding document but has been in the
> dove.dtsi since commit 5b03df9ace68 ("ARM: dove: switch to DT clock
> providers").
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Notes:
>     Changes in v2:
>     - Add clocks property
>     - interrupts.maxItems = 2
>     - Update maintainers based on ./scripts/get_maintainer.pl -f drivers/mmc/host/sdhci-dove.c
>
>  .../bindings/mmc/marvell,dove-sdhci.yaml      | 44 +++++++++++++++++++
>  .../devicetree/bindings/mmc/sdhci-dove.txt    | 14 ------
>  2 files changed, 44 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,dove-sdhci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-dove.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,dove-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,dove-sdhci.yaml
> new file mode 100644
> index 000000000000..7c9c652ad59c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/marvell,dove-sdhci.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/marvell,dove-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell sdhci-dove controller
> +
> +maintainers:
> +  - Adrian Hunter <adrian.hunter@intel.com>
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: marvell,dove-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sdio0: mmc@92000 {
> +      compatible = "marvell,dove-sdhci";
> +      reg = <0x92000 0x100>;
> +      interrupts = <35>;
> +      clocks = <&gate_clk 9>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-dove.txt b/Documentation/devicetree/bindings/mmc/sdhci-dove.txt
> deleted file mode 100644
> index ae9aab9abcd7..000000000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci-dove.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -* Marvell sdhci-dove controller
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the sdhci-pxav2 and sdhci-pxav3 drivers.
> -
> -- compatible: Should be "marvell,dove-sdhci".
> -
> -Example:
> -
> -sdio0: sdio@92000 {
> -       compatible = "marvell,dove-sdhci";
> -       reg = <0x92000 0x100>;
> -       interrupts = <35>;
> -};
> --
> 2.35.1
>
