From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v4, 5/5] mmc: sdhci-of-esdhc: add delay between tuning cycles
Date: Tue, 11 Apr 2017 13:10:31 +0800
Message-ID: <1491887431-31894-6-git-send-email-yangbo.lu@nxp.com>
References: <1491887431-31894-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:65184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753459AbdDKFZZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Apr 2017 01:25:25 -0400
In-Reply-To: <1491887431-31894-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

It's observed that eSDHC needed delay between tuning cycles for
HS200 successful tuning. This patch is to set 1ms delay for that.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None
Changes for v3:
	- Used a host member for tuning delay instead of a quirk.
Changes for v4:
	- None
---
 drivers/mmc/host/sdhci-of-esdhc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 80dc802..49ac197 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -809,6 +809,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.start_signal_voltage_switch =
 		esdhc_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = esdhc_execute_tuning;
+	host->tuning_delay = 1;
 
 	esdhc_init(pdev, host);
 
-- 
2.1.0.27.g96db324

