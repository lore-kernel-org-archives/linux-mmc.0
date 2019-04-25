From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 2/2] mmc: sdhci_am654: Fix SLOTTYPE write
Date: Thu, 25 Apr 2019 21:27:27 +0530
Message-ID: <20190425155727.20010-3-faiz_abbas@ti.com>
References: <20190425155727.20010-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425155727.20010-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

In the call to regmap_update_bits() for SLOTTYPE, the mask and value
fields are exchanged. Fix this.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 866a9082705f..613b151a73c5 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -205,8 +205,8 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
 
-	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, ctl_cfg_2,
-			   SLOTTYPE_MASK);
+	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
+			   ctl_cfg_2);
 
 	return sdhci_add_host(host);
 }
-- 
2.19.2
