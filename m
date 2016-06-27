From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/3] mmc: Fixes for 150 MHz Rockchip eMMC series
Date: Mon, 27 Jun 2016 10:39:24 -0700
Message-ID: <1467049167-14628-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35715 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbcF0Rjx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2016 13:39:53 -0400
Received: by mail-pa0-f42.google.com with SMTP id hl6so60932575pac.2
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2016 10:39:53 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, ulf.hansson@linaro.org, kishon@ti.com
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, briannorris@chromium.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, adrian.hunter@intel.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org

Despite positive testing across a number of machines and a number of
people, last week I got a report that my 150 MHz series was breaking
things on a handful of boards.

It turns out that reverting the patch to always power cycle across clock
changes fixes things and reverting that patch also doesn't actually
cause any known problems (and 150 MHz should even continue to work).

Although we really need to get to the bottom of things, it seems
expedient to revert while we're waiting for a better solution, hence
this series.  Also in this series is further increase in the time we'll
wait for the DLL to stabilize (found during reboot stress testing) and a
fix to the way we handle the card clock being reported as 0 (needed for
suspend/resume because of the revert we just did).

It's expected that this series could go through Ulf's mmc tree (like the
previous) with Kishon's Ack as appropriate.


Douglas Anderson (3):
  mmc: sdhci-of-arasan: Revert: Always power the PHY off/on when clock
    changes
  phy: rockchip-emmc: Be tolerant to card clock of 0 in power on
  phy: rockchip-emmc: Wait even longer for the DLL to lock

 drivers/mmc/host/sdhci-of-arasan.c | 21 +++++++----
 drivers/phy/phy-rockchip-emmc.c    | 71 ++++++++++++++++++++++++++------------
 2 files changed, 62 insertions(+), 30 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

