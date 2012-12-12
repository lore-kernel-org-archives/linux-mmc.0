From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 00/14] mmc: sh-mmcif: 3.8 fixes and improvements
Date: Wed, 12 Dec 2012 15:38:04 +0100
Message-ID: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

This patch series fixes several bugs in the sh_mmcif.c driver, that showed 
up on SMP with DMA (patches 10, 13), adds new features (3, 4) and adds 
multiple further improvements and minor fixes. Even though these bugs 
currently exist in the mainline, this patch series is not considered to 
be suitable for @stable. Patches are rather experimental and it is better 
to test them over a complete development cycle. They also are easier 
implemented on top of preparatory cosmetic patches.

Guennadi Liakhovetski (6):
  mmc: sh-mmcif: fix missing and consolidate IO completion timeouts
  mmc: sh-mmcif: (cosmetic) simplify boolean return blocks
  mmc: sh-mmcif: fix a race, causing an Oops on SMP
  mmc: sh-mmcif: reset error code for any opcode
  mmc: sh-mmcif: reset DMA completion immediately before starting DMA
  mmc: sh-mmcif: fix I/O errors

Shinya Kuribayashi (1):
  mmc: sh_mmcif: add support for bundled MMCIF IRQs

Teppei Kamijou (7):
  mmc: sh_mmcif: force to fail CMD52 immediately
  mmc: sh_mmcif: ensure run-time suspend call is processed before
    suspend
  mmc: sh_mmcif: Add support for eMMC Dual Data Rate
  mmc: sh_mmcif: Use msecs_to_jiffies() for host->timeout
  mmc: sh_mmcif: Avoid unnecessary mmc_delay() at mmc_card_sleepawake()
  mmc: sh-mmcif: Terminate DMA transactions when detecting timeout or
    error
  mmc: sh-mmcif: report all errors

 drivers/mmc/host/sh_mmcif.c |  215 +++++++++++++++++++++++++++++--------------
 1 files changed, 145 insertions(+), 70 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
