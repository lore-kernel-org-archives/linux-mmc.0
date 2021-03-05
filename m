Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA2C433E9
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 09:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C103364F5F
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 09:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhCEJHr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCEJH2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2021 04:07:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B75EC061574
        for <linux-mmc@vger.kernel.org>; Fri,  5 Mar 2021 01:07:28 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lI6Qg-0003MI-PA; Fri, 05 Mar 2021 10:07:26 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: dw_mmc: simplify optional reset handling
Date:   Fri,  5 Mar 2021 10:07:24 +0100
Message-Id: <20210305090724.18832-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_(de)assert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/mmc/host/dw_mmc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 2f4de30f650b..807f77fefc20 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3095,10 +3095,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	/* find reset controller when exist */
 	pdata->rstc = devm_reset_control_get_optional_exclusive(dev, "reset");
-	if (IS_ERR(pdata->rstc)) {
-		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
-			return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (IS_ERR(pdata->rstc))
+		return ERR_CAST(pdata->rstc);
 
 	if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
 		dev_info(dev,
@@ -3204,7 +3202,7 @@ int dw_mci_probe(struct dw_mci *host)
 		goto err_clk_ciu;
 	}
 
-	if (!IS_ERR(host->pdata->rstc)) {
+	if (host->pdata->rstc) {
 		reset_control_assert(host->pdata->rstc);
 		usleep_range(10, 50);
 		reset_control_deassert(host->pdata->rstc);
@@ -3344,8 +3342,7 @@ int dw_mci_probe(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (!IS_ERR(host->pdata->rstc))
-		reset_control_assert(host->pdata->rstc);
+	reset_control_assert(host->pdata->rstc);
 
 err_clk_ciu:
 	clk_disable_unprepare(host->ciu_clk);
@@ -3373,8 +3370,7 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (!IS_ERR(host->pdata->rstc))
-		reset_control_assert(host->pdata->rstc);
+	reset_control_assert(host->pdata->rstc);
 
 	clk_disable_unprepare(host->ciu_clk);
 	clk_disable_unprepare(host->biu_clk);
-- 
2.29.2

