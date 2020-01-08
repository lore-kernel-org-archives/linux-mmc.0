Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5991C33CA2
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A70820692
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 14:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="obzMdnPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgAHObf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:31:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36972 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgAHObe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 09:31:34 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008EVWMl065317;
        Wed, 8 Jan 2020 08:31:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578493892;
        bh=njpKt29+dtaFIGch37CbQfR9p/8Y8+c4taa6G2JbP78=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=obzMdnPSxS72O5adfld/iyMe/74tNXPG2uoTAFBfiisq/ezsr847baYqGn4akMNx4
         Soi+XpqWxTO67skHf38hQidGsGzhZ5TqWkwu3paTY4+wH+Ne6vJgkMxzkYYGC0fTMj
         unvJkDBzPdWOfb3GECDcN0jcbNduSmvD3Fn1F/hk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008EVWWs056097
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 08:31:32 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 08:31:32 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 08:31:32 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008EVS9V112013;
        Wed, 8 Jan 2020 08:31:30 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 1/3] mmc: sdhci_am654: Remove Inverted Write Protect flag
Date:   Wed, 8 Jan 2020 20:02:59 +0530
Message-ID: <20200108143301.1929-2-faiz_abbas@ti.com>
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

The MMC/SD controllers on am65x and j721e don't in fact detect the write
protect line as inverted. No issues were detected because of this
because the sdwp line is not connected on any of the evms. Fix this by
removing the flag.

Fixes: 1accbced1c32 ("mmc: sdhci_am654: Add Support for 4 bit IP on J721E")
Cc: stable@vger.kernel.org
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index b8e897e31e2e..2d38b1e12a7e 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -253,8 +253,7 @@ static struct sdhci_ops sdhci_am654_ops = {
 
 static const struct sdhci_pltfm_data sdhci_am654_pdata = {
 	.ops = &sdhci_am654_ops,
-	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
-		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
@@ -290,8 +289,7 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
 
 static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
 	.ops = &sdhci_j721e_8bit_ops,
-	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
-		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
@@ -314,8 +312,7 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
 
 static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
 	.ops = &sdhci_j721e_4bit_ops,
-	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
-		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
-- 
2.19.2

