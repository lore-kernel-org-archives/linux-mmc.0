From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/3] mmc: sdhci-iproc: define MMC caps in platform data
Date: Wed, 27 Jan 2016 22:25:40 +0000
Message-ID: <1453933542-30287-2-git-send-email-stefan.wahren@i2se.com>
References: <1453933542-30287-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:61290 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966279AbcA0W0x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 17:26:53 -0500
In-Reply-To: <1453933542-30287-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, jszhang@marvell.com, shawn.lin@rock-chips.com, bcm-kernel-feedback-list@broadcom.com, Stefan Wahren <stefan.wahren@i2se.com>

This patch moves the definition of the MMC capabilities
from the probe function into iproc platform data. After
that we are able to add support for another platform more
easily.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Suggested-by: Stephen Warren <swarren@wwwdotorg.org>
---
 drivers/mmc/host/sdhci-iproc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 55bc348..cdc6c4a 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -26,6 +26,7 @@ struct sdhci_iproc_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 caps;
 	u32 caps1;
+	u32 mmc_caps;
 };
 
 struct sdhci_iproc_host {
@@ -165,6 +166,7 @@ static const struct sdhci_iproc_data iproc_data = {
 	.pdata = &sdhci_iproc_pltfm_data,
 	.caps = 0x05E90000,
 	.caps1 = 0x00000064,
+	.mmc_caps = MMC_CAP_1_8V_DDR,
 };
 
 static const struct of_device_id sdhci_iproc_of_match[] = {
@@ -199,8 +201,7 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 	mmc_of_parse(host->mmc);
 	sdhci_get_of_property(pdev);
 
-	/* Enable EMMC 1/8V DDR capable */
-	host->mmc->caps |= MMC_CAP_1_8V_DDR;
+	host->mmc->caps |= iproc_host->data->mmc_caps;
 
 	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pltfm_host->clk)) {
-- 
1.7.9.5

