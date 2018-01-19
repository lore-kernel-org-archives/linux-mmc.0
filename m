From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: tmio: hide unused tmio_mmc_clk_disable/tmio_mmc_clk_enable functions
Date: Fri, 19 Jan 2018 15:54:44 +0100
Message-ID: <20180119145502.1114288-1-arnd@arndb.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:63849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754232AbeASOzR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jan 2018 09:55:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Masahiro Yamada <yamada.masahiro@socionext.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

When CONFIG_PM is disabled, we get a warning about the clock handling
being unused:

drivers/mmc/host/tmio_mmc_core.c:937:13: error: 'tmio_mmc_clk_disable' defined but not used [-Werror=unused-function]
 static void tmio_mmc_clk_disable(struct tmio_mmc_host *host)
             ^~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/tmio_mmc_core.c:929:12: error: 'tmio_mmc_clk_enable' defined but not used [-Werror=unused-function]
 static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
            ^~~~~~~~~~~~~~~~~~~

As the clock handling is now done elsewhere, this is only used when
power management is enabled. We could make the functions as __maybe_unused,
but since there is already an #ifdef section, it seems easier to move
the helpers closer to their callers.

Fixes: b21fc294387e ("mmc: tmio: move clk_enable/disable out of tmio_mmc_host_probe()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/tmio_mmc_core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 6d8719be75a8..33494241245a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -926,20 +926,6 @@ static void tmio_mmc_done_work(struct work_struct *work)
 	tmio_mmc_finish_request(host);
 }
 
-static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
-{
-	if (!host->clk_enable)
-		return -ENOTSUPP;
-
-	return host->clk_enable(host);
-}
-
-static void tmio_mmc_clk_disable(struct tmio_mmc_host *host)
-{
-	if (host->clk_disable)
-		host->clk_disable(host);
-}
-
 static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -1337,6 +1323,20 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 
 #ifdef CONFIG_PM
+static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
+{
+	if (!host->clk_enable)
+		return -ENOTSUPP;
+
+	return host->clk_enable(host);
+}
+
+static void tmio_mmc_clk_disable(struct tmio_mmc_host *host)
+{
+	if (host->clk_disable)
+		host->clk_disable(host);
+}
+
 int tmio_mmc_host_runtime_suspend(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
-- 
2.9.0

