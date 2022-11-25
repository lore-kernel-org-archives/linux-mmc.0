Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8669BC4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Nov 2022 09:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKYJBq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKYJBp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2022 04:01:45 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E8F1D327
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2022 01:01:44 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NJTP06jpzz15Mt7;
        Fri, 25 Nov 2022 17:01:08 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 17:01:41 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <chaotian.jing@mediatek.com>, <ulf.hansson@linaro.org>,
        <matthias.bgg@gmail.com>, <drinkcat@chromium.org>,
        <wenbin.mei@mediatek.com>, <cuigaosheng1@huawei.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mmc: mtk-sd: Fix missing clk_disable_unprepare in msdc_of_clock_parse()
Date:   Fri, 25 Nov 2022 17:01:41 +0800
Message-ID: <20221125090141.3626747-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The clk_disable_unprepare() should be called in the error handling
of devm_clk_bulk_get_optional, fix it by replacing devm_clk_get_optional
and clk_prepare_enable by devm_clk_get_optional_enabled.

Fixes: f5eccd94b63f ("mmc: mediatek: Add subsys clock control for MT8192 msdc")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/mmc/host/mtk-sd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 0f06cc5fec86..abadfc319053 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2605,13 +2605,11 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
 			return PTR_ERR(host->src_clk_cg);
 	}
 
-	host->sys_clk_cg = devm_clk_get_optional(&pdev->dev, "sys_cg");
+	/* If present, always enable for this clock gate */
+	host->sys_clk_cg = devm_clk_get_optional_enabled(&pdev->dev, "sys_cg");
 	if (IS_ERR(host->sys_clk_cg))
 		host->sys_clk_cg = NULL;
 
-	/* If present, always enable for this clock gate */
-	clk_prepare_enable(host->sys_clk_cg);
-
 	host->bulk_clks[0].id = "pclk_cg";
 	host->bulk_clks[1].id = "axi_cg";
 	host->bulk_clks[2].id = "ahb_cg";
-- 
2.25.1

