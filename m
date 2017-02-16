From: Piotr Sroka <piotrs@cadence.com>
Subject: [PATCH 1/2] [1/2] mmc: sdhci-cadence: Fix writing PHY delay
Date: Thu, 16 Feb 2017 13:06:52 +0000
Message-ID: <1487250413-5769-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from keymaster.Cadence.COM ([158.140.2.26]:53833 "EHLO
        mx-sanjose5.cadence.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754374AbdBPNmO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 08:42:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Piotr Sroka <piotrs@cadence.com>

Add polling for ACK to be sure that data are written to PHY register.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
 drivers/mmc/host/sdhci-cadence.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 4b0ecb9..c946e45 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -65,11 +65,12 @@ struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 };
 
-static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
+static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 				     u8 addr, u8 data)
 {
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
 	u32 tmp;
+	int ret;
 
 	tmp = (data << SDHCI_CDNS_HRS04_WDATA_SHIFT) |
 	      (addr << SDHCI_CDNS_HRS04_ADDR_SHIFT);
@@ -78,8 +79,14 @@ static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
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

