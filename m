From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
Date: Fri, 11 Nov 2016 11:22:43 +0800
Message-ID: <20161111112243.7431625d@xhacker>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
        <ee296deafdcbeb431a592b591ae38a758ba4cce7.1477911954.git-series.gregory.clement@free-electrons.com>
        <20161109182426.vfrpb4i2mfatdzz3@rob-hp-laptop>
        <15b06a12-ed69-03a7-ccc7-0c133ce1ac1e@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <15b06a12-ed69-03a7-ccc7-0c133ce1ac1e-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Jack(SH) Zhu" <jmzhu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shiwu Zhang <zhangshw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Xueping Liu <xpliu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hilbert
List-Id: linux-mmc@vger.kernel.org

Hi Rob, Ziji,

On Thu, 10 Nov 2016 19:44:19 +0800 Ziji Hu wrote:

> Hi Rob,
> 
> On 2016/11/10 2:24, Rob Herring wrote:
> > On Mon, Oct 31, 2016 at 12:09:54PM +0100, Gregory CLEMENT wrote:  
> >> From: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> >>
> >> Marvell Xenon SDHC can support eMMC/SD/SDIO.
> >> Add Xenon-specific properties.
> >> Also add properties for Xenon PHY setting.
> >>
> >> Signed-off-by: Hu Ziji <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >> ---
> >>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 161 +++++++-
> >>  MAINTAINERS                                                   |   1 +-
> >>  2 files changed, 162 insertions(+), 0 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> >> new file mode 100644
> >> index 000000000000..0d2d139494d3
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> >> @@ -0,0 +1,161 @@
> >> +Marvell's Xenon SDHCI Controller device tree bindings
> >> +This file documents differences between the core mmc properties
> >> +described by mmc.txt and the properties used by the Xenon implementation.
> >> +
> >> +A single Xenon IP can support multiple slots.
> >> +Each slot acts as an independent SDHC. It owns independent resources, such
> >> +as register sets clock and PHY.
> >> +Each slot should have an independent device tree node.
> >> +
> >> +Required Properties:
> >> +- compatible: should be one of the following
> >> +  - "marvell,armada-3700-sdhci": For controllers on Armada-3700 SOC.
> >> +  Must provide a second register area and marvell,pad-type.
> >> +  - "marvell,xenon-sdhci": For controllers on all the SOCs, other than
> >> +  Armada-3700.  
> > 
> > Need SoC specific compatible strings.
> >   
> 
> 	Xenon SDHC is a common IP for all Marvell SOCs.
> 	It is difficult to use a single SOC specific compatible to represent Xenon SDHC.
> 	There will be so many SOC compatible strings in list if each specific SOC owns a compatible.
> 	Actually only few SOCs require special properties.
> 	Any suggestion please?
> 
> >> +
> >> +- clocks:
> >> +  Array of clocks required for SDHCI.
> >> +  Requires at least one for Xenon IP core.
> >> +  Some SOCs require additional clock for AXI bus.
> >> +
> >> +- clock-names:
> >> +  Array of names corresponding to clocks property.
> >> +  The input clock for Xenon IP core should be named as "core".
> >> +  The optional AXI clock should be named as "axi".  
> > 
> > When is AXI clock optional? This should be required for ?? compatible 
> > strings.
> >   
> 	It is required on some SOCs.
> 	I will double check if a suitable compatible string can be determined for those SOCs.

Besides the core clk, berlin SoCs have one AXI clock. Usually, we have two
solutions:

solA: as current patch does, take "marvell,xenon-sdhci" as compatible string
and make the AXI clock property optional. Usually for berlin SoCs, we don't need
special properties.

PS: this solution is also what sdhci-pxav3.c takes

solB: As Rob said, add extra SoC compatible strings, so we'll have
something like:

static const struct of_device_id sdhci_xenon_of_match[] = {
	{ .compatible = "marvell,armada-3700-sdhci", },
	{ .compatible = "marvell,berlin4ct-sdhci", },
	...
	{ .compatible = "marvell,berlinxxx-mmc", },
}

then we take care the AXI clk for berlin SoCs in the code.


Which solution do you prefer?

Thanks,
Jisheng
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
