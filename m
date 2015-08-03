From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 06/16] mmc: host: omap_hsmmc: remove unnecessary pbias set_voltage
Date: Mon, 3 Aug 2015 17:56:31 +0530
Message-ID: <1438604801-11823-7-git-send-email-kishon@ti.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438604801-11823-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Remove the unnecessary pbias regulator_set_voltage done after
pbias regulator_disable in omap_hsmmc_set_power.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f6b056f..d635a38 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -270,7 +270,6 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 			if (!ret)
 				host->pbias_enabled = 0;
 		}
-		regulator_set_voltage(host->pbias, VDD_3V0, VDD_3V0);
 	}
 
 	/*
-- 
1.7.9.5
