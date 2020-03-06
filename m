Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0366AC10F25
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 17:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB90D2072D
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 17:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCFRo0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:44:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:60530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgCFRo0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 12:44:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCF25ACC2;
        Fri,  6 Mar 2020 17:44:24 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 03/11] mmc: sdhci: milbeaut: Use sdhci_set_power_and_voltage()
Date:   Fri,  6 Mar 2020 18:44:05 +0100
Message-Id: <20200306174413.20634-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306174413.20634-1-nsaenzjulienne@suse.de>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The sdhci core provides a helper function with the same functionality as
this controller's set_power() callback. Use it instead.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/mmc/host/sdhci-milbeaut.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
index 92f30a1db435..4e7cc0680f94 100644
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
@@ -139,7 +128,7 @@ static const struct sdhci_ops sdhci_milbeaut_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.set_power = sdhci_milbeaut_set_power,
+	.set_power = sdhci_set_power_and_bus_voltage,
 };
 
 static void sdhci_milbeaut_bridge_reset(struct sdhci_host *host,
-- 
2.25.1

