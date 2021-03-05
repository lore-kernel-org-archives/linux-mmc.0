Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89EDC433E0
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 09:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F6C64EEE
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 09:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhCEJIv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCEJIb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2021 04:08:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BBEC061574
        for <linux-mmc@vger.kernel.org>; Fri,  5 Mar 2021 01:08:30 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lI6Rh-0003aT-H9; Fri, 05 Mar 2021 10:08:29 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-st: simplify optional reset handling
Date:   Fri,  5 Mar 2021 10:08:27 +0100
Message-Id: <20210305090827.19124-1-p.zabel@pengutronix.de>
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
 drivers/mmc/host/sdhci-st.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 962872aec164..78941ac3a1d6 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -362,11 +362,10 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	if (IS_ERR(icnclk))
 		icnclk = NULL;
 
-	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc))
-		rstc = NULL;
-	else
-		reset_control_deassert(rstc);
+		return PTR_ERR(rstc);
+	reset_control_deassert(rstc);
 
 	host = sdhci_pltfm_init(pdev, &sdhci_st_pdata, sizeof(*pdata));
 	if (IS_ERR(host)) {
@@ -432,8 +431,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
 err_of:
 	sdhci_pltfm_free(pdev);
 err_pltfm_init:
-	if (rstc)
-		reset_control_assert(rstc);
+	reset_control_assert(rstc);
 
 	return ret;
 }
@@ -450,8 +448,7 @@ static int sdhci_st_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(pdata->icnclk);
 
-	if (rstc)
-		reset_control_assert(rstc);
+	reset_control_assert(rstc);
 
 	return ret;
 }
@@ -471,8 +468,7 @@ static int sdhci_st_suspend(struct device *dev)
 	if (ret)
 		goto out;
 
-	if (pdata->rstc)
-		reset_control_assert(pdata->rstc);
+	reset_control_assert(pdata->rstc);
 
 	clk_disable_unprepare(pdata->icnclk);
 	clk_disable_unprepare(pltfm_host->clk);
@@ -498,8 +494,7 @@ static int sdhci_st_resume(struct device *dev)
 		return ret;
 	}
 
-	if (pdata->rstc)
-		reset_control_deassert(pdata->rstc);
+	reset_control_deassert(pdata->rstc);
 
 	st_mmcss_cconfig(np, host);
 
-- 
2.29.2

