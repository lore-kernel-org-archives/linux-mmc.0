Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107F1C433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 17:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB15207BC
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 17:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aatZMowo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHYRAY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:00:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60472 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgHYRAY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 13:00:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07PH0IpM100291;
        Tue, 25 Aug 2020 12:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598374818;
        bh=wx+MkPPTaYJfYBTcROXK3BjImjEGwmVDFhuR5gyn5Ak=;
        h=From:To:CC:Subject:Date;
        b=aatZMowob99TDnUIbBhAkgDFCu1zmhjXUSJO+U/jMgqaK+8aVVSQWrX3Tx0qdK9Jh
         twKXuDxOqvXHeAbsxKpXiVLh46eYqI621uT6l9ZZMGBr5WqLT8I8H2fb7GPfwp8wPl
         Ou++F3QbfW3B/mk7vLe2pU2Ti2oq7TvVwgli7I+g=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07PH0Ina051836
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 12:00:18 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 25
 Aug 2020 12:00:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 25 Aug 2020 12:00:18 -0500
Received: from a0230074-OptiPlex-7010.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07PH0FWY016183;
        Tue, 25 Aug 2020 12:00:16 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2] mmc: sdhci_am654: Add workaround for card detect debounce timer
Date:   Tue, 25 Aug 2020 22:30:15 +0530
Message-ID: <20200825170015.32285-1-faiz_abbas@ti.com>
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

v2: Use read_poll_timeout() standard macro

 drivers/mmc/host/sdhci_am654.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f9d24af12396..9a048c80dad4 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -6,6 +6,7 @@
  *
  */
 #include <linux/clk.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -272,9 +273,19 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	sdhci_set_clock(host, clock);
 }
 
+static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
+{
+	writeb(val, host->ioaddr + reg);
+	usleep_range(1000, 10000);
+	return readb(host->ioaddr + reg);
+}
+
+#define MAX_POWER_ON_TIMEOUT	1500000 /* us */
 static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
 {
 	unsigned char timing = host->mmc->ios.timing;
+	u8 pwr;
+	int ret;
 
 	if (reg == SDHCI_HOST_CONTROL) {
 		switch (timing) {
@@ -291,6 +302,19 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
 	}
 
 	writeb(val, host->ioaddr + reg);
+	if (reg == SDHCI_POWER_CONTROL && (val & SDHCI_POWER_ON)) {
+		/*
+		 * Power on will not happen until the card detect debounce
+		 * timer expires. Wait at least 1.5 seconds for the power on
+		 * bit to be set
+		 */
+		ret = read_poll_timeout(sdhci_am654_write_power_on, pwr,
+					pwr & SDHCI_POWER_ON, 0,
+					MAX_POWER_ON_TIMEOUT, false, host, val,
+					reg);
+		if (ret)
+			dev_warn(mmc_dev(host->mmc), "Power on failed\n");
+	}
 }
 
 static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
-- 
2.17.1

