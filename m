From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 01/11] mmc: core: Add mmc_retune_hold_now()
Date: Thu, 15 Jun 2017 14:06:29 +0300
Message-ID: <1497524799-18165-2-git-send-email-adrian.hunter@intel.com>
References: <1497524799-18165-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52875 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbdFOLMt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Jun 2017 07:12:49 -0400
In-Reply-To: <1497524799-18165-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

In preparation for CQE support.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/host.c | 6 ++++++
 drivers/mmc/core/host.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 1503412f826c..ad88deb2e8f3 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -111,6 +111,12 @@ void mmc_retune_hold(struct mmc_host *host)
 	host->hold_retune += 1;
 }
 
+void mmc_retune_hold_now(struct mmc_host *host)
+{
+	host->retune_now = 0;
+	host->hold_retune += 1;
+}
+
 void mmc_retune_release(struct mmc_host *host)
 {
 	if (host->hold_retune)
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index fb6a76a03833..77d6f60d1bf9 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -19,6 +19,7 @@
 void mmc_retune_enable(struct mmc_host *host);
 void mmc_retune_disable(struct mmc_host *host);
 void mmc_retune_hold(struct mmc_host *host);
+void mmc_retune_hold_now(struct mmc_host *host);
 void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
 void mmc_retune_pause(struct mmc_host *host);
-- 
1.9.1

