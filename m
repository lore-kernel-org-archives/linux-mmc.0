Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E96C43467
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 10:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BEA20714
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 10:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gCaPcTV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgJHKBj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 06:01:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32820 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgJHKBj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2020 06:01:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 098A1aCH116484;
        Thu, 8 Oct 2020 05:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602151296;
        bh=q3MUyFjvN7mBX7FMCNBzHIOy27ICQpde7XSIoKizfFA=;
        h=From:To:CC:Subject:Date;
        b=gCaPcTV6P+9BK2VMk0sgSF3wIwQrLPu6YWEIffv9DTvLkfO0ygOLoxpcXKHea3tcB
         NmxIFHp1qRmBRRFs3FoapODz74roc/HqiftTkuu/RU/JPSWGbdxvaAE3P6anmxezl3
         KrUnZZvFRcvWOh+v9hvZW4B2sEA5PyWt06HdOnX0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 098A1aAh051533
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 05:01:36 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 05:01:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 05:01:36 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 098A1UUS111551;
        Thu, 8 Oct 2020 05:01:32 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH] mmc: sdhci_am654: Fix module autoload
Date:   Thu, 8 Oct 2020 15:31:29 +0530
Message-ID: <20201008100129.13917-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a MODULE_DEVICE_TABLE() entry so that the driver is autoloaded
when built as a module.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 2bce962bf7e4..a64ea143d185 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -739,6 +739,7 @@ static const struct of_device_id sdhci_am654_of_match[] = {
 	},
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, sdhci_am654_of_match);
 
 static int sdhci_am654_probe(struct platform_device *pdev)
 {
-- 
2.17.1

