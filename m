Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD0FC282DD
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 14:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BF220692
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 14:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rHLrLx3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgAHObk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:31:40 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36984 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgAHObi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 09:31:38 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008EVaPl065332;
        Wed, 8 Jan 2020 08:31:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578493896;
        bh=zHIIrACqLL9VHEPM34U/A7g8x9YWRzxHUu+RtrxLOpU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rHLrLx3+7zgCDGRnKuFbMhHB0jluNBDt0xdLAC9eCqqLlHnp4Ncr2HsQN2uJl5aL8
         Jo4buNXbiXNpaUvlFG2py6Yl/hpLD19+s77Ksgkwcjoekv5qiBSNxOri48f9t+/EV2
         0JJjichGF1dQOc4hLmi3J8BU4W1iD3pt//+Gij5g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008EVaZE049289;
        Wed, 8 Jan 2020 08:31:36 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 08:31:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 08:31:36 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008EVS9X112013;
        Wed, 8 Jan 2020 08:31:34 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 3/3] mmc: sdhci_am654: Fix Command Queuing in AM65x
Date:   Wed, 8 Jan 2020 20:03:01 +0530
Message-ID: <20200108143301.1929-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20200108143301.1929-1-faiz_abbas@ti.com>
References: <20200108143301.1929-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Command Queuing was enabled completely for J721e controllers which lead
to partial enablement even for Am65x. Complete CQ implementation for
AM65x by adding the irq callback.

Fixes: f545702b74f9 ("mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E")
Cc: stable@vger.kernel.org
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 59c0c41b3739..b8fe94fd9525 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -256,6 +256,19 @@ static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return 0;
 }
 
+static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
+{
+	int cmd_error = 0;
+	int data_error = 0;
+
+	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
+		return intmask;
+
+	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
+
+	return 0;
+}
+
 static struct sdhci_ops sdhci_am654_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -264,6 +277,7 @@ static struct sdhci_ops sdhci_am654_ops = {
 	.set_power = sdhci_am654_set_power,
 	.set_clock = sdhci_am654_set_clock,
 	.write_b = sdhci_am654_write_b,
+	.irq = sdhci_am654_cqhci_irq,
 	.reset = sdhci_reset,
 };
 
@@ -278,19 +292,6 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
 	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
 };
 
-static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
-{
-	int cmd_error = 0;
-	int data_error = 0;
-
-	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
-		return intmask;
-
-	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
-
-	return 0;
-}
-
 static struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
-- 
2.19.2

