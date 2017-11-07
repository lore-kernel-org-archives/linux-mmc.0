From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/6] mmc: tmio, renesas_shci: cleanups, core code change for new driver
Date: Tue,  7 Nov 2017 17:09:26 +0900
Message-ID: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:24879 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932418AbdKGIKx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Nov 2017 03:10:53 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


When I was implementing my dirver, I just noticed some candidates
for cleanups.  Some are required changes for my driver.



Masahiro Yamada (6):
  mmc: renesas_sdhc: remove eprobe jump label
  mmc: tmio: set tmio_mmc_host to driver data
  mmc: tmio: use devm_ioremap_resource() instead of devm_ioremap()
  mmc: tmio: move mmc_host_ops to struct tmio_mmc_host from static data
  mmc: tmio, renesas_sdhi: set mmc_host_ops hooks directly
  mmc: tmio: move mmc_of_parse() out of tmio_mmc_host_probe()

 drivers/mmc/host/renesas_sdhi_core.c | 24 ++++++++++++------------
 drivers/mmc/host/tmio_mmc.c          | 16 ++++++++--------
 drivers/mmc/host/tmio_mmc.h          |  4 +---
 drivers/mmc/host/tmio_mmc_core.c     | 31 +++++++++----------------------
 4 files changed, 30 insertions(+), 45 deletions(-)

-- 
2.7.4

