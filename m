From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] mmc: factor out getting dma direction from host drivers
Date: Thu, 23 Mar 2017 22:17:41 +0100
Message-ID: <44d784c1-ab30-db59-9037-db8c87935b43@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36880 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932783AbdCWVR5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2017 17:17:57 -0400
Received: by mail-wm0-f42.google.com with SMTP id n11so6923552wma.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2017 14:17:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Several host drivers contain identical code for determining the
DMA direction. Therefore factor this out to the core.

Heiner Kallweit (2):
  mmc: core: add mmc_get_dma_dir
  mmc: use new core function mmc_get_dma_dir

 drivers/mmc/host/android-goldfish.c | 10 ++--------
 drivers/mmc/host/atmel-mci.c        |  6 ++----
 drivers/mmc/host/davinci_mmc.c      | 10 +++-------
 drivers/mmc/host/dw_mmc.c           | 14 +++-----------
 drivers/mmc/host/jz4740_mmc.c       |  9 ++-------
 drivers/mmc/host/mmc_spi.c          |  5 +----
 drivers/mmc/host/mtk-sd.c           |  8 ++------
 drivers/mmc/host/mvsdio.c           | 11 +++++------
 drivers/mmc/host/omap_hsmmc.c       | 17 ++++-------------
 drivers/mmc/host/s3cmci.c           |  4 ++--
 drivers/mmc/host/sdhci.c            |  9 +++------
 drivers/mmc/host/sunxi-mmc.c        | 14 +++-----------
 include/linux/mmc/host.h            |  6 ++++++
 13 files changed, 38 insertions(+), 85 deletions(-)

-- 
2.12.0

