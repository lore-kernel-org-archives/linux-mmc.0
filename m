Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD02FC3F2D6
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70D52084E
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCFKkJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:40:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:44240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgCFKj0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9FF06B22D;
        Fri,  6 Mar 2020 10:39:24 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] mmc: sdhci: pxav3: Use quirk instead of custom set_power()
Date:   Fri,  6 Mar 2020 11:38:50 +0100
Message-Id: <20200306103857.23962-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306103857.23962-1-nsaenzjulienne@suse.de>
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With the introduction of SDHCI_QUIRK2_SET_BUS_VOLTAGE there is no need
to use a custom set_power() implementation as the quirk takes care of
configuring the bus voltage register even when powering trough a
regulator.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/mmc/host/sdhci-pxav3.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e55037ceda73..dc4a1e69e6f6 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -297,27 +297,8 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		__func__, uhs, ctrl_2);
 }
 
-static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
-			    unsigned short vdd)
-{
-	struct mmc_host *mmc = host->mmc;
-	u8 pwr = host->pwr;
-
-	sdhci_set_power_noreg(host, mode, vdd);
-
-	if (host->pwr == pwr)
-		return;
-
-	if (host->pwr == 0)
-		vdd = 0;
-
-	if (!IS_ERR(mmc->supply.vmmc))
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-}
-
 static const struct sdhci_ops pxav3_sdhci_ops = {
 	.set_clock = sdhci_set_clock,
-	.set_power = pxav3_set_power,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -330,6 +311,7 @@ static const struct sdhci_pltfm_data sdhci_pxav3_pdata = {
 		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
 		| SDHCI_QUIRK_32BIT_ADMA_SIZE
 		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_SET_BUS_VOLTAGE,
 	.ops = &pxav3_sdhci_ops,
 };
 
-- 
2.25.1

