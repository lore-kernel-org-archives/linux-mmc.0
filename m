Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D77BC282DD
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 14:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18D1206F0
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 14:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ybK9uNsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgAHObk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:31:40 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52732 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgAHObi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 09:31:38 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008EVYD1011656;
        Wed, 8 Jan 2020 08:31:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578493894;
        bh=41b0Bw5apTGi3W8sULpHQq8iAC1XNiFSJMxQOGad/Is=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ybK9uNsrWxaCboZN+nVS9HSVUNKB+fm4eEbi9D27YqGk5Sxd3RC1U7pgPQyzES/2S
         cn9FS9JDjUNaVPVi819Foqv7F7T8oPGdrZnQDSj87KwL2GSKDO1pwkVI0VRYFIh7/I
         +kMk43830q5VFdXWnuPDHe/24PyGjvYk+t1ogn1Q=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008EVYm2056122
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 08:31:34 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 08:31:34 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 08:31:34 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008EVS9W112013;
        Wed, 8 Jan 2020 08:31:32 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 2/3] mmc: sdhci_am654: Reset Command and Data line after tuning
Date:   Wed, 8 Jan 2020 20:03:00 +0530
Message-ID: <20200108143301.1929-3-faiz_abbas@ti.com>
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

The tuning data is leftover in the buffer after tuning. This can cause
issues in future data commands, especially with CQHCI. Reset the command
and data lines after tuning to continue from a clean state.

Fixes: 41fd4caeb00b ("mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 2d38b1e12a7e..59c0c41b3739 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -240,6 +240,22 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
 	writeb(val, host->ioaddr + reg);
 }
 
+static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int err = sdhci_execute_tuning(mmc, opcode);
+
+	if (err)
+		return err;
+	/*
+	 * Tuning data remains in the buffer after tuning.
+	 * Do a command and data reset to get rid of it
+	 */
+	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
+	return 0;
+}
+
 static struct sdhci_ops sdhci_am654_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -546,6 +562,8 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto pm_runtime_put;
 	}
 
+	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
+
 	ret = sdhci_am654_init(host);
 	if (ret)
 		goto pm_runtime_put;
-- 
2.19.2

