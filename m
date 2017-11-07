From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/2] mmc: renesas_sdhi: clean-up and fix CONFIG stuff for renesas_sdhi
Date: Tue,  7 Nov 2017 16:57:20 +0900
Message-ID: <1510041442-15176-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org




Masahiro Yamada (2):
  mmc: renesas_sdhi: consilidate DMAC CONFIG options
  mmc: renesas_shci: remove wrong depends on to enable compile test

 drivers/mmc/host/Kconfig  | 5 ++---
 drivers/mmc/host/Makefile | 8 ++------
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
2.7.4
