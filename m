From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: [PATCH 0/3] Fix sdhci-of-esdhc DMA coherency
Date: Sun, 22 Sep 2019 11:23:41 +0100
Message-ID: <20190922102341.GO25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>, dann frazier <dann.frazier@canonical.com>, Will Deacon <will.deacon@arm.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "Y.b. Lu" <yangbo.lu@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

The following patch set is a result of looking at the ADMA errors
observed on SolidRun's LX2160A board, caused by coherency mismatch
between DT and hardware.

The first patch improves the debugging by dumping the ADMA table
using the DMA address, which can be compared with the DMA address
reported in the register dump.  It also prints the interrupt status
that we read, whereas the register dump contains the _cleared_
interrupt status.

The second patch modifies sdhci-of-esdhc to set the DMA snoop bit
depending on whether DT marks the device as coherent or not.  With
this patch applied, driver will now set the hardware to match the
contents of DT, rather than always DMA snooping.  As explained by
Robin, if the hardware snoops the CPU caches, but the DMA API layer
does not expect this, the hardware can read stale data.  The hardware
state and the DMA API must always agree wrt this, for the sake of
data integrity.  Mismatch risks substantial filesystem corruption.

The third patch marks the LX2160A esdhc devices as dma-coherent.
Other users of the driver are not touched; I do not have the
information to know whether DMA snooping (coherency) is available
on other SoCs using this driver.  However, given the risk of
filesystem corruption, it is important no matter what that the
DMA API layer and the hardware agree - even if it means defaulting
to being non-coherent.

 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  2 ++
 drivers/mmc/host/sdhci-of-esdhc.c              |  7 ++++++-
 drivers/mmc/host/sdhci.c                       | 15 ++++++++++-----
 3 files changed, 18 insertions(+), 6 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
