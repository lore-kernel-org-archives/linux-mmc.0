From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/6] mmc: tmio/sdhi: clean up cruft
Date: Wed,  6 Apr 2016 11:25:28 +0200
Message-ID: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Largely due to DT unification, some parts of the code became obsolete. Let's
remove that, the code is complex enough still:

* There are no boards anymore with named interrupt support. Drop support for
  that (patches 2-4)
* No need anymore for a public mmc/tmio.h header file. Merge it into the
  private one (patch 5)

Patches 1+6 are small cleanups found on the way :)

Based on latest renesas-drivers which is based on v4.6-rc1 with my sdr50
patches on top. Tested on a Renesas Lager board and build bot is happy, too
(after finding some issues initially). A branch for testing is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi-uhs

I'd think this should all go via mmc, so an ACK from a sh-maintainer on patch 2
would be much appreciated.

Please test, comment, apply...

   Wolfram


Wolfram Sang (6):
  mmc: sh_mobile_sdhi: don't use array for DT configs
  mmc: sh_mobile_sdhi: remove obsolete irq_by_name registration
  mmc: tmio: remove now unneeded seperate irq handlers
  mmc: tmio: simplify irq handler
  mmc: tmio: merge distributed include files
  mmc: sh_mobile_sdhi: simplify code for voltage switching

 arch/sh/boards/board-sh7757lcr.c     |  1 -
 arch/sh/boards/mach-ap325rxa/setup.c |  1 -
 arch/sh/boards/mach-ecovec24/setup.c |  1 -
 arch/sh/boards/mach-kfr2r09/setup.c  |  1 -
 arch/sh/boards/mach-migor/setup.c    |  1 -
 arch/sh/boards/mach-se/7724/setup.c  |  1 -
 drivers/mmc/host/sh_mobile_sdhi.c    | 75 +++++++-----------------------------
 drivers/mmc/host/tmio_mmc.h          | 59 ++++++++++++++++++++++++++--
 drivers/mmc/host/tmio_mmc_dma.c      |  1 -
 drivers/mmc/host/tmio_mmc_pio.c      | 55 +++++---------------------
 include/linux/mmc/sh_mobile_sdhi.h   | 10 -----
 include/linux/mmc/tmio.h             | 73 -----------------------------------
 12 files changed, 79 insertions(+), 200 deletions(-)
 delete mode 100644 include/linux/mmc/sh_mobile_sdhi.h
 delete mode 100644 include/linux/mmc/tmio.h

-- 
2.7.0

