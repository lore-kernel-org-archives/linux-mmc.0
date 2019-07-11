From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Document Aspeed SD controller
Date: Thu, 11 Jul 2019 07:44:31 -0600
Message-ID: <CAL_Jsq+mAd=US3cbNQexFGrLxhkSyqi2XyGetyHrZV6QMd69EA@mail.gmail.com>
References: <20190710141611.21159-1-andrew@aj.id.au> <20190710141611.21159-2-andrew@aj.id.au>
 <CAL_JsqKrYcUbn_02z9GQO6U4rz7k=p3kB7_G0tKmv25MMZZNQg@mail.gmail.com> <3b0788cf-eee4-48b2-901d-d2ab6716ab1b@www.fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b0788cf-eee4-48b2-901d-d2ab6716ab1b@www.fastmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>, Adrian Hunter <adrian.hunter@intel.com>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ryan Chen <ryanchen.aspeed@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 10, 2019 at 6:56 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Thu, 11 Jul 2019, at 01:20, Rob Herring wrote:
> > On Wed, Jul 10, 2019 at 8:16 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> > > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > > data bus if only a single slot is enabled.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  .../bindings/mmc/sdhci-of-aspeed.yaml         | 91 +++++++++++++++++++
> >
> > aspeed,sdhci.yaml
>
> Ack. Previously I had separate documents for different compatibles, wasn't sure
> how to tackle name one document covering multiple compatibles.
>
> >
> > >  1 file changed, 91 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml b/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> > > new file mode 100644
> > > index 000000000000..e98a2ac4d46d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> > > @@ -0,0 +1,91 @@
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> >
> > The preferred license is (GPL-2.0 OR BSD-2-Clause) if that is okay with you.
>
> I should poke people internally again, I had asked, just haven't got a clear
> answer. What was the justification for the preference (just so I can pass that
> on)?

To use schema in non-GPL projects. *BSD, Zephyr, etc.

Rob
