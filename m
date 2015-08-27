From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 06/15] mmc: host: omap_hsmmc: remove unnecessary pbias set_voltage
Date: Thu, 27 Aug 2015 14:43:58 +0530
Message-ID: <1440666847-12594-7-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Remove the unnecessary pbias regulator_set_voltage done after
pbias regulator_disable in omap_hsmmc_set_power.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58e4ffd..c4c284e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -272,7 +272,6 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 			if (!ret)
 				host->pbias_enabled = 0;
 		}
-		regulator_set_voltage(host->pbias, VDD_3V0, VDD_3V0);
 	}
 
 	/*
-- 
1.7.9.5
