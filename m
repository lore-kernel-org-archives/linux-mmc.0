From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 03/10] mmc: omap: remove unused variables and includes
Date: Sat, 18 Aug 2012 00:22:23 +0530
Message-ID: <1345229550-8672-4-git-send-email-svenkatr@ti.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, vishp@ti.com, Venkatraman S <svenkatr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Get rid of some unnecessary includes in the driver and
a few unused variables.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 50e08f0..0ec4e55 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -27,18 +27,10 @@
 #include <linux/mmc/card.h>
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
-#include <linux/i2c/tps65010.h>
 #include <linux/slab.h>
 
-#include <asm/io.h>
-#include <asm/irq.h>
-
-#include <plat/board.h>
 #include <plat/mmc.h>
-#include <asm/gpio.h>
 #include <plat/dma.h>
-#include <plat/mux.h>
-#include <plat/fpga.h>
 
 #define	OMAP_MMC_REG_CMD	0x00
 #define	OMAP_MMC_REG_ARGL	0x01
@@ -107,7 +99,6 @@ struct mmc_omap_slot {
 	u16			saved_con;
 	u16			bus_mode;
 	unsigned int		fclk_freq;
-	unsigned		powered:1;
 
 	struct tasklet_struct	cover_tasklet;
 	struct timer_list       cover_timer;
@@ -139,7 +130,6 @@ struct mmc_omap_host {
 	unsigned int		phys_base;
 	int			irq;
 	unsigned char		bus_mode;
-	unsigned char		hw_bus_mode;
 	unsigned int		reg_shift;
 
 	struct work_struct	cmd_abort_work;
-- 
1.7.11.1.25.g0e18bef

