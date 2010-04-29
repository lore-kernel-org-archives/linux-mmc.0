From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v8 0/2] sDMA descriptor autoloading feature
Date: Thu, 29 Apr 2010 23:04:34 +0530
Message-ID: <i2x618f0c911004291034g7f5b377ds5efaf74c901bc036@mail.gmail.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Madhusudhan Chikkature <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

    This patch series is the introduction of new sDMA feature: descriptor
autoloading (v8) and it's adoption by the OMAP HSMMC driver.

   The previous version (v7) was blocked on achieving proper interrupt
syncronisation
between the MMC and DMA callback in the HSMMC driver.
  Thanks to Adrian Hunter's patch, https://patchwork.kernel.org/patch/94670/
this has been cleaned up.

Current version is based on for-next branch + Adrian Hunter's
interrupt syncronisation patch
(https://patchwork.kernel.org/patch/94670)

Changes since v7:
  * Removed the 'fix race condition between DMA and HSMMC callback'
part of the series
  * Added memory barries in start and resume sglist transfer for cpu
buffer syncronization
  * Cleanup and comments

This has been tested on OMAP3430, OMAP3630 and OMAP4430 SDP
for MMC file transfer and as boot file system.

Venkatraman S:
    sDMA: descriptor autoloading feature
    MMC: omap hsmmc adoption of descriptor autoloading feature

 arch/arm/plat-omap/dma.c              |  289 ++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dma.h |  170 +++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |  148 ++++++++++++++---
 3 files changed, 583 insertions(+), 24 deletions(-)
