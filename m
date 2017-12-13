From: Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH v2] mmc: sdhci: wait 5ms after set 1.8V signal enable
Date: Wed, 13 Dec 2017 15:48:49 -0800
Message-ID: <1513208929-13578-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44306 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750795AbdLMXsg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Dec 2017 18:48:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: nadavh@marvell.com, xigu@marvell.com, xswang@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com, Zhoujie Wu <zjwu@marvell.com>

According to SD spec 3.00 3.6.1 signal voltage switch
procedure, host should wait 5ms after set 1.8V signal
enable bit in Host Control 2 register and check if 1.8V
is stable or not.

On some cards, found without the delay would see "1.8V
regulator output did not became stable" err log.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
---
v2: removed undeliverable cc email address.

 drivers/mmc/host/sdhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9290a3..fe5f208 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1933,6 +1933,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		if (host->ops->voltage_switch)
 			host->ops->voltage_switch(host);
 
+		/* Wait for 5ms */
+		usleep_range(5000, 5500);
+
 		/* 1.8V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (ctrl & SDHCI_CTRL_VDD_180)
-- 
1.9.1

