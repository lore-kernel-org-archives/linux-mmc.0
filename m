From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ms_block: fix spelling mistake "randomally" -> "randomly"
Date: Wed, 11 Sep 2019 11:33:57 +0100
Message-ID: <20190911103357.1744-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dbg_verbose message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/memstick/core/ms_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 384927ebde74..d9ee8e3dc72d 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1087,7 +1087,7 @@ static u16 msb_get_free_block(struct msb_data *msb, int zone)
 
 	pos %= msb->free_block_count[zone];
 
-	dbg_verbose("have %d choices for a free block, selected randomally: %d",
+	dbg_verbose("have %d choices for a free block, selected randomly: %d",
 		msb->free_block_count[zone], pos);
 
 	pba = find_next_zero_bit(msb->used_blocks_bitmap,
-- 
2.20.1
