From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH v3 08/16] ARM: dts: add AM33XX EDMA support
Date: Thu, 10 Jan 2013 14:27:40 -0500
Message-ID: <20130110192740.GO14660@beef>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
	<1350566815-409-9-git-send-email-mporter@ti.com>
	<508D1414.2000506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <508D1414.2000506-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, Oct 28, 2012 at 04:46:36PM +0530, Sekhar Nori wrote:
> On 10/18/2012 6:56 PM, Matt Porter wrote:
> > Adds AM33XX EDMA support to the am33xx.dtsi as documented in
> > Documentation/devicetree/bindings/dma/ti-edma.txt
> > 
> > Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/am33xx.dtsi |   31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index bb31bff..ab9c78f 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -62,6 +62,37 @@
> >  			reg = <0x48200000 0x1000>;
> >  		};
> >  
> > +		edma: edma@49000000 {
> > +			compatible = "ti,edma3";
> > +			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > +			reg =	<0x49000000 0x10000>,
> > +				<0x44e10f90 0x10>;
> > +			interrupt-parent = <&intc>;
> > +			interrupts = <12 13 14>;
> > +			#dma-cells = <1>;
> > +			dma-channels = <64>;
> > +			ti,edma-regions = <4>;
> > +			ti,edma-slots = <256>;
> > +			ti,edma-reserved-channels = <0  2
> > +						     14 2
> > +						     26 6
> > +						     48 4
> > +						     56 8>;
> > +			ti,edma-reserved-slots = <0  2
> > +						  14 2
> > +						  26 6
> > +						  48 4
> > +						  56 8
> > +						  64 127>;
> 
> No need to reserve any channels or slots on AM335x, I think. This is
> used on DaVinci devices to share channels with DSP. I am not sure the
> cortex-M3 or PRU on the AM335x need to (or even can) have EDMA access.

I agree. I'm dropping this from the .dtsi in v4 as it is board/application
specific. The PRU, at least, can use the EDMA and I've seen examples as
such, but we can't hardcode this. The feature is there and documented in
the binding if somebody needs to reserve channels in their .dts.

-Matt

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
