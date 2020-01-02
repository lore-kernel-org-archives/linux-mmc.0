Return-Path: <SRS0=NlIn=2X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FBAC2D0DC
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jan 2020 10:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FBD21655
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Jan 2020 10:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="b/tK3mYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgABKvb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:51:31 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:37124 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgABKvb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Jan 2020 05:51:31 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47pPwf08kdz9d;
        Thu,  2 Jan 2020 11:51:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1577962290; bh=atf4WJYkMEjMDTYUd7CSdFR7Afff9C7xkxTkmYorvj4=;
        h=Date:From:Subject:To:Cc:From;
        b=b/tK3mYE7+PFrZUW3A61w9ejhzUdTFsu/ko2FHWPYgVjNGgLILN3PDiWNaQfT/qbk
         uUhL+VrkYaZ9qDW0isHCTCpfjjLuxbuvaKPr2qthh6G/WVtB1tPEFA3Fi+Fg72jeSM
         wNuovkghNhQbDoWti0RfVWLfgEAnKdERhFgJs4Zo1fGImFQiSTB5qaVI+Gp27AG33K
         SupYzHXLGQVFDZPnRImQqH9L98Q6Hkqix7SKqbTW0NdjPjfYJ7pAO7+wn+kuhQs6SS
         h+dCUtcglnlg1Mn+4N1A+mEMIjd1Tegc8pFc5QcVbbuOCVVLtE5VKq4vQ7gGjBPz9u
         JMRRvdI+wGawA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Thu, 02 Jan 2020 11:51:29 +0100
Message-Id: <3f3b2ac4634802af591a20b1b98dc8d0158aec45.1577962196.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] mmc: sdhci: fix minimum clock rate for v3 controller
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For SDHCIv3+ with programmable clock mode, minimal clock frequency is
still base clock / max(divider). Minimal programmable clock frequency is
always greater than minimal divided clock frequency. Without this patch,
SDHCI uses out-of-spec initial frequency when multiplier is big enough:

mmc1: mmc_rescan_try_freq: trying to init card at 468750 Hz
[for 480 MHz source clock divided by 1024]

Cc: stable@vger.kernel.org
Fixes: c3ed3877625f ("mmc: sdhci: add support for programmable clock mode")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 275102c0a1bf..0036ddf85674 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3902,11 +3902,9 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
 	else if (host->version >= SDHCI_SPEC_300) {
-		if (host->clk_mul) {
-			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
+		if (host->clk_mul)
 			max_clk = host->max_clk * host->clk_mul;
-		} else
-			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
+		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
-- 
2.20.1

