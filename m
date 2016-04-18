From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH v2 2/3] mmc: usdhi6rol0: add support for UHS modes
Date: Mon, 18 Apr 2016 15:44:54 +0200
Message-ID: <9f0fad850e6f0b01f7803f401a5393df06ee98e5.1460986983.git.larper@axis.com>
References: <cover.1460986983.git.larper@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:50309 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbcDRNpX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Apr 2016 09:45:23 -0400
In-Reply-To: <cover.1460986983.git.larper@axis.com>
In-Reply-To: <cover.1460986983.git.larper@axis.com>
References: <cover.1460986983.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Lars Persson <larper@axis.com>

Add a start_signal_voltage_switch() operation to support enabling of
UHS modes.

Signed-off-by: Lars Persson <larper@axis.com>
---
 drivers/mmc/host/usdhi6rol0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 807c06e..2585ea4 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1147,12 +1147,25 @@ static void usdhi6_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
+static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	int ret;
+
+	ret = mmc_regulator_set_vqmmc(mmc, ios);
+
+	if (ret < 0)
+		dev_warn(mmc_dev(mmc), "Voltage switch failed: %d\n", ret);
+
+	return ret;
+}
+
 static struct mmc_host_ops usdhi6_ops = {
 	.request	= usdhi6_request,
 	.set_ios	= usdhi6_set_ios,
 	.get_cd		= usdhi6_get_cd,
 	.get_ro		= usdhi6_get_ro,
 	.enable_sdio_irq = usdhi6_enable_sdio_irq,
+	.start_signal_voltage_switch = usdhi6_sig_volt_switch,
 };
 
 /*			State machine handlers				*/
-- 
2.1.4

