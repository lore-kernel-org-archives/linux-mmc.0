From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 00/10] patch set about the MXS-DMA
Date: Thu, 19 Jan 2012 14:15:57 +0800
Message-ID: <1326953767-24155-1-git-send-email-b32955@freescale.com>
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
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, artem.bityutskiy@intel.com, b29396@freescale.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, w.sang@pengutronix.de, Huang Shijie <b32955@freescale.com>, linux-mtd@lists.infradead.org, shawn.guo@linaro.org, shijie8@gmail.com, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-mmc@vger.kernel.org

This patch set does two things about the MXS-DMA:
[1] patch 1 ~ patch 5: move the mxs dma header to a more common place.
	Beside the mx23/mx28, the APBH-DMA is also used by MX50 and MX6Q.
	So move the mxs dma header file to a more common place, and rename
	it to mxs-dma.h

[2] patch 6 ~ patch 10: rewrite the last parameter of mxs_dma_prep_slave_sg().
	In the new GPMI version, some hardware behavior changes.
	The WAIT4END bit should be set in the middle one of the ECC READ page DMA chain.
	The DMA chain should be set like this:

          +-----+               +-----+                      +-----+
          | cmd | ------------> | cmd | ------------------>  | cmd |
          +-----+               +-----+                      +-----+
                                   ^                            ^
                                   |                            |
                                   |                            |
                              set WAIT4END here too        set WAIT4END here

         Please read the comment in patch "MXS-DMA : add more flags for MXS-DMA".

Huang Shijie (10):
  MXS-DMA : move the mxs-dma.h to a more common place
  MXS-DMA : change the header
  MXS-MMC : change the DMA header file
  MTD/GPMI : change the DMA header file
  ASoc : change the DMA header file
  MXS-DMA : add more flags for MXS-DMA
  MXS-DMA : change the last parameter of mxs_dma_prep_slave_sg()
  MXS-MMC : use the new DMA flags
  MTD/GPMI : add a new field `gpmi_version`
  MTD/GPMI : change the code for new DMA interface

 arch/arm/mach-mxs/include/mach/dma.h   |   28 ----------------
 drivers/dma/mxs-dma.c                  |   12 ++++---
 drivers/mmc/host/mxs-mmc.c             |   12 +++---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |   23 ++++++++++---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    6 +++-
 drivers/mtd/nand/gpmi-nand/gpmi-regs.h |    2 +
 include/linux/mxs-dma.h                |   54 ++++++++++++++++++++++++++++++++
 sound/soc/mxs/mxs-pcm.c                |    2 +-
 sound/soc/mxs/mxs-pcm.h                |    2 +-
 sound/soc/mxs/mxs-saif.c               |    2 +-
 10 files changed, 94 insertions(+), 49 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/dma.h
 create mode 100644 include/linux/mxs-dma.h
