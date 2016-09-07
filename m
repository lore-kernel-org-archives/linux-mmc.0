From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v5 2/2] mmc: core: Optimize the mmc erase size alignment
Date: Wed,  7 Sep 2016 10:38:25 +0800
Message-ID: <bc52ccbc0c22e2d2f795d75faf748e4e68900e51.1473215578.git.baolin.wang@linaro.org>
References: <48ff46b96e01df36aa5d1c2daf1091d2ec2e729f.1473215578.git.baolin.wang@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33057 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932768AbcIGCjT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2016 22:39:19 -0400
Received: by mail-pf0-f179.google.com with SMTP id g202so1145808pfb.0
        for <linux-mmc@vger.kernel.org>; Tue, 06 Sep 2016 19:39:18 -0700 (PDT)
In-Reply-To: <48ff46b96e01df36aa5d1c2daf1091d2ec2e729f.1473215578.git.baolin.wang@linaro.org>
In-Reply-To: <48ff46b96e01df36aa5d1c2daf1091d2ec2e729f.1473215578.git.baolin.wang@linaro.org>
References: <48ff46b96e01df36aa5d1c2daf1091d2ec2e729f.1473215578.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com, dianders@chromium.org, heiko@sntech.de, david@protonic.nl, hdegoede@redhat.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linus.walleij@linaro.org, baolin.wang@linaro.org

In most cases the 'card->erase_size' is power of 2, then the round_up/down()
function is more efficient than '%' operation when the 'card->erase_size' is
power of 2.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/core/core.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 11b4897..4264ac6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2209,19 +2209,37 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
 {
 	unsigned int from_new = *from, nr_new = nr, rem;
 
-	rem = from_new % card->erase_size;
-	if (rem) {
-		rem = card->erase_size - rem;
-		from_new += rem;
+	/*
+	 * When the 'card->erase_size' is power of 2, we can use round_up/down()
+	 * to align the erase size efficiently.
+	 */
+	if (is_power_of_2(card->erase_size)) {
+		unsigned int temp = from_new;
+
+		from_new = round_up(temp, card->erase_size);
+		rem = from_new - temp;
+
 		if (nr_new > rem)
 			nr_new -= rem;
 		else
 			return 0;
-	}
 
-	rem = nr_new % card->erase_size;
-	if (rem)
-		nr_new -= rem;
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
 
 	if (nr_new == 0)
 		return 0;
-- 
1.7.9.5

