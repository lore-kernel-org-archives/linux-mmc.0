From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 0/6] mmc: sdhci-s3c: Fix base clock source management
Date: Sat, 11 Jan 2014 22:39:00 +0100
Message-ID: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On platforms prior to Exynos the SDHCI block used internal clock
divider controlled by SELFREQ field of CLKCON register to divide base
clock selected from several external clocks fed to the block by
SELBASECLK bitfield of CONTROL2 register. Depending on wanted clock
frequency, different external clock may be the best choice and so
the driver needs to switch the SELBASECLK mux on the fly.

However the selection logic has been broken for quite some time leaving
the controller using always clock 0, which is not always the right
source and leading to suboptimal performance of the SDHCI block on
affected platforms.

This series intends to fix the problems mentioned above and also clean-up
clock management code slightly.

Tested on S3C6410-based Mini6410 board, with following performance
figures:

* Before this series (133 MHz HCLK always selected, leading to at most
  33 MHz card clock):

root@tiny6410:~# hdparm -t /dev/mmcblk0

/dev/mmcblk0:
 Timing buffered disk reads:  42 MB in  3.10 seconds =  13.54 MB/sec
root@tiny6410:~# hdparm -t /dev/mmcblk0

/dev/mmcblk0:
 Timing buffered disk reads:  44 MB in  3.11 seconds =  14.14 MB/sec
root@tiny6410:~#

* After this series (48 MHz EPLL clock selected, leading to 48 MHz card
  clock):

root@tiny6410:~# hdparm -t /dev/mmcblk0 

/dev/mmcblk0:
 Timing buffered disk reads:  56 MB in  3.04 seconds =  18.41 MB/sec
root@tiny6410:~# hdparm -t /dev/mmcblk0

/dev/mmcblk0:
 Timing buffered disk reads:  60 MB in  3.06 seconds =  19.63 MB/sec
root@tiny6410:~#

Tomasz Figa (6):
  mmc: sdhci-s3c: Use shifts to divide by powers of two
  mmc: sdhci-s3c: Cache bus clock rates
  mmc: sdhci-s3c: Use correct condition to check for clock presence
  mmc: sdhci-s3c: Simplify min/max clock calculation
  mmc: sdhci-s3c: Fix handling of bus clock switching
  mmc: sdhci-s3c: Do not allow frequencies higher than requested

 drivers/mmc/host/sdhci-s3c.c | 170 ++++++++++++++++++++-----------------------
 1 file changed, 77 insertions(+), 93 deletions(-)

-- 
1.8.5.2
