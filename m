Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE04CC10DCE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 17:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70552072D
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 17:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCFRob (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:44:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:60580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgCFRoa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 12:44:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E704DACC2;
        Fri,  6 Mar 2020 17:44:28 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        Hu Ziji <huziji@marvell.com>
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 06/11] mmc: sdhci: xenon: Use sdhci_set_power_and_voltage()
Date:   Fri,  6 Mar 2020 18:44:08 +0100
Message-Id: <20200306174413.20634-7-nsaenzjulienne@suse.de>
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
 drivers/mmc/host/sdhci-xenon.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 1dea1ba66f7b..1e9a7a76f2ba 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -213,24 +213,6 @@ static void xenon_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 
-static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
-		unsigned short vdd)
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
 static void xenon_voltage_switch(struct sdhci_host *host)
 {
 	/* Wait for 5ms after set 1.8V signal enable bit */
@@ -240,7 +222,7 @@ static void xenon_voltage_switch(struct sdhci_host *host)
 static const struct sdhci_ops sdhci_xenon_ops = {
 	.voltage_switch		= xenon_voltage_switch,
 	.set_clock		= sdhci_set_clock,
-	.set_power		= xenon_set_power,
+	.set_power		= sdhci_set_power_and_bus_voltage,
 	.set_bus_width		= sdhci_set_bus_width,
 	.reset			= xenon_reset,
 	.set_uhs_signaling	= xenon_set_uhs_signaling,
-- 
2.25.1

