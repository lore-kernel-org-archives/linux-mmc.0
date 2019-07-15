From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document Aspeed SD controller
Date: Mon, 15 Jul 2019 07:26:57 -0600
Message-ID: <CAL_JsqK+oLFZof1zpvUs_Siek=+Rc+CPYL-_oE0KuiXwunr0vA@mail.gmail.com>
References: <20190712033214.24713-1-andrew@aj.id.au> <20190712033214.24713-2-andrew@aj.id.au>
 <20190712131028.ba4d4jetg4btsx4u@flea> <5c831fd3-d0e2-474b-8a6e-8f51f92fbdf8@www.fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c831fd3-d0e2-474b-8a6e-8f51f92fbdf8@www.fastmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jeffery <andrew@aj.id.au>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>, Adrian Hunter <adrian.hunter@intel.com>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ryan Chen <ryanchen.aspeed@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Jul 14, 2019 at 8:30 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 12 Jul 2019, at 22:41, Maxime Ripard wrote:
> > Hi,
> >
> > On Fri, Jul 12, 2019 at 01:02:13PM +0930, Andrew Jeffery wrote:
> > > The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> > > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > > data bus if only a single slot is enabled.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > > In v2:
> > >
> > > * Rename to aspeed,sdhci.yaml
> > > * Rename sd-controller compatible
> > > * Add `maxItems: 1` for reg properties
> > > * Move sdhci subnode description to patternProperties
> > > * Drop sdhci compatible requirement
> > > * #address-cells and #size-cells are required
> > > * Prevent additional properties
> > > * Implement explicit ranges in example
> > > * Remove slot property
> > >
> > >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 90 +++++++++++++++++++
> > >  1 file changed, 90 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > new file mode 100644
> > > index 000000000000..67a691c3348c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > @@ -0,0 +1,90 @@
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ASPEED SD/SDIO/eMMC Controller
> > > +
> > > +maintainers:
> > > +  - Andrew Jeffery <andrew@aj.id.au>
> > > +  - Ryan Chen <ryanchen.aspeed@gmail.com>
> > > +
> > > +description: |+
> > > +  The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the SDIO
> > > +  Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit data bus if
> > > +  only a single slot is enabled.
> > > +
> > > +  The two slots are supported by a common configuration area. As the SDHCIs for
> > > +  the slots are dependent on the common configuration area, they are described
> > > +  as child nodes.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum: [ aspeed,ast2400-sd-controller, aspeed,ast2500-sd-controller ]
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: Common configuration registers
> > > +  ranges: true
> > > +  clocks:
> > > +    maxItems: 1
> > > +    description: The SD/SDIO controller clock gate
> >
> > #address-cells and #size-cells have not been described here.
> >
> > > +patternProperties:
> > > +  "^sdhci@[0-9a-f]+$":
> > > +    type: object
> > > +    properties:
> > > +      compatible:
> > > +        enum: [ aspeed,ast2400-sdhci, aspeed,ast2500-sdhci ]
> > > +      reg:
> > > +        maxItems: 1
> > > +        description: The SDHCI registers
> > > +      clocks:
> > > +        maxItems: 1
> > > +        description: The SD bus clock
> > > +      interrupts:
> > > +        maxItems: 1
> > > +        description: The SD interrupt shared between both slots
> > > +    required:
> > > +      - compatible
> > > +      - reg
> > > +      - clocks
> > > +      - interrupts
> > > +
> > > +additionalProperties: false
> >
> > But that means that it will generate a warning in your DT if you ever
> > use them.
> >
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +  - ranges
> > > +  - clocks
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > +    sdc@1e740000 {
> > > +            compatible = "aspeed,ast2500-sd-controller";
> > > +            reg = <0x1e740000 0x100>;
> > > +            #address-cells = <1>;
> > > +            #size-cells = <1>;
> >
> > Starting with your example.
>
> Heh, right. Thanks. I was inspecting the output of the `dt_binding_check` and
> `dtbs_check` make targets, though maybe I overlooked this. The aspeed dtsis
> do generate a quite a number of warnings which make it hard to parse, so I'm
> going to send a series to clean that up too.

FYI, This will run checks with only the schema file you specify:

make dtbs_check DT_SCHEMA_FILES=path/to/schema/file

Rob
