Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61451C4361A
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 22:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAC5223DB
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 22:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgLCWaJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Dec 2020 17:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLCWaJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Dec 2020 17:30:09 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        yong mao <yong.mao@mediatek.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: mediatek: mark PM functions as __maybe_unused
Date:   Thu,  3 Dec 2020 23:29:16 +0100
Message-Id: <20201203222922.1067522-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The #ifdef check for the suspend/resume functions is wrong:

drivers/mmc/host/mtk-sd.c:2765:12: error: unused function 'msdc_suspend' [-Werror,-Wunused-function]
static int msdc_suspend(struct device *dev)
drivers/mmc/host/mtk-sd.c:2779:12: error: unused function 'msdc_resume' [-Werror,-Wunused-function]
static int msdc_resume(struct device *dev)

Remove the #ifdef and mark all four as __maybe_unused to aovid the
problem.

Fixes: c0a2074ac575 ("mmc: mediatek: Fix system suspend/resume support for CQHCI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/mtk-sd.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index d057fb11112a..de09c6347524 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2683,7 +2683,6 @@ static int msdc_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static void msdc_save_reg(struct msdc_host *host)
 {
 	u32 tune_reg = host->dev_comp->pad_tune_reg;
@@ -2742,7 +2741,7 @@ static void msdc_restore_reg(struct msdc_host *host)
 		__msdc_enable_sdio_irq(host, 1);
 }
 
-static int msdc_runtime_suspend(struct device *dev)
+static int __maybe_unused msdc_runtime_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
@@ -2752,7 +2751,7 @@ static int msdc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int msdc_runtime_resume(struct device *dev)
+static int __maybe_unused msdc_runtime_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
@@ -2762,7 +2761,7 @@ static int msdc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int msdc_suspend(struct device *dev)
+static int __maybe_unused msdc_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	int ret;
@@ -2776,11 +2775,10 @@ static int msdc_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static int msdc_resume(struct device *dev)
+static int __maybe_unused msdc_resume(struct device *dev)
 {
 	return pm_runtime_force_resume(dev);
 }
-#endif
 
 static const struct dev_pm_ops msdc_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(msdc_suspend, msdc_resume)
-- 
2.27.0

