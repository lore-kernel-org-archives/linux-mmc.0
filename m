Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B20FC3526B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F7A423405
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 13:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgLPNSA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Dec 2020 08:18:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9458 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgLPNSA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2020 08:18:00 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cwwd84mxPzhkxK;
        Wed, 16 Dec 2020 21:16:44 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:17:04 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] mmc: core: convert comma to semicolon
Date:   Wed, 16 Dec 2020 21:17:37 +0800
Message-ID: <20201216131737.14883-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/mmc/core/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d42037f0f10d..07c5f242f28a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -547,10 +547,10 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	host->cqe_ops->cqe_recovery_start(host);
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.opcode       = MMC_STOP_TRANSMISSION,
-	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC,
+	cmd.opcode       = MMC_STOP_TRANSMISSION;
+	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
-	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	mmc_wait_for_cmd(host, &cmd, 0);
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -558,7 +558,7 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	cmd.arg          = 1; /* Discard entire queue */
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
-	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 
 	host->cqe_ops->cqe_recovery_finish(host);
-- 
2.22.0

