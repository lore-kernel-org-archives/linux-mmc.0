Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7959DC4338F
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 15:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58AA160D07
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 15:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhHGPkZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 11:40:25 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:2675 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232062AbhHGPkZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 7 Aug 2021 11:40:25 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GhmkZ203Qz64;
        Sat,  7 Aug 2021 17:40:05 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sat, 7 Aug 2021 17:39:57 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH v4 5/5] mmc: sdhci: simplify v2/v3+ clock calculation
Message-ID: <YQ6pTYL15xEEzoCy@qmqm.qmqm.pl>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <a8a677659b27244be865a730f6a7f2b7805a4390.1627204633.git.mirq-linux@rere.qmqm.pl>
 <9a6b8e4a-b944-c1d7-f310-fea1e1269e6d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a6b8e4a-b944-c1d7-f310-fea1e1269e6d@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 04, 2021 at 03:40:38PM +0300, Adrian Hunter wrote:
> On 25/07/21 12:20 pm, Micha³ Miros³aw wrote:
> > For base clock setting, SDHCI V2 differs from V3+ only in allowed divisor
> > values.  Remove the duplicate version of code and reduce indentation
> > levels.  We can see now, that 'real_div' can't be zero, so the check is
> > removed.  While at it, replace divisor search loops with divide-and-clamp
> > to make the code even more readable.
> 
> It doesn't seem simpler to me, just different.
> 
> Simpler would mean broken into separate logical functions, getting rid of
> the gotos, and above all having the changes broken into separate patches
> for easy review.

I've extracted part of the function. It does look better I think, but it
can be improved. Please take a look.

--->8<---

    mmc: sdhci: rework clock calculation
    
    Rework the code by extracting register value and real clock rate
    calculations to a separate function.  This also removes duplicated
    calculations of real_div and divisor search loops.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cfa314e659bc..9822903841f1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1845,97 +1845,79 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	return preset;
 }
 
-u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
+static u16 sdhci_calc_clk_mode(struct sdhci_host *host, int div, bool prog_mode,
 		   unsigned int *actual_clock)
 {
-	int div = 0; /* Initialized for compiler warning */
-	int real_div = div, clk_mul = 1;
+	unsigned int clk_mul, real_div;
 	u16 clk = 0;
-	bool switch_base_clk = false;
-
-	if (host->version >= SDHCI_SPEC_300) {
-		if (host->preset_enabled) {
-			u16 pre_val;
-
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
-			goto clock_set;
-		}
-
-		/*
-		 * Check if the Host Controller supports Programmable Clock
-		 * Mode.
-		 */
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
+	if (prog_mode) {
+		clk = SDHCI_PROG_CLOCK_MODE;
+		clk_mul = host->max_clk ?: 1;
+		real_div = div + 1;
 	} else {
-		/* Version 2.00 divisors must be a power of 2. */
-		for (div = 1; div < SDHCI_MAX_DIV_SPEC_200; div *= 2) {
-			if ((host->max_clk / div) <= clock)
-				break;
-		}
-		real_div = div;
-		div >>= 1;
+		clk_mul = 1;
+		real_div = div * 2 + !div;
 	}
 
-clock_set:
-	if (real_div)
-		*actual_clock = (host->max_clk * clk_mul) / real_div;
+	*actual_clock = (host->max_clk * clk_mul) / real_div;
+
 	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
 		<< SDHCI_DIVIDER_HI_SHIFT;
 
 	return clk;
 }
+
+u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
+		   unsigned int *actual_clock)
+{
+	unsigned int div;
+
+	if (clock == 0)
+		return 0;
+
+	if (host->preset_enabled) {
+		/* Note: Only version 3.00+ can have preset_enabled. */
+
+		u16 pre_val = sdhci_get_preset_value(host);
+		bool prog_mode = !!(pre_val & SDHCI_PRESET_CLKGEN_SEL);
+		div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
+
+		return sdhci_calc_clk_mode(host, div, prog_mode, actual_clock);
+	}
+
+	if (host->version >= SDHCI_SPEC_300 && host->clk_mul) {
+		/* Programmable Clock Mode is supported. */
+
+		div = DIV_ROUND_UP(host->max_clk * host->clk_mul, clock) - 1;
+		if (div <= SDHCI_MAX_DIV_SPEC_300 / 2)
+			return sdhci_calc_clk_mode(host, div, true, actual_clock);
+
+		/*
+		 * Divisor is too big for requested clock rate.
+		 * Fall back to the base clock.
+		 */
+	}
+
+	div = DIV_ROUND_UP(host->max_clk, clock);
+
+	if (div == 1 && (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN))
+		div = 2;
+
+	if (host->version >= SDHCI_SPEC_300) {
+		/* Version 3.00 divisor must be 1 or a multiple of 2. */
+		if (div != 1)
+			div += div & 1;
+		div = min(div, SDHCI_MAX_DIV_SPEC_300);
+	} else {
+		/* Version 2.00 divisor must be a power of 2. */
+		div = roundup_pow_of_two(div);
+		div = min(div, SDHCI_MAX_DIV_SPEC_200);
+	}
+
+	return sdhci_calc_clk_mode(host, div / 2, false, actual_clock);
+}
 EXPORT_SYMBOL_GPL(sdhci_calc_clk);
 
 void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
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
