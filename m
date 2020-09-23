Return-Path: <SRS0=GgYk=DA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109F9C4727F
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 10:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E0E235FC
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 10:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y0566akZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIWKws (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:52:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48646 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKwo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2020 06:52:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NAqcnD128382;
        Wed, 23 Sep 2020 05:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600858358;
        bh=runcSRoWQ8bJImFtJY5wwr5mMQV7+ECnZJBtzhhyvuU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=y0566akZIKkvbmcZbr5R9b0QJ6/xEtdWaE8sjedhzi3uzKY82Y/UWfHlLgP7r+Xwi
         A9FzaIBcxEu/0tmqaZhH322c7IYZguG0QR8QkCQT9rrSMyhbAAvOEI6XCXNTBtFbW8
         823KSllMeURWxTohNpUw4XcxB0cRieNolFEtj4wk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NAqcX2103009
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 05:52:38 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 05:52:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 05:52:37 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NAq7qm059762;
        Wed, 23 Sep 2020 05:52:33 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 5/6] mmc: sdhci_am654: Add support for software tuning
Date:   Wed, 23 Sep 2020 16:22:05 +0530
Message-ID: <20200923105206.7988-6-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923105206.7988-1-faiz_abbas@ti.com>
References: <20200923105206.7988-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With the new SW tuning App note[1], a custom tuning algorithm is
required for eMMC HS200, HS400 and SD card UHS modes. The algorithm
involves running through the 32 possible input tap delay values and
sending the appropriate tuning command (CMD19/21) for each of them
to get a fail or pass result for each of the values. Typically, the
range will have a small contiguous failing window. Considering the
tuning range as a circular buffer, the algorithm then sets a final
tuned value directly opposite to the failing window.

[1] https://www.ti.com/lit/pdf/spract9

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 1213b711e60a..5af7638ad606 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -396,7 +396,46 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
+#define ITAP_MAX	32
+static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
+					       u32 opcode)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	int cur_val, prev_val = 1, fail_len = 0, pass_window = 0, pass_len;
+	u32 itap;
+
+	/* Enable ITAPDLY */
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
+			   1 << ITAPDLYENA_SHIFT);
+
+	for (itap = 0; itap < ITAP_MAX; itap++) {
+		sdhci_am654_write_itapdly(sdhci_am654, itap);
+
+		cur_val = !mmc_send_tuning(host->mmc, opcode, NULL);
+		if (cur_val && !prev_val)
+			pass_window = itap;
+
+		if (!cur_val)
+			fail_len++;
+
+		prev_val = cur_val;
+	}
+	/*
+	 * Having determined the length of the failing window and start of
+	 * the passing window calculate the length of the passing window and
+	 * set the final value halfway through it considering the range as a
+	 * circular buffer
+	 */
+	pass_len = ITAP_MAX - fail_len;
+	itap = (pass_window + (pass_len >> 1)) % ITAP_MAX;
+	sdhci_am654_write_itapdly(sdhci_am654, itap);
+
+	return 0;
+}
+
 static struct sdhci_ops sdhci_am654_ops = {
+	.platform_execute_tuning = sdhci_am654_platform_execute_tuning,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
@@ -426,6 +465,7 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
 };
 
 static struct sdhci_ops sdhci_j721e_8bit_ops = {
+	.platform_execute_tuning = sdhci_am654_platform_execute_tuning,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
@@ -449,6 +489,7 @@ static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
 };
 
 static struct sdhci_ops sdhci_j721e_4bit_ops = {
+	.platform_execute_tuning = sdhci_am654_platform_execute_tuning,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-- 
2.17.1

