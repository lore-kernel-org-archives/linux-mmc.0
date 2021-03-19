Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D692C43381
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358C064F42
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Mar 2021 14:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCSON3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhCSOM6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2021 10:12:58 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77363C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:12:58 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id x8so3072580ual.6
        for <linux-mmc@vger.kernel.org>; Fri, 19 Mar 2021 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PWgAYd4GZnp/T9aLTG5OoUnHXCTXz0kWLYL1sUoKSAs=;
        b=pE55rx/nQAWWiRcoufqivpmIlRzEZI94QO9TqdlQvOOAyIVhYB3wg9rKP28xSWSdND
         8ejGpFL7Hru1KdgUfbnz9esO6B16LKif/0/V93pB+dueCVSqoitKE554m26G3jJAz/4W
         K5TTrMnG0fx4HWa+ZI0nFwWdXE4jNXVx4bul67ywCLG1BREjNCWtUYFJ63DtoXjusnG1
         pzRj2CxrhTm3rHroP4F1mLECTFH+vnaCi+JdUoOqweNNkvI3DWtfZuULjiSg08LUL0F4
         Hr0CU8bi/+ER4v0ZVkNtB0vWix01KeTgAKV1xg4wiKRU9fitdxo9sW86UIl/a2uCfgNw
         4q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWgAYd4GZnp/T9aLTG5OoUnHXCTXz0kWLYL1sUoKSAs=;
        b=YBFP9qfCNInZzN2cY8pWOxb/AEZ1owMdZuFZQ3N6vCK+g30BlMEXZ8Vp5iGZRIUwkw
         G30s/dBp6BusoLznmpaA8cdV1eeircfvHNMYcJ2cKGUFJSeijUEuka5rP35e57gsYmFI
         3Ek796Uy2QiOsWkD4soPXjC43iJvocGF2Q89sZZNRBDLDRSQsZEh2Jg/I7ANv86kMttN
         Ymz9/5scJG/2eWmZbNEN1jjpxk3PrxZG6s7+KjvFdgtTPs2OM4dXsJyKotJurFpgMwWL
         kAMkDCHo4ntrZnmyNs9JTYvyXonbDyg/S/IcyFsmVZEIU2pvyPLr/QdcN11C532UPKuC
         ACmw==
X-Gm-Message-State: AOAM5312UgGUT2+oYF29A0oCQR+tgoDzteqCc2go7NKpUD6fGmhoQt8C
        dd68oZ8U435elK66s7cIQSMa4++hj8dFewnhxU8mcg==
X-Google-Smtp-Source: ABdhPJybbh/9ZCCPoUUBxpdshVjauryv12ykA3cCDS1cePj8MJAy6TjeAM1Lg26t8d7/zZ7mGyc6CxPIuECyP0fWj0g=
X-Received: by 2002:ab0:6f0e:: with SMTP id r14mr5394574uah.15.1616163176593;
 Fri, 19 Mar 2021 07:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <1615879102-45919-1-git-send-email-shawn.lin@rock-chips.com> <1615879102-45919-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1615879102-45919-2-git-send-email-shawn.lin@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:20 +0100
Message-ID: <CAPDyKFoANfvc1-jnM6+kSprzxoefECvDoRW5K07aU11QaNsdoQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rockchip support
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Mar 2021 at 08:18, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> This patch adds rockchip support in sdhci-of-dwcmhsc.yaml
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v6: None
> Changes in v5: None
> Changes in v4:
> - rename compatible to rockchip,rk3568-dwcmshc
> - constrains rockchip,txclk-tapnum to u8 to match the register map
>
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml           | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index f99fb9f..e6c9a2f 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -16,6 +16,7 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - rockchip,rk3568-dwcmshc
>        - snps,dwcmshc-sdhci
>
>    reg:
> @@ -31,12 +32,24 @@ properties:
>      items:
>        - description: core clock
>        - description: bus clock for optional
> +      - description: axi clock for rockchip specified
> +      - description: block clock for rockchip specified
> +      - description: timer clock for rockchip specified
> +
>
>    clock-names:
>      minItems: 1
>      items:
>        - const: core
>        - const: bus
> +      - const: axi
> +      - const: block
> +      - const: timer
> +
> +  rockchip,txclk-tapnum:
> +    description: Specify the number of delay for tx sampling.
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +
>
>  required:
>    - compatible
> @@ -49,6 +62,17 @@ unevaluatedProperties: false
>
>  examples:
>    - |
> +    mmc@fe310000 {
> +      compatible = "rockchip,rk3568-dwcmshc";
> +      reg = <0xfe310000 0x10000>;
> +      interrupts = <0 25 0x4>;
> +      clocks = <&cru 17>, <&cru 18>, <&cru 19>, <&cru 20>, <&cru 21>;
> +      clock-names = "core", "bus", "axi", "block", "timer";
> +      bus-width = <8>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +    };
> +  - |
>      mmc@aa0000 {
>        compatible = "snps,dwcmshc-sdhci";
>        reg = <0xaa000 0x1000>;
> --
> 2.7.4
>
>
>
