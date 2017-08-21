From: Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH v2] mmc: sdhci-xenon: add set_power callback
Date: Mon, 21 Aug 2017 11:02:09 -0700
Message-ID: <1503338529-21102-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56550 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753646AbdHUR7H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 13:59:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com, Zhoujie Wu <zjwu@marvell.com>

Xenon sdh controller requests proper SD bus voltage select
bits programmed even with vmmc power supply. Any reserved
value(100b-000b) programmed in this field will lead to controller
ignore SD bus power bit and keep its value at zero.
Add set_power callback to handle this.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
---
Updated according to Jisheng Zhang's comment.
 drivers/mmc/host/sdhci-xenon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index edd4d915..a4be2fd 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -210,8 +210,27 @@ static void xenon_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 
+static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
+		unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+	u8 pwr = host->pwr;
+
+	sdhci_set_power_noreg(host, mode, vdd);
+
+	if (host->pwr == pwr)
+		return;
+
+	if (host->pwr == 0)
+		vdd = 0;
+
+	if (!IS_ERR(mmc->supply.vmmc))
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+}
+
 static const struct sdhci_ops sdhci_xenon_ops = {
 	.set_clock		= sdhci_set_clock,
+	.set_power		= xenon_set_power,
 	.set_bus_width		= sdhci_set_bus_width,
 	.reset			= xenon_reset,
 	.set_uhs_signaling	= xenon_set_uhs_signaling,
-- 
1.9.1

