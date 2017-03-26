From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 0/2] mmc: factor out getting dma direction from host
 drivers
Date: Sun, 26 Mar 2017 20:39:46 +0200
Message-ID: <d3d01681-9456-0800-733f-369f6d3a26be@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34902 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdCZSjx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Mar 2017 14:39:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id p52so3866788wrc.2
        for <linux-mmc@vger.kernel.org>; Sun, 26 Mar 2017 11:39:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Several host drivers contain identical code for determining the
DMA direction. Therefore factor this out to the core.

v2:
- use new function in more new places
v3:
- fix a compile error in change to atmel driver

Heiner Kallweit (2):
  mmc: core: add mmc_get_dma_dir
  mmc: use new core function mmc_get_dma_dir

 drivers/mmc/host/android-goldfish.c | 10 ++--------
 drivers/mmc/host/atmel-mci.c        | 30 +++++++++++-------------------
 drivers/mmc/host/davinci_mmc.c      | 14 ++++----------
 drivers/mmc/host/dw_mmc.c           | 14 +++-----------
 drivers/mmc/host/jz4740_mmc.c       |  9 ++-------
 drivers/mmc/host/mmc_spi.c          |  5 +----
 drivers/mmc/host/mmci.c             | 20 ++++++++------------
 drivers/mmc/host/moxart-mmc.c       |  8 +++-----
 drivers/mmc/host/mtk-sd.c           |  8 ++------
 drivers/mmc/host/mvsdio.c           | 11 +++++------
 drivers/mmc/host/omap_hsmmc.c       | 17 ++++-------------
 drivers/mmc/host/s3cmci.c           |  4 ++--
 drivers/mmc/host/sdhci.c            |  9 +++------
 drivers/mmc/host/sunxi-mmc.c        | 14 +++-----------
 include/linux/mmc/host.h            |  6 ++++++
 15 files changed, 59 insertions(+), 120 deletions(-)

-- 
2.12.0


