From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH V2] OMAP4 ES2:  HSMMC soft reset change
Date: Wed, 29 Sep 2010 06:16:18 +0530 (IST)
Message-ID: <65452.192.168.10.88.1285721178.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

The omap4 es2 hsmmc has a updated soft reset logic.After the
reset is issued monitor a 0->1 transition first. The reset of
CMD or DATA lines is complete only after a 0->1->0 transition
of SRC or SRD bits.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Tested-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c           |    3 +++
 arch/arm/plat-omap/include/plat/mmc.h |    1 +
 drivers/mmc/host/omap_hsmmc.c         |   11 +++++++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 87ce6ff..37f9f56 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -298,6 +298,9 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info
*controllers)
 		else
 			mmc->slots[0].features |= HSMMC_HAS_PBIAS;

+		if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
+			mmc->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
+
 		switch (c->mmc) {
 		case 1:
 			if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
diff --git a/arch/arm/plat-omap/include/plat/mmc.h
b/arch/arm/plat-omap/include/plat/mmc.h
index 4f819fc..2c4629a 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -103,6 +103,7 @@ struct omap_mmc_platform_data {

 		/* we can put the features above into this variable */
 #define HSMMC_HAS_PBIAS		(1 << 0)
+#define HSMMC_HAS_UPDATED_RESET	(1 << 1)
 		unsigned features;

 		int switch_pin;			/* gpio (card detect) */
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 53f8fa5..69858e7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -982,6 +982,17 @@ static inline void omap_hsmmc_reset_controller_fsm(struct
omap_hsmmc_host *host,
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 			 OMAP_HSMMC_READ(host->base, SYSCTL) | bit);

+	/*
+	 * OMAP4 ES2 and greater has an updated reset logic.
+	 * Monitor a 0->1 transition first
+	 */
+	if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET) {
+		while ((!(OMAP_HSMMC_READ(host, SYSCTL) & bit))
+					&& (i++ < limit))
+			cpu_relax();
+	}
+	i = 0;
+
 	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & bit) &&
 		(i++ < limit))
 		cpu_relax();
-- 
1.7.0.4



