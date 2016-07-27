From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2] mmc: core: Optimize the mmc erase size alignment
Date: Wed, 27 Jul 2016 15:17:27 +0800
Message-ID: <5117da51a7f11a16a8d10af060e2123f0d0a3ae8.1469603653.git.baolin.wang@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36137 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbcG0HRs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 03:17:48 -0400
Received: by mail-pf0-f173.google.com with SMTP id h186so8046598pfg.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 00:17:47 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com, dianders@chromium.org, heiko@sntech.de, david@protonic.nl, hdegoede@redhat.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linus.walleij@linaro.org, baolin.wang@linaro.org

Before issuing mmc_erase() function, users always have checked if it can
erase with mmc_can_erase/trim/discard() function, thus remove the redundant
erase checking in mmc_erase() function.

This patch also optimizes the erase start/end sector alignment with
round_up()/round_down() function, when erase command is MMC_ERASE_ARG.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - Add the alignment if card->erase_size is not power of 2.
---
 drivers/mmc/core/core.c |   78 +++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b4c08d1a..303a917 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2195,6 +2195,51 @@ out:
 	return err;
 }
 
+static unsigned int mmc_align_erase_size(struct mmc_card *card,
+					 unsigned int *from,
+					 unsigned int *to,
+					 unsigned int nr)
+{
+	unsigned int from_new = *from, nr_new = nr, rem;
+
+	if (is_power_of_2(card->erase_size)) {
+		unsigned int temp = from_new;
+
+		from_new = round_up(temp, card->erase_size);
+		rem = from_new - temp;
+
+		if (nr_new > rem)
+			nr_new -= rem;
+		else
+			return 0;
+
+		nr_new = round_down(nr_new, card->erase_size);
+	} else {
+		rem = from_new % card->erase_size;
+		if (rem) {
+			rem = card->erase_size - rem;
+			from_new += rem;
+			if (nr_new > rem)
+				nr_new -= rem;
+			else
+				return 0;
+		}
+
+		rem = nr_new % card->erase_size;
+		if (rem)
+			nr_new -= rem;
+	}
+
+	if (nr_new == 0)
+		return 0;
+
+	/* 'from' and 'to' are inclusive */
+	*to = from_new + nr_new - 1;
+	*from = from_new;
+
+	return nr_new;
+}
+
 /**
  * mmc_erase - erase sectors.
  * @card: card to erase
@@ -2210,13 +2255,6 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	unsigned int rem, to = from + nr;
 	int err;
 
-	if (!(card->host->caps & MMC_CAP_ERASE) ||
-	    !(card->csd.cmdclass & CCC_ERASE))
-		return -EOPNOTSUPP;
-
-	if (!card->erase_size)
-		return -EOPNOTSUPP;
-
 	if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
 		return -EOPNOTSUPP;
 
@@ -2234,31 +2272,11 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	}
 
 	if (arg == MMC_ERASE_ARG) {
-		rem = from % card->erase_size;
-		if (rem) {
-			rem = card->erase_size - rem;
-			from += rem;
-			if (nr > rem)
-				nr -= rem;
-			else
-				return 0;
-		}
-		rem = nr % card->erase_size;
-		if (rem)
-			nr -= rem;
+		rem = mmc_align_erase_size(card, &from, &to, nr);
+		if (rem == 0)
+			return 0;
 	}
 
-	if (nr == 0)
-		return 0;
-
-	to = from + nr;
-
-	if (to <= from)
-		return -EINVAL;
-
-	/* 'from' and 'to' are inclusive */
-	to -= 1;
-
 	/*
 	 * Special case where only one erase-group fits in the timeout budget:
 	 * If the region crosses an erase-group boundary on this particular
-- 
1.7.9.5

