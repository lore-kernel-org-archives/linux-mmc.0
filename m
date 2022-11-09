Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2FBC4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 12:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKIMe7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 07:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKIMe6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 07:34:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D53518386
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 04:34:53 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b21so16957092plc.9
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 04:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=twQZkMX8iLp4iWdpt/IOZvrdMMyf9kmvm74HwTx7wcw=;
        b=phZH7t/rwe+yvS8O4qEZe+boF0ujwjw+sNIg3oSaH+c/Zq5Rm5p1N/hQi6W0XBJ6X8
         q+Oqnl6f/9S3vhQauqgKXrrtMM63Eb00tgoD2iREZnylaS+KoTKMtvZRo6j37dG8e69y
         gS44dMNdg/riFLO2b/1AyxvvztZSWKj0fncTpZD0fRittg/PSN2Lwrl+dtXBF6doDbwT
         AxjcOm9Yxol22d6sQpyT1+Zi7c8nrqNwXZg//uiTe16f4FY/ly0QcAG1pFMvv9bELGom
         Z1j0/0UPFiDnqXXyDXZ1qBuJ1eCZ/WzuuxxlwMq2f7cCw9B2u6CH5p+2HbE0LNUVOSHp
         FCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twQZkMX8iLp4iWdpt/IOZvrdMMyf9kmvm74HwTx7wcw=;
        b=UAYzqAIA0ZJNqeBWjNQ/mSFOZWCvehSC4c/9Ynd7X5Sa2lCMadFBxa7FGkPt63haXM
         gLozWhhXTudWaXxHHTHZRjmOVH2jh2DHmmRgdkLh9mBsayyp9PxSAkpIg8cm0j6QV8eO
         J2OZRhCxprSUok9OdOpk7GJoGedVrOhmICKigygDvfT5TWj3p7WzYbBmz8LchgENK2XL
         Q9CXwKJviw82VF7dCvBEkIz53mnOEnq5qZpX1QRcvXiZLbzVNuoCQ8JYqSi566gxtgF7
         /LVXZm3wUqcpbP4N5VH5NR6fllVqf4DvbX9n0VDbuyRX5SlYbDfywN8C5Yovpa+32Go6
         mCYw==
X-Gm-Message-State: ACrzQf0BijCgTujrZqhoT2iWdL5sc+QQfUCgEqj2ctQWwrupZoBidy3S
        cfyrFP7mtxVZk8PROlWNERWAExZmOPbMZwU8teoEhQ==
X-Google-Smtp-Source: AMsMyM7AyPsAODWVfKIktvX6iARVh9LUhQxRZAt/mD97cpCfKPJpsMk5NXfi3ysBEd5tSHabMTMY8CW8Y8EzKRqcoEk=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr61928822plb.148.1667997292880; Wed, 09
 Nov 2022 04:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20221107173310.60503-1-sebastian.reichel@collabora.com>
In-Reply-To: <20221107173310.60503-1-sebastian.reichel@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:34:15 +0100
Message-ID: <CAPDyKFrwgu2zdju72d7ftKDn3UJHsthmfav9zf3FQjs-aMgz-g@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] dt-bindings: mmc: sdhci-of-dwcmhsc: Add reset support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Nov 2022 at 18:33, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Properly describe reset related properties in the binding.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since PATCHv1:
>  * https://lore.kernel.org/all/20221021171654.87071-1-sebastian.reichel@collabora.com/
>  * dropped minItems (Krzysztof Kozlowski)
>  * reset-names are not copy pasted and intentionally the same as
>    the clock-names. DT looks like this:
>
>    clocks = <&cru CCLK_EMMC>, <&cru HCLK_EMMC>,
>             <&cru ACLK_EMMC>, <&cru BCLK_EMMC>,
>             <&cru TMCLK_EMMC>;
>    clock-names = "core", "bus", "axi", "block", "timer";
>    resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
>             <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
>             <&cru SRST_T_EMMC>;
>    reset-names = "core", "bus", "axi", "block", "timer";
> ---
>  .../devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml   | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 71f8e726d641..51ba44cad842 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -45,6 +45,17 @@ properties:
>        - const: block
>        - const: timer
>
> +  resets:
> +    maxItems: 5
> +
> +  reset-names:
> +    items:
> +      - const: core
> +      - const: bus
> +      - const: axi
> +      - const: block
> +      - const: timer
> +
>    rockchip,txclk-tapnum:
>      description: Specify the number of delay for tx sampling.
>      $ref: /schemas/types.yaml#/definitions/uint8
> --
> 2.35.1
>
