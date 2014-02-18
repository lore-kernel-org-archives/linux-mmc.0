From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: add support for the Armada 38x SDHCI
 controller
Date: Tue, 18 Feb 2014 20:57:15 +0100
Message-ID: <20140218205715.531fc219@skate>
References: <1392736109-3981-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<2905238.0nD7CECiVl@wuerfel>
	<20140218202616.3cfa0ef8@skate>
	<5574693.NJgodrZ14k@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48256 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751560AbaBRT5X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 14:57:23 -0500
In-Reply-To: <5574693.NJgodrZ14k@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Marcin Wojtas <mw@semihalf.com>

Dear Arnd Bergmann,

On Tue, 18 Feb 2014 20:43:04 +0100, Arnd Bergmann wrote:

> > There are two completely different mechanisms:
> > 
> >  * The CPU -> { memory, device } windows. These windows are managed by
> >    the mvebu-mbus driver, as they are configured using global
> >    registers, owned by the mvebu-driver.
> > 
> >  * The device -> memory windows. These windows are needed for a given
> >    device to access memory in order to do DMA. These windows are
> >    configured through registers that are part of each peripheral
> >    register area.
> 
> Yes, I understand the difference. The former corresponds to
> the DT 'ranges' property, while the latter is the 'dma-ranges'
> property.

Hum, possible. I must admit I've never looked at the dma-ranges
property.

> > > I assume there are more the same register ranges for each bus master
> > > behind mbus (PCI being special again). How about adding an exported
> > > function to the mbus driver that sets up all the windows for one
> > > bus master correctly, passing only the number of the bus master?
> > 
> > This is certainly a possible refactoring, but it involves changing a
> > fairly large number of drivers, since many drivers are using
> > mv_mbus_dram_info() (this function and all the code spread in drivers
> > to configure windows predates the mach-mvebu thing and all the DT
> > conversion).
> 
> Is the layout of the mbus configuration windows in each device
> the same?

The number of windows is different, and for some devices, there are
additional registers to poke.

The simple example is:

 http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/mvsdio.c#n658

this one has only 4 windows, no remappable windows, no special register
to poke.

Another example is:

 http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/mv_xor.c#n1116

this one has 8 windows, 4 are remappable, and there are special
registers to poke: WINDOW_BAR_ENABLE(x) and WINDOW_OVERRIDE_CTRL(x).

Yet another example is:

 http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/marvell/mvneta.c#n2717

this one has 6 windows, 4 are remappable, and there is a special
register to poke: MVNETA_BASE_ADDR_ENABLE.

So, I believe some refactoring is possible, but we cannot completely
eliminate a per-driver handling of some of these registers.

> > Therefore, I'd like to have the possibility of handling sdhci-pxav3.c
> > like all other drivers for now, and then do a cleanup of this area.
> > Would this be possible?
> 
> Yes, sounds reasonable.

Great, thanks!

> Thanks for the clarification.

You're welcome, thanks for reviewing the patches!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
