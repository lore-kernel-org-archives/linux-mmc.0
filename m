From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/5] mmc: tmio: Share register access functions
Date: Tue, 21 Jun 2011 08:00:09 +0900
Message-ID: <1308610812-3479-3-git-send-email-horms@verge.net.au>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1308610812-3479-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Move register access functions into a shared header.
Use sd_ctrl_write16 in tmio_mmc_dma.c:tmio_mmc_enable_dma().

Other than avoiding (trivial) open-coding, the motivation for
this is to allow platform-hooks in access functions to
be applied across all applicable accesses.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

Dependencies: "mmc: tmio: name 0xd8 as CTL_DMA_ENABLE"
---
 drivers/mmc/host/tmio_mmc.h     |   35 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc_dma.c |    2 +-
 drivers/mmc/host/tmio_mmc_pio.c |   34 ----------------------------------
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 8260bc2..0c22df0 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -134,4 +134,39 @@ int tmio_mmc_host_resume(struct device *dev);
 int tmio_mmc_host_runtime_suspend(struct device *dev);
 int tmio_mmc_host_runtime_resume(struct device *dev);
 
+static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
+{
+	return readw(host->ctl + (addr << host->bus_shift));
+}
+
+static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
+		u16 *buf, int count)
+{
+	readsw(host->ctl + (addr << host->bus_shift), buf, count);
+}
+
+static inline u32 sd_ctrl_read32(struct tmio_mmc_host *host, int addr)
+{
+	return readw(host->ctl + (addr << host->bus_shift)) |
+	       readw(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
+}
+
+static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val)
+{
+	writew(val, host->ctl + (addr << host->bus_shift));
+}
+
+static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
+		u16 *buf, int count)
+{
+	writesw(host->ctl + (addr << host->bus_shift), buf, count);
+}
+
+static inline void sd_ctrl_write32(struct tmio_mmc_host *host, int addr, u32 val)
+{
+	writew(val, host->ctl + (addr << host->bus_shift));
+	writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
+}
+
+
 #endif
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 9c4da66..f24a029 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -26,7 +26,7 @@ static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
 #if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
 	/* Switch DMA mode on or off - SuperH specific? */
-	writew(enable ? 2 : 0, host->ctl + (CTL_DMA_ENABLE << host->bus_shift));
+	sd_ctrl_write16(host, enable ? 2 : 0, CTL_DMA_ENABLE);
 #endif
 }
 
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index ad6347b..105f720 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -46,40 +46,6 @@
 
 #include "tmio_mmc.h"
 
-static u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
-{
-	return readw(host->ctl + (addr << host->bus_shift));
-}
-
-static void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
-		u16 *buf, int count)
-{
-	readsw(host->ctl + (addr << host->bus_shift), buf, count);
-}
-
-static u32 sd_ctrl_read32(struct tmio_mmc_host *host, int addr)
-{
-	return readw(host->ctl + (addr << host->bus_shift)) |
-	       readw(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
-}
-
-static void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val)
-{
-	writew(val, host->ctl + (addr << host->bus_shift));
-}
-
-static void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
-		u16 *buf, int count)
-{
-	writesw(host->ctl + (addr << host->bus_shift), buf, count);
-}
-
-static void sd_ctrl_write32(struct tmio_mmc_host *host, int addr, u32 val)
-{
-	writew(val, host->ctl + (addr << host->bus_shift));
-	writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
-}
-
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
 	u32 mask = sd_ctrl_read32(host, CTL_IRQ_MASK) & ~(i & TMIO_MASK_IRQ);
-- 
1.7.4.4

