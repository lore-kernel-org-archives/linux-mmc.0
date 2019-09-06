From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 0/4] Add MMC virtual command queue support
Date: Fri,  6 Sep 2019 11:51:58 +0800
Message-ID: <cover.1567740135.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, baolin.wang@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi All,

Now the MMC read/write stack will always wait for previous request is
completed by mmc_blk_rw_wait(), before sending a new request to hardware,
or queue a work to complete request, that will bring context switching
overhead, especially for high I/O per second rates, to affect the IO
performance.

Thus this patch set will introduce the virtual command queue support,
and set the queue depth as 2, that means we do not need wait for previous
request is completed and can queue 2 requests in flight. It is enough to
let the irq handler always trigger the next request without a context
switch and then ask the blk_mq layer for the next one to get queued,
as well as avoiding a long latency.

Moreover we can expand the virtual command queue interface to support
MMC packed request or packed command instead of adding new interfaces,
according to previosus discussion.

Below are some comparison data with fio tool. The fio command I used
is like below with changing the '--rw' parameter and enabling the direct
IO flag to measure the actual hardware transfer speed in 4K block size.

./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read

My eMMC card working at HS400 Enhanced strobe mode:
[    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB 
[    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
[    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
[    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)

1. Without virtual command queue
I tested 3 times for each case and output a average speed.

1) Sequential read:
Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
Average speed: 28.7MiB/s

2) Random read:
Speed: 18.2MiB/s, 8.9MiB/s, 15.8MiB/s
Average speed: 14.3MiB/s

3) Sequential write:
Speed: 21.1MiB/s, 27.9MiB/s, 25MiB/s
Average speed: 24.7MiB/s

4) Random write:
Speed: 21.5MiB/s, 18.1MiB/s, 18.1MiB/s
Average speed: 19.2MiB/s

2. With virtual command queue
I tested 3 times for each case and output a average speed.

1) Sequential read:
Speed: 44.1MiB/s, 42.3MiB/s, 44.4MiB/s
Average speed: 43.6MiB/s

2) Random read:
Speed: 30.6MiB/s, 30.9MiB/s, 30.5MiB/s
Average speed: 30.6MiB/s

3) Sequential write:
Speed: 44.1MiB/s, 45.9MiB/s, 44.2MiB/s
Average speed: 44.7MiB/s

4) Random write:
Speed: 45.1MiB/s, 43.3MiB/s, 42.4MiB/s
Average speed: 43.6MiB/s

Form above data, we can see the virtual command queue can help to improve the
performance obviously.

Any comments are welcome. Thanks a lot.

Baolin Wang (4):
  mmc: host: cqhci: Move the struct cqhci_slot into header file
  mmc: Add virtual command queue support
  mmc: host: sdhci-sprd: Add virtual command queue support
  mmc: host: sdhci: Add virtual command queue support

 drivers/mmc/core/block.c      |   62 ++++++++
 drivers/mmc/core/mmc.c        |   13 +-
 drivers/mmc/core/queue.c      |   25 ++-
 drivers/mmc/host/Kconfig      |    9 ++
 drivers/mmc/host/Makefile     |    1 +
 drivers/mmc/host/cqhci-virt.c |  346 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.c      |   10 --
 drivers/mmc/host/cqhci.h      |   45 +++++-
 drivers/mmc/host/sdhci-sprd.c |   16 ++
 drivers/mmc/host/sdhci.c      |    7 +-
 include/linux/mmc/host.h      |    1 +
 11 files changed, 512 insertions(+), 23 deletions(-)
 create mode 100644 drivers/mmc/host/cqhci-virt.c

-- 
1.7.9.5
