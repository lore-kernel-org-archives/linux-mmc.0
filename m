From: Ido Yariv <ido@wizery.com>
Subject: [PATCH v2 3/6] arm: davinci: mmc: Add support for set_power callback
Date: Sun, 10 Jul 2011 16:14:36 +0300
Message-ID: <1310303679-17936-4-git-send-email-ido@wizery.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55270 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1GJNO5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Jul 2011 09:14:57 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so3184676wwe.1
        for <linux-mmc@vger.kernel.org>; Sun, 10 Jul 2011 06:14:57 -0700 (PDT)
In-Reply-To: <1310303679-17936-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>

Some devices connected to the MMC bus are power controlled by external
means. For instance, an SDIO device may be powered down/up by an
external gpio line.

In order to avoid toggling power from within the MMC host driver, add a
set_power callback function, which will be called by set_ios upon
powering down/up.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 arch/arm/mach-davinci/include/mach/mmc.h |    3 +++
 drivers/mmc/host/davinci_mmc.c           |   13 +++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/mmc.h b/arch/arm/mach-davinci/include/mach/mmc.h
index d4f1e96..5ba6b22 100644
--- a/arch/arm/mach-davinci/include/mach/mmc.h
+++ b/arch/arm/mach-davinci/include/mach/mmc.h
@@ -12,6 +12,9 @@ struct davinci_mmc_config {
 	/* get_cd()/get_wp() may sleep */
 	int	(*get_cd)(int module);
 	int	(*get_ro)(int module);
+
+	void	(*set_power)(int module, bool on);
+
 	/* wires == 0 is equivalent to wires == 4 (4-bit parallel) */
 	u8	wires;
 
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 0076c74..64a8325 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -807,12 +807,25 @@ static void calculate_clk_divider(struct mmc_host *mmc, struct mmc_ios *ios)
 static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmc_davinci_host *host = mmc_priv(mmc);
+	struct platform_device *pdev = to_platform_device(mmc->parent);
+	struct davinci_mmc_config *config = pdev->dev.platform_data;
 
 	dev_dbg(mmc_dev(host->mmc),
 		"clock %dHz busmode %d powermode %d Vdd %04x\n",
 		ios->clock, ios->bus_mode, ios->power_mode,
 		ios->vdd);
 
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		if (config && config->set_power)
+			config->set_power(pdev->id, false);
+		break;
+	case MMC_POWER_UP:
+		if (config && config->set_power)
+			config->set_power(pdev->id, true);
+		break;
+	}
+
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_8:
 		dev_dbg(mmc_dev(host->mmc), "Enabling 8 bit mode\n");
-- 
1.7.4.1

