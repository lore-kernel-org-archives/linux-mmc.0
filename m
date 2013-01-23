From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: tmio: add barriers to IO operations
Date: Wed, 23 Jan 2013 17:46:18 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301231745130.26301@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Without barriers SDIO operations fail with runtime PM enabled.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index d857f5c..ad1a1c6 100644
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
+	wmb();
 	readsw(host->ctl + (addr << host->bus_shift), buf, count);
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
 	writesw(host->ctl + (addr << host->bus_shift), buf, count);
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

