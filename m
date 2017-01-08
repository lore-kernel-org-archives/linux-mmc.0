From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 8/8] mmc-core: Use kmalloc_array() in mmc_alloc_sg()
Date: Sun, 8 Jan 2017 22:55:31 +0100
Message-ID: <a2c80b39-6f7e-81ad-01d2-fce831e6cd8c@users.sourceforge.net>
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
Date: Sun, 8 Jan 2017 22:10:40 +0100

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/core/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index a6496d8027bc..b1986622c60e 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -152,7 +152,7 @@ static struct scatterlist *mmc_alloc_sg(int sg_len, int *err)
 {
 	struct scatterlist *sg;
 
-	sg = kmalloc(sizeof(struct scatterlist)*sg_len, GFP_KERNEL);
+	sg = kmalloc_array(sg_len, sizeof(*sg), GFP_KERNEL);
 	if (!sg)
 		*err = -ENOMEM;
 	else {
-- 
2.11.0
