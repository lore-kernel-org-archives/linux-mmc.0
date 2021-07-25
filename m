Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456B1C4338F
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 09:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241AE6023F
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 09:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhGYIkU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jul 2021 04:40:20 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:54030 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230310AbhGYIkT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 25 Jul 2021 04:40:19 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GXcww0VFmzQ4;
        Sun, 25 Jul 2021 11:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1627204848; bh=3RQA0YY2zxTg+Xk+cZmLedNuKzlo21ajTA3ny9uoqwg=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=JlRwUCBxOPs1wQ4kZ09ylNVEBwqIPSJv8NMyDUldc39/eUapyWDNN8RRH4GIPtWUl
         kTbDscrcaki5bMe5llfarNT1223EZeQekzUu+5Q8Nb0ZrWjvHt4K3GwT39lbNfANpy
         RmMOIh3HFzHLs2tVrnj9596Ik31NJ83dKpJ/wfff32R0o1zcqHOIQTwpIhG5WKF+3J
         oiFPcN+lh3bMbehx+rBKmBBorg+QtQokNWwkWD4azrctgfQoFNKUqLBSL5wvAAD98d
         JoMhivNbQXPOIQL5jp7SHocou8jx0/j/uDcqWYnVxibXCjdzHEK9F4DmMODyfc4L2Z
         Wsmlz3liloXGg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sun, 25 Jul 2021 11:20:47 +0200
Message-Id: <e65dc96eb24caf8baa5431a51fe694b969e2d51f.1627204633.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 2/5] mmc: sdhci: always obey programmable clock config in
 preset value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When host controller uses programmable clock presets but doesn't
advertise programmable clock support, we can only guess what frequency
it generates. Let's at least return correct SDHCI_PROG_CLOCK_MODE bit
value in this case.

Fixes: 52983382c74f ("mmc: sdhci: enhance preset value function")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v4: no changes
v3: added a comment for this case
v2: no changes
---
 drivers/mmc/host/sdhci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c7438dd13e3e..3ab60e7f936b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1859,11 +1859,14 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 
 			pre_val = sdhci_get_preset_value(host);
 			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
-			if (host->clk_mul &&
-				(pre_val & SDHCI_PRESET_CLKGEN_SEL)) {
+			if (pre_val & SDHCI_PRESET_CLKGEN_SEL) {
 				clk = SDHCI_PROG_CLOCK_MODE;
 				real_div = div + 1;
 				clk_mul = host->clk_mul;
+				if (!clk_mul) {
+					/* The clock frequency is unknown. Assume undivided base. */
+					clk_mul = 1;
+				}
 			} else {
 				real_div = max_t(int, 1, div << 1);
 			}
-- 
2.30.2

