Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D60C43217
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 18:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhKXStX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhKXStW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2021 13:49:22 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FD4C06173E;
        Wed, 24 Nov 2021 10:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=NaShKU+gB8/YODlRGH4eQzK9sS6+KcPIIAbBK8gxphY=; b=0f+GX8dBs8zJWS13k5mtqAjoNZ
        gjuwmNYLsRaBDN8QN96JbJ3dHxSsjU3k/BDs0B7YH5V/v8FFf8H+LNX8rMPCU3Jhu1t+PCfe28ZYK
        aDENVTmbIA341XtbSF1qGVQR6yGlk/84SzRip4AwMuJ52j40d1cmElUeaoLXc+qhTGUKdMZb1DGrI
        NQpprmz3WEYh4FGWUPmFWuQwlQrj+37ITe55hGFAYPCq5EltM6s+w5fkejCnd8LH/zqGTYnlnae0i
        ChJVU4dyLsGLpOgDqvTBefEiLTYneLsrrayLCZnorOtVCBcvnDWxjUS/6HVSIk5ZiHHt0vjdzf0L1
        ksoJ6Wrw==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mpxHW-00007s-7d; Wed, 24 Nov 2021 18:46:10 +0000
From:   John Keeping <john@metanate.com>
To:     linux-mmc@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Heiko Stuebner <heiko@sntech.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/4] mmc: dw_mmc: hi3798cv200: use common_caps
Date:   Wed, 24 Nov 2021 18:46:00 +0000
Message-Id: <20211124184603.3897245-3-john@metanate.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211124184603.3897245-1-john@metanate.com>
References: <20211124184603.3897245-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The capabilities for all instances are the same, so use common_caps
instead of caps/num_caps to remove the dependency on the mshcN device
tree alias.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index 39794f93826f..e9437ef8ef19 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -23,12 +23,6 @@ struct hi3798cv200_priv {
 	struct clk *drive_clk;
 };
 
-static unsigned long dw_mci_hi3798cv200_caps[] = {
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23,
-	MMC_CAP_CMD23
-};
-
 static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct hi3798cv200_priv *priv = host->priv;
@@ -166,8 +160,7 @@ static int dw_mci_hi3798cv200_init(struct dw_mci *host)
 }
 
 static const struct dw_mci_drv_data hi3798cv200_data = {
-	.caps = dw_mci_hi3798cv200_caps,
-	.num_caps = ARRAY_SIZE(dw_mci_hi3798cv200_caps),
+	.common_caps = MMC_CAP_CMD23,
 	.init = dw_mci_hi3798cv200_init,
 	.set_ios = dw_mci_hi3798cv200_set_ios,
 	.execute_tuning = dw_mci_hi3798cv200_execute_tuning,
-- 
2.34.0

