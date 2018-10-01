From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/2] mmc: tmio: remove confusing TMIO_MMC_HAVE_HIGH_REG flag
Date: Mon,  1 Oct 2018 21:31:00 +0900
Message-ID: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

CTL_SDIO_REGS is a register specific to tmio_mmc.c

Currently, we handle it in tmio_mmc_core.c, hence need
TMIO_MMC_HAVE_HIGH_REG flag to prevent the other platforms
from accessing to it.

We can just move CTL_SDIO_REGS to tmio_mmc.c
and delete the confusing TMIO_MMC_HAVE_HIGH_REG flag.



Masahiro Yamada (2):
  mmc: tmio: move MFD variant reset to a platform hook
  mmc: tmio: remove TMIO_MMC_HAVE_HIGH_REG flag

 drivers/mmc/host/tmio_mmc.c      | 16 ++++++++++++++--
 drivers/mmc/host/tmio_mmc.h      |  4 +---
 drivers/mmc/host/tmio_mmc_core.c |  7 +++----
 include/linux/mfd/tmio.h         |  7 -------
 4 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.7.4
