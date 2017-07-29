From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 00/12] constify mmc_host_ops structures
Date: Sat, 29 Jul 2017 07:59:29 +0200
Message-ID: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:52084 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750929AbdG2GY6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 29 Jul 2017 02:24:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mediatek@lists.infradead.org
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org


The mmc_host_ops structure is only stored in the ops field of an
mmc_host structure, which is declared as const.  Thus the mmc_host_ops
structure itself can be const.

Done with the help of Coccinelle.

---

 drivers/mmc/host/bcm2835.c     |    2 +-
 drivers/mmc/host/davinci_mmc.c |    2 +-
 drivers/mmc/host/moxart-mmc.c  |    2 +-
 drivers/mmc/host/mtk-sd.c      |    2 +-
 drivers/mmc/host/s3cmci.c      |    2 +-
 drivers/mmc/host/sdricoh_cs.c  |    2 +-
 drivers/mmc/host/sh_mmcif.c    |    2 +-
 drivers/mmc/host/sunxi-mmc.c   |    2 +-
 drivers/mmc/host/toshsd.c      |    2 +-
 drivers/mmc/host/usdhi6rol0.c  |    2 +-
 drivers/mmc/host/vub300.c      |    2 +-
 drivers/mmc/host/wmt-sdmmc.c   |    2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)
