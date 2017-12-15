From: Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH v3] mmc: sdhci: wait 5ms after set 1.8V signal enable
Date: Fri, 15 Dec 2017 11:28:56 -0800
Message-ID: <1513366136-20302-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50334 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755593AbdLOT2m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Dec 2017 14:28:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: nadavh@marvell.com, xigu@marvell.com, xswang@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com, Zhoujie Wu <zjwu@marvell.com>

According to SD spec 3.00 3.6.1 signal voltage switch
procedure step 6~8,
(6) Set 1.8V Signal Enable in the Host Control 2 register.
(7) Wait 5ms. 1.8V voltage regulator shall be stable within this period.
(8) If 1.8V Signal Enable is cleared by Host Controller, go to step (12).

Host should wait 5ms after set 1.8V signal enable bit in
Host Control 2 register and check if 1.8V is stable or not.

But current code checks if this bit is cleared by controller
right after set it. On some platforms found the bit is not
cleared right away and host reports "1.8V regulator output
did not became stable" and 5ms delay can help.

Follow the spec and add 5ms delay to make sure the 1.8V Signal Enable
bit is cleared.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
---
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

