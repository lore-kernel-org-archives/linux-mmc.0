From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 0/6] dmaengine: New 'universal' API for requesting channel
Date: Fri, 27 Nov 2015 10:29:36 +0200
Message-ID: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58442 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbbK0IaR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Nov 2015 03:30:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com

Hi,

As it has been discussed in the following thread:
http://www.gossamer-threads.com/lists/linux/kernel/2181487#2181487

Andy: I did looked at the unified device properties, but I decided to not to use
it as I don't see it to fit well and most of the legacy board files are using
resources to specify at least their memory regions so adding the DMA resource
to them would be more inline with the rest of the code.

This is the first RFC to try to address the deferred probing and dmaengine API
consolidation.

The last three patch is to show how things will work in real life. I have
access to OMAP-L138 evm, which can boot in DT and legacy mode so this is a good
platform for me to test things out.

With this series I have taken a path which would result two new API, which can
be used to convert most of the current users already and with some work all
users might be able to move to this set.
With this set the filter_fn used for legacy (non DT/ACPI) channel request is no
longer needed to be exported to client drivers since the selection of the
correct filter_fn will be done in the core.

So, the first proposal is to have:

struct dma_chan *dma_request_chan(struct device *dev, const char *name,
				  const dma_cap_mask_t *mask);
struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);

The dma_request_chan_by_mask() is to request any channel matching with the
requested capabilities, can be used to request channel for memcpy, memset, xor,
etc where no hardware synchronization is needed.

The dma_request_chan() is to request a slave channel. The mask parameter is
optional and it is used to check if the received channel's capabilities can\
satisfy the requested mask. The dma_request_chan() will try to find the channel
via DT, ACPI or in case if the kernel booted in non DT/ACPI mode it will use a
filter lookup table and retrieves the RESOURCE_DMA from the requester's device.
This legacy mode needs changes in platform code, in dmaengine drivers and
finally the dmaengine user drivers can be converted:

RESOURCE_DMA needs to be added to the platform devices with names

For each dmaengine driver a string array listing the devices handled by the
given DMA driver:

static char *da8xx_edma0_devices[] = {
	"davinci-mcasp.0",
	"da830-mmc.0",
};

This information is going to be needed by the dmaengine driver, so
modification to the platform_data is needed, and the driver map should be
added to the pdata of the DMA driver:

da8xx_edma0_pdata.devnames = da8xx_edma0_devices;
da8xx_edma0_pdata.devcnt = ARRAY_SIZE(da8xx_edma0_devices);

The DMA driver then needs to convigure the needed device -> filter_fn
mapping before it registers with dma_async_device_register() :

if (info->devnames) {
	ecc->dma_slave.filter_map.devnames = info->devnames;
	ecc->dma_slave.filter_map.devcnt = info->devcnt;
	ecc->dma_slave.filter_map.filter_fn = edma_filter_fn;
}

When neither DT or ACPI lookup is available the dma_request_chan() will
try to match the requester's device name with the filter_map's list of
device names, when a match found it will requests the named DMA resource
using the requester's pdev and with the needed information available it
will try to get the channele with the dma_get_channel() internal function.

Regards,
Peter
---
Peter Ujfalusi (6):
  dmaengine: core: Allow NULL mask pointer in
    __dma_device_satisfies_mask()
  dmaengine: core: Move and merge the code paths using private_candidate
  dmaengine: core: Introduce new, universal API to request a channel
  dmaengine: edma: Add support for DMA filter mapping to slave devices
  ARM: davinci: devices-da8xx: device -> dma instance mapping support
  mmc: davinci_mmc: Switch to use the new dmaengine API for requesting
    channel (NOT FOR MERGE)

 arch/arm/mach-davinci/devices-da8xx.c |  31 ++++++
 drivers/dma/dmaengine.c               | 175 ++++++++++++++++++++++++++--------
 drivers/dma/edma.c                    |   6 ++
 drivers/mmc/host/davinci_mmc.c        |  51 +++-------
 include/linux/dmaengine.h             |  21 ++++
 include/linux/platform_data/edma.h    |   3 +
 6 files changed, 211 insertions(+), 76 deletions(-)

-- 
2.6.3

