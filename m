From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 14/25] mmc: sdhci: Improve register dump print format
Date: Mon, 20 Mar 2017 19:50:42 +0200
Message-ID: <1490032253-6030-15-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36549 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756165AbdCTR6N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:13 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Ensure all prints start with the mmc host name, and the text all lines up.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 104 ++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 93730a3013ff..70022a0c886a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -40,6 +40,9 @@
 #define DBG(f, x...) \
 	pr_debug("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
 
+#define SDHCI_DUMP(f, x...) \
+	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
+
 #define MAX_TUNING_LOOP 40
 
 static unsigned int debug_quirks = 0;
@@ -51,65 +54,64 @@
 
 static void sdhci_dumpregs(struct sdhci_host *host)
 {
-	pr_err(DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
-	       mmc_hostname(host->mmc));
-
-	pr_err(DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
-	       sdhci_readl(host, SDHCI_DMA_ADDRESS),
-	       sdhci_readw(host, SDHCI_HOST_VERSION));
-	pr_err(DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
-	       sdhci_readw(host, SDHCI_BLOCK_SIZE),
-	       sdhci_readw(host, SDHCI_BLOCK_COUNT));
-	pr_err(DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
-	       sdhci_readl(host, SDHCI_ARGUMENT),
-	       sdhci_readw(host, SDHCI_TRANSFER_MODE));
-	pr_err(DRIVER_NAME ": Present:  0x%08x | Host ctl: 0x%08x\n",
-	       sdhci_readl(host, SDHCI_PRESENT_STATE),
-	       sdhci_readb(host, SDHCI_HOST_CONTROL));
-	pr_err(DRIVER_NAME ": Power:    0x%08x | Blk gap:  0x%08x\n",
-	       sdhci_readb(host, SDHCI_POWER_CONTROL),
-	       sdhci_readb(host, SDHCI_BLOCK_GAP_CONTROL));
-	pr_err(DRIVER_NAME ": Wake-up:  0x%08x | Clock:    0x%08x\n",
-	       sdhci_readb(host, SDHCI_WAKE_UP_CONTROL),
-	       sdhci_readw(host, SDHCI_CLOCK_CONTROL));
-	pr_err(DRIVER_NAME ": Timeout:  0x%08x | Int stat: 0x%08x\n",
-	       sdhci_readb(host, SDHCI_TIMEOUT_CONTROL),
-	       sdhci_readl(host, SDHCI_INT_STATUS));
-	pr_err(DRIVER_NAME ": Int enab: 0x%08x | Sig enab: 0x%08x\n",
-	       sdhci_readl(host, SDHCI_INT_ENABLE),
-	       sdhci_readl(host, SDHCI_SIGNAL_ENABLE));
-	pr_err(DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
-	       sdhci_readw(host, SDHCI_ACMD12_ERR),
-	       sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
-	pr_err(DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
-	       sdhci_readl(host, SDHCI_CAPABILITIES),
-	       sdhci_readl(host, SDHCI_CAPABILITIES_1));
-	pr_err(DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
-	       sdhci_readw(host, SDHCI_COMMAND),
-	       sdhci_readl(host, SDHCI_MAX_CURRENT));
-	pr_err(DRIVER_NAME ": Resp[0]:  0x%08x | Resp[1]:  0x%08x\n",
+	SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
+
+	SDHCI_DUMP("Sys addr:  0x%08x | Version:  0x%08x\n",
+		   sdhci_readl(host, SDHCI_DMA_ADDRESS),
+		   sdhci_readw(host, SDHCI_HOST_VERSION));
+	SDHCI_DUMP("Blk size:  0x%08x | Blk cnt:  0x%08x\n",
+		   sdhci_readw(host, SDHCI_BLOCK_SIZE),
+		   sdhci_readw(host, SDHCI_BLOCK_COUNT));
+	SDHCI_DUMP("Argument:  0x%08x | Trn mode: 0x%08x\n",
+		   sdhci_readl(host, SDHCI_ARGUMENT),
+		   sdhci_readw(host, SDHCI_TRANSFER_MODE));
+	SDHCI_DUMP("Present:   0x%08x | Host ctl: 0x%08x\n",
+		   sdhci_readl(host, SDHCI_PRESENT_STATE),
+		   sdhci_readb(host, SDHCI_HOST_CONTROL));
+	SDHCI_DUMP("Power:     0x%08x | Blk gap:  0x%08x\n",
+		   sdhci_readb(host, SDHCI_POWER_CONTROL),
+		   sdhci_readb(host, SDHCI_BLOCK_GAP_CONTROL));
+	SDHCI_DUMP("Wake-up:   0x%08x | Clock:    0x%08x\n",
+		   sdhci_readb(host, SDHCI_WAKE_UP_CONTROL),
+		   sdhci_readw(host, SDHCI_CLOCK_CONTROL));
+	SDHCI_DUMP("Timeout:   0x%08x | Int stat: 0x%08x\n",
+		   sdhci_readb(host, SDHCI_TIMEOUT_CONTROL),
+		   sdhci_readl(host, SDHCI_INT_STATUS));
+	SDHCI_DUMP("Int enab:  0x%08x | Sig enab: 0x%08x\n",
+		   sdhci_readl(host, SDHCI_INT_ENABLE),
+		   sdhci_readl(host, SDHCI_SIGNAL_ENABLE));
+	SDHCI_DUMP("AC12 err:  0x%08x | Slot int: 0x%08x\n",
+		   sdhci_readw(host, SDHCI_ACMD12_ERR),
+		   sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
+	SDHCI_DUMP("Caps:      0x%08x | Caps_1:   0x%08x\n",
+		   sdhci_readl(host, SDHCI_CAPABILITIES),
+		   sdhci_readl(host, SDHCI_CAPABILITIES_1));
+	SDHCI_DUMP("Cmd:       0x%08x | Max curr: 0x%08x\n",
+		   sdhci_readw(host, SDHCI_COMMAND),
+		   sdhci_readl(host, SDHCI_MAX_CURRENT));
+	SDHCI_DUMP("Resp[0]:   0x%08x | Resp[1]:  0x%08x\n",
 		   sdhci_readl(host, SDHCI_RESPONSE),
 		   sdhci_readl(host, SDHCI_RESPONSE + 4));
-	pr_err(DRIVER_NAME ": Resp[2]:  0x%08x | Resp[3]:  0x%08x\n",
+	SDHCI_DUMP("Resp[2]:   0x%08x | Resp[3]:  0x%08x\n",
 		   sdhci_readl(host, SDHCI_RESPONSE + 8),
 		   sdhci_readl(host, SDHCI_RESPONSE + 12));
-
-	pr_err(DRIVER_NAME ": Host ctl2: 0x%08x\n",
-	       sdhci_readw(host, SDHCI_HOST_CONTROL2));
+	SDHCI_DUMP("Host ctl2: 0x%08x\n",
+		   sdhci_readw(host, SDHCI_HOST_CONTROL2));
 
 	if (host->flags & SDHCI_USE_ADMA) {
-		if (host->flags & SDHCI_USE_64_BIT_DMA)
-			pr_err(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x%08x\n",
-			       sdhci_readl(host, SDHCI_ADMA_ERROR),
-			       sdhci_readl(host, SDHCI_ADMA_ADDRESS_HI),
-			       sdhci_readl(host, SDHCI_ADMA_ADDRESS));
-		else
-			pr_err(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
-			       sdhci_readl(host, SDHCI_ADMA_ERROR),
-			       sdhci_readl(host, SDHCI_ADMA_ADDRESS));
+		if (host->flags & SDHCI_USE_64_BIT_DMA) {
+			SDHCI_DUMP("ADMA Err:  0x%08x | ADMA Ptr: 0x%08x%08x\n",
+				   sdhci_readl(host, SDHCI_ADMA_ERROR),
+				   sdhci_readl(host, SDHCI_ADMA_ADDRESS_HI),
+				   sdhci_readl(host, SDHCI_ADMA_ADDRESS));
+		} else {
+			SDHCI_DUMP("ADMA Err:  0x%08x | ADMA Ptr: 0x%08x\n",
+				   sdhci_readl(host, SDHCI_ADMA_ERROR),
+				   sdhci_readl(host, SDHCI_ADMA_ADDRESS));
+		}
 	}
 
-	pr_err(DRIVER_NAME ": ===========================================\n");
+	SDHCI_DUMP("============================================\n");
 }
 
 /*****************************************************************************\
-- 
1.9.1

