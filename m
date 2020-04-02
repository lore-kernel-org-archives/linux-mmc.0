Return-Path: <SRS0=tKpl=5S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF843C2BA1B
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B435D20757
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="PWyfGkYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbgDBLy7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:54:59 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:59778 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388154AbgDBLy7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 07:54:59 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tM1r4wP3zwy;
        Thu,  2 Apr 2020 13:54:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585828496; bh=w9lqLlJJ6XJvsSd0hc1eF6HC5pdJ5YRJaBkIo26sigY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=PWyfGkYNRr4N0Y5lOGgGjsFgSBRyoc+aLbRXWxRSwy0sPpZ8G9UoUnN3OqT5n3jNc
         8txyg0ATQrXD3htPqOnwp1mdqFtu7prKp10nPdR+7D6GEq+GrLm4S6KAs2PoqPR9jp
         QQC51qH8vj0pg0Rf4eYiNjsR1xpf9d4BYFNsl4X7F1+9YutJWBKJ1zvcs+VWhpadfQ
         S/N4A38fzQHNZpcedANbD/FFr6Rk5kSVDUoadXOFCRSNBNkZ0GJ/OmGfvN0n5aQfOO
         5Dq7wk7J7871Rktm1iFF9KTuNT7v6SzHhvHfGxRyWPGLI9+Od06zOTnhzy5y6EdVoJ
         HV+cajuQpA/0Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 13:54:56 +0200
Message-Id: <637b9bea4c28a0eeacf754d2930596b8e6673808.1585827904.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/7] mmc: sdhci: move SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
 frequency limit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Move clock frequency limit for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN where
it belongs.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci-of-arasan.c | 7 ++++---
 drivers/mmc/host/sdhci.c           | 3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index d4905c106c06..5e3b9131a631 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -339,7 +339,6 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
 	.ops = &sdhci_arasan_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
 			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
@@ -410,8 +409,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
 static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 	.ops = &sdhci_arasan_cqe_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
 static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
@@ -1155,6 +1153,9 @@ static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
 	bool dma64;
 	int ret;
 
+	if (sdhci_pltfm_clk_get_max_clock(host) <= 25000000)
+		host->quirks2 |= SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN;
+
 	if (!sdhci_arasan->has_cqe)
 		return sdhci_add_host(host);
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a043bf5e3565..ed88ac4e4cf3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1809,8 +1809,7 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 			/* Version 3.00 divisors must be a multiple of 2. */
 			if (host->max_clk <= clock) {
 				div = 1;
-				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
-					&& host->max_clk <= 25000000)
+				if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
 					div = 2;
 			} else {
 				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
-- 
2.20.1

