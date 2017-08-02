From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] mmc: core: correct taac parameter according to the specification
Date: Wed,  2 Aug 2017 11:12:42 +0800
Message-ID: <1501643563-16094-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:35684 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdHBDNI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Aug 2017 23:13:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Per the spec of JESD84-B51, section 7.3, replce tacc with taac to
fix the obvious typo.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/core.c  | 14 +++++++-------
 drivers/mmc/core/mmc.c   |  8 ++++----
 drivers/mmc/core/sd.c    | 12 ++++++------
 include/linux/mmc/card.h |  4 ++--
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 15623cc..6177eb0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -733,8 +733,8 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 	if (data->flags & MMC_DATA_WRITE)
 		mult <<= card->csd.r2w_factor;
 
-	data->timeout_ns = card->csd.tacc_ns * mult;
-	data->timeout_clks = card->csd.tacc_clks * mult;
+	data->timeout_ns = card->csd.taac_ns * mult;
+	data->timeout_clks = card->csd.taac_clks * mult;
 
 	/*
 	 * SD cards also have an upper limit on the timeout.
@@ -1859,14 +1859,14 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 	} else {
 		/* CSD Erase Group Size uses write timeout */
 		unsigned int mult = (10 << card->csd.r2w_factor);
-		unsigned int timeout_clks = card->csd.tacc_clks * mult;
+		unsigned int timeout_clks = card->csd.taac_clks * mult;
 		unsigned int timeout_us;
 
-		/* Avoid overflow: e.g. tacc_ns=80000000 mult=1280 */
-		if (card->csd.tacc_ns < 1000000)
-			timeout_us = (card->csd.tacc_ns * mult) / 1000;
+		/* Avoid overflow: e.g. taac_ns=80000000 mult=1280 */
+		if (card->csd.taac_ns < 1000000)
+			timeout_us = (card->csd.taac_ns * mult) / 1000;
 		else
-			timeout_us = (card->csd.tacc_ns / 1000) * mult;
+			timeout_us = (card->csd.taac_ns / 1000) * mult;
 
 		/*
 		 * ios.clock is only a target.  The real clock rate might be
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4ffea14..adb5c88 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -41,11 +41,11 @@
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
 
-static const unsigned int tacc_exp[] = {
+static const unsigned int taac_exp[] = {
 	1,	10,	100,	1000,	10000,	100000,	1000000, 10000000,
 };
 
-static const unsigned int tacc_mant[] = {
+static const unsigned int taac_mant[] = {
 	0,	10,	12,	13,	15,	20,	25,	30,
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
@@ -153,8 +153,8 @@ static int mmc_decode_csd(struct mmc_card *card)
 	csd->mmca_vsn	 = UNSTUFF_BITS(resp, 122, 4);
 	m = UNSTUFF_BITS(resp, 115, 4);
 	e = UNSTUFF_BITS(resp, 112, 3);
-	csd->tacc_ns	 = (tacc_exp[e] * tacc_mant[m] + 9) / 10;
-	csd->tacc_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
+	csd->taac_ns	 = (taac_exp[e] * taac_mant[m] + 9) / 10;
+	csd->taac_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
 
 	m = UNSTUFF_BITS(resp, 99, 4);
 	e = UNSTUFF_BITS(resp, 96, 3);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index a1b0aa1..4fd1620 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -39,11 +39,11 @@
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
 
-static const unsigned int tacc_exp[] = {
+static const unsigned int taac_exp[] = {
 	1,	10,	100,	1000,	10000,	100000,	1000000, 10000000,
 };
 
-static const unsigned int tacc_mant[] = {
+static const unsigned int taac_mant[] = {
 	0,	10,	12,	13,	15,	20,	25,	30,
 	35,	40,	45,	50,	55,	60,	70,	80,
 };
@@ -111,8 +111,8 @@ static int mmc_decode_csd(struct mmc_card *card)
 	case 0:
 		m = UNSTUFF_BITS(resp, 115, 4);
 		e = UNSTUFF_BITS(resp, 112, 3);
-		csd->tacc_ns	 = (tacc_exp[e] * tacc_mant[m] + 9) / 10;
-		csd->tacc_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
+		csd->taac_ns	 = (taac_exp[e] * taac_mant[m] + 9) / 10;
+		csd->taac_clks	 = UNSTUFF_BITS(resp, 104, 8) * 100;
 
 		m = UNSTUFF_BITS(resp, 99, 4);
 		e = UNSTUFF_BITS(resp, 96, 3);
@@ -148,8 +148,8 @@ static int mmc_decode_csd(struct mmc_card *card)
 		 */
 		mmc_card_set_blockaddr(card);
 
-		csd->tacc_ns	 = 0; /* Unused */
-		csd->tacc_clks	 = 0; /* Unused */
+		csd->taac_ns	 = 0; /* Unused */
+		csd->taac_clks	 = 0; /* Unused */
 
 		m = UNSTUFF_BITS(resp, 99, 4);
 		e = UNSTUFF_BITS(resp, 96, 3);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 46c73e9..279b390 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -29,8 +29,8 @@ struct mmc_csd {
 	unsigned char		structure;
 	unsigned char		mmca_vsn;
 	unsigned short		cmdclass;
-	unsigned short		tacc_clks;
-	unsigned int		tacc_ns;
+	unsigned short		taac_clks;
+	unsigned int		taac_ns;
 	unsigned int		c_size;
 	unsigned int		r2w_factor;
 	unsigned int		max_dtr;
-- 
1.9.1


