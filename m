Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2829BC4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 07:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F46D61AAB
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 07:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhHPHjs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 03:39:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50216 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233725AbhHPHjr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 03:39:47 -0400
X-UUID: ddc78e7cede847719bbbc67db851edb8-20210816
X-UUID: ddc78e7cede847719bbbc67db851edb8-20210816
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1020425944; Mon, 16 Aug 2021 15:39:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 16 Aug 2021 15:39:12 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 16 Aug 2021 15:39:11 +0800
From:   Mason Zhang <Mason.Zhang@mediatek.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH 1/1] mmc: mediatek: fixed clk contrl flow
Date:   Mon, 16 Aug 2021 15:38:14 +0800
Message-ID: <20210816073813.11715-1-Mason.Zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

this patch fixed clk contrl flow in set clk rate, no need close clk src,
gate cg is enough, so no need call clk prepare/unprepare.

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4dfc246c5f95..d9835b272c1f 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -895,9 +895,9 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 	 * So if want to only gate src_clk, need gate its parent(mux).
 	 */
 	if (host->src_clk_cg)
-		clk_disable_unprepare(host->src_clk_cg);
+		clk_disable(host->src_clk_cg);
 	else
-		clk_disable_unprepare(clk_get_parent(host->src_clk));
+		clk_disable(clk_get_parent(host->src_clk));
 	if (host->dev_comp->clk_div_bits == 8)
 		sdr_set_field(host->base + MSDC_CFG,
 			      MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
@@ -907,9 +907,9 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
 			      MSDC_CFG_CKMOD_EXTRA | MSDC_CFG_CKDIV_EXTRA,
 			      (mode << 12) | div);
 	if (host->src_clk_cg)
-		clk_prepare_enable(host->src_clk_cg);
+		clk_enable(host->src_clk_cg);
 	else
-		clk_prepare_enable(clk_get_parent(host->src_clk));
+		clk_enable(clk_get_parent(host->src_clk));
 
 	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
 		cpu_relax();
-- 
2.18.0

