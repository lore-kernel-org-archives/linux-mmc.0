Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106CFC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11F661214
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 10:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhIVKdh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:33:37 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:56756 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbhIVKde (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2021 06:33:34 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18MAB7N1012563;
        Wed, 22 Sep 2021 18:11:07 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Sep
 2021 18:31:25 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <adrian.hunter@intel.com>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <andrew@aj.id.au>
CC:     <BMC-SW@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 01/10] clk: aspeed: ast2600: Porting sdhci clock source
Date:   Wed, 22 Sep 2021 18:31:07 +0800
Message-ID: <20210922103116.30652-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18MAB7N1012563
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- There are two clock sources used to generate
  SD/SDIO clock, APLL clock and HCLK (200MHz).
  User can select which clock source should be used
  by configuring SCU310[8].
- The SD/SDIO clock divider selection table SCU310[30:28]
  is different between AST2600-A1 and AST2600-A2/A3.
  For AST2600-A1, 200MHz SD/SDIO clock cannot be
  gotten by the dividers in SCU310[30:28] if APLL
  is not the multiple of 200MHz and HCLK is 200MHz.
  For AST2600-A2/A3, a new divider, "1", is added and
  200MHz SD/SDIO clock can be obtained by adopting HCLK
  as clock source and setting SCU310[30:28] to 3b'111.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/clk/clk-ast2600.c | 69 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index bc3be5f3eae1..a6778c18274a 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -168,6 +168,30 @@ static const struct clk_div_table ast2600_div_table[] = {
 	{ 0 }
 };
 
+static const struct clk_div_table ast2600_sd_div_a1_table[] = {
+	{ 0x0, 2 },
+	{ 0x1, 4 },
+	{ 0x2, 6 },
+	{ 0x3, 8 },
+	{ 0x4, 10 },
+	{ 0x5, 12 },
+	{ 0x6, 14 },
+	{ 0x7, 16 },
+	{ 0 }
+};
+
+static const struct clk_div_table ast2600_sd_div_a2_table[] = {
+	{ 0x0, 2 },
+	{ 0x1, 4 },
+	{ 0x2, 6 },
+	{ 0x3, 8 },
+	{ 0x4, 10 },
+	{ 0x5, 12 },
+	{ 0x6, 14 },
+	{ 0x7, 1 },
+	{ 0 }
+};
+
 /* For hpll/dpll/epll/mpll */
 static struct clk_hw *ast2600_calc_pll(const char *name, u32 val)
 {
@@ -424,6 +448,11 @@ static const char *const emmc_extclk_parent_names[] = {
 	"mpll",
 };
 
+static const char *const sd_extclk_parent_names[] = {
+	"hclk",
+	"apll",
+};
+
 static const char * const vclk_parent_names[] = {
 	"dpll",
 	"d1pll",
@@ -523,18 +552,42 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_EMMC] = hw;
 
-	/* SD/SDIO clock divider and gate */
-	hw = clk_hw_register_gate(dev, "sd_extclk_gate", "hpll", 0,
-			scu_g6_base + ASPEED_G6_CLK_SELECTION4, 31, 0,
-			&aspeed_g6_clk_lock);
+	clk_hw_register_fixed_rate(NULL, "hclk", NULL, 0, 200000000);
+
+	regmap_read(map, 0x310, &val);
+	hw = clk_hw_register_mux(dev, "sd_extclk_mux",
+				 sd_extclk_parent_names,
+				 ARRAY_SIZE(sd_extclk_parent_names), 0,
+				 scu_g6_base + ASPEED_G6_CLK_SELECTION4, 8, 1,
+				 0, &aspeed_g6_clk_lock);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
-	hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
-			0, scu_g6_base + ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
-			ast2600_div_table,
-			&aspeed_g6_clk_lock);
+
+	hw = clk_hw_register_gate(dev, "sd_extclk_gate", "sd_extclk_mux",
+				  0, scu_g6_base + ASPEED_G6_CLK_SELECTION4,
+				  31, 0, &aspeed_g6_clk_lock);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
+
+	regmap_read(map, 0x14, &val);
+	/* AST2600-A2/A3 clock divisor is different from AST2600-A1 */
+	if (((val & GENMASK(23, 16)) >> 16) >= 2) {
+		/* AST2600-A2/A3 */
+		hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
+					0, scu_g6_base + ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
+					ast2600_sd_div_a2_table,
+					&aspeed_g6_clk_lock);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+	} else {
+		/* AST2600-A1 */
+		hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
+					0, scu_g6_base + ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
+					ast2600_sd_div_a1_table,
+					&aspeed_g6_clk_lock);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+	}
 	aspeed_g6_clk_data->hws[ASPEED_CLK_SDIO] = hw;
 
 	/* MAC1/2 RMII 50MHz RCLK */
-- 
2.17.1

