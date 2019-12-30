Return-Path: <SRS0=mt+k=2U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7A3C2D0CE
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 09:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E3E20663
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 09:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HD174iY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfL3JWg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:22:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42192 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfL3JWg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Dec 2019 04:22:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBU9MTaE003658;
        Mon, 30 Dec 2019 03:22:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577697749;
        bh=OJA99jZBbljYKu/eIbyE5SJxvJXIQvpqRdw8rl7bW6M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HD174iY7G0vpuvI91CRG7pjKaNXMAvNZPYvSld6eMFuVv+pPIatYRh2UhQU0pj+EM
         trJ4y3dnPrpINaKCzO6YEEdHEIRaUCMlO4YD+a7U8NcLfXHpVCSA1CBZsL9E8sFH0G
         x5Whv3aqPci1p+rC0OgWQMap401VWV4lLdcD0AoA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBU9MTdD130939
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Dec 2019 03:22:29 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 03:22:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 03:22:28 -0600
Received: from a0230074-OptiPlex-7010.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBU9MOJj109856;
        Mon, 30 Dec 2019 03:22:27 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>, <shawn.lin@rock-chips.com>
Subject: [PATCH 1/3] mmc: sdhci: Add Quirk to reset data lines after tuning
Date:   Mon, 30 Dec 2019 14:53:41 +0530
Message-ID: <20191230092343.30692-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20191230092343.30692-1-faiz_abbas@ti.com>
References: <20191230092343.30692-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some arasan controllers have data leftover in the buffer after tuning
procedure is complete which interferes with future data commands. Add a
quirk to reset the data after tuning is finished.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b1c26da3fe0..e4b478efb560 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2316,6 +2316,9 @@ EXPORT_SYMBOL_GPL(sdhci_start_tuning);
 
 void sdhci_end_tuning(struct sdhci_host *host)
 {
+	if (host->quirks2 & SDHCI_QUIRK2_RESET_DATA_POST_TUNING)
+		sdhci_reset(host, SDHCI_RESET_DATA);
+
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index fe83ece6965b..28826124f7c3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -484,6 +484,10 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/*
+ * Controller needs to reset data lines once tuning is complete
+ */
+#define SDHCI_QUIRK2_RESET_DATA_POST_TUNING		(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.19.2

