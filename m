From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: sdhci-cadence: fix bit shift of read data from PHY port
Date: Tue, 14 Feb 2017 20:05:40 +0900
Message-ID: <1487070340-8988-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This macro is currently unused, but it may be useful for debug use.
Fix it just in case.

Fixes: ff6af28faff5 ("mmc: sdhci-cadence: add Cadence SD4HC support")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 4b0ecb9..5ffa2e5 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -25,7 +25,7 @@
 #define   SDHCI_CDNS_HRS04_ACK			BIT(26)
 #define   SDHCI_CDNS_HRS04_RD			BIT(25)
 #define   SDHCI_CDNS_HRS04_WR			BIT(24)
-#define   SDHCI_CDNS_HRS04_RDATA_SHIFT		12
+#define   SDHCI_CDNS_HRS04_RDATA_SHIFT		16
 #define   SDHCI_CDNS_HRS04_WDATA_SHIFT		8
 #define   SDHCI_CDNS_HRS04_ADDR_SHIFT		0
 
-- 
2.7.4
