From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: Document Aspeed SD controller
Date: Thu, 22 Aug 2019 21:25:24 +0930
Message-ID: <c78d4c45-477b-4078-b269-aec72571c8cd@www.fastmail.com>
References: <20190807003629.2974-1-andrew@aj.id.au>
 <20190807003629.2974-2-andrew@aj.id.au>
 <CACPK8Xe6Zp1uOqEffEc0b6oGa7portEAifGPRqb876HmA+oZeg@mail.gmail.com>
 <6c94aada-9c4a-4f55-9a43-349282ad12af@www.fastmail.com>
 <CAPDyKFrDPxFMm710Z25i-euOT2rrgCNXVa4na-fye0xamMXq_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrDPxFMm710Z25i-euOT2rrgCNXVa4na-fye0xamMXq_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Joel Stanley <joel@jms.id.au>, linux-mmc <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, devicetree <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed <linux-aspeed@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ryan Chen <ryanchen.aspeed@gmail.com>
List-Id: linux-mmc@vger.kernel.org



On Thu, 22 Aug 2019, at 21:15, Ulf Hansson wrote:
> On Thu, 15 Aug 2019 at 07:37, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Thu, 15 Aug 2019, at 15:06, Joel Stanley wrote:
> > > On Wed, 7 Aug 2019 at 00:38, Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > > The ASPEED SD/SDIO/MMC controller exposes two slots implementing the
> > > > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > > > data bus if only a single slot is enabled.
> > > >
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > >
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > >
> > > Two minor comments below.
> > >
> > > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > @@ -0,0 +1,105 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > >
> > > No "Copyright IBM" ?
> >
> > I'm going rogue.
> >
> > That reminds me I should chase up where we got to with the binding
> > licensing.
> >
> > >
> > > > +%YAML 1.2
> > > > +---
> > >
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > > +    sdc@1e740000 {
> > > > +            compatible = "aspeed,ast2500-sd-controller";
> > > > +            reg = <0x1e740000 0x100>;
> > > > +            #address-cells = <1>;
> > > > +            #size-cells = <1>;
> > > > +            ranges = <0 0x1e740000 0x10000>;
> > >
> > > According to the datasheet this could be 0x20000. It does not matter
> > > though, as there's nothing in it past 0x300.
> >
> > Good catch.
> >
> 
> Are you planning on sending a v6 or you want me to apply this and you
> can post a patch on top?

Yeah, sorry, I wasn't very clear there. I was hoping just to do a follow-up
patch with the cleanups if you're okay with that?

Andrew
