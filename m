Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832C5C2D0D0
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573E1207FF
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 09:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jNB9QYMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfLJJvO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:51:14 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47096 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJu7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 04:50:59 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBA9oqmK004876;
        Tue, 10 Dec 2019 03:50:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575971452;
        bh=lhC3vf6rK9axq0zLoFoOH6nCOYCQy/v5ElTNHSVMC78=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jNB9QYMeWu90a6/cq5c2iASF24QjTCy82qzRUExjFmiumYxWwctepj4vW1W6UF6rN
         osE6Ao5wmEB2XR3rzONFCxgSew5tOgIabumHw+bknqGIGbQbwr/Mg6mpgYkRKXey2b
         nsSIAUUxLHQX8YfPqWaHTvGPB3KHdpqzu7U11JN8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBA9oqLg090761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 03:50:52 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 03:50:51 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 03:50:51 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBA9oZVn048503;
        Tue, 10 Dec 2019 03:50:49 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <adrian.hunter@intel.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <ulf.hansson@linaro.org>,
        <zhang.chunyan@linaro.org>, <tony@atomide.com>
Subject: [PATCH v3 4/7] mmc: sdhci: Add quirk for disabling DTO during erase command
Date:   Tue, 10 Dec 2019 15:21:48 +0530
Message-ID: <20191210095151.15441-5-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20191210095151.15441-1-faiz_abbas@ti.com>
References: <20191210095151.15441-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some controllers might prematurely issue a data timeout during an erase
command. Add a quirk to disable the interrupt when an erase command is
issued.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 5 +++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6f3d4991bee1..b8934c50b9c4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1532,6 +1532,11 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Initially, a command has no error */
 	cmd->error = 0;
 
+	if (cmd->opcode == MMC_ERASE &&
+	    (host->quirks2 & SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE)) {
+		sdhci_set_data_timeout_irq(host, false);
+	}
+
 	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
 	    cmd->opcode == MMC_STOP_TRANSMISSION)
 		cmd->flags |= MMC_RSP_BUSY;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b28706a1bc6f..beda9afba3a6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -482,6 +482,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Controller needs to disable DTO for erase command */
+#define SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE		(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.19.2

