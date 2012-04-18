From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/8] ARM: OMAP: fix DMA vs memory ordering
Date: Wed, 18 Apr 2012 11:26:39 +0100
Message-ID: <20120418102639.GN25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk> <20120418101519.GU13842@arwen.pp.htv.fi> <20120418101733.GL25053@n2100.arm.linux.org.uk> <20120418101854.GV13842@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120418101854.GV13842@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 18, 2012 at 01:18:55PM +0300, Felipe Balbi wrote:
> On Wed, Apr 18, 2012 at 11:17:33AM +0100, Russell King - ARM Linux wrote:
> > Has anyone seen a problem (other than me when trying to get DMA engine
> > working with omap-serial transmit paths) ?
> 
> probably not since omap-serial isn't using DMA anyway. Nevermind

... which is a good thing because the driver is rather broken for DMA
support (take a look at what the set_termios() method does, and consider
what happens if that function is called when there's DMA activity
outstanding.)

I've come to the conclusion that it's not worth the effort to try to
convert omap-serial to DMAengine support.  Firstly, DMA support requires
hardware assisted flow control to work - which it currently doesn't for
many many reasons.  Not only because of wrong defines, but also because
the programming examples in the OMAP4430 TRM is wrong.  You'd do much
better going to the TI16C752B data sheet and seeing how the original IP
was described.  Why TI didn't include a copy of that in the TRM...

Secondly, the problem I mention above wrt set_termios(), with the flow
control fixed, results in a nice race condition causing the TX DMA to
write into registers other than the FIFO data register, corrupting the
UART configuration and halting system boot.

(I have a series of patches to fix the flow control issues, and this
requires some work outside of the omap-serial driver to achieve that.
I'll post those patches when they're fully ready.  At the moment, it's
probably better to rip out all the hardware assisted flow control code
from omap-serial so that we fall back on the standard software driven
flow control.)
