From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v3 1/3] mmc: sdhci_am654: Fix SLOTTYPE write
Date: Tue, 28 May 2019 15:29:26 +0530
Message-ID: <20190528095928.26452-2-faiz_abbas@ti.com>
References: <20190528095928.26452-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528095928.26452-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

In the call to regmap_update_bits() for SLOTTYPE, the mask and value
fields are exchanged. Fix this.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/mmc/host/sdhci_am654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index a91c0b45c48d..3222ea4d584d 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -231,7 +231,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
 		ctl_cfg_2 = SLOTTYPE_EMBEDDED;
 
 	regmap_update_bits(sdhci_am654->base, CTL_CFG_2,
-			   ctl_cfg_2, SLOTTYPE_MASK);
+			   SLOTTYPE_MASK, ctl_cfg_2);
 
 	return sdhci_add_host(host);
 }
-- 
2.19.2
