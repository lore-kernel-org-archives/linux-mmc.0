From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v4 12/13] mmc: sdhci-pxav2: remove unnecessary assignment of pltfm_host->priv
Date: Tue, 26 Jan 2016 18:15:52 +0800
Message-ID: <1453803353-6266-13-git-send-email-jszhang@marvell.com>
References: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:45291 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965086AbcAZKUy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 05:20:54 -0500
In-Reply-To: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

The sdhci_pltfm_init() function has initialized the priv member as
NULL, so there's no need to do it again.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-pxav2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index beffd86..1d8dd35 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -177,7 +177,6 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = NULL;
 
 	clk = clk_get(dev, "PXA-SDHCLK");
 	if (IS_ERR(clk)) {
-- 
2.7.0

