Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C2CC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 08:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiK3IDr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 03:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbiK3IDp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 03:03:45 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE2652895;
        Wed, 30 Nov 2022 00:03:38 -0800 (PST)
Received: from SHSend.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by SHSQR01.spreadtrum.com with ESMTPS id 2AU82hee061268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Wed, 30 Nov 2022 16:02:44 +0800 (CST)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from xm13705pcu.spreadtrum.com (10.13.3.189) by
 shmbx05.spreadtrum.com (10.29.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 30 Nov 2022 16:02:40 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <zhang.lyra@gmail.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhenxiong.lai@unisoc.com>, <yuelin.tang@unisoc.com>,
        <gengcixi@gmail.com>
Subject: [PATCH] mmc: sdhci-sprd: Fix no reset data and command after voltage switch
Date:   Wed, 30 Nov 2022 16:02:24 +0800
Message-ID: <20221130080224.12831-1-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.3.189]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 2AU82hee061268
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

After switching the voltage, no reset data and command will cause
CMD2 timeout.

Fixes: 29ca763fc26f ("mmc: sdhci-sprd: Add pin control support for voltage switch")
Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/sdhci-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index b92a408f138d..464508be8ec8 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -470,7 +470,7 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 
 	if (IS_ERR(sprd_host->pinctrl))
-		return 0;
+		goto reset;
 
 	switch (ios->signal_voltage) {
 	case MMC_SIGNAL_VOLTAGE_180:
@@ -496,6 +496,7 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
+reset:
 	/* Wait for 300 ~ 500 us for pin state stable */
 	usleep_range(300, 500);
 	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
-- 
2.17.1

