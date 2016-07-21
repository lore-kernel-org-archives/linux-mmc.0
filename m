From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: Re: Unsynchronized access to spi bus by mmc_rescan?
Date: Thu, 21 Jul 2016 16:44:51 -0400
Message-ID: <20160721204451.GE15995@brightrain.aerifal.cx>
References: <20160422212842.GB21636@brightrain.aerifal.cx>
 <20160504224445.GW21636@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160504224445.GW21636-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, May 04, 2016 at 06:44:45PM -0400, Rich Felker wrote:
> Ping.
> 
> On Fri, Apr 22, 2016 at 05:28:42PM -0400, Rich Felker wrote:
> > I'm working on a driver for the J-core (http://j-core.org) SPI master,
> > which is currently limited to PIO and using the spi-bitbang framework
> > (probably not the right thing to use, but planned to change, and seems
> > orthogonal to the issue at hand). We're using it to access an SD card
> > via the mmc_spi mmc host driver, and experiencing crashes/corruption
> > that I tracked down to mmc_rescan (we don't yet have an interrupt for
> > media change) happening during SPI message transfers. Which locks are
> > supposed to preclude this from happening? Is it likely something wrong
> > our driver is using, or is there possibly a general bug in the MMC/SPI
> > subsystem(s)?

Ping. I'm also experiencing this issue with multiple devices on the
same spi bus; access seems completely unsynchronized. While it's hard
to rule out the possibility of it being specific to the spi master
driver, the driver just implements transfer_one and set_cs, so
synchronization would necessarily have to happen at a higher level.
Any tips on how I could further track down the cause?

Rich
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
