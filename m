Return-Path: <SRS0=tKpl=5S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CADC2BA17
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F3B20757
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="aY/JFc37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbgDBLzA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:55:00 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:58487 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388155AbgDBLy7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 07:54:59 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tM1s43sBz1qr;
        Thu,  2 Apr 2020 13:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585828497; bh=YCRJD8BehMcOPBVe27CPoZJLMWHOv11vvbz+rZe5/fM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=aY/JFc37M16HcekIU0+WP8YP3yWfM6vPDyROsIM3QArVRkm2yl9Nc1erTvAxG2LZR
         BO7V1pjvglCQBBNpwWV9x56m/KTBbtsMd3uf4f8O9brOnYlw6LJg90lHuGNO2LdfFC
         20QPtlKBVbF771UpvO511f3wYTYYvacNcVPg22Cj68hVOYuFkoTu7Y/bdP3yTqgStL
         vYv9D4rs4UmFjTeo2lS7enkt4nW2m7BeowUr5lZEGq7tajt2cN1IuwVKxVZdidAhez
         pi2G6h9PxsCj/E4dQt9321yo24BRaUiKq0b8mWgeErBR53QdarTUA8ScLd2GamsTFP
         IiRZGDpMlbjcg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 13:54:57 +0200
Message-Id: <1a7f7f0941314da66acda3c60f44b3d2417133e6.1585827904.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5/7] mmc: sdhci: simplify clock frequency calculation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Make clock frequency calculations simpler by replacing loops
with divide-and-clamp.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci.c | 56 +++++++++++++++++++---------------------
 drivers/mmc/host/sdhci.h |  4 +--
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ed88ac4e4cf3..d750c0997c3f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1756,10 +1756,13 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock)
 {
-	int div = 0; /* Initialized for compiler warning */
+	unsigned int div = 0; /* Initialized for compiler warning */
 	int real_div = div, clk_mul = 1;
 	u16 clk = 0;
-	bool switch_base_clk = false;
+	bool use_base_clk;
+
+	if (clock == 0)
+		unreachable();
 
 	if (host->version >= SDHCI_SPEC_300) {
 		if (host->preset_enabled) {
@@ -1781,13 +1784,12 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		 * Check if the Host Controller supports Programmable Clock
 		 * Mode.
 		 */
-		if (host->clk_mul) {
-			for (div = 1; div <= 1024; div++) {
-				if ((host->max_clk * host->clk_mul / div)
-					<= clock)
-					break;
-			}
-			if ((host->max_clk * host->clk_mul / div) <= clock) {
+		use_base_clk = !host->clk_mul;
+
+		if (!use_base_clk) {
+			div = DIV_ROUND_UP(host->max_clk * host->clk_mul, clock);
+
+			if (div <= SDHCI_MAX_DIV_SPEC_300 / 2 + 1) {
 				/*
 				 * Set Programmable Clock Mode in the Clock
 				 * Control register.
@@ -1798,35 +1800,31 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 				div--;
 			} else {
 				/*
-				 * Divisor can be too small to reach clock
-				 * speed requirement. Then use the base clock.
+				 * Divisor is too big for requested clock rate.
+				 * Use the base clock, then.
 				 */
-				switch_base_clk = true;
+				use_base_clk = true;
 			}
 		}
 
-		if (!host->clk_mul || switch_base_clk) {
-			/* Version 3.00 divisors must be a multiple of 2. */
-			if (host->max_clk <= clock) {
-				div = 1;
-				if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
-					div = 2;
-			} else {
-				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
-				     div += 2) {
-					if ((host->max_clk / div) <= clock)
-						break;
-				}
+		if (use_base_clk) {
+			/* Version 3.00 divisors must be 1 or a multiple of 2. */
+			div = DIV_ROUND_UP(host->max_clk, clock);
+			if (div > 1) {
+				div = min(div, SDHCI_MAX_DIV_SPEC_300);
+				div = round_up(div, 2);
 			}
-			real_div = div;
 			div >>= 1;
+			if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
+				div += !div;
+
+			real_div = div * 2 + !div;
 		}
 	} else {
 		/* Version 2.00 divisors must be a power of 2. */
-		for (div = 1; div < SDHCI_MAX_DIV_SPEC_200; div *= 2) {
-			if ((host->max_clk / div) <= clock)
-				break;
-		}
+		div = DIV_ROUND_UP(host->max_clk, clock);
+		div = min(div, SDHCI_MAX_DIV_SPEC_200);
+		div = roundup_pow_of_two(div);
 		real_div = div;
 		div >>= 1;
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 79dffbb731d3..ea8aabb3bf16 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -290,8 +290,8 @@
  * End of controller registers.
  */
 
-#define SDHCI_MAX_DIV_SPEC_200	256
-#define SDHCI_MAX_DIV_SPEC_300	2046
+#define SDHCI_MAX_DIV_SPEC_200	256u
+#define SDHCI_MAX_DIV_SPEC_300	2046u
 
 /*
  * Host SDMA buffer boundary. Valid values from 4K to 512K in powers of 2.
-- 
2.20.1

