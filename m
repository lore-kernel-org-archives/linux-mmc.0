Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14E6C64EC4
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Mar 2023 16:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCFQg4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Mar 2023 11:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCFQgi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Mar 2023 11:36:38 -0500
X-Greylist: delayed 413 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 08:36:11 PST
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608938675;
        Mon,  6 Mar 2023 08:36:11 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 9256021E38;
        Mon,  6 Mar 2023 17:27:56 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v1] mmc: sdhci_am654: lower power-on failed message severity
Date:   Mon,  6 Mar 2023 17:27:51 +0100
Message-Id: <20230306162751.163369-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Lower the power-on failed message severity from warn to info when the
controller does not power-up. It's normal to have this situation when
the SD card slot is empty, therefore we should not warn the user about
it.

Fixes: 7ca0f166f5b2 ("mmc: sdhci_am654: Add workaround for card detect debounce timer")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/mmc/host/sdhci_am654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 7ef828942df3..89953093e20c 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -369,7 +369,7 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
 					MAX_POWER_ON_TIMEOUT, false, host, val,
 					reg);
 		if (ret)
-			dev_warn(mmc_dev(host->mmc), "Power on failed\n");
+			dev_info(mmc_dev(host->mmc), "Power on failed\n");
 	}
 }
 
-- 
2.25.1

