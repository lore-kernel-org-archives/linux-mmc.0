From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: reduce nesting and join error strings into one line
Date: Tue,  9 Feb 2016 20:43:11 +0900
Message-ID: <1455018191-8545-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

No reason to use the double "if" nesting.  This fix allows to move
the nested block to the left and tidy up the error message without
80-col overflow.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/core/mmc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index bf49e44..3789a50 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -345,14 +345,14 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 
 	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
 	card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
-	if (card->csd.structure == 3) {
-		if (card->ext_csd.raw_ext_csd_structure > 2) {
-			pr_err("%s: unrecognised EXT_CSD structure "
-				"version %d\n", mmc_hostname(card->host),
-					card->ext_csd.raw_ext_csd_structure);
-			err = -EINVAL;
-			goto out;
-		}
+
+	if (card->csd.structure == 3 &&
+	    card->ext_csd.raw_ext_csd_structure > 2) {
+		pr_err("%s: unrecognised EXT_CSD structure version %d\n",
+		       mmc_hostname(card->host),
+		       card->ext_csd.raw_ext_csd_structure);
+		err = -EINVAL;
+		goto out;
 	}
 
 	np = mmc_of_find_child_device(card->host, 0);
-- 
1.9.1
