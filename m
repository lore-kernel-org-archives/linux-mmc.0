Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308B9C43460
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 18:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4F061104
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 18:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhDISlg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:41:36 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45768 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhDISlf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Apr 2021 14:41:35 -0400
Received: by mail-ot1-f48.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so1507063otf.12;
        Fri, 09 Apr 2021 11:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4MvFSu+iSn/dauM/cnTOpr/Gc9vHIrXjG/A41VJDYI4=;
        b=PLydOaWV6fk08DU815AVnNCL5lCl3RCBVUtHUmfFA9pbzk90os0Uw8SKLkFAxNs2dv
         aVUHIu6Hiy0HqdMmzMefEzQYoVSGX9wiirkyK5qkygCPlAS0G6V6/NQElfYwNyobz2mD
         EB2luZcTlgHuqd9cdHm5xpig6eneyZcZ19rW8+17XJ6xjhWxe1U+9+GLIZitgo1Vkb5O
         ZgCbDe/O/CCfHr9YF/nJXDepIuos3mq2cmHjFfLV3yakaCnGCKZ6ILbRFg/rUnI37WvN
         29DF/mfKbBMtkEB01oDz4R0i3Pw+zwCtFCia6ZStko+vtez/BRNyrIYitDgX3WPQ4DkL
         ip+A==
X-Gm-Message-State: AOAM531FJ/btuz61S1rJaABoqQzUC6zHZzBjVOb9HIBUlXzN0kHAgXr/
        dRu6Qnbcq6dOdI4Y95Hy/w==
X-Google-Smtp-Source: ABdhPJzGKW/WQeP+HhyULbXe22Y/RLS1g/vF+rFi385EeuxrtQnl324VEHdsSv/nFS6zXrD211MquA==
X-Received: by 2002:a9d:68ce:: with SMTP id i14mr12827904oto.151.1617993680723;
        Fri, 09 Apr 2021 11:41:20 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j11sm667128ooo.45.2021.04.09.11.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:41:20 -0700 (PDT)
Received: (nullmailer pid 3937011 invoked by uid 1000);
        Fri, 09 Apr 2021 18:41:18 -0000
Date:   Fri, 9 Apr 2021 13:41:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        ryan_chen@aspeedtech.com, chin-ting_kuo@aspeedtech.com
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: sdhci-of-aspeed: Add power-gpio
 and power-switch-gpio
Message-ID: <20210409184118.GA3934798@robh.at.kernel.org>
References: <20210408015218.20560-1-steven_lee@aspeedtech.com>
 <20210408015218.20560-2-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408015218.20560-2-steven_lee@aspeedtech.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Apr 08, 2021 at 09:52:17AM +0800, Steven Lee wrote:
> AST2600-A2 EVB provides the reference design for enabling SD bus power
> and toggling SD bus signal voltage by GPIO pins.
> Add the definition and example for power-gpio and power-switch-gpio
> properties.
> 
> In the reference design, GPIOV0 of AST2600-A2 EVB is connected to power
> load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is connected to
> a 1.8v and a 3.3v power load switch that providing signal voltage to
> SD1 bus.
> If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> disabled.
> If GPIOV1 is active high, 3.3v power load switch is enabled, SD1 signal
> voltage is 3.3v. Otherwise, 1.8v power load switch will be enabled, SD1
> signal voltage becomes 1.8v.
> 
> AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and GPIOV3
> as power-switch-gpio.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 987b287f3bff..515a74614f3c 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -37,6 +37,14 @@ properties:
>    clocks:
>      maxItems: 1
>      description: The SD/SDIO controller clock gate
> +  power-gpio:

'-gpios' is the preferred form even if just 1.

> +    description:
> +      The GPIO for enabling/disabling SD bus power.
> +    maxItems: 1

blank line

> +  power-switch-gpio:
> +    description:
> +      The GPIO for toggling the signal voltage between 3.3v and 1.8v.
> +    maxItems: 1
>  
>  patternProperties:
>    "^sdhci@[0-9a-f]+$":
> @@ -61,6 +69,14 @@ patternProperties:
>        sdhci,auto-cmd12:
>          type: boolean
>          description: Specifies that controller should use auto CMD12
> +      power-gpio:
> +        description:
> +          The GPIO for enabling/disabling SD bus power.
> +        maxItems: 1
> +      power-switch-gpio:
> +        description:
> +          The GPIO for toggling the signal voltage between 3.3v and 1.8v.
> +        maxItems: 1
>      required:
>        - compatible
>        - reg
> @@ -80,6 +96,7 @@ required:
>  examples:
>    - |
>      #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/gpio/aspeed-gpio.h>
>      sdc@1e740000 {
>              compatible = "aspeed,ast2500-sd-controller";
>              reg = <0x1e740000 0x100>;
> @@ -94,6 +111,10 @@ examples:
>                      interrupts = <26>;
>                      sdhci,auto-cmd12;
>                      clocks = <&syscon ASPEED_CLK_SDIO>;
> +                    power-gpio = <&gpio0 ASPEED_GPIO(V, 0)
> +                                     GPIO_ACTIVE_HIGH>;
> +                    power-switch-gpio = <&gpio0 ASPEED_GPIO(V, 1)
> +                                     GPIO_ACTIVE_HIGH>;
>              };
>  
>              sdhci1: sdhci@200 {
> @@ -102,5 +123,9 @@ examples:
>                      interrupts = <26>;
>                      sdhci,auto-cmd12;
>                      clocks = <&syscon ASPEED_CLK_SDIO>;
> +                    power-gpio = <&gpio0 ASPEED_GPIO(V, 2)
> +                                     GPIO_ACTIVE_HIGH>;
> +                    power-switch-gpio = <&gpio0 ASPEED_GPIO(V, 3)
> +                                     GPIO_ACTIVE_HIGH>;
>              };
>      };
> -- 
> 2.17.1
> 
