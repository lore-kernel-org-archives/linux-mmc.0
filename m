Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A487C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7338860F4B
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhIVKdp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:33:45 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:11651 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhIVKdl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2021 06:33:41 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18MAB8JN012566;
        Wed, 22 Sep 2021 18:11:08 +0800 (GMT-8)
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
Subject: [PATCH 04/10] mmc: Add invert flag for clock phase signedness
Date:   Wed, 22 Sep 2021 18:31:10 +0800
Message-ID: <20210922103116.30652-5-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18MAB8JN012566
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The clock phase degree may be between -360 to 360.
If the data signal is leading to the clock, the signedness
of clock phase is postive, otherwise, the signedness
is negative.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/mmc/core/host.c  | 10 ++++++----
 include/linux/mmc/host.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d4683b1d263f..c2de7cbc7838 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -214,14 +214,16 @@ static void mmc_retune_timer(struct timer_list *t)
 static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
 				      struct mmc_clk_phase *phase)
 {
-	int degrees[2] = {0};
+	int degrees[4] = {0};
 	int rc;
 
-	rc = device_property_read_u32_array(dev, prop, degrees, 2);
+	rc = device_property_read_u32_array(dev, prop, degrees, 4);
 	phase->valid = !rc;
 	if (phase->valid) {
-		phase->in_deg = degrees[0];
-		phase->out_deg = degrees[1];
+		phase->inv_in_deg = degrees[0] ? true : false;
+		phase->in_deg = degrees[1];
+		phase->inv_out_deg = degrees[2] ? true : false;
+		phase->out_deg = degrees[3];
 	}
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c0c9a0fdf57..3c13010683e0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -82,7 +82,9 @@ struct mmc_ios {
 
 struct mmc_clk_phase {
 	bool valid;
+	bool inv_in_deg;
 	u16 in_deg;
+	bool inv_out_deg;
 	u16 out_deg;
 };
 
-- 
2.17.1

