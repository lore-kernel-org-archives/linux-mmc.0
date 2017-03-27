From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 5/7] mmc: sdhci-of-esdhc: add delay between tuning cycles
Date: Mon, 27 Mar 2017 15:49:40 +0800
Message-ID: <1490600982-5410-6-git-send-email-yangbo.lu@nxp.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0049.outbound.protection.outlook.com ([104.47.42.49]:35920
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751668AbdC0IEe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Mar 2017 04:04:34 -0400
In-Reply-To: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

It's observed that eSDHC needed delay between tuning cycles for
HS200 successful tuning. This patch is to set 1ms delay for that.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None
Changes for v3:
	- Used a host member for tuning delay instead of a quirk.
---
 drivers/mmc/host/sdhci-of-esdhc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 8c8e147..0754ef4 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -807,6 +807,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.start_signal_voltage_switch =
 		esdhc_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = esdhc_execute_tuning;
+	host->tuning_delay = 1;
 
 	esdhc_init(pdev, host);
 
-- 
2.1.0.27.g96db324

