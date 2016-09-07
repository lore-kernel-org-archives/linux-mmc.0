From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v5 1/2] mmc: core: Factor out the alignment of erase size
Date: Wed,  7 Sep 2016 10:38:24 +0800
Message-ID: <48ff46b96e01df36aa5d1c2daf1091d2ec2e729f.1473215578.git.baolin.wang@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36288 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932687AbcIGCjN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2016 22:39:13 -0400
Received: by mail-pa0-f52.google.com with SMTP id id6so1036698pad.3
        for <linux-mmc@vger.kernel.org>; Tue, 06 Sep 2016 19:39:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com, dianders@chromium.org, heiko@sntech.de, david@protonic.nl, hdegoede@redhat.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linus.walleij@linaro.org, baolin.wang@linaro.org

In order to clean up the mmc_erase() function and do some optimization
for erase size alignment, factor out the guts of erase size alignment
into mmc_align_erase_size() function.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Changes since v4:
 - Abandon the patch removing the checking if mmc can erase.
 - Add missing validations in mmc_erase().

Changes since v3:
 - Split into 3 separate patches.
 - Add test tag by Shawn.

Changes since v2:
 - Add nr checking and other optimization in mmc_erase() function.

Changes since v1:
 - Add the alignment if card->erase_size is not power of 2.
---
 drivers/mmc/core/core.c |   48 +++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e55cde6..11b4897 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2202,6 +2202,36 @@ out:
 	return err;
 }
 
+static unsigned int mmc_align_erase_size(struct mmc_card *card,
+					 unsigned int *from,
+					 unsigned int *to,
+					 unsigned int nr)
+{
+	unsigned int from_new = *from, nr_new = nr, rem;
+
+	rem = from_new % card->erase_size;
+	if (rem) {
+		rem = card->erase_size - rem;
+		from_new += rem;
+		if (nr_new > rem)
+			nr_new -= rem;
+		else
+			return 0;
+	}
+
+	rem = nr_new % card->erase_size;
+	if (rem)
+		nr_new -= rem;
+
+	if (nr_new == 0)
+		return 0;
+
+	*to = from_new + nr_new;
+	*from = from_new;
+
+	return nr_new;
+}
+
 /**
  * mmc_erase - erase sectors.
  * @card: card to erase
@@ -2240,26 +2270,12 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 			return -EINVAL;
 	}
 
-	if (arg == MMC_ERASE_ARG) {
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
-	}
+	if (arg == MMC_ERASE_ARG)
+		nr = mmc_align_erase_size(card, &from, &to, nr);
 
 	if (nr == 0)
 		return 0;
 
-	to = from + nr;
-
 	if (to <= from)
 		return -EINVAL;
 
-- 
1.7.9.5

