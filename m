From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: Document Aspeed SD controller
Date: Mon, 05 Aug 2019 11:40:17 +0930
Message-ID: <35aaa5a4-1e0d-4f64-8985-36e2c01ccc05@www.fastmail.com>
References: <20190730062316.32037-1-andrew@aj.id.au>
 <20190730062316.32037-2-andrew@aj.id.au>
 <CAL_Jsq+oZRREV=VjYUxT3WphOa5tBaF1pvS_JKSphBY=3XB5MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+oZRREV=VjYUxT3WphOa5tBaF1pvS_JKSphBY=3XB5MA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>, Adrian Hunter <adrian.hunter@intel.com>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ryan Chen <ryanchen.aspeed@gmail.com>
List-Id: linux-mmc@vger.kernel.org



On Fri, 2 Aug 2019, at 08:29, Rob Herring wrote:
> On Tue, Jul 30, 2019 at 12:23 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > data bus if only a single slot is enabled.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > ---
> > v3:
> > * Fix compatible enums
> > * Add AST2600 compatibles
> > * Describe #address-cells / #size-cells
> > ---
> >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 100 ++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > new file mode 100644
> > index 000000000000..dd2a00c59641
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > @@ -0,0 +1,100 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED SD/SDIO/eMMC Controller
> > +
> > +maintainers:
> > +  - Andrew Jeffery <andrew@aj.id.au>
> > +  - Ryan Chen <ryanchen.aspeed@gmail.com>
> > +
> > +description: |+
> > +  The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the SDIO
> > +  Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit data bus if
> > +  only a single slot is enabled.
> > +
> > +  The two slots are supported by a common configuration area. As the SDHCIs for
> > +  the slots are dependent on the common configuration area, they are described
> > +  as child nodes.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2400-sd-controller
> > +      - aspeed,ast2500-sd-controller
> > +      - aspeed,ast2600-sd-controller
> > +  reg:
> > +    maxItems: 1
> > +    description: Common configuration registers
> > +  "#address-cells":
> > +    const: 1
> > +  "#size-cells":
> > +    const: 1
> > +  ranges: true
> > +  clocks:
> > +    maxItems: 1
> > +    description: The SD/SDIO controller clock gate
> > +
> > +patternProperties:
> > +  "^sdhci@[0-9a-f]+$":
> 
> This should probably have:
> 
> allOf:
>   - $ref: mmc-controller.yaml
> 
> Another new thing in 5.3. :)

Ack.

> 
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - aspeed,ast2400-sdhci
> > +          - aspeed,ast2500-sdhci
> > +          - aspeed,ast2600-sdhci
> > +      reg:
> > +        maxItems: 1
> > +        description: The SDHCI registers
> > +      clocks:
> > +        maxItems: 1
> > +        description: The SD bus clock
> > +      interrupts:
> > +        maxItems: 1
> > +        description: The SD interrupt shared between both slots
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - clocks
> > +      - interrupts
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> > +  - clocks
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/aspeed-clock.h>
> > +    sdc@1e740000 {
> > +            compatible = "aspeed,ast2500-sd-controller";
> > +            reg = <0x1e740000 0x100>;
> > +            #address-cells = <1>;
> > +            #size-cells = <1>;
> > +            ranges = <0 0x1e740000 0x10000>;
> > +            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
> > +
> > +            sdhci0: sdhci@100 {
> > +                    compatible = "aspeed,ast2500-sdhci";
> > +                    reg = <0x100 0x100>;
> > +                    interrupts = <26>;
> > +                    sdhci,auto-cmd12;
> 
> Not documented. Maybe should be common, but there's only a few users.

I'll document it locally for the moment.

Cheers,

Andrew
