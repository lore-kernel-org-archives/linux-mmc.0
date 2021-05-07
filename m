Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A099C433ED
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 01:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1549F610F7
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 01:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhEGBO0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 21:14:26 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44927 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhEGBOZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 21:14:25 -0400
Received: by mail-ot1-f47.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so6596187otp.11;
        Thu, 06 May 2021 18:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6+SbgXWxY1gSEdIUiXJS8BiZpv/UGkcHHXtFb/TCI+A=;
        b=kBa7ed397SfmCauDMj0NKPmi9RHt/xwlC23yWBGAcM1aHOl4eWS4ARMxQPZBjfSNc3
         tU6AUXF7Nl+1FFalOJ+LgBv4a1DIngE5HKugOvgZAWOpesiAla1fCkW8ZWx+Fh8czELX
         GYmnYkglhKXyMToAx2krqr1GFUCRY56eUf+rnBtXYqBUSxAdi64bNDgrmLqZVEE8NAOr
         ZoGCekc+uL+DBRSfNFvEIow+rYt8hi9OdER5++23M4PabvtavNMoI1+MDyszvXD3KsHv
         GC2Qntbv+llth2Ax6UpkTDGBrMgLSM/xpNaQJAK3QizdiQ28nhneNUitt/B7QaYf2w/k
         JFHA==
X-Gm-Message-State: AOAM533jsrJyhyY3NVPV+fIY66Jjqm5KDk1ONbqopVsFrs9DdP6YZKlC
        +s2mB0PTJhsvv5QqeGlHPSKBK/ph8w==
X-Google-Smtp-Source: ABdhPJwprZcJkifPHv8l3JVb9xsBJ7fjNDgXUBwbZFhFrpcupUfUM5N35itbxcoRLv515J42Jwkdcg==
X-Received: by 2002:a9d:5f0c:: with SMTP id f12mr6055681oti.258.1620350006471;
        Thu, 06 May 2021 18:13:26 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v19sm920949otq.35.2021.05.06.18.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 18:13:25 -0700 (PDT)
Received: (nullmailer pid 1125071 invoked by uid 1000);
        Fri, 07 May 2021 01:13:24 -0000
Date:   Thu, 6 May 2021 20:13:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, Hongweiz@ami.com,
        ryan_chen@aspeedtech.com, chin-ting_kuo@aspeedtech.com
Subject: Re: [PATCH v3 1/5] dt-bindings: mmc: sdhci-of-aspeed: Add an example
 for AST2600-A2 EVB
Message-ID: <20210507011324.GA1119409@robh.at.kernel.org>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-2-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506100312.1638-2-steven_lee@aspeedtech.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, May 06, 2021 at 06:03:08PM +0800, Steven Lee wrote:
> AST2600-A2 EVB has the reference design for enabling SD bus
> power and toggling SD bus signal voltage by GPIO pins.
> 
> In the reference design, GPIOV0 of AST2600-A2 EVB is connected to
> power load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is
> connected to a 1.8v and a 3.3v power load switch that providing
> signal voltage to
> SD1 bus.
> 
> If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> disabled.
> If GPIOV1 is active high, 3.3v power load switch is enabled, SD1
> signal voltage is 3.3v. Otherwise, 1.8v power load switch will be
> enabled, SD1 signal voltage becomes 1.8v.
> 
> AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and
> GPIOV3 as power-switch-gpio.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 101 +++++++++++++++++-
>  1 file changed, 97 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 987b287f3bff..de7e61b3d37a 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -45,10 +45,16 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        enum:
> -          - aspeed,ast2400-sdhci
> -          - aspeed,ast2500-sdhci
> -          - aspeed,ast2600-sdhci
> +        oneOf:
> +          - items:
> +              - enum:
> +                  - aspeed,ast2400-sdhci
> +                  - aspeed,ast2500-sdhci
> +                  - aspeed,ast2600-sdhci
> +          - items:
> +              - enum:
> +                  - aspeed,ast2600-sdhci
> +              - const: sdhci

Why are you adding 'sdhci'. That's not useful as a compatible given how 
many quirks different implementations have.


>        reg:
>          maxItems: 1
>          description: The SDHCI registers
> @@ -104,3 +110,90 @@ examples:
>                      clocks = <&syscon ASPEED_CLK_SDIO>;
>              };
>      };
> +
> +  - |

Why do we need another example?

> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    vcc_sdhci0: regulator-vcc-sdhci0 {
> +            compatible = "regulator-fixed";
> +            regulator-name = "SDHCI0 Vcc";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            gpios = <&gpio0 168
> +                            GPIO_ACTIVE_HIGH>;
> +            enable-active-high;
> +    };
> +
> +    vccq_sdhci0: regulator-vccq-sdhci0 {
> +            compatible = "regulator-gpio";
> +
> +            regulator-name = "SDHCI0 VccQ";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <3300000>;
> +            gpios = <&gpio0 169
> +                            GPIO_ACTIVE_HIGH>;
> +            gpios-states = <1>;
> +            states = <3300000 1>,
> +                     <1800000 0>;
> +    };
> +
> +    vcc_sdhci1: regulator-vcc-sdhci1 {
> +            compatible = "regulator-fixed";
> +
> +            regulator-name = "SDHCI1 Vcc";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            gpios = <&gpio0 170
> +                            GPIO_ACTIVE_HIGH>;
> +            enable-active-high;
> +    };
> +
> +    vccq_sdhci1: regulator-vccq-sdhci1 {
> +            compatible = "regulator-gpio";
> +
> +            regulator-name = "SDHCI1 VccQ";
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <3300000>;
> +            gpios = <&gpio0 171
> +                            GPIO_ACTIVE_HIGH>;
> +            gpios-states = <1>;
> +            states = <3300000 1>,
> +                     <1800000 0>;
> +    };
> +
> +    sdc@1e740000 {
> +            compatible = "aspeed,ast2600-sd-controller";
> +            reg = <0x1e740000 0x100>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0 0x1e740000 0x20000>;
> +            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
> +
> +            sdhci@1e740100 {
> +                    compatible = "aspeed,ast2600-sdhci","sdhci";
> +                    reg = <0x100 0x100>;
> +                    interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +                    sdhci,auto-cmd12;
> +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> +                    vmmc-supply = <&vcc_sdhci0>;
> +                    vqmmc-supply = <&vccq_sdhci0>;
> +                    sd-uhs-sdr104;
> +                    clk-phase-uhs-sdr104 = <180>, <180>;
> +            };
> +
> +            sdhci@1e740200 {
> +                    compatible = "aspeed,ast2600-sdhci","sdhci";
> +                    reg = <0x200 0x100>;
> +                    interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +                    sdhci,auto-cmd12;
> +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> +                    vmmc-supply = <&vcc_sdhci1>;
> +                    vqmmc-supply = <&vccq_sdhci1>;
> +                    sd-uhs-sdr104;
> +                    clk-phase-uhs-sdr104 = <0>, <0>;
> +            };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
