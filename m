From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 5/5] mmc: sdhci-of-arasan: add power domain support
Date: Fri, 29 Jul 2016 12:16:45 +0800
Message-ID: <1469765805-31049-1-git-send-email-shawn.lin@rock-chips.com>
References: <1469765703-30999-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:54295 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbcG2ET5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jul 2016 00:19:57 -0400
In-Reply-To: <1469765703-30999-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Feng Xiao <xf@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

We should enable power domain once provided. Otherwise
we take risk of bus err as it's maybe in off state before
probing.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-arasan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index e0f193f..e507e94 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -25,6 +25,8 @@
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_opp.h>
 #include "sdhci-pltfm.h"
 
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
@@ -515,6 +517,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_dis_ahb;
 	}
 
+	pm_runtime_enable(host->dev);
+	pm_runtime_get_sync(host->dev);
+
 	sdhci_get_of_property(pdev);
 	pltfm_host->clk = clk_xin;
 
@@ -577,6 +582,8 @@ clk_dis_ahb:
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
 err_pltfm_free:
 	sdhci_pltfm_free(pdev);
+	pm_runtime_put(host->dev);
+	pm_runtime_disable(host->dev);
 	return ret;
 }
 
@@ -599,6 +606,9 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(clk_ahb);
 
+	pm_runtime_put(host->dev);
+	pm_runtime_disable(host->dev);
+
 	return ret;
 }
 
-- 
2.3.7


