From: Piotr Sroka <piotrs@cadence.com>
Subject: [PATCH] mmc: sdhci-cadence: add parsing sdhci properties
Date: Tue, 11 Apr 2017 12:13:38 +0100
Message-ID: <1491909218-7300-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53811 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752069AbdDKLOE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Apr 2017 07:14:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Piotr Sroka <piotrs@cadence.com>

Add calling sdhci_get_of_property function to parse sdhci properties.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
 drivers/mmc/host/sdhci-cadence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 7797e98..19d5698 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -330,6 +330,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
 
+	sdhci_get_of_property(pdev);
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto free;
-- 
2.2.2

