Return-Path: <SRS0=Uv8K=7S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DA3C433E0
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Jun 2020 12:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E222075B
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Jun 2020 12:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFEMzu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:55:50 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:58710 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbgFEMzu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2020 08:55:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1869643|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00106272-0.000406173-0.998531;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.Hib7hso_1591361738;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.Hib7hso_1591361738)
          by smtp.aliyun-inc.com(10.147.41.143);
          Fri, 05 Jun 2020 20:55:47 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, mripard@kernel.org, wens@csie.org,
        tiny.windzz@gmail.com, rmfrfs@gmail.com, frank@allwinnertech.com,
        marex@denx.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: mediatek: do not hide address in msdc_request_timeout()
Date:   Fri,  5 Jun 2020 20:55:45 +0800
Message-Id: <20200605125545.31974-2-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200605125545.31974-1-frank@allwinnertech.com>
References: <20200605125545.31974-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Using %px to show the actual address in msdc_request_timeout()
to help us to debug issue.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 39e7fc54c438..28b4a136fc72 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1411,7 +1411,7 @@ static void msdc_request_timeout(struct work_struct *work)
 	/* simulate HW timeout status */
 	dev_err(host->dev, "%s: aborting cmd/data/mrq\n", __func__);
 	if (host->mrq) {
-		dev_err(host->dev, "%s: aborting mrq=%p cmd=%d\n", __func__,
+		dev_err(host->dev, "%s: aborting mrq=%px cmd=%d\n", __func__,
 				host->mrq, host->mrq->cmd->opcode);
 		if (host->cmd) {
 			dev_err(host->dev, "%s: aborting cmd=%d\n",
-- 
2.24.0

