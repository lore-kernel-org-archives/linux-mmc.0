Return-Path: <SRS0=GgYk=DA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF839C4727E
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 10:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971BB23787
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 10:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TMvk0e86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIWKw5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:52:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48708 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKw5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2020 06:52:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NAqhnj128471;
        Wed, 23 Sep 2020 05:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600858363;
        bh=RwvV4fff1/3YbuFQjSkZJTR5Z25J5Mw1lL9+HBJUs00=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TMvk0e86KN9AH15NYeySRL15tjlImJ8mvy9FoGu2ZrkrsQykhEocZTfXnGsPDaLDw
         FT0Ua6pcwpzONOY6m08+NaWCb+kv4uWWtwjpET9JkY/e2kMsUsYuBX4hrPANNFGLDP
         t0FouPqpyiTJ4D0anoNg3DhIA+8nBJvREgYv57ds=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NAqhBm006131
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 05:52:43 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 05:52:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 05:52:43 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NAq7qn059762;
        Wed, 23 Sep 2020 05:52:38 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 6/6] mmc: sdhci_am654: Enable tuning for SDR50
Date:   Wed, 23 Sep 2020 16:22:06 +0530
Message-ID: <20200923105206.7988-7-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923105206.7988-1-faiz_abbas@ti.com>
References: <20200923105206.7988-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to the SW tuning App note[1], tuning is required for all
UHS speed modes. Tuning for SDR50 is not enabled in Capabilities by
default so enable it from the CTL_CFG registers.

[1] https://www.ti.com/lit/pdf/spract9

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 5af7638ad606..2bce962bf7e4 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -19,9 +19,11 @@
 
 /* CTL_CFG Registers */
 #define CTL_CFG_2		0x14
+#define CTL_CFG_3		0x18
 
 #define SLOTTYPE_MASK		GENMASK(31, 30)
 #define SLOTTYPE_EMBEDDED	BIT(30)
+#define TUNINGFORSDR50_MASK	BIT(13)
 
 /* PHY Registers */
 #define PHY_CTRL1	0x100
@@ -646,6 +648,10 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
 			   ctl_cfg_2);
 
+	/* Enable tuning for SDR50 */
+	regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
+			   TUNINGFORSDR50_MASK);
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		return ret;
-- 
2.17.1

