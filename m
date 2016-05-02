From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 0/4] mmc: tmio/sdhi: prevent regressions when setting clock
Date: Mon,  2 May 2016 22:25:38 +0200
Message-ID: <1462220742-4426-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33992 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755066AbcEBU0D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 May 2016 16:26:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>

Here is a small refactoring series for setting the clock for SDHI cores. This
is to prevent regression on platforms where this feature has not been tested.
One such regression is known on r8a7740 (patches 2+3). Patch 4 fixes an
oversight and patch 1 is a small cleanup.

RFC for now since I can't test these patches on my hardware currently. Will do
so on Wednesday, probably. Posting now since because Geert may already want to
test on r8a7740. Branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git sdhi-for-ulf

Thanks,

   Wolfram

Wolfram Sang (4):
  mmc: sh_mobile_sdhi: make clk_update function more compact
  mmc: tmio/sdhi: introduce flag for RCar 2+ specific features
  mmc: sh_mobile_sdhi: only change the clock on RCar Gen2+
  mmc: sh_mobile_sdhi: check return value when changing clk

 drivers/mmc/host/sh_mobile_sdhi.c | 17 +++++++++--------
 drivers/mmc/host/tmio_mmc_pio.c   |  6 +++---
 include/linux/mfd/tmio.h          |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.6.2

