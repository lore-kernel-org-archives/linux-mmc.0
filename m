From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [RFC PATCH 1/3] mmc: sdhci: Add platform_dumpregs callback support to sdhci_ops.
Date: Fri, 30 Dec 2016 17:02:09 +0530
Message-ID: <1483097531-9991-2-git-send-email-riteshh@codeaurora.org>
References: <1483097531-9991-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483097531-9991-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

Add new host operation ->platform_dumpregs to provide a
mechanism through which host drivers can dump platform
specific registers in addition to SDHC registers
during error conditions.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2390980..73a8918 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -101,6 +101,9 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 			       readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
 	}
 
+	if (host->ops->platform_dumpregs)
+		host->ops->platform_dumpregs(host);
+
 	pr_err(DRIVER_NAME ": ===========================================\n");
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0b66f21..400f3a1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -564,6 +564,7 @@ struct sdhci_ops {
 					 struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
+	void	(*platform_dumpregs)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
