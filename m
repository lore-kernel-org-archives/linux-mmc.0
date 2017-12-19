From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: tmio: use io* accessors consistently
Date: Tue, 19 Dec 2017 14:34:03 +0100
Message-ID: <20171219133403.788-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44181 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763016AbdLSNeI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 Dec 2017 08:34:08 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Because we started using io*_rep accessors previously because they are
more widely defined across architectures, let's be consistent and use
this family for all accessor wrappers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

And here is the follow-up patch. Tested on a R-Car M3-W; still could checksum a
huge file from SD without performance regressions.

 drivers/mmc/host/tmio_mmc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 03519c4ca0aa1a..e7d651352dc90f 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -227,7 +227,7 @@ int tmio_mmc_host_runtime_resume(struct device *dev);
 
 static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 {
-	return readw(host->ctl + (addr << host->bus_shift));
+	return ioread16(host->ctl + (addr << host->bus_shift));
 }
 
 static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
@@ -239,8 +239,8 @@ static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
 static inline u32 sd_ctrl_read16_and_16_as_32(struct tmio_mmc_host *host,
 					      int addr)
 {
-	return readw(host->ctl + (addr << host->bus_shift)) |
-	       readw(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
+	return ioread16(host->ctl + (addr << host->bus_shift)) |
+	       ioread16(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
 }
 
 static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr,
@@ -257,7 +257,7 @@ static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr,
 	 */
 	if (host->write16_hook && host->write16_hook(host, addr))
 		return;
-	writew(val, host->ctl + (addr << host->bus_shift));
+	iowrite16(val, host->ctl + (addr << host->bus_shift));
 }
 
 static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
@@ -269,8 +269,8 @@ static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
 static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host,
 						int addr, u32 val)
 {
-	writew(val & 0xffff, host->ctl + (addr << host->bus_shift));
-	writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
+	iowrite16(val & 0xffff, host->ctl + (addr << host->bus_shift));
+	iowrite16(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
 }
 
 static inline void sd_ctrl_write32_rep(struct tmio_mmc_host *host, int addr,
-- 
2.11.0

