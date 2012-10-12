From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/4] MMC: omap_hsmmc: set platform data after probe from DT node
Date: Fri, 12 Oct 2012 12:58:12 +0200
Message-ID: <1350039495-360-2-git-send-email-zonque@gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1350039495-360-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Daniel Mack <zonque@gmail.com>, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

When probed from DT, the self-allocated platform data has to be attached
to the actual device. Otherwise a NULL pointer will be dereferenced from
omap_hsmmc_card_detect if a gpio handle for card-detect has been passed.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/mmc/host/omap_hsmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 19ccb59..4b70823 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1728,6 +1728,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 			const u16 *offsetp = match->data;
 			pdata->reg_offset = *offsetp;
 		}
+		pdev->dev.platform_data = pdata;
 	}
 
 	if (pdata == NULL) {
-- 
1.7.11.4

