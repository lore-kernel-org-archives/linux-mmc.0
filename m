Return-Path: <SRS0=IwUb=AU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9677FC433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jul 2020 20:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759162077D
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jul 2020 20:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgGIUjo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:39:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46894 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgGIUjo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2020 16:39:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069JW2m0066808;
        Thu, 9 Jul 2020 15:57:09 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325kgy6b54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 15:57:09 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 069JonWg007544;
        Thu, 9 Jul 2020 19:57:09 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 325k28au91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 19:57:08 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 069Jv6Vu20840928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jul 2020 19:57:06 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6BBE7806A;
        Thu,  9 Jul 2020 19:57:07 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A57E7805C;
        Thu,  9 Jul 2020 19:57:07 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.163.54.227])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jul 2020 19:57:07 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au,
        ulf.hansson@linaro.org, adrian.hunter@intel.com, sboyd@kernel.org,
        mturquette@baylibre.com, eajames@linux.ibm.com
Subject: [PATCH 1/2] clk: AST2600: Add mux for EMMC clock
Date:   Thu,  9 Jul 2020 14:57:05 -0500
Message-Id: <20200709195706.12741-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200709195706.12741-1-eajames@linux.ibm.com>
References: <20200709195706.12741-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_10:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=1 bulkscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090131
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The EMMC clock can be derived from either the HPLL or the MPLL. Register
a clock mux so that the rate is calculated correctly based upon the
parent.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/clk/clk-ast2600.c | 49 ++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index 99afc949925f..177368cac6dd 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -131,6 +131,18 @@ static const struct clk_div_table ast2600_eclk_div_table[] = {
 	{ 0 }
 };
 
+static const struct clk_div_table ast2600_emmc_extclk_div_table[] = {
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
 static const struct clk_div_table ast2600_mac_div_table[] = {
 	{ 0x0, 4 },
 	{ 0x1, 4 },
@@ -390,6 +402,11 @@ static struct clk_hw *aspeed_g6_clk_hw_register_gate(struct device *dev,
 	return hw;
 }
 
+static const char *const emmc_extclk_parent_names[] = {
+	"emmc_extclk_hpll_in",
+	"mpll",
+};
+
 static const char * const vclk_parent_names[] = {
 	"dpll",
 	"d1pll",
@@ -459,16 +476,32 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_UARTX] = hw;
 
-	/* EMMC ext clock divider */
-	hw = clk_hw_register_gate(dev, "emmc_extclk_gate", "hpll", 0,
-			scu_g6_base + ASPEED_G6_CLK_SELECTION1, 15, 0,
-			&aspeed_g6_clk_lock);
+	/* EMMC ext clock */
+	hw = clk_hw_register_fixed_factor(dev, "emmc_extclk_hpll_in", "hpll",
+					  0, 1, 2);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
-	hw = clk_hw_register_divider_table(dev, "emmc_extclk", "emmc_extclk_gate", 0,
-			scu_g6_base + ASPEED_G6_CLK_SELECTION1, 12, 3, 0,
-			ast2600_div_table,
-			&aspeed_g6_clk_lock);
+
+	hw = clk_hw_register_mux(dev, "emmc_extclk_mux",
+				 emmc_extclk_parent_names,
+				 ARRAY_SIZE(emmc_extclk_parent_names), 0,
+				 scu_g6_base + ASPEED_G6_CLK_SELECTION1, 11, 1,
+				 0, &aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	hw = clk_hw_register_gate(dev, "emmc_extclk_gate", "emmc_extclk_mux",
+				  0, scu_g6_base + ASPEED_G6_CLK_SELECTION1,
+				  15, 0, &aspeed_g6_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	hw = clk_hw_register_divider_table(dev, "emmc_extclk",
+					   "emmc_extclk_gate", 0,
+					   scu_g6_base +
+						ASPEED_G6_CLK_SELECTION1, 12,
+					   3, 0, ast2600_emmc_extclk_div_table,
+					   &aspeed_g6_clk_lock);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
 	aspeed_g6_clk_data->hws[ASPEED_CLK_EMMC] = hw;
-- 
2.24.0

