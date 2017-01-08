From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/8] mmc-core: Use kmalloc_array() in mmc_test_area_init()
Date: Sun, 8 Jan 2017 22:42:11 +0100
Message-ID: <a9b14d1d-de5c-5a22-fcd0-021d7b01cb36@users.sourceforge.net>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Linus Walleij <linus.walleij@linaro.org>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 8 Jan 2017 18:44:26 +0100

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/core/mmc_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 3ab6e52d106c..e85ef503d7ce 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -1579,7 +1579,7 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
 	if (!t->mem)
 		return -ENOMEM;
 
-	t->sg = kmalloc(sizeof(struct scatterlist) * t->max_segs, GFP_KERNEL);
+	t->sg = kmalloc_array(t->max_segs, sizeof(*t->sg), GFP_KERNEL);
 	if (!t->sg) {
 		ret = -ENOMEM;
 		goto out_free;
-- 
2.11.0
