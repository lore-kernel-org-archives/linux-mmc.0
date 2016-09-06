From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4 3/3] mmc: core: Optimize the mmc erase size alignment
Date: Tue,  6 Sep 2016 10:55:12 +0800
Message-ID: <8f20dfea761960fd9bbcb6a0ce3ae0178e039b31.1473130123.git.baolin.wang@linaro.org>
References: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
In-Reply-To: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
References: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com, dianders@chromium.org, heiko@sntech.de, david@protonic.nl, hdegoede@redhat.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linus.walleij@linaro.org, baolin.wang@linaro.org
List-Id: linux-mmc@vger.kernel.org

In most cases the 'card->erase_size' is power of 2, then the round_up/down()
function is more efficient than '%' operation when the 'card->erase_size' is
power of 2.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/core/core.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5f93eef..e014949 100644
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
