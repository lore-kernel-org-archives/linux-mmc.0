From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Sat, 25 Aug 2012 08:57:42 +0100
Message-ID: <20120825075742.GC25765@n2100.arm.linux.org.uk>
References: <CAMQu2gy-U1WmgGOGZ+VyXjZmLem9TEWbq5kR8jzC0qXvqF-=BA@mail.gmail.com>
 <CAAwP0s2Efuuc7vsX3bZuwz175zUjnmsOV87OcZ06p_eoe4T3Ug@mail.gmail.com>
 <alpine.DEB.2.01.1208232246530.15831@pmeerw.net>
 <CAMQu2gyEGPbNEE0ur0wh9RoJKuBe4B5NkQMUafQNWGVLX8t9vg@mail.gmail.com>
 <alpine.DEB.2.01.1208240942100.21552@pmeerw.net>
 <20120824094231.GA25765@n2100.arm.linux.org.uk>
 <CAMQu2gxs0bzNMtxb0LFyFKM9s4M4yXxFpopaBO+Hah3RjhCpLA@mail.gmail.com>
 <20120824103913.GB25765@n2100.arm.linux.org.uk>
 <CAMQu2gw-vEguFU9naxsHtDVOfJkZVsFNMWJbvbc=ZuULy7TZNA@mail.gmail.com>
 <alpine.DEB.2.01.1208241404440.21552@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.01.1208241404440.21552@pmeerw.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Kevin Hilman <khilman@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Chris Ball <cjb@laptop.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 24, 2012 at 02:10:38PM +0200, Peter Meerwald wrote:
> with Linux 3.6-rc3:
> 
> CONFIG_DMA_OMAP=m
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=m
> CONFIG_MMC_OMAP_HS=y
> CONFIG_SPI_OMAP24XX=y
> CONFIG_MTD_NAND_OMAP2=y
> 
>   LD      init/built-in.o
> drivers/built-in.o: In function `omap2_mcspi_setup':
> /home/pmeerw/linux-pmeerw/drivers/spi/spi-omap2-mcspi.c:859: undefined reference to `omap_dma_filter_fn'
> drivers/built-in.o: In function `omap_nand_probe':
> /home/pmeerw/linux-pmeerw/drivers/mtd/nand/omap2.c:1371: undefined reference to `omap_dma_filter_fn'
> drivers/built-in.o: In function `omap_hsmmc_probe':
> /home/pmeerw/linux-pmeerw/drivers/mmc/host/omap_hsmmc.c:2039: undefined reference to `omap_dma_filter_fn'
> make: *** [vmlinux] Error 1
> 
> in addition to SPI and MMC, there seems to be also a NAND dependency

Yes.  Unlike the PL08x driver, OMAP has no way to pass the filter function
into its drivers, and I didn't want the pain of fiddling around with DT
crap to try and work out how to do this.  So what you have here is
something that I got as far as I could, and TI then wanted it pushed into
mainline.

I have no solution for the above at present - the long term solution is
to sort out how to deal with DMA engine with DT etc.  At the moment,
there has been discussion about this but no solution.
