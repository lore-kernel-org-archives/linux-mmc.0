From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 09/16] mmc: host: omap_hsmmc: Prepare *set_timing() to be used for iodelay setting
Date: Fri, 16 Jun 2017 18:15:37 +0530
Message-ID: <20170616124544.15046-10-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

No functional change. Add separate case statements for certain timing
like MMC_TIMING_SD_HS and MMC_TIMING_MMC_HS even though AC12_UHSMC_RES
has to be written to the AC12 register (same as for default modes).
Also have separate case sections for MMC_TIMING_UHS_SDR104 and
MMC_TIMING_UHS_HS200 even though the same UHSMC value has to be written
to the AC12 register. This is in preparation for setting iodelay
values.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 3676ffa72929..d797224152ac 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1726,6 +1726,8 @@ static void omap_hsmmc_set_timing(struct omap_hsmmc_host *host)
 	val &= ~AC12_UHSMC_MASK;
 	switch (ios->timing) {
 	case MMC_TIMING_UHS_SDR104:
+		val |= AC12_UHSMC_SDR104;
+		break;
 	case MMC_TIMING_MMC_HS200:
 		val |= AC12_UHSMC_SDR104;
 		break;
@@ -1741,6 +1743,13 @@ static void omap_hsmmc_set_timing(struct omap_hsmmc_host *host)
 	case MMC_TIMING_UHS_SDR12:
 		val |= AC12_UHSMC_SDR12;
 		break;
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_MMC_HS:
+		val |= AC12_UHSMC_RES;
+		break;
+	case MMC_TIMING_MMC_DDR52:
+		val |= AC12_UHSMC_RES;
+		break;
 	default:
 		val |= AC12_UHSMC_RES;
 		break;
-- 
2.11.0
