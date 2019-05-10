From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 3/3] mmc: sdhci_am654: Fix SLOTTYPE write
Date: Fri, 10 May 2019 09:12:28 +0530
Message-ID: <20190510034228.32211-4-faiz_abbas@ti.com>
References: <20190510034228.32211-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510034228.32211-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

In the call to regmap_update_bits() for SLOTTYPE, the mask and value
fields are exchanged. Fix this. This didn't have any affect on the
driver because this was a NOP and it was taking the correct value from
the bootloader.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 3ff949925127..d0b20780dd0f 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -227,8 +227,8 @@ static int sdhci_am654_init(struct sdhci_host *host)
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
