Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9866BC433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 07:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60ED420578
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 07:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWcVGZZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgHYHeY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgHYHeX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 03:34:23 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DFCC061574
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2020 00:34:23 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p186so3083467vsa.10
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2020 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9dUMlaBrYr0QPUU+/BwByH9mR1EJj9X/+BxAnd7n7g=;
        b=VWcVGZZn5sYlE6nfnxiL29D4ccEVLF9u8czOtdAqCykk2zBJn5knqKwUqCg5HMma+6
         KwV0WWoujrW5/0UCkoKguK5ad5NXefPHrFozEi+YSFAvGzmGkChZuU3MyPeT80sjrpIy
         YEUTdM5QAtkzP3hY3L/bA7jkrEuHdJESNH/TAeF1r7lj8DBPAbiNXYyLGQt+/Sau2zct
         ka/PnkTHIU6Qc3i40yokiEtlkD4hfZKP9ip1mwqEWjg9HpKua/EpKtsOmbhSVhyeGnWh
         SQKeG0iKCSNYH3b3qiJdvoap0Q4Ovz4+zYRiTVkyK6NDADdEtJ90QM6utPbWW52Lk2Ri
         4fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9dUMlaBrYr0QPUU+/BwByH9mR1EJj9X/+BxAnd7n7g=;
        b=SVwHqe3Tj13HSf3asA8xWHQI1K+9sLDwPZONHo4pg+P2Lb72mTW+oDnN7RFkQEePZD
         a4J0MXl2K/ghDCEbyLj/u4tm5tGBjYGWbx8jGpvX+fQjpJ2BF4u1VTeusS9UPdOOu48y
         cNzmipjeFqsXw058xjQ9kqmcu7Mj2q/nbROAnXd7ML9R1axlDfbel3kYPjeQD+CnvjB4
         Rw//65kul7ZchNS4EHgZouUYK1B71bxXhmSpR3xSx/UNBSe4QvwRWz7hy8fooRpS9zbL
         mGVAlc9UvjiJTyH2INOTMXjnPKCO0LjfYeR2/Ca+qZlQI6lNA/CLjquCC+dOg0/lUvWl
         Z23g==
X-Gm-Message-State: AOAM530fU60Wpi/AhRVMdOALSbE8FwCOQ18vP292esNj8uKroL6D0nUz
        1iyZ+16ETjWSiuJVtIL5MShvrKoZwYOBaosSFDY9yvNr0FdK7A==
X-Google-Smtp-Source: ABdhPJyq3iaF9iHmf1FP2YZmUz8+m0tjz+LBxu2zhSgpmuNGB3x9iwVpZxb6Icf9nxJJqlL9tdZw9y4dFEqmdQmH7ik=
X-Received: by 2002:a67:8c06:: with SMTP id o6mr5056875vsd.200.1598340862095;
 Tue, 25 Aug 2020 00:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200824151035.31093-1-lars.povlsen@microchip.com> <20200824151035.31093-2-lars.povlsen@microchip.com>
In-Reply-To: <20200824151035.31093-2-lars.povlsen@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Aug 2020 09:33:45 +0200
Message-ID: <CAPDyKFoBom1n4AHniiukPiE_szskHrhcmVXfMpKTvNo9Xw9v0w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 Aug 2020 at 17:10, Lars Povlsen <lars.povlsen@microchip.com> wrote:
>
> The Sparx5 SDHCI controller is based on the Designware controller IP.
>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../mmc/microchip,dw-sparx5-sdhci.yaml        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> new file mode 100644
> index 0000000000000..55883290543b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/microchip,dw-sparx5-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip Sparx5 Mobile Storage Host Controller Binding
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +maintainers:
> +  - Lars Povlsen <lars.povlsen@microchip.com>
> +
> +# Everything else is described in the common file
> +properties:
> +  compatible:
> +    const: microchip,dw-sparx5-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Handle to "core" clock for the sdhci controller.
> +
> +  clock-names:
> +    items:
> +      - const: core
> +
> +  microchip,clock-delay:
> +    description: Delay clock to card to meet setup time requirements.
> +      Each step increase by 1.25ns.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 1
> +    maximum: 15
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/microchip,sparx5.h>
> +    sdhci0: mmc@600800000 {

Nitpick:

I think we should use solely "mmc[n]" here. So:

mmc0@600800000 {

Please update patch3/3 accordingly as well.

> +        compatible = "microchip,dw-sparx5-sdhci";
> +        reg = <0x00800000 0x1000>;
> +        pinctrl-0 = <&emmc_pins>;
> +        pinctrl-names = "default";
> +        clocks = <&clks CLK_ID_AUX1>;
> +        clock-names = "core";
> +        assigned-clocks = <&clks CLK_ID_AUX1>;
> +        assigned-clock-rates = <800000000>;
> +        interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +        bus-width = <8>;
> +        microchip,clock-delay = <10>;
> +    };

Kind regards
Uffe
