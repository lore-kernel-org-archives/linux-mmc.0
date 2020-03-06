Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC73C10F25
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBC92146E
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFKj6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:39:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:44402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgCFKj3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AE761B282;
        Fri,  6 Mar 2020 10:39:27 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] mmc: sdhci: Unexport sdhci_set_power_noreg()
Date:   Fri,  6 Mar 2020 11:38:53 +0100
Message-Id: <20200306103857.23962-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306103857.23962-1-nsaenzjulienne@suse.de>
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There are no users left and, ideally, it's not a function that should be
called outside of the core sdhci code.

As sdhci_set_power_reg() depends on sdhci_set_power_noreg() it was moved
underneath it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/mmc/host/sdhci.c | 39 +++++++++++++++++++--------------------
 drivers/mmc/host/sdhci.h |  2 --
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c7fd87447457..728442b129f4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1913,25 +1913,7 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 }
 EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
-static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
-				unsigned short vdd)
-{
-	struct mmc_host *mmc = host->mmc;
-
-	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-
-	if (host->quirks2 & SDHCI_QUIRK2_SET_BUS_VOLTAGE) {
-		sdhci_set_power_noreg(host, mode, vdd);
-		return;
-	}
-
-	if (mode != MMC_POWER_OFF)
-		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
-	else
-		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
-}
-
-void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
+static void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd)
 {
 	u8 pwr = 0;
@@ -2003,7 +1985,24 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			mdelay(10);
 	}
 }
-EXPORT_SYMBOL_GPL(sdhci_set_power_noreg);
+
+static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
+				unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+
+	if (host->quirks2 & SDHCI_QUIRK2_SET_BUS_VOLTAGE) {
+		sdhci_set_power_noreg(host, mode, vdd);
+		return;
+	}
+
+	if (mode != MMC_POWER_OFF)
+		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
+	else
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+}
 
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		     unsigned short vdd)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9531a4e5b148..330557434519 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -774,8 +774,6 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
 void sdhci_enable_clk(struct sdhci_host *host, u16 clk);
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		     unsigned short vdd);
-void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
-			   unsigned short vdd);
 void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
-- 
2.25.1

