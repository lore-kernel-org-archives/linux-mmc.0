From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document Aspeed SD controller
Date: Thu, 18 Jul 2019 11:19:40 +0930
Message-ID: <e93c02e3-c855-4f29-aa20-535dd53d9321@www.fastmail.com>
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-2-andrew@aj.id.au>
 <CAL_JsqLkOtsAxj9NvNB=EEkH00k-dtNedNY042uuntSmcjhDhA@mail.gmail.com>
 <3fe55ea9-b949-48a0-9eab-90ad3bc1ee2a@www.fastmail.com>
 <CAL_JsqKMo_uv4Ur-D4NaUXk94hGJeRt5fg+0998dDjJCTgumGg@mail.gmail.com>
 <e7b472a8-73ae-4f39-a3e4-9e2d9dbcd01e@www.fastmail.com>
 <CAL_JsqKYL5yv8E=aKD1fJwXx1LLdUAs_ZFrc5k1dHsB9u+2ing@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKYL5yv8E=aKD1fJwXx1LLdUAs_ZFrc5k1dHsB9u+2ing@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>, Adrian Hunter <adrian.hunter@intel.com>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ryan Chen <ryanchen.aspeed@gmail.com>
List-Id: linux-mmc@vger.kernel.org



On Wed, 17 Jul 2019, at 23:13, Rob Herring wrote:
> On Tue, Jul 16, 2019 at 9:58 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Wed, 17 Jul 2019, at 00:27, Rob Herring wrote:
> > > On Mon, Jul 15, 2019 at 6:36 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > >
> > > >
> > > > On Tue, 16 Jul 2019, at 07:47, Rob Herring wrote:
> > > > > On Thu, Jul 11, 2019 at 9:32 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > > >
> > > > > > The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> > > > > > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > > > > > data bus if only a single slot is enabled.
> > > > > >
> > > > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > > > > ---
> > > > > > In v2:
> > > > > >
> > > > > > * Rename to aspeed,sdhci.yaml
> > > > > > * Rename sd-controller compatible
> > > > > > * Add `maxItems: 1` for reg properties
> > > > > > * Move sdhci subnode description to patternProperties
> > > > > > * Drop sdhci compatible requirement
> > > > > > * #address-cells and #size-cells are required
> > > > > > * Prevent additional properties
> > > > > > * Implement explicit ranges in example
> > > > > > * Remove slot property
> > > > > >
> > > > > >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 90 +++++++++++++++++++
> > > > > >  1 file changed, 90 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..67a691c3348c
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > > > @@ -0,0 +1,90 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: ASPEED SD/SDIO/eMMC Controller
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Andrew Jeffery <andrew@aj.id.au>
> > > > > > +  - Ryan Chen <ryanchen.aspeed@gmail.com>
> > > > > > +
> > > > > > +description: |+
> > > > > > +  The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the SDIO
> > > > > > +  Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit data bus if
> > > > > > +  only a single slot is enabled.
> > > > > > +
> > > > > > +  The two slots are supported by a common configuration area. As the SDHCIs for
> > > > > > +  the slots are dependent on the common configuration area, they are described
> > > > > > +  as child nodes.
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    enum: [ aspeed,ast2400-sd-controller, aspeed,ast2500-sd-controller ]
> > > > >
> > > > > This is actually a list of 4 strings. Please reformat to 1 per line.
> > > >
> > > > On reflection that's obvious, but also a somewhat subtle interaction with the
> > > > preference for no quotes (the obvious caveat being "except where required").
> > >
> > > It wasn't something I'd run into before. I'm working on a check, but
> > > unfortunately we can only check for quotes not needed and can't check
> > > for missing quotes.
> > >
> > > > Thanks for pointing it out.
> > > >
> > > > I have been running `make dt_binding_check` and `make dtbs_check` over
> > > > these, looks like I need to up my game a bit though. Do you do additional things
> > > > in your workflow?
> > >
> > > That should have thrown the warnings. If you aren't seeing those, do
> > > you have dtschema package installed (see
> > > Documentation/devicetree/writing-schema.md)?
> >
> > I do have it installed, but as mentioned previously there's a fair few
> > warnings emitted currently by the Aspeed devicetrees, so it might have
> > got lost in the noise. I've started to clean that up, though probably need
> > some direction there too.
> >
> > Separately I'm currently trying to track down an issue where I get errors
> > on the Aspeed dts cpu nodes about failing to match the riscv CPU
> > compatibles, it seems dt-validate isn't finding the ARM CPU compatible
> > strings. It feels more annoying to track down that I'd like.
> 
> There's a fix in today's linux-next for that and it should be in
> Linus' tree in a few days.
> 

Thanks, I'll take a look.

Andrew
