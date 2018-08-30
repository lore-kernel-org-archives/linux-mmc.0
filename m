From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V8 1/9] mmc: sdhci: Add version V4 definition
Date: Thu, 30 Aug 2018 16:21:37 +0800
Message-ID: <1535617305-16952-2-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Added definitions for v400, v410, v420.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 drivers/mmc/host/sdhci.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 97e4efa..01bf88c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3508,7 +3508,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	override_timeout_clk = host->timeout_clk;
 
-	if (host->version > SDHCI_SPEC_300) {
+	if (host->version > SDHCI_SPEC_420) {
 		pr_err("%s: Unknown controller version (%d). You may experience problems.\n",
 		       mmc_hostname(mmc), host->version);
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 732d82f..dbd48a8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -270,6 +270,9 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+#define   SDHCI_SPEC_410	4
+#define   SDHCI_SPEC_420	5
 
 /*
  * End of controller registers.
-- 
2.7.4
