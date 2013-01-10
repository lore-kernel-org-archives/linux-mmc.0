From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH v3 16/16] ARM: dts: add AM33XX SPI support
Date: Thu, 10 Jan 2013 13:46:53 -0600
Message-ID: <20130110194653.GA32519@kahuna>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-17-git-send-email-mporter@ti.com>
 <508D1791.1040806@ti.com> <20130110193547.GQ14660@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130110193547.GQ14660@beef>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 14:35-20130110, Matt Porter wrote:
> On Sun, Oct 28, 2012 at 05:01:29PM +0530, Sekhar Nori wrote:
> > On 10/18/2012 6:56 PM, Matt Porter wrote:
> > > Adds AM33XX SPI support for am335x-bone and am335x-evm.
> > > 
> > > Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> > > ---
> > >  arch/arm/boot/dts/am335x-bone.dts |   17 +++++++++++++++
> > >  arch/arm/boot/dts/am335x-evm.dts  |    9 ++++++++
> > >  arch/arm/boot/dts/am33xx.dtsi     |   43 +++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 69 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> > > index 5510979..23edfd8 100644
> > > --- a/arch/arm/boot/dts/am335x-bone.dts
> > > +++ b/arch/arm/boot/dts/am335x-bone.dts
> > > @@ -18,6 +18,17 @@
> > >  		reg = <0x80000000 0x10000000>; /* 256 MB */
> > >  	};
> > >  
> > > +	am3358_pinmux: pinmux@44e10800 {
> > > +		spi1_pins: pinmux_spi1_pins {
> > > +			pinctrl-single,pins = <
> > > +				0x190 0x13	/* mcasp0_aclkx.spi1_sclk, OUTPUT_PULLUP | MODE3 */
> > > +				0x194 0x33	/* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
> > > +				0x198 0x13	/* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
minor comment:
doing as a 0x33 is better for both d1, d0 as D0,D1 can be switched between SDI and SDO
as needed with ti,pindir-d0-out-d1-in
> > > +				0x19c 0x13	/* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
> > > +			>;
> > 
> > Is there a single pinmux setting that provides SPI functionality on the
> > bone headers? Or this is specific to a cape you tested with?
> 
> No, there are two usable settings for spi1 and one setting for spi0.
> I'm dropping this from the series since it's specific to how I wired up
> the homebrew cape I use for spi testing on the Bone. I publish the
> branch where all these extra "test-specific" patches (that aren't intended
> to be merged) are at in the cover letter.  Anybody that needs context of
> how/what worked and was tested can grab them there.
Possibly dumb question:
Cant we have pre-usable spi configurations?  Like spi1_configuration1_pins,
spi2_configuration1_pins, spi0_configuration1_pins? If documented with
P9 pin names in the bone dts, it saves a bit of effort in looking up
pad offset when dealing with capes.
-- 
Regards,
Nishanth Menon
