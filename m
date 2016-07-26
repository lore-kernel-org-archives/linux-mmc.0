From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH] mmc: core: Optimize the mmc erase size alignment
Date: Tue, 26 Jul 2016 19:27:36 +0800
Message-ID: <0366906585240f8123e889527f9eac1e37f9f3d0.1469532291.git.baolin.wang@linaro.org>
References: <y>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36569 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802AbcGZL15 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2016 07:27:57 -0400
Received: by mail-pf0-f176.google.com with SMTP id h186so74584853pfg.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jul 2016 04:27:56 -0700 (PDT)
In-Reply-To: <y>
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
 drivers/mmc/core/core.c |   58 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b4c08d1a..4dd333e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2195,6 +2195,31 @@ out:
 	return err;
 }
 
+static unsigned int mmc_align_erase_size(struct mmc_card *card,
+					 unsigned int *from,
+					 unsigned int *to,
+					 unsigned int nr)
+{
+	unsigned int from_old = *from, nr_old = nr;
+	unsigned int from_new, nr_new;
+
+	from_new = round_up(from_old, card->erase_size);
+	if (nr_old > from_new - from_old)
+		nr_old -= from_new - from_old;
+	else
+		return 0;
+
+	nr_new = round_down(nr_old, card->erase_size);
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
@@ -2210,13 +2235,6 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
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
 
@@ -2234,31 +2252,11 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
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

