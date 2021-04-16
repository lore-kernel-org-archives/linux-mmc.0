Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593FAC433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 02:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DAC6117A
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 02:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhDPCSU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 22:18:20 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:41188 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbhDPCSU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 22:18:20 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id A8FD1D16D6;
        Fri, 16 Apr 2021 10:17:51 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2750T140649265346304S1618539470001313_;
        Fri, 16 Apr 2021 10:17:50 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <22c1bd01685647ba05e1019aa3f85c07>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: ulf.hansson@linaro.org
X-RCPT-COUNT: 4
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc-rockchip: Just set default sample value for legacy mode
Date:   Fri, 16 Apr 2021 10:17:34 +0800
Message-Id: <1618539454-182170-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

.set_ios() is called from .resume() as well. For SDIO device which sets
keep-power-in-suspend, nothing should be changed after resuming, as well
as sample tuning value, since this value is tuned already. So we should
not overwrite it with the default value.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 753502c..d36991a 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -61,7 +61,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	}
 
 	/* Make sure we use phases which we can enumerate with */
-	if (!IS_ERR(priv->sample_clk))
+	if (!IS_ERR(priv->sample_clk) && ios->timing <= MMC_TIMING_SD_HS)
 		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
 
 	/*
-- 
2.7.4



