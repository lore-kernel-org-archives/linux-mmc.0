Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182EC10F00
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEA421744
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCFKjY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:39:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:44104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgCFKjX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A510AADC9;
        Fri,  6 Mar 2020 10:39:21 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] mmc: sdhci: milbeaut: Use quirk instead of custom set_power()
Date:   Fri,  6 Mar 2020 11:38:47 +0100
Message-Id: <20200306103857.23962-3-nsaenzjulienne@suse.de>
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
 drivers/mmc/host/sdhci-milbeaut.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
index 92f30a1db435..6a935554c54d 100644
--- a/drivers/mmc/host/sdhci-milbeaut.c
+++ b/drivers/mmc/host/sdhci-milbeaut.c
@@ -121,17 +121,6 @@ static void sdhci_milbeaut_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
-static void sdhci_milbeaut_set_power(struct sdhci_host *host,
-			unsigned char mode, unsigned short vdd)
-{
-	if (!IS_ERR(host->mmc->supply.vmmc)) {
-		struct mmc_host *mmc = host->mmc;
-
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-	}
-	sdhci_set_power_noreg(host, mode, vdd);
-}
-
 static const struct sdhci_ops sdhci_milbeaut_ops = {
 	.voltage_switch = sdhci_milbeaut_soft_voltage_switch,
 	.get_min_clock = sdhci_milbeaut_get_min_clock,
@@ -139,7 +128,6 @@ static const struct sdhci_ops sdhci_milbeaut_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.set_power = sdhci_milbeaut_set_power,
 };
 
 static void sdhci_milbeaut_bridge_reset(struct sdhci_host *host,
@@ -262,7 +250,8 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
 			   SDHCI_QUIRK_DELAY_AFTER_POWER;
 	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
 			SDHCI_QUIRK2_TUNING_WORK_AROUND |
-			SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+			SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			SDHCI_QUIRK2_SET_BUS_VOLTAGE;
 
 	priv->enable_cmd_dat_delay = device_property_read_bool(dev,
 						"fujitsu,cmd-dat-delay-select");
-- 
2.25.1

