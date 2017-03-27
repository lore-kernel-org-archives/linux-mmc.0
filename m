From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 4/7] mmc: sdhci: Control the delay between tuning commands
Date: Mon, 27 Mar 2017 15:49:39 +0800
Message-ID: <1490600982-5410-5-git-send-email-yangbo.lu@nxp.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:47115
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752067AbdC0IEq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Mar 2017 04:04:46 -0400
In-Reply-To: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

From: Adrian Hunter <adrian.hunter@intel.com>

The delay between tuning commands for SD cards is not part of the
specification. A driver that needs it probably needs it for eMMC
too, whereas most drivers would probably like to set it to 0. Make
it a host member (host->tuning_delay) that defaults to the existing
behaviour. Drivers can set it to zero to eliminate the delay, or
set it to a positive value to always have a delay.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None
Changes for v3:
	- Used a host member for tuning delay instead of a quirk.(Adrian's patch)
	- Addressed warning in checkpatch.
---
 drivers/mmc/host/sdhci.c | 11 ++++++++---
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0d4485d..ffd1607 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2100,9 +2100,9 @@ static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 			break;
 		}
 
-		/* eMMC spec does not require a delay between tuning cycles */
-		if (opcode == MMC_SEND_TUNING_BLOCK)
-			mdelay(1);
+		/* Spec does not require a delay between tuning cycles */
+		if (host->tuning_delay > 0)
+			mdelay(host->tuning_delay);
 	}
 
 	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
@@ -2164,6 +2164,9 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	host->mmc->retune_period = tuning_count;
 
+	if (host->tuning_delay < 0)
+		host->tuning_delay = opcode == MMC_SEND_TUNING_BLOCK;
+
 	sdhci_start_tuning(host);
 
 	__sdhci_execute_tuning(host, opcode);
@@ -3108,6 +3111,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	host->cqe_ier     = SDHCI_CQE_INT_MASK;
 	host->cqe_err_ier = SDHCI_CQE_INT_ERR_MASK;
 
+	host->tuning_delay = -1;
+
 	return host;
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index fdb5d7e..2407960 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -538,6 +538,8 @@ struct sdhci_host {
 #define SDHCI_TUNING_MODE_1	0
 #define SDHCI_TUNING_MODE_2	1
 #define SDHCI_TUNING_MODE_3	2
+	/* Delay (ms) between tuning commands */
+	int			tuning_delay;
 
 	unsigned long private[0] ____cacheline_aligned;
 };
-- 
2.1.0.27.g96db324

