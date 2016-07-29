From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/5] mmc: dw_mmc: add power domain support
Date: Fri, 29 Jul 2016 12:15:02 +0800
Message-ID: <1469765703-30999-5-git-send-email-shawn.lin@rock-chips.com>
References: <1469765703-30999-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:43885 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbcG2ESd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jul 2016 00:18:33 -0400
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

 drivers/mmc/host/dw_mmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 32380d5..8b39168 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -22,6 +22,8 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_opp.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
@@ -3024,6 +3026,9 @@ int dw_mci_probe(struct dw_mci *host)
 		host->bus_hz = clk_get_rate(host->ciu_clk);
 	}
 
+	pm_runtime_enable(host->dev);
+	pm_runtime_get_sync(host->dev);
+
 	if (!host->bus_hz) {
 		dev_err(host->dev,
 			"Platform data must supply bus speed\n");
@@ -3197,6 +3202,9 @@ err_clk_biu:
 	if (!IS_ERR(host->biu_clk))
 		clk_disable_unprepare(host->biu_clk);
 
+	pm_runtime_put(host->dev);
+	pm_runtime_disable(host->dev);
+
 	return ret;
 }
 EXPORT_SYMBOL(dw_mci_probe);
@@ -3226,6 +3234,9 @@ void dw_mci_remove(struct dw_mci *host)
 
 	if (!IS_ERR(host->biu_clk))
 		clk_disable_unprepare(host->biu_clk);
+
+	pm_runtime_put(host->dev);
+	pm_runtime_disable(host->dev);
 }
 EXPORT_SYMBOL(dw_mci_remove);
 
-- 
2.3.7


