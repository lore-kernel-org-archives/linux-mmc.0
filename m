From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 5/5] mmc: sdhci-of-arasan: add sdhci_arasan_voltage_switch for arasan,5.1
Date: Wed, 21 Sep 2016 09:45:23 +0800
Message-ID: <1474422323-29410-1-git-send-email-shawn.lin@rock-chips.com>
References: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:43489 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754147AbcIUBot (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2016 21:44:49 -0400
In-Reply-To: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

Per the vendor's requirement, we shouldn't do any setting for
1.8V Signaling Enable, otherwise the interaction/behaviour between
phy and controller will be undefined. Mostly it works fine if we do
that, but we still see failures. Anyway, let's fix it to meet the
vendor's requirement. The error log looks like:

 [   93.405085] mmc1: unexpected status 0x800900 after switch
 [   93.408474] mmc1: switch to bus width 1 failed
 [   93.408482] mmc1: mmc_select_hs200 failed, error -110
 [   93.408492] mmc1: error -110 during resume (card was removed?)
 [   93.408705] PM: resume of devices complete after 213.453 msecs

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 33601a8..9162495 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -245,6 +245,28 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
 	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
 }
 
+static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
+				       struct mmc_ios *ios)
+{
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+		/*
+		 * Plese don't switch to 1V8 as arasan,5.1 doesn't
+		 * actually refer to this setting to indicate the
+		 * signal voltage and the state machine will be broken
+		 * actually if we force to enable 1V8. That's something
+		 * like broken quirk but we could work around here.
+		 */
+		return 0;
+	case MMC_SIGNAL_VOLTAGE_330:
+	case MMC_SIGNAL_VOLTAGE_120:
+		/* We don't support 3V3 and 1V2 */
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -636,6 +658,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 		host->mmc_host_ops.hs400_enhanced_strobe =
 					sdhci_arasan_hs400_enhanced_strobe;
+		host->mmc_host_ops.start_signal_voltage_switch =
+					sdhci_arasan_voltage_switch;
 	}
 
 	ret = sdhci_add_host(host);
-- 
2.3.7


