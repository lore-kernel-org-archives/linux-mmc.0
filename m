From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 1/4] mmc: core: Return from mmc_set_clock if hz is already set to ios.clock
Date: Tue, 20 Dec 2016 11:23:16 +0530
Message-ID: <1482213199-29152-2-git-send-email-riteshh@codeaurora.org>
References: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/core/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 543eadd..125f8a9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1139,6 +1139,9 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
 	if (hz > host->f_max)
 		hz = host->f_max;
 
+	if (hz == host->ios.clock)
+		return;
+
 	host->ios.clock = hz;
 	mmc_set_ios(host);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
