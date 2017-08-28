From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 00/13] mmc: meson-gx: driver fixups and upgrades
Date: Mon, 28 Aug 2017 16:29:02 +0200
Message-ID: <20170828142915.27020-1-jbrunet@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:37102 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdH1O3U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Aug 2017 10:29:20 -0400
Received: by mail-wr0-f180.google.com with SMTP id n37so2156005wrf.4
        for <linux-mmc@vger.kernel.org>; Mon, 28 Aug 2017 07:29:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The patchset features several bugfixes, rework and upgrade for the
meson-gx MMC driver.

The main goal is to improve readability and enable new high speed
modes, such as eMMC DDR52 and sdcard UHS modes up to SDR50 (100Mhz)

SDR104 is not working with a few cards on the p200 and the
libretech-cc. I suspect that 200Mhz might be a bit too fast for the PCB
of these boards, adding noise to the signal and eventually breaking
the communication with some cards. The same cards are working well on a
laptop or the nanopi-k2 at 200Mhz.

This series has been tested on gxbb-p200, gxbb-nanopi-k2 and
gxl-s905x-libretech-cc

Changes since v2 [1]:
* Drop patches 1 to 3: Applied.
* Drop patch 4: Debug stuff which should not have been sent.
* Added fix to previous patch 3:
  If the clock register is not initialized before registering the clk
  with CCF, the framework will complain about an illegal divider value.
  This had gone unnoticed because it was later fixed by the clock init
  rework.

  Ulf, I know it is getting late but it would be nice if patch #1 of
  this v3 could go with 3 patches you already applied. The rest can
  wait for the following cycle.

Changes since v1 [0]:
* Reorder patches to have fixes first, then rework and finally
  enhancements.
* Use CCF to manage clock phases

[0]: https://lkml.kernel.org/r/20170804174353.16486-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20170821160301.21899-1-jbrunet@baylibre.com

Jerome Brunet (13):
  mmc: meson-gx: initialize sane clk default before clock register
  mmc: meson-gx: cfg init overwrite values
  mmc: meson-gx: rework set_ios function
  mmc: meson-gx: rework clk_set function
  mmc: meson-gx: rework clock init function
  mmc: meson-gx: fix dual data rate mode frequencies
  mmc: meson-gx: work around clk-stop issue
  mmc: meson-gx: simplify interrupt handler
  mmc: meson-gx: implement card_busy callback
  mmc: meson-gx: use CCF to handle the clock phases
  mmc: meson-gx: implement voltage switch callback
  mmc: meson-gx: change default tx phase
  mmc: meson-gx: rework tuning function

 drivers/mmc/host/meson-gx-mmc.c | 710 ++++++++++++++++++++++++++++------------
 1 file changed, 493 insertions(+), 217 deletions(-)

-- 
2.9.5

