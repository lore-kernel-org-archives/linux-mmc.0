From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
Date: Fri, 11 Nov 2016 11:33:38 +0800
Message-ID: <20161111113324.377b8841@xhacker>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
        <ee296deafdcbeb431a592b591ae38a758ba4cce7.1477911954.git-series.gregory.clement@free-electrons.com>
        <20161109182426.vfrpb4i2mfatdzz3@rob-hp-laptop>
        <15b06a12-ed69-03a7-ccc7-0c133ce1ac1e@marvell.com>
        <20161111112243.7431625d@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52301 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965233AbcKKDjD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2016 22:39:03 -0500
In-Reply-To: <20161111112243.7431625d@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziji Hu <huziji@marvell.com>, Rob Herring <robh@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert

On Fri, 11 Nov 2016 11:22:43 +0800 Jisheng Zhang wrote:

> Hi Rob, Ziji,
> 
> On Thu, 10 Nov 2016 19:44:19 +0800 Ziji Hu wrote:
> 
> > Hi Rob,
> > 
> > On 2016/11/10 2:24, Rob Herring wrote:  
> > > On Mon, Oct 31, 2016 at 12:09:54PM +0100, Gregory CLEMENT wrote:    
> > >> From: Ziji Hu <huziji@marvell.com>
> > >>
> > >> Marvell Xenon SDHC can support eMMC/SD/SDIO.
> > >> Add Xenon-specific properties.
> > >> Also add properties for Xenon PHY setting.
> > >>
> > >> Signed-off-by: Hu Ziji <huziji@marvell.com>
> > >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > >> ---
> > >>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 161 +++++++-
> > >>  MAINTAINERS                                                   |   1 +-
> > >>  2 files changed, 162 insertions(+), 0 deletions(-)
> > >>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> > >> new file mode 100644
> > >> index 000000000000..0d2d139494d3
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
> > >> @@ -0,0 +1,161 @@
> > >> +Marvell's Xenon SDHCI Controller device tree bindings
> > >> +This file documents differences between the core mmc properties
> > >> +described by mmc.txt and the properties used by the Xenon implementation.
> > >> +
> > >> +A single Xenon IP can support multiple slots.
> > >> +Each slot acts as an independent SDHC. It owns independent resources, such
> > >> +as register sets clock and PHY.
> > >> +Each slot should have an independent device tree node.
> > >> +
> > >> +Required Properties:
> > >> +- compatible: should be one of the following
> > >> +  - "marvell,armada-3700-sdhci": For controllers on Armada-3700 SOC.
> > >> +  Must provide a second register area and marvell,pad-type.
> > >> +  - "marvell,xenon-sdhci": For controllers on all the SOCs, other than
> > >> +  Armada-3700.    
> > > 
> > > Need SoC specific compatible strings.
> > >     
> > 
> > 	Xenon SDHC is a common IP for all Marvell SOCs.
> > 	It is difficult to use a single SOC specific compatible to represent Xenon SDHC.
> > 	There will be so many SOC compatible strings in list if each specific SOC owns a compatible.
> > 	Actually only few SOCs require special properties.
> > 	Any suggestion please?
> >   
> > >> +
> > >> +- clocks:
> > >> +  Array of clocks required for SDHCI.
> > >> +  Requires at least one for Xenon IP core.
> > >> +  Some SOCs require additional clock for AXI bus.
> > >> +
> > >> +- clock-names:
> > >> +  Array of names corresponding to clocks property.
> > >> +  The input clock for Xenon IP core should be named as "core".
> > >> +  The optional AXI clock should be named as "axi".    
> > > 
> > > When is AXI clock optional? This should be required for ?? compatible 
> > > strings.
> > >     
> > 	It is required on some SOCs.
> > 	I will double check if a suitable compatible string can be determined for those SOCs.  
> 
> Besides the core clk, berlin SoCs have one AXI clock. Usually, we have two
> solutions:
> 
> solA: as current patch does, take "marvell,xenon-sdhci" as compatible string
> and make the AXI clock property optional. Usually for berlin SoCs, we don't need
> special properties.

Personally, I prefer solA: use the IP name as compatible string. This is IP
specific rather than SoC specific. The HW itself supports two clks

Thanks,
Jisheng

> 
> PS: this solution is also what sdhci-pxav3.c takes
> 
> solB: As Rob said, add extra SoC compatible strings, so we'll have
> something like:
> 
> static const struct of_device_id sdhci_xenon_of_match[] = {
> 	{ .compatible = "marvell,armada-3700-sdhci", },
> 	{ .compatible = "marvell,berlin4ct-sdhci", },
> 	...
> 	{ .compatible = "marvell,berlinxxx-mmc", },
> }
> 
> then we take care the AXI clk for berlin SoCs in the code.
> 
> 
> Which solution do you prefer?
> 
> Thanks,
> Jisheng

