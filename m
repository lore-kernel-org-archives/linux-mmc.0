Return-Path: <SRS0=tKpl=5S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7AFC2BA15
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F5020787
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 11:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="C+WkvBCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbgDBLzB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:55:01 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:48099 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388165AbgDBLzA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 07:55:00 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tM1t2z6bz1vW;
        Thu,  2 Apr 2020 13:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585828498; bh=khf7zih+kXw+JC1hB17Cn0g0Tar7KZrUWoe09zQ0hQw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=C+WkvBCKaqWfzIaomFriw/wvD9tPTswt4XO10Lg+uREhGNmhIGLRBoC2u10s8HNZx
         7ZYE+NpVTsROje2/vjSuflaCd1HFnK2LBoBM+DSFYO+o5pYbGLRWIStxfxSBlTdufS
         PuFKnRTYkJB9md9+GIfHPALQHhf86WlNud0wrO9iGMIPWQ8ClYQvcS8AdOvB58kp+U
         qz2nJTCnkqySWQDJ1UjOnSuo6E03ukm5mLQtLvuUAK6wALSZGYKMPT0A2FTO5XiTfZ
         c8uw+TDenDm7P+NcnK/QsYjRLn9CzblXbfOjchxgrsXGagtK2Qeh/jB44SWLDLPZXs
         MAer15BmyFWPw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 13:54:57 +0200
Message-Id: <ea92e0e23c8cc79b960d9129aa64d0371e630b7f.1585827904.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 6/7] mmc: sdhci: squash v2/v3+ clock calculation differences
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

SDHCI V2 differs from base-clock-V3+ only in allowed divisor values.
Remove the duplicate version of code. We can see now, that 'real_div'
can't be zero.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci.c | 106 ++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 57 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d750c0997c3f..01fd897f8f3c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1756,82 +1756,74 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock)
 {
-	unsigned int div = 0; /* Initialized for compiler warning */
-	int real_div = div, clk_mul = 1;
+	unsigned int div, real_div, clk_mul = 1;
 	u16 clk = 0;
-	bool use_base_clk;
 
 	if (clock == 0)
 		unreachable();
 
-	if (host->version >= SDHCI_SPEC_300) {
-		if (host->preset_enabled) {
-			u16 pre_val;
-
-			pre_val = sdhci_get_preset_value(host);
-			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
-			if (pre_val & SDHCI_PRESET_CLKGEN_SEL) {
-				clk = SDHCI_PROG_CLOCK_MODE;
-				real_div = div + 1;
-				clk_mul = host->clk_mul ?: 1;
-			} else {
-				real_div = max_t(int, 1, div << 1);
-			}
+	if (host->preset_enabled) {
+		/* Only version 3.00+ can have preset_enabled */
+		u16 pre_val;
+
+		pre_val = sdhci_get_preset_value(host);
+		div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
+		if (pre_val & SDHCI_PRESET_CLKGEN_SEL) {
+			clk = SDHCI_PROG_CLOCK_MODE;
+			real_div = div + 1;
+			clk_mul = host->clk_mul ?: 1;
+		} else {
+			real_div = max_t(int, 1, div << 1);
+		}
+
+		goto clock_set;
+	}
+
+	/*
+	 * Check if the Host Controller supports Programmable Clock
+	 * Mode.
+	 */
+	if (host->version >= SDHCI_SPEC_300 && host->clk_mul) {
+		div = DIV_ROUND_UP(host->max_clk * host->clk_mul, clock);
+
+		if (div <= SDHCI_MAX_DIV_SPEC_300 / 2 + 1) {
+			/*
+			 * Set Programmable Clock Mode in the Clock
+			 * Control register.
+			 */
+			clk = SDHCI_PROG_CLOCK_MODE;
+			real_div = div;
+			clk_mul = host->clk_mul;
+			div--;
+
 			goto clock_set;
 		}
 
 		/*
-		 * Check if the Host Controller supports Programmable Clock
-		 * Mode.
+		 * Divisor is too big for requested clock rate.
+		 * Fall back to the base clock, then.
 		 */
-		use_base_clk = !host->clk_mul;
+	}
 
-		if (!use_base_clk) {
-			div = DIV_ROUND_UP(host->max_clk * host->clk_mul, clock);
+	div = DIV_ROUND_UP(host->max_clk, clock);
 
-			if (div <= SDHCI_MAX_DIV_SPEC_300 / 2 + 1) {
-				/*
-				 * Set Programmable Clock Mode in the Clock
-				 * Control register.
-				 */
-				clk = SDHCI_PROG_CLOCK_MODE;
-				real_div = div;
-				clk_mul = host->clk_mul;
-				div--;
-			} else {
-				/*
-				 * Divisor is too big for requested clock rate.
-				 * Use the base clock, then.
-				 */
-				use_base_clk = true;
-			}
-		}
+	if (div == 1 && (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN))
+		div = 2;
 
-		if (use_base_clk) {
-			/* Version 3.00 divisors must be 1 or a multiple of 2. */
-			div = DIV_ROUND_UP(host->max_clk, clock);
-			if (div > 1) {
-				div = min(div, SDHCI_MAX_DIV_SPEC_300);
-				div = round_up(div, 2);
-			}
-			div >>= 1;
-			if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
-				div += !div;
-
-			real_div = div * 2 + !div;
-		}
+	if (host->version >= SDHCI_SPEC_300) {
+		/* Version 3.00 divisors must be a multiple of 2. */
+		div = min(div, SDHCI_MAX_DIV_SPEC_300);
+		div = DIV_ROUND_UP(div, 2);
 	} else {
 		/* Version 2.00 divisors must be a power of 2. */
-		div = DIV_ROUND_UP(host->max_clk, clock);
 		div = min(div, SDHCI_MAX_DIV_SPEC_200);
-		div = roundup_pow_of_two(div);
-		real_div = div;
-		div >>= 1;
+		div = roundup_pow_of_two(div) / 2;
 	}
 
+	real_div = div * 2 + !div;
+
 clock_set:
-	if (real_div)
-		*actual_clock = (host->max_clk * clk_mul) / real_div;
+	*actual_clock = (host->max_clk * clk_mul) / real_div;
 	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
 		<< SDHCI_DIVIDER_HI_SHIFT;
-- 
2.20.1

