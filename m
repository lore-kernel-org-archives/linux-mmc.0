From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v3 13/13] mmc: tmio: add barriers to IO operations
Date: Wed,  6 Feb 2013 20:47:00 +0100
Message-ID: <1360180020-18555-14-git-send-email-g.liakhovetski@gmx.de>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

Without barriers SDIO operations fail with runtime PM enabled.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Paul Mundt <lethal@linux-sh.org>
---

v3: use iowrite16_rep() and ioread16_rep() for consistency.

 drivers/mmc/host/tmio_mmc.h |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index d857f5c..a10ebd0 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -159,19 +159,20 @@ int tmio_mmc_host_runtime_resume(struct device *dev);
 
 static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 {
-	return readw(host->ctl + (addr << host->bus_shift));
+	return ioread16(host->ctl + (addr << host->bus_shift));
 }
 
 static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
 		u16 *buf, int count)
 {
-	readsw(host->ctl + (addr << host->bus_shift), buf, count);
+	wmb();
+	ioread16_rep(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
 static inline u32 sd_ctrl_read32(struct tmio_mmc_host *host, int addr)
 {
-	return readw(host->ctl + (addr << host->bus_shift)) |
-	       readw(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
+	return ioread16(host->ctl + (addr << host->bus_shift)) |
+	       ioread16(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
 }
 
 static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val)
@@ -181,19 +182,20 @@ static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val
 	 */
 	if (host->pdata->write16_hook && host->pdata->write16_hook(host, addr))
 		return;
-	writew(val, host->ctl + (addr << host->bus_shift));
+	iowrite16(val, host->ctl + (addr << host->bus_shift));
 }
 
 static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
 		u16 *buf, int count)
 {
-	writesw(host->ctl + (addr << host->bus_shift), buf, count);
+	iowrite16_rep(host->ctl + (addr << host->bus_shift), buf, count);
+	wmb();
 }
 
 static inline void sd_ctrl_write32(struct tmio_mmc_host *host, int addr, u32 val)
 {
-	writew(val, host->ctl + (addr << host->bus_shift));
-	writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
+	iowrite16(val, host->ctl + (addr << host->bus_shift));
+	iowrite16(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
 }
 
 
-- 
1.7.2.5

