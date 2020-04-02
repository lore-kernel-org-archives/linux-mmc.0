Return-Path: <SRS0=tKpl=5S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0996BC2BA17
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86F120787
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="oZTOjt/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbgDBLzS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:55:18 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:2730 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387722AbgDBLy6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 07:54:58 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tM1r1CxvzqB;
        Thu,  2 Apr 2020 13:54:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585828496; bh=+s4mWBHcT/yU7fnAxvETRm8Us7IU85To0TkAkXM8nKo=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=oZTOjt/qsWu+92DRj2VN61RxUCSurDrb27f7n19fTpulzeiwKEQQUZwANbvN8m0Hq
         WKZ3s2NpA6asVVTQT3uU61K/T5xZRrSCE0w3Q30O+1wDMTkFl9yHT/PLhYPeXuv25E
         mqcrITJ/EUOpMWwphdW0iJQlei8G/EpBH0+ZF/rh7pcRXI+STS+TZA+x7jTAIoU9Q/
         q9CMu4bg+juzXqv6Ol0dR0PakA6Jyd3IRRlahx6saQfvVlMqduo2JtzY+UfezcuIbv
         Dij8fIa9BYAkroQkj3bkyoIcwYGn+8uLo40tAIjbU608NxsUftCP794mkwERgnLbIe
         fnFz5QXJu5f2Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 13:54:55 +0200
Message-Id: <eb105eedaa387ced14bb687e38d3aa33d4fcf70a.1585827904.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/7] mmc: sdhci: fix SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Suneel Garapati <suneel.garapati@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix returned clock rate for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN case.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: stable@kernel.vger.org
Fixes: d1955c3a9a1d ("mmc: sdhci: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN")
---
 drivers/mmc/host/sdhci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b2dc4f1cfa5c..a043bf5e3565 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1807,9 +1807,12 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 
 		if (!host->clk_mul || switch_base_clk) {
 			/* Version 3.00 divisors must be a multiple of 2. */
-			if (host->max_clk <= clock)
+			if (host->max_clk <= clock) {
 				div = 1;
-			else {
+				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
+					&& host->max_clk <= 25000000)
+					div = 2;
+			} else {
 				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
 				     div += 2) {
 					if ((host->max_clk / div) <= clock)
@@ -1818,9 +1821,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 			}
 			real_div = div;
 			div >>= 1;
-			if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
-				&& !div && host->max_clk <= 25000000)
-				div = 1;
 		}
 	} else {
 		/* Version 2.00 divisors must be a power of 2. */
-- 
2.20.1

