From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 1/3] mmc: omap_hsmmc: set host capabilities by reading
 MMCHS_CAPA2 register
Date: Thu, 13 Nov 2014 18:26:17 +0530
Message-ID: <1415883379-19654-2-git-send-email-kishon@ti.com>
References: <1415883379-19654-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1415883379-19654-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: chris@printf.net, ulf.hansson@linaro.org, tony@atomide.com
Cc: devicetree@vger.kernel.org, nsekhar@ti.com, afenkart@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Viswanath Puttagunta <vishp@ti.com>

set SDR104, SDR50, DDR50 and HS200 capability flags to caps/caps2 by reading
MMCHS_CAPA2 register.

Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Suggested-by: Misael Lopez Cruz <misael.lopez@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index df27bb4..2e42ed3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -64,6 +64,7 @@
 #define OMAP_HSMMC_ISE		0x0138
 #define OMAP_HSMMC_AC12		0x013C
 #define OMAP_HSMMC_CAPA		0x0140
+#define OMAP_HSMMC_CAPA2	0x0144
 
 #define VS18			(1 << 26)
 #define VS30			(1 << 25)
@@ -139,6 +140,10 @@
 #define ACTO	(1 << 1)
 #define ACNE	(1 << 0)
 
+#define SDR50	(1 << 0)
+#define SDR104	(1 << 1)
+#define DDR50	(1 << 2)
+
 #define MMC_AUTOSUSPEND_DELAY	100
 #define MMC_TIMEOUT_MS		20		/* 20 mSec */
 #define MMC_TIMEOUT_US		20000		/* 20000 micro Sec */
@@ -2028,6 +2033,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	unsigned tx_req, rx_req;
 	const struct omap_mmc_of_data *data;
 	void __iomem *base;
+	u32 reg;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -2153,6 +2159,19 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	mmc->pm_caps = mmc_slot(host).pm_caps;
 
+	reg = OMAP_HSMMC_READ(host->base, OMAP_HSMMC_CAPA2);
+
+	if (reg & SDR50)
+		mmc->caps |= MMC_CAP_UHS_DDR50;
+
+	if (reg & SDR104) {
+		mmc->caps |= MMC_CAP_UHS_SDR104;
+		mmc->caps2 |= MMC_CAP2_HS200;
+	}
+
+	if (reg & DDR50)
+		mmc->caps |= MMC_CAP_UHS_DDR50;
+
 	omap_hsmmc_conf_bus_power(host);
 
 	if (!pdev->dev.of_node) {
-- 
1.7.9.5
