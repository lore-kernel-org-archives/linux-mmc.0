Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27029C4320E
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 09:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1228260F48
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 09:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhGYIkX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jul 2021 04:40:23 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:8047 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhGYIkU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 25 Jul 2021 04:40:20 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GXcwy2z3Czht;
        Sun, 25 Jul 2021 11:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1627204850; bh=wrtM/TaqZHhc2ZGPOV+J7wI2/pfMfTBud1zAmTDVaG4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=AiMIISlPSSguzeuYmeszm5KL5Jnvw6Nvlv1I5odfE2NVTP3mc/vTHM9wE/FpxtRBW
         +fLf1rNodb7Y32JTEVaqL6tMpShQmLqoomtsR6DamdOpi7Qjw/cWva29XvHZCz2FmY
         vpswvRUNd5WQZ5evYZ7LtfU6Bk35Obrp8XXuZhHJzWab/lkkU1kAis8WV2oiEjPCd4
         ojz1JNpDwPKngzxY1zbW7n/kD9T+qyNqcvF0urn83EQGcL46jj8PmRys80h1ppOBwn
         Z1TKve7mhshvRLD+BdFIRdxb0oRlHocuPJ41S1s5jRNmotV4LGuUty/vtMl8cHhQDR
         u7UTw8wQ/Tg/A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sun, 25 Jul 2021 11:20:49 +0200
Message-Id: <a8a677659b27244be865a730f6a7f2b7805a4390.1627204633.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 5/5] mmc: sdhci: simplify v2/v3+ clock calculation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For base clock setting, SDHCI V2 differs from V3+ only in allowed divisor
values.  Remove the duplicate version of code and reduce indentation
levels.  We can see now, that 'real_div' can't be zero, so the check is
removed.  While at it, replace divisor search loops with divide-and-clamp
to make the code even more readable.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v4: no changes
v3: squashed div-conversion and deduplication patches to avoid code churn
v2: no changes
---
 drivers/mmc/host/sdhci.c | 124 ++++++++++++++++++---------------------
 drivers/mmc/host/sdhci.h |   4 +-
 2 files changed, 58 insertions(+), 70 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cfa314e659bc..90bda4150083 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1848,88 +1848,76 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock)
 {
-	int div = 0; /* Initialized for compiler warning */
-	int real_div = div, clk_mul = 1;
+	unsigned int div, real_div, clk_mul = 1;
 	u16 clk = 0;
-	bool switch_base_clk = false;
 
-	if (host->version >= SDHCI_SPEC_300) {
-		if (host->preset_enabled) {
-			u16 pre_val;
+	if (clock == 0)
+		return clk;
+
+	if (host->preset_enabled) {
+		/* Only version 3.00+ can have preset_enabled */
+		u16 pre_val;
+
+		pre_val = sdhci_get_preset_value(host);
+		div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
+		if (!(pre_val & SDHCI_PRESET_CLKGEN_SEL))
+			goto base_div_set;
+
+		clk = SDHCI_PROG_CLOCK_MODE;
+		real_div = div + 1;
+		clk_mul = host->clk_mul;
+		if (!clk_mul) {
+			/* The clock frequency is unknown. Assume undivided base. */
+			clk_mul = 1;
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
+		if (div <= SDHCI_MAX_DIV_SPEC_300 / 2 + 1) {
+			/*
+			 * Set Programmable Clock Mode in the Clock
+			 * Control register.
+			 */
+			clk = SDHCI_PROG_CLOCK_MODE;
+			clk_mul = host->clk_mul;
+			real_div = div--;
 
-			pre_val = sdhci_get_preset_value(host);
-			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
-			if (pre_val & SDHCI_PRESET_CLKGEN_SEL) {
-				clk = SDHCI_PROG_CLOCK_MODE;
-				real_div = div + 1;
-				clk_mul = host->clk_mul;
-				if (!clk_mul) {
-					/* The clock frequency is unknown. Assume undivided base. */
-					clk_mul = 1;
-				}
-			} else {
-				real_div = max_t(int, 1, div << 1);
-			}
 			goto clock_set;
 		}
 
 		/*
-		 * Check if the Host Controller supports Programmable Clock
-		 * Mode.
+		 * Divisor is too big for requested clock rate.
+		 * Fall back to the base clock.
 		 */
-		if (host->clk_mul) {
-			for (div = 1; div <= 1024; div++) {
-				if ((host->max_clk * host->clk_mul / div)
-					<= clock)
-					break;
-			}
-			if ((host->max_clk * host->clk_mul / div) <= clock) {
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
-				 * Divisor can be too small to reach clock
-				 * speed requirement. Then use the base clock.
-				 */
-				switch_base_clk = true;
-			}
-		}
+	}
 
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
-			}
-			real_div = div;
-			div >>= 1;
-		}
+	div = DIV_ROUND_UP(host->max_clk, clock);
+
+	if (div == 1 && (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN))
+		div = 2;
+
+	if (host->version >= SDHCI_SPEC_300) {
+		/* Version 3.00 divisors must be a multiple of 2. */
+		div = min(div, SDHCI_MAX_DIV_SPEC_300);
+		div = DIV_ROUND_UP(div, 2);
 	} else {
 		/* Version 2.00 divisors must be a power of 2. */
-		for (div = 1; div < SDHCI_MAX_DIV_SPEC_200; div *= 2) {
-			if ((host->max_clk / div) <= clock)
-				break;
-		}
-		real_div = div;
-		div >>= 1;
+		div = min(div, SDHCI_MAX_DIV_SPEC_200);
+		div = roundup_pow_of_two(div) / 2;
 	}
 
+base_div_set:
+	real_div = div * 2 + !div;
+
 clock_set:
-	if (real_div)
-		*actual_clock = (host->max_clk * clk_mul) / real_div;
+	*actual_clock = (host->max_clk * clk_mul) / real_div;
 	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
 		<< SDHCI_DIVIDER_HI_SHIFT;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 074dc182b184..a3fa70d91410 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -284,8 +284,8 @@
  * End of controller registers.
  */
 
-#define SDHCI_MAX_DIV_SPEC_200	256
-#define SDHCI_MAX_DIV_SPEC_300	2046
+#define SDHCI_MAX_DIV_SPEC_200	256u
+#define SDHCI_MAX_DIV_SPEC_300	2046u
 
 /*
  * Host SDMA buffer boundary. Valid values from 4K to 512K in powers of 2.
-- 
2.30.2

