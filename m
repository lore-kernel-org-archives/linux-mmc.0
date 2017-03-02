From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 4/9] mmc: sdhci: add a callback for using tuning block
Date: Thu, 2 Mar 2017 17:47:25 +0800
Message-ID: <1488448050-7574-5-git-send-email-yangbo.lu@nxp.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:11018
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750771AbdCBKEU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Mar 2017 05:04:20 -0500
In-Reply-To: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

Some non-standard SD host controllers may use tuning block
for executing tuning procedure.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3c9a924..051b192 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2166,6 +2166,9 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		goto out_unlock;
 	}
 
+	if (host->ops->set_tuning_block)
+		host->ops->set_tuning_block(host);
+
 	host->mmc->retune_period = tuning_count;
 
 	sdhci_start_tuning(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 04af687..d43519b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -568,6 +568,7 @@ struct sdhci_ops {
 					 int card_drv, int *drv_type);
 	int	(*start_signal_voltage_switch)(struct sdhci_host *host,
 					       unsigned char signal_voltage);
+	void	(*set_tuning_block)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.1.0.27.g96db324

