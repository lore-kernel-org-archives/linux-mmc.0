From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v03 00/15] dmaengine: New 'universal' API for requesting channel
Date: Wed, 2 Dec 2015 15:59:10 +0200
Message-ID: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: tony@atomide.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

I keep this still as RFC.

Changes since RFC v02:
- Using has_acpi_companion() instead ACPI_HANDLE()
- mask matching change within private_candidate()
- Fallback in dma_request_chan() when DT/ACPI lookup fails.
- Rename dma_get_channel() -> find_candidate()
- Arch code changes as suggested by Arnd
- Some documentation updated, more need to be done.

Changes since RFC v01:
- dma_request_chan(); lost the mask parameter
- The new API does not rely on RESOURCE_DMA, instead the dma_filter_map table
  will be used to provide the needed information to the filter function in
  legacy mode
- Extended the example patches to convert most of daVinci to use the new API to
  request the DMA channels.

TODO: Documentation update ;)

As it has been discussed in the following thread:
http://www.gossamer-threads.com/lists/linux/kernel/2181487#2181487

Andy: I did looked at the unified device properties, but I decided to not to use
it as I don't see it to fit well and most of the legacy board files are using
resources to specify at least their memory regions so adding the DMA resource
to them would be more inline with the rest of the code.

The ARM, mmc and spi patches are converting daVinci drivers board files to use
the new method of requesting DMA channel.

With this series I have taken a path which would result two new API, which can
be used to convert most of the current users already and with some work all
users might be able to move to this set.
With this set the filter_fn used for legacy (non DT/ACPI) channel request is no
longer needed to be exported to client drivers since the selection of the
correct filter_fn will be done in the core.

So, the first proposal is to have:

struct dma_chan *dma_request_chan(struct device *dev, const char *name);
struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);

The dma_request_chan_by_mask() is to request any channel matching with the
requested capabilities, can be used to request channel for memcpy, memset, xor,
etc where no hardware synchronization is needed.

The dma_request_chan() is to request a slave channel. The dma_request_chan() will try to find the
channel via DT, ACPI or in case if the kernel booted in non DT/ACPI mode
it will use a filter lookup table and retrieves the needed information from
the dma_filter_map provided by the DMA drivers.
This legacy mode needs changes in platform code, in dmaengine drivers and
finally the dmaengine user drivers can be converted:

For each dmaengine driver an array of DMA device, slave and the parameter
for the filter function needs to be added:

static const struct dma_filter_map da830_edma_map[] = {
	{ "davinci-mcasp.0", "rx", EDMA_FILTER_PARAM(0, 0) },
	{ "davinci-mcasp.0", "tx", EDMA_FILTER_PARAM(0, 1) },
	{ "davinci-mcasp.1", "rx", EDMA_FILTER_PARAM(0, 2) },
	{ "davinci-mcasp.1", "tx", EDMA_FILTER_PARAM(0, 3) },
	{ "davinci-mcasp.2", "rx", EDMA_FILTER_PARAM(0, 4) },
	{ "davinci-mcasp.2", "tx", EDMA_FILTER_PARAM(0, 5) },
	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 14) },
	{ "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 15) },
	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 16) },
	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 17) },
	{ "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 18) },
	{ "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 19) },
};

This information is going to be needed by the dmaengine driver, so
modification to the platform_data is needed, and the driver map should be
added to the pdata of the DMA driver:

da8xx_edma0_pdata.slave_map = da830_edma_map;
da8xx_edma0_pdata.slavecnt = ARRAY_SIZE(da830_edma_map);

The DMA driver then needs to configure the needed device -> filter_fn
mapping before it registers with dma_async_device_register() :

if (info->slave_map) {
	ecc->dma_slave.filter_map.map = info->slave_map;
	ecc->dma_slave.filter_map.mapcnt = info->slavecnt;
	ecc->dma_slave.filter_map.filter_fn = edma_filter_fn;
}

When neither DT or ACPI lookup is available the dma_request_chan() will
try to match the requester's device name with the filter_map's list of
device names, when a match found it will use the information from the
dma_filter_map to get the channel with the dma_get_channel() internal
function.

Regards,
Peter
---
Peter Ujfalusi (15):
  dmaengine: core: Skip mask matching when it is not provided to
    private_candidate
  dmaengine: core: Move and merge the code paths using private_candidate
  dmaengine: core: Introduce new, universal API to request a channel
  dmaengine: edma: Add support for DMA filter mapping to slave devices
  ARM: davinci: devices-da8xx: Add dma_filter_map to edma
  ARM: davinci: dm355: Add dma_filter_map to edma
  ARM: davinci: dm365: Add dma_filter_map to edma
  ARM: davinci: dm644x: Add dma_filter_map to edma
  ARM: davinci: dm646x: Add dma_filter_map to edma
  mmc: davinci_mmc: Use dma_request_chan() to requesting DMA channel
  spi: davinci: Use dma_request_chan() to requesting DMA channel
  ARM: davinci: devices-da8xx: Remove DMA resources for MMC and SPI
  ARM: davinci: devices: Remove DMA resources for MMC
  ARM: davinci: dm355: Remove DMA resources for SPI
  ARM: davinci: dm365: Remove DMA resources for SPI

 Documentation/dmaengine/client.txt    |  23 ++---
 arch/arm/mach-davinci/devices-da8xx.c |  95 +++++++++---------
 arch/arm/mach-davinci/devices.c       |  19 ----
 arch/arm/mach-davinci/dm355.c         |  28 ++++--
 arch/arm/mach-davinci/dm365.c         |  30 ++++--
 arch/arm/mach-davinci/dm644x.c        |  12 +++
 arch/arm/mach-davinci/dm646x.c        |  11 +++
 drivers/dma/dmaengine.c               | 181 ++++++++++++++++++++++++++--------
 drivers/dma/edma.c                    |   6 ++
 drivers/mmc/host/davinci_mmc.c        |  52 +++-------
 drivers/spi/spi-davinci.c             |  76 +++++---------
 include/linux/dmaengine.h             |  27 +++++
 include/linux/platform_data/edma.h    |   7 ++
 13 files changed, 336 insertions(+), 231 deletions(-)

-- 
2.6.3
