From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: Document Aspeed SD controller
Date: Thu, 15 Aug 2019 15:08:24 +0930
Message-ID: <6c94aada-9c4a-4f55-9a43-349282ad12af@www.fastmail.com>
References: <20190807003629.2974-1-andrew@aj.id.au>
 <20190807003629.2974-2-andrew@aj.id.au>
 <CACPK8Xe6Zp1uOqEffEc0b6oGa7portEAifGPRqb876HmA+oZeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACPK8Xe6Zp1uOqEffEc0b6oGa7portEAifGPRqb876HmA+oZeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, devicetree <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed <linux-aspeed@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ryan Chen <ryanchen.aspeed@gmail.com>
List-Id: linux-mmc@vger.kernel.org



On Thu, 15 Aug 2019, at 15:06, Joel Stanley wrote:
> On Wed, 7 Aug 2019 at 00:38, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The ASPEED SD/SDIO/MMC controller exposes two slots implementing the
> > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > data bus if only a single slot is enabled.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Two minor comments below.
> 
> > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > @@ -0,0 +1,105 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> 
> No "Copyright IBM" ?

I'm going rogue.

That reminds me I should chase up where we got to with the binding
licensing.

> 
> > +%YAML 1.2
> > +---
> 
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
> 
> According to the datasheet this could be 0x20000. It does not matter
> though, as there's nothing in it past 0x300.

Good catch.

Andrew
