From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Document Aspeed SD controller
Date: Wed, 10 Jul 2019 09:49:45 -0600
Message-ID: <CAL_JsqKrYcUbn_02z9GQO6U4rz7k=p3kB7_G0tKmv25MMZZNQg@mail.gmail.com>
References: <20190710141611.21159-1-andrew@aj.id.au> <20190710141611.21159-2-andrew@aj.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710141611.21159-2-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>, Adrian Hunter <adrian.hunter@intel.com>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ryanchen.aspeed@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 10, 2019 at 8:16 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> data bus if only a single slot is enabled.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  .../bindings/mmc/sdhci-of-aspeed.yaml         | 91 +++++++++++++++++++

aspeed,sdhci.yaml

>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml b/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> new file mode 100644
> index 000000000000..e98a2ac4d46d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later

The preferred license is (GPL-2.0 OR BSD-2-Clause) if that is okay with you.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sdhci-of-aspeed.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED SD/SDIO/eMMC Controller
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@aj.id.au>
> +  - Ryan Chen <ryanchen.aspeed@gmail.com>
> +
> +description: |+
> +  The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the SDIO
> +  Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit data bus if
> +  only a single slot is enabled.
> +
> +  The two slots are supported by a common configuration area. As the SDHCIs for
> +  the slots are dependent on the common configuration area, they are described
> +  as child nodes.
> +
> +properties:
> +  compatible:
> +    enum: [ aspeed,ast2400-sdc, aspeed,ast2500-sdc ]
> +  reg:
> +    description: Common configuration registers

This should have a 'maxItems: 1'. Same for the child reg.

> +  ranges: true
> +  clocks:
> +    maxItems: 1
> +    description: The SD/SDIO controller clock gate
> +  sdhci:

This needs to be a pattern (under patternProperties) as these have
unit-addresses.

> +    type: object
> +    properties:
> +      compatible:
> +        allOf:
> +          - enum: [ aspeed,ast2400-sdhci, aspeed,ast2500-sdhci ]
> +          - const: sdhci

This condition can never be true. What you need is s/allOf/items/.
However, 'sdhci' is not really a useful compatible because every
implementation has quirks, so I'd drop it.

> +      reg:
> +        description: The SDHCI registers
> +      clocks:
> +        maxItems: 1
> +        description: The SD bus clock
> +      slot:
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0, 1]

Is this really needed? Offset 0x100 is slot 0 and offset 0x200 is slot
1. Does that ever change?

> +      interrupts:
> +        maxItems: 1
> +        description: The SD interrupt shared between both slots
> +    required:
> +      - compatible
> +      - reg
> +      - clocks
> +      - slot
> +      - interrupts
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - clocks

#address-cells and #size-cells are required too.

You should also add 'additionalProperties: false' here so other random
properties can't be present.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    sdc@1e740000 {
> +            compatible = "aspeed,ast2500-sdc";
> +            reg = <0x1e740000 0x100>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges;

It's preferred to limit the range here and then the child addresses
are 0x100 and 0x200.

> +            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
> +
> +            sdhci0: sdhci@1e740100 {
> +                    compatible = "aspeed,ast2500-sdhci", "sdhci";
> +                    reg = <0x1e740100 0x100>;
> +                    slot = <0>;
> +                    interrupts = <26>;
> +                    sdhci,auto-cmd12;
> +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> +            };
> +
> +            sdhci1: sdhci@1e740200 {
> +                    compatible = "aspeed,ast2500-sdhci", "sdhci";
> +                    reg = <0x1e740200 0x100>;
> +                    slot = <1>;
> +                    interrupts = <26>;
> +                    sdhci,auto-cmd12;
> +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> +            };
> +    };
> --
> 2.20.1
>
