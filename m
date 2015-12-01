From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC v02 03/15] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Tue, 1 Dec 2015 09:00:32 -0800
Message-ID: <20151201170031.GT23396@atomide.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
 <20151130155142.GZ2517@atomide.com>
 <565D56A0.2090204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49816 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbbLARAk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Dec 2015 12:00:40 -0500
Content-Disposition: inline
In-Reply-To: <565D56A0.2090204@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151201 00:14]:
> On 11/30/2015 05:51 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [151130 05:49]:
> >>
> >> For each dmaengine driver an array of DMA device, slave and the parameter
> >> for the filter function needs to be added:
> >>
> >> static struct dma_filter_map da830_edma_map[] = {
> >> 	DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)),
> >> 	DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)),
> >> 	DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)),
> >> 	DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0, 3)),
> >> 	DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0, 4)),
> >> 	DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0, 5)),
> >> 	DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14)),
> >> 	DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15)),
> >> 	DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16)),
> >> 	DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17)),
> >> 	DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18)),
> >> 	DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19)),
> >> };
> > 
> > FYI, if the EDMA_CTRL_CHAN above is just the evtmux registers
> 
> No, they are not. They are the eDMA event numbers. I used the EDMA_CTRL_CHAN()
> macro for all board files to have uniform look for the data. The first
> parameter means the eDMA instance number while the second is the event number
> on that eDMA. Since most devices have only one eDMA, we have 0 as eDMA id in
> most cases.
> The eventmux, or crossbar is different thing and we have several versions of
> the event crossbar or mux used.

OK

> > those
> > can be handled with the pinctrl framework. It seems that would allow
> > leaving out some of the built-in look up data, and have the mux parts
> > handled by a proper device driver. Below is a sample from the dm81xx
> > platform for reference.
> > 
> > SoC dtsi file:
> > 
> > evtmux: pinmux@f90 {
> > 	compatible = "pinctrl-single";
> > 	reg = <0xf90 0x40>;
> > 	#address-cells = <1>;
> > 	#size-cells = <0>;
> > 	pinctrl-single,register-width = <8>;
> > 	pinctrl-single,function-mask = <0x1f>;
> > };
> > 
> > Board specific dts file:
> > 
> > &evtmux {
> > 	sd2_edma_pins: pinmux_sd2_edma_pins {
> > 	pinctrl-single,pins = <
> > 		8 1     /* use SDTXEVT1 for EDMA instead of MCASP0TX */
> > 		9 2     /* use SDRXEVT1 for EDMA instead of MCASP0RX */
> > 		>;
> > 	};
> > };
> 
> I see. The dm81xx basically am33xx/am43xx?

Yeah similar to am33xx with different clocks and with a bunch of accelerators.

> Actually I would prefer to use the dmaengine's event router framework and we
> do have support for the am33xx/am43xx type of crossbar already implemented.
> I'm going to resend the DTS series for am33xx/am43xx to convert them to use
> the new DT bindings along with the dma event router support:
> https://www.mail-archive.com/linux-omap%40vger.kernel.org/msg120828.html

OK yes a dmaengine event router works too when available. Good to see
them as separate driver instances now :) Are only the dts changes missing
now?

FYI, when we have separate interconnect driver instances, we don't want to
and cannot tweak registers outside the interconnect instance because of them
being in separate clock and/or power domains :p

In any case, it seems there's no harm using pinctrl for evtmux on dm81xx
until the event router is available. It's currently only needed on the
t410 emmc that I'm aware of :)

> > Dynamic muxing of these channels can be done too using the pinctrl
> > framework named modes, but probably is not a good idea in the case of
> > SD card and MaASP in case something goes wrong :)
> 
> In theory it can be done, but in practice it is not possible. It is up to the
> board design decision to select which DMA event is not needed to be used in
> default mode and that one can be used to route the crossbar hidden request to it.
> Just imaging: playing audio from MMC (in the example you have), audio needs
> constant DMA, so the MMC would never get DMA request, also the drivers tend to
> request the DMA channel in their probe/init and hold to it as long as they are
> loaded...

Yes dynamic muxing of the dma channels sounds like file corruption waiting
to happen :) Let's stay away from that.

Regards,

Tony
