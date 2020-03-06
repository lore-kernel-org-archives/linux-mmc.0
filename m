Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0148C10F27
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D97C20848
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCFKjW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:39:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCFKjW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ABC6EAC46;
        Fri,  6 Mar 2020 10:39:20 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] mmc: sdhci: Add quirk SDHCI_QUIRK2_SET_BUS_VOLTAGE
Date:   Fri,  6 Mar 2020 11:38:46 +0100
Message-Id: <20200306103857.23962-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306103857.23962-1-nsaenzjulienne@suse.de>
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adds quirk for controllers whose bus power select register has to be set
even when powering SD cards from a regulator.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/mmc/host/sdhci.c | 5 +++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c59566363a42..c7fd87447457 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1920,6 +1920,11 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 
 	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 
+	if (host->quirks2 & SDHCI_QUIRK2_SET_BUS_VOLTAGE) {
+		sdhci_set_power_noreg(host, mode, vdd);
+		return;
+	}
+
 	if (mode != MMC_POWER_OFF)
 		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
 	else
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cac2d97782e6..9531a4e5b148 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -484,6 +484,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Set bus voltage even when powering from an external regulator */
+#define SDHCI_QUIRK2_SET_BUS_VOLTAGE			(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.25.1

