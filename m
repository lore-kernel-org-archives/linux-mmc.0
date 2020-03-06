Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E5C10F00
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDAB2166E
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCFKjZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:39:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:44144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgCFKjY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BAF70B1A6;
        Fri,  6 Mar 2020 10:39:22 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] mmc: sdhci: arsan: Use quirk instead of custom set_power()
Date:   Fri,  6 Mar 2020 11:38:48 +0100
Message-Id: <20200306103857.23962-4-nsaenzjulienne@suse.de>
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
 drivers/mmc/host/sdhci-of-arasan.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 0146d7dd315b..928953bbdc10 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -325,17 +325,6 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
-static void sdhci_arasan_set_power(struct sdhci_host *host, unsigned char mode,
-		     unsigned short vdd)
-{
-	if (!IS_ERR(host->mmc->supply.vmmc)) {
-		struct mmc_host *mmc = host->mmc;
-
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-	}
-	sdhci_set_power_noreg(host, mode, vdd);
-}
-
 static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -343,7 +332,6 @@ static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.set_power = sdhci_arasan_set_power,
 };
 
 static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
@@ -351,7 +339,8 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
-			SDHCI_QUIRK2_STOP_WITH_TC,
+			SDHCI_QUIRK2_STOP_WITH_TC |
+			SDHCI_QUIRK2_SET_BUS_VOLTAGE,
 };
 
 static struct sdhci_arasan_of_data sdhci_arasan_data = {
@@ -362,7 +351,8 @@ static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
 	.ops = &sdhci_arasan_ops,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
-			SDHCI_QUIRK2_STOP_WITH_TC,
+			SDHCI_QUIRK2_STOP_WITH_TC |
+			SDHCI_QUIRK2_SET_BUS_VOLTAGE,
 };
 
 static struct sdhci_arasan_of_data sdhci_arasan_zynqmp_data = {
@@ -414,7 +404,6 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-	.set_power = sdhci_arasan_set_power,
 	.irq = sdhci_arasan_cqhci_irq,
 };
 
@@ -422,7 +411,8 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 	.ops = &sdhci_arasan_cqe_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+		   SDHCI_QUIRK2_SET_BUS_VOLTAGE,
 };
 
 static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
-- 
2.25.1

