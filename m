From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: sdhci-pxav3: dt: Support "broken-cd"/"wp-inverted" properties
Date: Sat, 08 Sep 2012 23:05:36 -0400
Message-ID: <87mx0zzyin.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45611 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab2IIDFm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 8 Sep 2012 23:05:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Zhangfei Gao <zhangfei.gao@marvell.com>

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index a553b18..8a9b367 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -198,6 +198,12 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 	if (clk_delay_cycles > 0)
 		pdata->clk_delay_cycles = clk_delay_cycles;
 
+	if (of_find_property(np, "broken-cd", NULL))
+		pdata->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
+	if (of_find_property(np, "wp-inverted", NULL))
+		pdata->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
+
 	return pdata;
 }
 #else
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
