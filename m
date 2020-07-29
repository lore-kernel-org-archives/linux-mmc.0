Return-Path: <SRS0=hC2C=BI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD8DC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Jul 2020 23:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEA62074B
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Jul 2020 23:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bb9N3Cc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgG2Xlv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:41:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40904 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgG2Xlv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jul 2020 19:41:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06TNfln7011481;
        Wed, 29 Jul 2020 18:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596066107;
        bh=mKQILzQaWWB+D7WiScwwL5rhE5YnH3vAA0/W5ZSEf1E=;
        h=From:To:CC:Subject:Date;
        b=Bb9N3Cc10xLHpFsFprsrnS59aESVCx1AiFqux3hyhdU4khkddrhN0i/UDI6NFgobv
         YoRC2k37Q7YjTJfj9jcqT+G+7KlM8n5c/mlKi0fxcrFGR71/OTMJP1mdpILAMMnqNu
         8k6yQawC4s2O+SAfVBvFG3uxGNBjtx83qMiv4OtI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06TNflW6123165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 18:41:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Jul 2020 18:41:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Jul 2020 18:41:47 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06TNfaIF119367;
        Wed, 29 Jul 2020 18:41:39 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH] mmc: sdhci_am654: Add workaround for card detect debounce timer
Date:   Thu, 30 Jul 2020 05:11:30 +0530
Message-ID: <20200729234130.25056-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is a one time delay because of a card detect debounce timer in the
controller IP. This timer runs as soon as power is applied to the module
regardless of whether a card is present or not and any writes to
SDHCI_POWER_ON will return 0 before it expires. This timeout has been
measured to be about 1 second in am654x and j721e.

Write-and-read-back in a loop on SDHCI_POWER_ON for a maximum of
1.5 seconds to make sure that the controller actually powers on.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 1718b9e8af63..55cff9de2f3e 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -272,6 +272,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	sdhci_set_clock(host, clock);
 }
 
+#define MAX_POWER_ON_TIMEOUT	1500 /* ms */
 static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
 {
 	unsigned char timing = host->mmc->ios.timing;
@@ -291,6 +292,26 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
 	}
 
 	writeb(val, host->ioaddr + reg);
+	if (reg == SDHCI_POWER_CONTROL && (val & SDHCI_POWER_ON)) {
+		/*
+		 * Power on will not happen until the card detect debounce
+		 * timer expires. Wait at least 1.5 seconds for the power on
+		 * bit to be set
+		 */
+		ktime_t timeout = ktime_add_ms(ktime_get(),
+					       MAX_POWER_ON_TIMEOUT);
+		do {
+			if (ktime_compare(ktime_get(), timeout) > 0) {
+				dev_warn(mmc_dev(host->mmc),
+					 "Power on failed\n");
+
+				return;
+			}
+
+			writeb(val, host->ioaddr + reg);
+			usleep_range(1000, 10000);
+		} while (!(readb(host->ioaddr + reg) & SDHCI_POWER_ON));
+	}
 }
 
 static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
-- 
2.17.1

