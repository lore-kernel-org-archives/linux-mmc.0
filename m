From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/4] mmc: sdhci-of-arasan: Call mmc_of_parse()
Date: Wed,  6 May 2015 20:31:21 +0200
Message-ID: <1430937082-27149-3-git-send-email-lars@metafoo.de>
References: <1430937082-27149-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-205.synserver.de ([212.40.185.205]:1094 "EHLO
	smtp-out-205.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbbEFSb2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 14:31:28 -0400
In-Reply-To: <1430937082-27149-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Thomas Abraham <thomas.abraham@linaro.org>, Mike Looijmans <mike.looijmans@topic.nl>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

The device-tree documentation for the Arasan SDHCI controller already
claims that it supports the standard MMC devicetree properties. Update the
driver implementation accordingly by calling mmc_of_parse().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 21c0c08..538fd81 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -175,6 +175,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	}
 
 	sdhci_get_of_property(pdev);
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto clk_disable_all;
+
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->priv = sdhci_arasan;
 	pltfm_host->clk = clk_xin;
-- 
1.8.0

