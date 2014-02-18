From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: add support for the Armada 38x SDHCI
 controller
Date: Tue, 18 Feb 2014 20:26:16 +0100
Message-ID: <20140218202616.3cfa0ef8@skate>
References: <1392736109-3981-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<2905238.0nD7CECiVl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48111 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751180AbaBRT0T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 14:26:19 -0500
In-Reply-To: <2905238.0nD7CECiVl@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Marcin Wojtas <mw@semihalf.com>

Dear Arnd Bergmann,

On Tue, 18 Feb 2014 19:02:47 +0100, Arnd Bergmann wrote:

> > In order to achieve this, the sdhci-pxav3 driver is extended with an
> > additional compatible string "marvell,armada-380-sdhci". When this
> > compatible string is used, the MBus windows are initialized in a way
> > that is identical to what all other DMA-capable drivers for Marvell
> > EBU platforms do.
> 
> It seems odd to do this in the sdhci driver, when the configuration
> is done in registers that belong to mbus.

No, those registers don't belong to MBus. They belong to the device
itself, as they configure the device -> memory windows.

Because SDHCI has a standard register interface, they separated the
SDHCI registers (standard) from the registers to configure the device
-> Mbus windows (Marvell-specific).

But in all other IPs, the device -> memory windows are configured in
registers that are just in the middle of the other registers for this
device.

Examples:

 * In the mvneta driver, the register definitions:

   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/marvell/mvneta.c#n57

   and the corresponding code:

   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/marvell/mvneta.c#n2717

 * In the XOR driver, the register definitions:

   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/mv_xor.h#n53

   and the corresponding code:

   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/mv_xor.c#n1116

 * In the mvsdio driver, the register definitions:

   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/mvsdio.h#n66

   and the corresponding code:

   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/mvsdio.c#n658

And there are many more examples throughout the kernel. These registers
are in the middle of the other registers for the IP. The SDHCI IP is an
exception here.

> 
> > +/*
> > + * These registers are relative to the second register region, for the
> > + * MBus bridge.
> > + */
> > +#define SDHCI_WINDOW_CTRL(i)   (0x80 + ((i) << 3))
> > +#define SDHCI_WINDOW_BASE(i)   (0x84 + ((i) << 3))
> > +#define SDHCI_MAX_WIN_NUM      8
> 
> These look similar to the outbound mbus windows that are used for MMIO,
> but it's not really clear from the code what they really do.

There are two completely different mechanisms:

 * The CPU -> { memory, device } windows. These windows are managed by
   the mvebu-mbus driver, as they are configured using global
   registers, owned by the mvebu-driver.

 * The device -> memory windows. These windows are needed for a given
   device to access memory in order to do DMA. These windows are
   configured through registers that are part of each peripheral
   register area.

> 
> > +       for (i = 0; i < SDHCI_MAX_WIN_NUM; i++) {
> > +               writel(0, regs + SDHCI_WINDOW_CTRL(i));
> > +               writel(0, regs + SDHCI_WINDOW_BASE(i));
> > +       }
> > +
> > +       for (i = 0; i < dram->num_cs; i++) {
> > +               const struct mbus_dram_window *cs = dram->cs + i;
> > +
> > +               /* Write size, attributes and target id to control register
> > */ +               writel(((cs->size - 1) & 0xffff0000) |
> > +                       (cs->mbus_attr << 8) |
> > +                       (dram->mbus_dram_target_id << 4) | 1,
> > +                       regs + SDHCI_WINDOW_CTRL(i));
> > +               /* Write base address to base register */
> > +               writel(cs->base, regs + SDHCI_WINDOW_BASE(i));
> > +       }
> 
> Accessing the mbus_dram_window() is also something that seems to fit
> better into the mbus driver.
> 
> I assume there are more the same register ranges for each bus master
> behind mbus (PCI being special again). How about adding an exported
> function to the mbus driver that sets up all the windows for one
> bus master correctly, passing only the number of the bus master?

This is certainly a possible refactoring, but it involves changing a
fairly large number of drivers, since many drivers are using
mv_mbus_dram_info() (this function and all the code spread in drivers
to configure windows predates the mach-mvebu thing and all the DT
conversion).

Therefore, I'd like to have the possibility of handling sdhci-pxav3.c
like all other drivers for now, and then do a cleanup of this area.
Would this be possible?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
