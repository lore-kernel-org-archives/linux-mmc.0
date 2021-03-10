Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB769C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 03:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899FC64FE8
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 03:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhCJDBt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 22:01:49 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:46645 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhCJDBZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 22:01:25 -0500
Received: by mail-io1-f49.google.com with SMTP id u8so16288385ior.13;
        Tue, 09 Mar 2021 19:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=344tVBROrcGfG7Le5DlzQjIDt0SKG8pa76TGE6syYKo=;
        b=HkqC+Nx31C7nObd87mBzZUzC8qkMhMf5ZSErcb8rGcUnx7s44/i9T8B5nLSH9agftY
         3kQqcZghGdBu4XriphcBKH6NAcRh9VJzbzumSW+7crMtHGFqXw1LQlvviqzmw4w7RDE4
         ocOLmYtDgijQhQjYgBjrHo0JCd1aWRwXwIJwiXOT/5o08DEmA18jM6XbRC3JS7UK5k/k
         0e1LCmfM0iN/l6IobaFYtYzW14OV1YczTlx4/OdnnWM2tfjoejldtk7Hx845l65oWJ8j
         hdKNZkVHLRpVX6B89fMXn4cgIMBv8/x6JUFUAGK6Hn5IpxaWaH2aL683vp0Jt+6JK+iT
         sNeQ==
X-Gm-Message-State: AOAM5337hy2Sh3XNnpE36Bg5Omt6ZtWR5uIl71B+Cso3vvM1+2zLB4bN
        xUwY5TR4VENQU4IeLLitwk0J34d4fA==
X-Google-Smtp-Source: ABdhPJylE3SN4ifqoY3q9XY3cnPA0IAuGy62a5W/RzBRG2WNspkLT5vtScelB/9Khap1fxrZ0GXl9w==
X-Received: by 2002:a5e:a508:: with SMTP id 8mr993226iog.135.1615345284888;
        Tue, 09 Mar 2021 19:01:24 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o7sm8628180ilj.67.2021.03.09.19.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 19:01:24 -0800 (PST)
Received: (nullmailer pid 1665491 invoked by uid 1000);
        Wed, 10 Mar 2021 03:01:22 -0000
Date:   Tue, 9 Mar 2021 20:01:22 -0700
From:   Rob Herring <robh@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rockchip
 support
Message-ID: <20210310030122.GA1664258@robh.at.kernel.org>
References: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
 <1615254990-192784-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615254990-192784-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 09, 2021 at 09:56:29AM +0800, Shawn Lin wrote:
> This patch adds rockchip support in sdhci-of-dwcmhsc.yaml
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v3: None
> 
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml           | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index f99fb9f..43989f2 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -16,6 +16,7 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - rockchip,dwcmshc-sdhci
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
> +    $ref: /schemas/types.yaml#/definitions/uint32

Constraints for this? 0 - 2^32 is okay?

> +
>  
>  required:
>    - compatible
> @@ -49,6 +62,17 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    mmc@fe310000 {
> +      compatible = "rockchip,dwcmshc-sdhci";
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
