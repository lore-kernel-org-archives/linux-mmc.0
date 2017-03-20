From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/25] mmc: sdhci: Add response register to register dump
Date: Mon, 20 Mar 2017 19:50:40 +0200
Message-ID: <1490032253-6030-13-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14086 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756155AbdCTR6Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:16 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Add response register to register dump.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 56be77c2044e..40f69ae51adf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -87,6 +87,13 @@ static void sdhci_dumpregs(struct sdhci_host *host)
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

