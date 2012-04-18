From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [RFC 0/8] DMA engine conversion for omap_hsmmc
Date: Wed, 18 Apr 2012 11:09:54 +0100
Message-ID: <20120418100954.GK25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This series is the preliminary conversion of OMAPs private DMA API to
DMAengine.  It focuses on the OMAP HSMMC driver, as I believe that is
the only DMA-capable driver which is used on the platforms I have
available (3430LDP and 4430SDP).

For the OMAP DMAengine driver, there's a few short-comings:

1. pause/resume support is not implemented; it's not clear whether the
   OMAP hardware is capable of supporting this sanely.

2. status function does not return DMA residue.

3. DMAengine holds on to physical DMA channels while the driver maintains
   a reference to the virtual DMA engine channel.  This is not an issue
   with drivers; drivers should be able to hold a DMA channel for their
   lifetime.  DMAengine code could be improved to dynamically allocate
   physical channels, but this should happen when more drivers have been
   converted.

I took the approach with omap_hsmmc to add DMAengine support to the driver
along side the existing DMA support, so that I had a stage where I could
switch between the two implementations for comparisons - and also to allow
me to run with read using DMAengine support, and write using the private
API.  This allowed a progressive switch over to using DMAengine, and
allowed debugging without destroying the contents of the MMC card.

A point about DMAengine and DMA API for anyone who contemplates converting
other drivers: the struct device to be used for mapping/unmapping/coherent
memory is the DMAengine's device structure (channel->device->dev) not the
peripheral (eg, MMC) device structure.  It's the DMAengine which is
performing the DMA to memory, not the peripheral device.  The peripheral
device is merely receiving the data from the DMAengine, and does not care
where that data has come from.  So, dma masks for peripheral devices are
meaningless (and wrong.)
