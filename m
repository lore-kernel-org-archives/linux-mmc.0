From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: sdhci-of-at91: new compatible string
 and update properties
Date: Fri, 18 Oct 2019 14:15:23 +0200
Message-ID: <20191018121522.vq2co7b42kb2ykox@M43218.corp.atmel.com>
References: <20191011103340.26749-1-ludovic.desroches@microchip.com>
 <CAPDyKFqxfBG-CDd_O9d8X89GZmNFXh=CoFE2QqptgtLtOU5=_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqxfBG-CDd_O9d8X89GZmNFXh=CoFE2QqptgtLtOU5=_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, claudiu.beznea@microchip.com, Eugen.Hristev@microchip.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 18, 2019 at 12:56:14PM +0200, Ulf Hansson wrote:
> On Fri, 11 Oct 2019 at 12:33, Ludovic Desroches
> <ludovic.desroches@microchip.com> wrote:
> >
> > There is a new compatible string for the SAM9X60 sdhci device. It involves
> > an update of the properties about the clocks stuff.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> This doesn't apply any more, can you please re-spin it?

Sure, I'll rebase these patches and send a v2

Regards

Ludovic

> 
> Kind regards
> Uffe
> 
> 
> > ---
> >
> > Changes:
> > - v2: remove the extra example and fix node label
> >
> > This patch conflicts with Nicolas' one: "dt-bindings: sdhci-of-at91: add
> > the microchip,sdcal-inverted property". Let me know which one has to be
> > rebased or you can handle it.
> >
> > Ludovic
> >
> >
> >  .../devicetree/bindings/mmc/sdhci-atmel.txt       | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> > index 1b662d7171a0..5d541ad4d4eb 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> > @@ -5,17 +5,26 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
> >  sdhci-of-at91 driver.
> >
> >  Required properties:
> > -- compatible:          Must be "atmel,sama5d2-sdhci".
> > +- compatible:          Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
> >  - clocks:              Phandlers to the clocks.
> > -- clock-names:         Must be "hclock", "multclk", "baseclk";
> > +- clock-names:         Must be "hclock", "multclk", "baseclk" for
> > +                       "atmel,sama5d2-sdhci".
> > +                       Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
> > +
> > +Optional properties:
> > +- assigned-clocks:     The same with "multclk".
> > +- assigned-clock-rates The rate of "multclk" in order to not rely on the
> > +                       gck configuration set by previous components.
> >
> >
> >  Example:
> >
> > -sdmmc0: sdio-host@a0000000 {
> > +mmc0: sdio-host@a0000000 {
> >         compatible = "atmel,sama5d2-sdhci";
> >         reg = <0xa0000000 0x300>;
> >         interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
> >         clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
> >         clock-names = "hclock", "multclk", "baseclk";
> > +       assigned-clocks = <&sdmmc0_gclk>;
> > +       assigned-clock-rates = <480000000>;
> >  };
> > --
> > 2.23.0
> >
