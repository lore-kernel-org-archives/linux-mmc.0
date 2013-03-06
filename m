From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v4 2/3] mmc: sdhci: add function get_cd
Date: Wed,  6 Mar 2013 11:29:01 +0800
Message-ID: <1362540542-28995-3-git-send-email-kliu5@marvell.com>
References: <1362540542-28995-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34567 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752164Ab3CFD2e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Mar 2013 22:28:34 -0500
In-Reply-To: <1362540542-28995-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

1. mmc_rescan will call get_cd to know whether the card is present
before mmc_rescan_try_freq to avoid useless trials during
card removal or start host is called when card is not present.
2. get_cd need to be checked to resolve slow card removal issue.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sdhci.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 51bbba4..8b21d28 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1581,6 +1581,35 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	sdhci_runtime_pm_put(host);
 }
 
+static int sdhci_do_get_cd(struct sdhci_host *host)
+{
+	int gpio_cd;
+
+	if (host->flags & SDHCI_DEVICE_DEAD)
+		return 0;
+	/* If polling/nonremovable, assume that the card is always present. */
+	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
+			(host->mmc->caps & MMC_CAP_NONREMOVABLE))
+		return 1;
+	/* Try slot gpio detect */
+	gpio_cd = mmc_gpio_get_cd(host->mmc);
+	if (!IS_ERR_VALUE(gpio_cd))
+		return !!gpio_cd;
+	/* Host native card detect */
+	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+}
+
+static int sdhci_get_cd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret;
+
+	sdhci_runtime_pm_get(host);
+	ret = sdhci_do_get_cd(host);
+	sdhci_runtime_pm_put(host);
+	return ret;
+}
+
 static int sdhci_check_ro(struct sdhci_host *host)
 {
 	unsigned long flags;
@@ -2038,6 +2067,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
+	.get_cd		= sdhci_get_cd,
 	.get_ro		= sdhci_get_ro,
 	.hw_reset	= sdhci_hw_reset,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
-- 
1.7.9.5

