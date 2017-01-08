From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/8] mmc-core: Fix a typo in a comment line
Date: Sun, 8 Jan 2017 22:43:33 +0100
Message-ID: <8d856fe0-76cd-b226-9ef3-51b07af47223@users.sourceforge.net>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Linus Walleij <linus.walleij@linaro.org>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 8 Jan 2017 19:05:37 +0100

Add a missing character in the function description.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/core/mmc_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index e85ef503d7ce..2f838a13a904 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -1533,7 +1533,7 @@ static int mmc_test_area_cleanup(struct mmc_test_card *test)
 
 /*
  * Initialize an area for testing large transfers.  The test area is set to the
- * middle of the card because cards may have different charateristics at the
+ * middle of the card because cards may have different characteristics at the
  * front (for FAT file system optimization).  Optionally, the area is erased
  * (if the card supports it) which may improve write performance.  Optionally,
  * the area is filled with data for subsequent read tests.
-- 
2.11.0

