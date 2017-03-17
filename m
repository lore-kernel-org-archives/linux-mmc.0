From: Piotr Sroka <piotrs@cadence.com>
Subject: [v3 1/3] mmc: sdhci-cadence: Fix writing PHY delay
Date: Fri, 17 Mar 2017 12:38:22 +0000
Message-ID: <1489754302-10996-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Piotr Sroka <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org

Add polling for ACK to be sure that data are written to PHY register.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
Changes for v2:
- fix indent
---
Changes for v3:
- none
---
 drivers/mmc/host/sdhci-cadence.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 316cfec..b2334ec 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -66,11 +66,12 @@ struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 };
 
-static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
-				     u8 addr, u8 data)
+static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
+				    u8 addr, u8 data)
 {
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
 	u32 tmp;
+	int ret;
 
 	tmp = (data << SDHCI_CDNS_HRS04_WDATA_SHIFT) |
 	      (addr << SDHCI_CDNS_HRS04_ADDR_SHIFT);
@@ -79,8 +80,14 @@ static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 	tmp |= SDHCI_CDNS_HRS04_WR;
 	writel(tmp, reg);
 
+	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
+	if (ret)
+		return ret;
+
 	tmp &= ~SDHCI_CDNS_HRS04_WR;
 	writel(tmp, reg);
+
+	return 0;
 }
 
 static void sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
-- 
2.2.2
