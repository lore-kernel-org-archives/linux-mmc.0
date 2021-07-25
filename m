Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B657C4338F
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 04:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F3660E77
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 04:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGYDvc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Jul 2021 23:51:32 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:31610 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhGYDvb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 24 Jul 2021 23:51:31 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GXVMw5tY7zWx;
        Sun, 25 Jul 2021 06:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1627187116; bh=heq1Nrofd2BQKP+4WIO5NxEzHqe39kUnYWVEiXv6rW0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Y2HEpcdbQreqce7yHTVI3ebiKNVIzLSd9s+J5JhHu3tcvjwdZLY4EvvA0WwK+/+sB
         qfTG6E+50eN+Ob1RTN3FMADZaRm9/S9ubrKsG9orZXDIZzgaW1jgmn4/XsQSDqMEyz
         cGAFONr1HY85Ws+inBjEPlmF1ilI4NSBBTZXlS7nZwx1qQLkvmnf1WU0BZeO/TDzHM
         ENEN+ij5NQZgGvS6Puv8+zYXD4T/I57MHbqZ6tVBTuCOxsufRgHqEbZqM8DggRJDKZ
         cllyTO325ExBTeNI74PvO95xi/N7gEy3Js2fF3dZvDmuog7VLNr9TW7OJh9OeYBM0W
         i6QKrRsxdnuKA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sun, 25 Jul 2021 06:25:16 +0200
Message-Id: <c9ab2448700a1ad83ed5288fd36d13a35f393850.1627186831.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1627186831.git.mirq-linux@rere.qmqm.pl>
References: <cover.1627186831.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 2/5] mmc: sdhci: always obey programmable clock config in
 preset value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chris Ball <cjb@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
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

