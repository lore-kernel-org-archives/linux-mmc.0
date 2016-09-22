From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH PoC 0/7] mmc: switch to blk-mq
Date: Thu, 22 Sep 2016 15:57:03 +0200
Message-ID: <1474552630-28314-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>, Omar Sandoval <osandov@osandov.com>, Christoph Hellwig <hch@lst.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi,

Since Linus Walleij is also working on that and I won't
probably have time to touch this code till the end of
upcoming month, here it is (basically a code dump of my
proof-of-concept work).  I hope that it would be useful
to somebody.

It is extremely ugly & full of bogus debug code but boots
fine on my Odroid-XU3 and benchmarks can be run.

The patchset is based on top of patches up to "[PATCH v3
24/30] mmc: block: Introduce queue semantics" patch from
"[PATCH V3 00/30] mmc: mmc: dd Software Command Queuing"
series by Adrian Hunter:

  http://www.spinics.net/lists/linux-mmc/msg38013.html

[ It was commmit f3ba397441825f99edb4833a5f52dd2355d253c7
  in swcmdq branch from:

  http://git.infradead.org/users/ahunter/linux-sdhci.git

  Unfortunalty it got rebased later to V4 -- my patchset
  probably still applies and works fine but I have not
  tested this yet. ]

PS Linus, I got async requests support working, see patch #7.
You may be able to use this method depending on the hackiness
level of your patches. ;)


Initial benchmark results:

   root@target:~# time dd if=/dev/mmcblk0 of=/dev/null bs=4k

   vanilla - performance governor - 1300MHz/1800MHz
   15758000128 bytes (16 GB) copied, 69.8334 s, 226 MB/s

   blk-mq - performance governor - 1300MHz/1800MHz
   15758000128 bytes (16 GB) copied, 79.0868 s, 199 MB/s

   vanilla - performance governor - 200MHz/200MHz
   15758000128 bytes (16 GB) copied, 228.014 s, 69.1 MB/s

   blk-mq - performance governor - 200MHz/200MHz
   15758000128 bytes (16 GB) copied, 208.536 s, 75.6 MB/s

   vanilla - on-demand governor - 1300MHz/1800MHz
   15758000128 bytes (16 GB) copied, 77.0968 s, 204 MB/s

   blk-mq - on-demand governor - 1300/1800MHz
   15758000128 bytes (16 GB) copied, 96.351 s, 164 MB/s


   root@target:~# time dd if=/dev/mmcblk0 of=/dev/null

   vanilla - on-demand governor - 1300MHz/1800MHz
   15758000128 bytes (16 GB) copied, 155.149 s, 102 MB/s

   blk-mq - on-demand governor - 1300MHz/1800MHz
   15758000128 bytes (16 GB) copied, 106.122 s, 148 MB/s


Bartlomiej Zolnierkiewicz (7):
  mmc-mq: add debug printks
  mmc-mq: remove async requests support
  mmc-mq: request completion fixes
  mmc-mq: implement checking for queue busy condition
  mmc-mq: remove some debug printks
  mmc-mq: initial blk-mq support
  mmc-mq: async request support for blk-mq mode

 drivers/mmc/card/block.c    | 174 +++++++++++++-------------
 drivers/mmc/card/mmc_test.c |   8 +-
 drivers/mmc/card/queue.c    | 262 ++++++++++++++++++++++++++------------
 drivers/mmc/card/queue.h    |  50 +++++++-
 drivers/mmc/core/bus.c      |   2 -
 drivers/mmc/core/core.c     | 299 +++++++++++++++++++++++++++++---------------
 drivers/mmc/core/core.h     |   2 -
 drivers/mmc/core/mmc_ops.c  |   9 ++
 drivers/mmc/host/dw_mmc.c   |   3 +-
 include/linux/mmc/card.h    |   1 -
 include/linux/mmc/core.h    |   6 +-
 include/linux/mmc/host.h    |  15 ---
 12 files changed, 529 insertions(+), 302 deletions(-)

-- 
1.9.1
