From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 4/4] mmc: sdhci-of-arasan: add sdhci_arasan_voltage_switch for arasan,5.1
Date: Fri, 23 Sep 2016 08:03:11 +0800
Message-ID: <1474588991-10344-4-git-send-email-shawn.lin@rock-chips.com>
References: <1474588991-10344-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474588991-10344-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

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

Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index da8e40a..1573a8d 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -265,6 +265,28 @@ void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
 	}
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
@@ -661,6 +683,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 		host->mmc_host_ops.hs400_enhanced_strobe =
 					sdhci_arasan_hs400_enhanced_strobe;
+		host->mmc_host_ops.start_signal_voltage_switch =
+					sdhci_arasan_voltage_switch;
 	}
 
 	ret = sdhci_add_host(host);
-- 
2.3.7
