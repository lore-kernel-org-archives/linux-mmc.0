Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3891C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 11:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C34619BA
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 11:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCWLUi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:20:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14846 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhCWLUM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2021 07:20:12 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F4TPb1kWQz92t4;
        Tue, 23 Mar 2021 19:18:11 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 19:20:00 +0800
From:   'w00385741 <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Adrian Hunter <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     <linux-mmc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] mmc: sdhci-of-dwcmshc: fix error return code in dwcmshc_probe()
Date:   Tue, 23 Mar 2021 11:29:56 +0000
Message-ID: <20210323112956.1016884-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: c2c4da37837e ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 06873686d5e9..e96c628aeeeb 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -383,8 +383,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
 
 	if (pltfm_data == &sdhci_dwcmshc_rk3568_pdata) {
 		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk3568_priv), GFP_KERNEL);
-		if (!rk_priv)
+		if (!rk_priv) {
+			err = -ENOMEM;
 			goto err_clk;
+		}
 
 		priv->priv = rk_priv;
 

