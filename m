Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8C9C4321E
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E0260F41
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhIVKdj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:33:39 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:13295 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhIVKdf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2021 06:33:35 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18MAB7kO012564;
        Wed, 22 Sep 2021 18:11:07 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Sep
 2021 18:31:26 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <adrian.hunter@intel.com>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <andrew@aj.id.au>
CC:     <BMC-SW@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 02/10] sdhci: aspeed: Add SDR50 support
Date:   Wed, 22 Sep 2021 18:31:08 +0800
Message-ID: <20210922103116.30652-3-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18MAB7kO012564
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From the analog waveform analysis result, SD/SDIO controller
of AST2600 cannot always work well with 200MHz. The upper bound
stable frequency for SD/SDIO controller is 100MHz. Thus, SDR50
supported bit, instead of SDR104, in capability 2 register
should be set in advance.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 6e4e132903a6..c6eaeb02e3f9 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -35,6 +35,8 @@
 #define ASPEED_SDC_CAP1_1_8V           (0 * 32 + 26)
 /* SDIO{14,24} */
 #define ASPEED_SDC_CAP2_SDR104         (1 * 32 + 1)
+/* SDIO{14,24} */
+#define ASPEED_SDC_CAP2_SDR50          (1 * 32 + 0)
 
 struct aspeed_sdc {
 	struct clk *clk;
@@ -410,11 +412,17 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 	sdhci_get_of_property(pdev);
 
 	if (of_property_read_bool(np, "mmc-hs200-1_8v") ||
+		of_property_read_bool(np, "sd-uhs-sdr50") ||
 	    of_property_read_bool(np, "sd-uhs-sdr104")) {
 		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP1_1_8V,
 					       true, slot);
 	}
 
+	if (of_property_read_bool(np, "sd-uhs-sdr50")) {
+		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP2_SDR50,
+					       true, slot);
+	}
+
 	if (of_property_read_bool(np, "sd-uhs-sdr104")) {
 		aspeed_sdc_set_slot_capability(host, dev->parent, ASPEED_SDC_CAP2_SDR104,
 					       true, slot);
-- 
2.17.1

