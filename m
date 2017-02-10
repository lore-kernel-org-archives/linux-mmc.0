From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 26/39] mmc: sdhci: Add response register to register dump
Date: Fri, 10 Feb 2017 14:55:39 +0200
Message-ID: <1486731352-8018-27-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35475 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751337AbdBJNS1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:18:27 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Add response register to register dump.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8aa8541a349a..ee7e8c0519e6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -86,6 +86,13 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 	pr_err(DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
 	       sdhci_readw(host, SDHCI_COMMAND),
 	       sdhci_readl(host, SDHCI_MAX_CURRENT));
+	pr_err(DRIVER_NAME ": Resp[0]:  0x%08x | Resp[1]:  0x%08x\n",
+		   sdhci_readl(host, SDHCI_RESPONSE),
+		   sdhci_readl(host, SDHCI_RESPONSE + 4));
+	pr_err(DRIVER_NAME ": Resp[2]:  0x%08x | Resp[3]:  0x%08x\n",
+		   sdhci_readl(host, SDHCI_RESPONSE + 8),
+		   sdhci_readl(host, SDHCI_RESPONSE + 12));
+
 	pr_err(DRIVER_NAME ": Host ctl2: 0x%08x\n",
 	       sdhci_readw(host, SDHCI_HOST_CONTROL2));
 
-- 
1.9.1

