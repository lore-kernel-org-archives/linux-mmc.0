From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH] OMAP4: HSMMC cmd line reset change
Date: Thu, 16 Sep 2010 05:28:11 +0530 (IST)
Message-ID: <51627.192.168.10.89.1284595091.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org

OMAP4: HSMMC cmd line reset change

The cmd line reset logic is changed in OMAP4 ES2. The new procedure
is to monitor a 0->1 transition and then 1->0 transition.The earlier
logic would fail on ES2 chips because the loop could exit even before
the reset is actually complete.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4526d27..750ba7d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -976,12 +976,19 @@ static inline void omap_hsmmc_reset_controller_fsm(struct
omap_hsmmc_host *host,
 						   unsigned long bit)
 {
 	unsigned long i = 0;
+	unsigned long j = 0;
 	unsigned long limit = (loops_per_jiffy *
 				msecs_to_jiffies(MMC_TIMEOUT_MS));

 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 			 OMAP_HSMMC_READ(host->base, SYSCTL) | bit);

+	if (cpu_is_omap44xx() && bit == SRC) {
+		while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
+				&& (j++ < limit))
+			cpu_relax();
+	}
+
 	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & bit) &&
 		(i++ < limit))
 		cpu_relax();
-- 
1.7.0.4



