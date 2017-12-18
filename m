From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH] mmc: tmio: use ioread* for repeated access to a register
Date: Mon, 18 Dec 2017 01:00:21 +0100
Message-ID: <20171218000021.16655-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Not all archs define reads* and writes*. Switch to ioread*_rep and
friends which is defined everywhere, so we can enable COMPILE_TEST after
that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

So, I pushed this to buildbot on top of Yamada-san's patch series and there
were no complaints, even with COMPILE_TEST enabled. I also did some tests on
HW and checksuming huge files on SD cards still works.

However, I am not sure about this mixture of read* and ioread* functions. Shall
we convert maybe all of those?

 drivers/mmc/host/tmio_mmc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 76094345cbacf3..03519c4ca0aa1a 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -233,7 +233,7 @@ static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
 				      u16 *buf, int count)
 {
-	readsw(host->ctl + (addr << host->bus_shift), buf, count);
+	ioread16_rep(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
 static inline u32 sd_ctrl_read16_and_16_as_32(struct tmio_mmc_host *host,
@@ -246,7 +246,7 @@ static inline u32 sd_ctrl_read16_and_16_as_32(struct tmio_mmc_host *host,
 static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr,
 				      u32 *buf, int count)
 {
-	readsl(host->ctl + (addr << host->bus_shift), buf, count);
+	ioread32_rep(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
 static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr,
@@ -263,7 +263,7 @@ static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr,
 static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
 				       u16 *buf, int count)
 {
-	writesw(host->ctl + (addr << host->bus_shift), buf, count);
+	iowrite16_rep(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
 static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host,
@@ -276,7 +276,7 @@ static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host,
 static inline void sd_ctrl_write32_rep(struct tmio_mmc_host *host, int addr,
 				       const u32 *buf, int count)
 {
-	writesl(host->ctl + (addr << host->bus_shift), buf, count);
+	iowrite32_rep(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
 #endif
-- 
2.11.0
