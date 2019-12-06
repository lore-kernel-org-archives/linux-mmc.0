Return-Path: <SRS0=q/7Q=Z4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65044C43603
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 11:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3923224659
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 11:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ri3f9kyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfLFLmR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:42:17 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36644 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLFLmR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2019 06:42:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB6BgFIq054225;
        Fri, 6 Dec 2019 05:42:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575632535;
        bh=oQQWI05cs5ZZbMyfIpjlE+7PWlwHVVzIAHXpj5+znlE=;
        h=From:To:CC:Subject:Date;
        b=Ri3f9kyDt18kPeUNNtPOqcToR1BxZwGAgaXjEeIdVPsH6eHCGUonqcAo7ZNOoxTMP
         +aC8DcK9nwzC4gakVZbuVNiXq6C3/zXQaz2k95fI3Oj6LAEvkmpObgs3kP6bb/0tHr
         ncDPnR4mSE42HVZIjIGgMjsaMS88XXlpeGy4Qklg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB6BgF6c008805
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Dec 2019 05:42:15 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Dec
 2019 05:42:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Dec 2019 05:42:14 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6Bg6JA079926;
        Fri, 6 Dec 2019 05:42:11 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH] mmc: sdhci: Update the tuning failed messages to pr_debug level
Date:   Fri, 6 Dec 2019 17:13:26 +0530
Message-ID: <20191206114326.15856-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tuning support in DDR50 speed mode was added in SD Specifications Part1
Physical Layer Specification v3.01. Its not possible to distinguish
between v3.00 and v3.01 from the SCR and that is why since
commit 4324f6de6d2e ("mmc: core: enable CMD19 tuning for DDR50 mode")
tuning failures are ignored in DDR50 speed mode.

Cards compatible with v3.00 don't respond to CMD19 in DDR50 and this
error gets printed during enumeration and also if retune is triggered at
any time during operation. Update the printk level to pr_debug so that
these errors don't lead to false error reports.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 296d955ede59..42a9c8179da7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2417,8 +2417,8 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 		sdhci_send_tuning(host, opcode);
 
 		if (!host->tuning_done) {
-			pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
-				mmc_hostname(host->mmc));
+			pr_debug("%s: Tuning timeout, falling back to fixed sampling clock\n",
+				 mmc_hostname(host->mmc));
 			sdhci_abort_tuning(host, opcode);
 			return -ETIMEDOUT;
 		}
-- 
2.19.2

