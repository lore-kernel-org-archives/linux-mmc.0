From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 1/2] mmc: sdhci: Export sdhci_request()
Date: Mon, 20 Aug 2018 12:23:32 +0300
Message-ID: <1534757013-4524-2-git-send-email-avienamo@nvidia.com>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Allow SDHCI drivers to hook code before and after sdhci_request() by
making it externally visible.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index da47f7b..1e0c0a6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1636,7 +1636,7 @@ EXPORT_SYMBOL_GPL(sdhci_set_power);
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host;
 	int present;
@@ -1675,6 +1675,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_request);
 
 void sdhci_set_bus_width(struct sdhci_host *host, int width)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cc963a5..73c4744 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -729,6 +729,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		     unsigned short vdd);
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
+void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
-- 
2.7.4
