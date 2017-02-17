From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 2/4] mmc: sdhci: add new helper to get timeout clock
Date: Fri, 17 Feb 2017 11:56:18 +0800
Message-ID: <1487303780-234812-3-git-send-email-shawn.lin@rock-chips.com>
References: <1487303780-234812-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:53294 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932110AbdBQD7m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 22:59:42 -0500
In-Reply-To: <1487303780-234812-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Shawn Lin <shawn.lin@rock-chips.com>

If the timeout clock is zero, it actually means we
need to get it from other methods. Given the fact that
almost all the platforms are getting this from the common
clock framework API, so we could invent this new helper
to be resued for the variant drivers.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-pltfm.c | 14 ++++++++++++++
 drivers/mmc/host/sdhci-pltfm.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index ad49bfa..5a88681 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -44,6 +44,20 @@ unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_clk_get_max_clock);
 
+unsigned int sdhci_pltfm_clk_get_timeout_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	unsigned int freq;
+
+	freq = DIV_ROUND_UP(clk_get_rate(pltfm_host->clk), 1000);
+
+	if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
+		freq = DIV_ROUND_UP(freq, 1000);
+
+	return freq;
+}
+EXPORT_SYMBOL_GPL(sdhci_pltfm_clk_get_timeout_clock);
+
 static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 957839d..14c11aa 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -103,6 +103,7 @@ extern int sdhci_pltfm_register(struct platform_device *pdev,
 extern int sdhci_pltfm_unregister(struct platform_device *pdev);
 
 extern unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host);
+extern unsigned int sdhci_pltfm_clk_get_timeout_clock(struct sdhci_host *host);
 
 static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
 {
-- 
1.9.1


