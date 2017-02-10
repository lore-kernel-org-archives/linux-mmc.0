From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 28/39] mmc: sdhci: Export sdhci_dumpregs
Date: Fri, 10 Feb 2017 14:55:41 +0200
Message-ID: <1486731352-8018-29-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33254 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbdBJNts (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:49:48 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Export sdhci_dumpregs so that it can be called by drivers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 91da20acd068..5aa96ada1314 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -51,7 +51,7 @@
 
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 
-static void sdhci_dumpregs(struct sdhci_host *host)
+void sdhci_dumpregs(struct sdhci_host *host)
 {
 	SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
 
@@ -112,6 +112,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 
 	SDHCI_DUMP("============================================\n");
 }
+EXPORT_SYMBOL_GPL(sdhci_dumpregs);
 
 /*****************************************************************************\
  *                                                                           *
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index edf3adfbc213..61753492a8e8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -702,4 +702,6 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 extern int sdhci_runtime_resume_host(struct sdhci_host *host);
 #endif
 
+void sdhci_dumpregs(struct sdhci_host *host);
+
 #endif /* __SDHCI_HW_H */
-- 
1.9.1

