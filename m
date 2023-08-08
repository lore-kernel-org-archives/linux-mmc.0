Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA0C001DB
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 18:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbjHHSQC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbjHHSPh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 14:15:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012767A0C5
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 10:21:57 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKvMn1hlRzVk0Q;
        Tue,  8 Aug 2023 21:35:49 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 21:37:42 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <sugaya.taichi@socionext.com>, <orito.takao@socionext.com>,
        <vireshk@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next 2/2] mmc: sdhci: milbeaut: remove redundant of_match_ptr()
Date:   Tue, 8 Aug 2023 21:37:14 +0800
Message-ID: <20230808133714.214914-3-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808133714.214914-1-wangzhu9@huawei.com>
References: <20230808133714.214914-1-wangzhu9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove of_match_ptr() here.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/mmc/host/sdhci-milbeaut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
index 148b37ac6564..701b11a14c6f 100644
--- a/drivers/mmc/host/sdhci-milbeaut.c
+++ b/drivers/mmc/host/sdhci-milbeaut.c
@@ -334,7 +334,7 @@ static struct platform_driver sdhci_milbeaut_driver = {
 	.driver = {
 		.name = "sdhci-milbeaut",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table = of_match_ptr(mlb_dt_ids),
+		.of_match_table = mlb_dt_ids,
 	},
 	.probe	= sdhci_milbeaut_probe,
 	.remove	= sdhci_milbeaut_remove,
-- 
2.17.1

