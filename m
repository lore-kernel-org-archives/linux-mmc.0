From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH next] mmc: sdhci-pxav3: Remove checks for optional core clock in error/remove path
Date: Mon, 5 Jan 2015 15:59:19 +0800
Message-ID: <1420444759-3812-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61745 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600AbbAEIDB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jan 2015 03:03:01 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

Commit 63589e92c2d9 ("clk: Ignore error and NULL pointers passed to
clk_{unprepare, disable}()") allows NULL or error pointer to be passed
unconditionally.

This patch is to simplify probe error and remove code paths.

However, we reserve the core clock checks in runtime suspend/resume code
because we want a little smaller latency.

This patch can be applied after the sdhci-pxav3 unbalanced pm/clock issues
patches being merged.
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313103.html

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 4de39fb..63967b8 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -398,8 +398,7 @@ err_of_parse:
 err_cd_req:
 err_mbus_win:
 	clk_disable_unprepare(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_disable_unprepare(pxa->clk_core);
+	clk_disable_unprepare(pxa->clk_core);
 err_clk_get:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -418,8 +417,7 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	sdhci_remove_host(host, 1);
 
 	clk_disable_unprepare(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_disable_unprepare(pxa->clk_core);
+	clk_disable_unprepare(pxa->clk_core);
 
 	sdhci_pltfm_free(pdev);
 
-- 
2.1.4

