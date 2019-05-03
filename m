From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: block: Fix memory leak in blk-mq when cleaning up
Date: Fri,  3 May 2019 16:35:26 -0700
Message-ID: <20190503233526.226272-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-rockchip@lists.infradead.org, groeck@chromium.org, mka@chromium.org, drinkcat@chromium.org, Douglas Anderson <dianders@chromium.org>, Ming Lei <ming.lei@redhat.com>, linux-mmc@vger.kernel.org, Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
List-Id: linux-mmc@vger.kernel.org

If I run the following on rk3288-veyron-minnie (a 2GB machine)

  cd /sys/bus/platform/drivers/dwmmc_rockchip
  for i in $(seq 1 3000); do
    echo "========================" $i
    echo ff0f0000.dwmmc > unbind
    sleep .5
    echo ff0f0000.dwmmc > bind
    while true; do
      if [ -e /dev/mmcblk2 ]; then
        break;
      fi
      sleep .1
    done
  done

Then I start OOMing somewhere between iteration 200 and 250.  Using
kmemleak, I see reports like:

unreferenced object 0xe39c5580 (size 64):
  comm "kworker/1:0", pid 17, jiffies 4294821091 (age 96.952s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ad19d10a>] __kmalloc+0x1ec/0x2dc
    [<a28614c3>] blk_mq_alloc_tag_set+0x27c/0x2bc
    [<0955ae01>] mmc_init_queue+0xa8/0x2a8
    [<5102b986>] mmc_blk_alloc_req+0xf8/0x2d4
    [<f1c2214f>] mmc_blk_probe+0x4a8/0x6c0
    [<0dfdd9d5>] mmc_bus_probe+0x24/0x28

It's pretty clear that we're missing a call to blk_mq_free_tag_set().
Let's add it.

Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/core/queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 7c364a9c4eeb..09071e13282e 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -480,6 +480,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	 */
 	flush_work(&mq->complete_work);
 
+	blk_mq_free_tag_set(&mq->tag_set);
+
 	mq->card = NULL;
 }
 
-- 
2.21.0.1020.gf2820cf01a-goog
