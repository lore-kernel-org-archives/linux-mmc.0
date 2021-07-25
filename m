Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2066FC4320E
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 04:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D048760F23
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 04:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhGYDvc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Jul 2021 23:51:32 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:60515 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhGYDvb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 24 Jul 2021 23:51:31 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Jul 2021 23:51:31 EDT
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GXVMx3YbFzX8;
        Sun, 25 Jul 2021 06:25:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1627187117; bh=j17GcKmlnE8dNVYM8Ye986ikoYzsb1uGAdqmnn6MswM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Rj4CcHtMtjgf2wc4QRN5AIBbNP6v9zKW6AS5crkSmit8XZtmxkWPCciRMUo2OjMdx
         seKWPXzqj49NnHmLUwQt8GVDyo+F2zj7EIPF8lDeKnT+eW8CcjwK2/KP2LI7lqYoNp
         w8iwNzJFOc10kTxQDrNJrJJhZeSUb624fqPHrmVYHrrJMoFhaN2nUuNGgI7ML9enmK
         V+dq2ePDhn7zSddB+ptraTD62PRN1jV/KY9dtpzA9gNnqcXrZRyBgaUlgN40kqc/Uw
         FXlLgdGloAh/x/Aqy7k1AWkMp0PosZ19SAhxPiqk5b+PUsH8cR2wFMo7v7sswLH5z/
         kFIZWcB3qL9HQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sun, 25 Jul 2021 06:25:16 +0200
Message-Id: <198e2af8eb70212cdd6d85d7fb8ff547e295fa77.1627186831.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1627186831.git.mirq-linux@rere.qmqm.pl>
References: <cover.1627186831.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 3/5] mmc: sdhci: fix SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Suneel Garapati <suneel.garapati@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chris Ball <cjb@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix returned clock rate for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN case.
This fixes real_div value that was calculated as 1 (meaning no division)
instead of 2 with the quirk enabled.

Cc: stable@kernel.vger.org
Fixes: d1955c3a9a1d ("mmc: sdhci: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v3: updated commit message
v2: no changes
---
 drivers/mmc/host/sdhci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3ab60e7f936b..0993f7d0ce8e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1903,9 +1903,12 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 
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
@@ -1914,9 +1917,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
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
2.30.2

