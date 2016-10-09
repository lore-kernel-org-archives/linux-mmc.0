From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESEND PATCH 0/9] Init runtime PM support for dw_mmc
Date: Sun,  9 Oct 2016 21:58:17 +0800
Message-ID: <1476021506-869-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:55476 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbcJINxD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Oct 2016 09:53:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>


Hi Jaehoon and Ulf,

   This patch is gonna support runtime PM for dw_mmc.
It could support to disable ciu_clk by default and disable
biu_clk if the devices are non-removeable, or removeable
with gpio-base card detect.

   Then I remove the system PM since the runtime PM actually
does the same thing as it. So I help migrate the dw_mmc variant
drivers to use runtime PM pairs and pm_runtime_force_*. Note
that I only enable runtime PM for dw_mmc-rockchip as I will
leave the decision to the owners of the corresponding drivers.
I just tested it on my RK3288 platform with linux-next to make
the runtime PM and system PM work fine for my emmc, sd card and
sdio. But I don't have hardware to help test other variant drivers.
But in theory it should work fine as I mentioned that the runtime
PM does the same thing as system PM except for disabling ciu_clk
aggressively which should not be related to the variant hosts.

   As you could see that I just extend the slot-gpio a bit, so the
ideal way is Ulf could pick them up with Jaehoon's ack. :)



Shawn Lin (9):
  mmc: dw_mmc: add runtime PM callback
  mmc: dw_mmc-rockchip: add runtime PM support
  mmc: core: expose the capability of gpio card detect
  mmc: dw_mmc-rockchip: disable biu clk if possible
  mmc: dw_mmc-k3: deploay runtime PM facilities
  mmc: dw_mmc-exynos: deploay runtime PM facilities
  mmc: dw_mmc-pci: deploay runtime PM facilities
  mmc: dw_mmc-pltfm: deploay runtime PM facilities
  mmc: dw_mmc: remove system PM callback

 drivers/mmc/core/slot-gpio.c       |  8 +++++
 drivers/mmc/host/dw_mmc-exynos.c   | 21 ++++++-----
 drivers/mmc/host/dw_mmc-k3.c       | 37 +++++++++----------
 drivers/mmc/host/dw_mmc-pci.c      | 25 ++++++++-----
 drivers/mmc/host/dw_mmc-pltfm.c    | 26 ++++++++------
 drivers/mmc/host/dw_mmc-rockchip.c | 73 ++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/dw_mmc.c          | 24 ++++++-------
 drivers/mmc/host/dw_mmc.h          |  6 ++--
 include/linux/mmc/slot-gpio.h      |  1 +
 9 files changed, 152 insertions(+), 69 deletions(-)

-- 
2.3.7


