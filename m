From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 2/2] mmc: sdhci: add function get_cd
Date: Tue, 26 Feb 2013 17:48:26 +0800
Message-ID: <1361872106-24385-1-git-send-email-kliu5@marvell.com>
References: <y>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:56532 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932643Ab3BZJsP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Feb 2013 04:48:15 -0500
In-Reply-To: <y>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lars-Peter Clausen <lars@metafoo.de>, Mike Rapoport <mike@compulab.co.il>, Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

1. mmc_rescan will call get_cd to know whether the card is present
before mmc_rescan_try_freq to avoid useless trials during
card removal or start host is called when card is not present.
2. get_cd need to be checked to resolve slow card removal issue.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 51bbba4..6779760 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1581,6 +1581,36 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	sdhci_runtime_pm_put(host);
 }
 
+static int sdhci_do_get_cd(struct sdhci_host *host)
+{
+	int is_detected;
+	int gpio_cd = mmc_gpio_get_cd(host->mmc);
+
+	if (host->flags & SDHCI_DEVICE_DEAD)
+		is_detected = 0;
+	else if (!IS_ERR_VALUE(gpio_cd))
+		is_detected = gpio_cd;
+	else if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
+			(host->mmc->caps & MMC_CAP_NONREMOVABLE))
+		is_detected = 1;
+	else
+		is_detected = (sdhci_readl(host, SDHCI_PRESENT_STATE)
+				& SDHCI_CARD_PRESENT);
+
+	return is_detected;
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
@@ -2038,6 +2068,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
+	.get_cd		= sdhci_get_cd,
 	.get_ro		= sdhci_get_ro,
 	.hw_reset	= sdhci_hw_reset,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
-- 
1.7.9.5

