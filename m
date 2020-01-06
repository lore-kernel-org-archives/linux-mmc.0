Return-Path: <SRS0=NLoK=23=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57D5C32771
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jan 2020 11:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1CC2075A
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jan 2020 11:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AHUA7yhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgAFLBG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:01:06 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59244 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgAFLBG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jan 2020 06:01:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006B0xYA071053;
        Mon, 6 Jan 2020 05:00:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578308460;
        bh=oXVdXQ9prB7weyzjMxgSgloYgv+iQVU79j23bRLTqSE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AHUA7yhyLTJdbMRJHcpp8FLZRdxR8rUP4vRTrmongtVRlAk4dbVeBdL6GH7HYBdWj
         pbMt0CSwvjqgxkUBltNjft9xTgoahV63vMwI76T23hQtLtko3rK0H/3afLg59pshgR
         3sCVfOYuGRNtKMCYav6N0AlO2g5Fn5mGmXhxQ+0o=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 006B0x4i063673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 05:00:59 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 05:00:59 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 05:00:59 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006B00Jw007044;
        Mon, 6 Jan 2020 05:00:53 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <adrian.hunter@intel.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <ulf.hansson@linaro.org>, <tony@atomide.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v4 07/11] mmc: sdhci-omap: Disable data timeout interrupt during erase
Date:   Mon, 6 Jan 2020 16:31:29 +0530
Message-ID: <20200106110133.13791-8-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20200106110133.13791-1-faiz_abbas@ti.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Disable data timeout interrupt during an erase operation

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 84d85aa743da..1f05c8e98d62 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -827,6 +828,15 @@ static u32 sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
 	return intmask;
 }
 
+static void sdhci_omap_set_timeout(struct sdhci_host *host,
+				   struct mmc_command *cmd)
+{
+	if (cmd->opcode == MMC_ERASE)
+		sdhci_set_data_timeout_irq(host, false);
+
+	__sdhci_set_timeout(host, cmd);
+}
+
 static struct sdhci_ops sdhci_omap_ops = {
 	.set_clock = sdhci_omap_set_clock,
 	.set_power = sdhci_omap_set_power,
@@ -838,6 +848,7 @@ static struct sdhci_ops sdhci_omap_ops = {
 	.reset = sdhci_omap_reset,
 	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
 	.irq = sdhci_omap_irq,
+	.set_timeout = sdhci_omap_set_timeout,
 };
 
 static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
-- 
2.19.2

