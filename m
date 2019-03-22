From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mmc: sdhci-omap: Make sdhci_omap_reset static
Date: Fri, 22 Mar 2019 22:11:38 +0800
Message-ID: <20190322141138.19244-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, kishon@ti.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-mmc@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

drivers/mmc/host/sdhci-omap.c:788:6: warning:
 symbol 'sdhci_omap_reset' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mmc/host/sdhci-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 5bbed47..649c03f 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -785,7 +785,7 @@ static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_omap_start_clock(omap_host);
 }
 
-void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
+static void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
-- 
2.7.0
