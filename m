From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 187/304] mmc: sdhci-omap: Fix timeout checks
Date: Mon, 28 Jan 2019 10:41:44 -0500
Message-ID: <20190128154341.47195-187-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 9f0ea0bda1d06120b053bb0c283f54afec59293d ]

Always check the wait condition before returning timeout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-omap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index d264391616f9..d02f5cf76b3d 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -220,8 +220,12 @@ static void sdhci_omap_conf_bus_power(struct sdhci_omap_host *omap_host,
 
 	/* wait 1ms */
 	timeout = ktime_add_ms(ktime_get(), SDHCI_OMAP_TIMEOUT);
-	while (!(sdhci_omap_readl(omap_host, SDHCI_OMAP_HCTL) & HCTL_SDBP)) {
-		if (WARN_ON(ktime_after(ktime_get(), timeout)))
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (sdhci_omap_readl(omap_host, SDHCI_OMAP_HCTL) & HCTL_SDBP)
+			break;
+		if (WARN_ON(timedout))
 			return;
 		usleep_range(5, 10);
 	}
@@ -653,8 +657,12 @@ static void sdhci_omap_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 
 	/* wait 1ms */
 	timeout = ktime_add_ms(ktime_get(), SDHCI_OMAP_TIMEOUT);
-	while (!(sdhci_omap_readl(omap_host, SDHCI_OMAP_STAT) & INT_CC_EN)) {
-		if (WARN_ON(ktime_after(ktime_get(), timeout)))
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (sdhci_omap_readl(omap_host, SDHCI_OMAP_STAT) & INT_CC_EN)
+			break;
+		if (WARN_ON(timedout))
 			return;
 		usleep_range(5, 10);
 	}
-- 
2.19.1
