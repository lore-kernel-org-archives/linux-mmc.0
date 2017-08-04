From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 00/14] mmc: meson-gx: driver fixups and upgrade
Date: Fri,  4 Aug 2017 19:43:39 +0200
Message-ID: <20170804174353.16486-1-jbrunet@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:37826 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbdHDRoB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Aug 2017 13:44:01 -0400
Received: by mail-wr0-f176.google.com with SMTP id 33so19261386wrz.4
        for <linux-mmc@vger.kernel.org>; Fri, 04 Aug 2017 10:44:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The patchset features several bugfixes, rework and upgrade for the
meson-gx MMC driver.

The main goal is to improve readability and enable new high speed
modes, such as eMMC DDR52 and sdcard UHS modes up to SDR50 (100Mhz)

While full speed SDR104 is stable with most cards, a few seems to
require an even more precise tuning. For this, we'll probably have
to implement per-line delay calibration.

This series has been tested on gxbb-p200, gxbb-nanopi-k2 and
gxl-s905x-libretech

Jerome Brunet (14):
  mmc: meson-gx: fix mux mask definition
  mmc: meson-gx: remove CLK_DIVIDER_ALLOW_ZERO clock flag
  mmc: meson-gx: clean up some constants
  mmc: meson-gx: use _irqsave variant of spinlock
  mmc: meson-gx: cfg init overwrite values
  mmc: meson-gx: rework set_ios function
  mmc: meson-gx: rework clk_set function
  mmc: meson-gx: rework clock init function
  mmc: meson-gx: simplify interrupt handler
  mmc: meson-gx: implement card_busy callback
  mmc: meson-gx: rework tuning function
  mmc: meson-gx: fix dual data rate mode frequencies
  mmc: meson-gx: work around clk-stop issue
  mmc: meson-gx: implement voltage switch callback

 drivers/mmc/host/meson-gx-mmc.c | 611 ++++++++++++++++++++++++++--------------
 1 file changed, 396 insertions(+), 215 deletions(-)

-- 
2.9.4

