From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 0/4] Control clock for accessing syscon provided by arasan IP
Date: Fri,  2 Sep 2016 08:54:37 +0800
Message-ID: <1472777681-16656-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:40707 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750697AbcIBBAf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2016 21:00:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>


This patchset is gonna take over the ownership of aclk_emmc_grf
by sdhci-of-arasan which is used to access corecfg_* stuff provided
by arasan. This clock is optional for sdhci-of-arasan which means we
would not break the driver  without adding this. But we strongly
recommend the upcoming users whose platforms have the similar
cases to add this rather than to add any flags for their specific
clock drivers to make this clock always on.

This patchset is based on linux-next. And patch 4 should *not* be
landed before others, so it would be nice to pack these four patches
via Ulf's tree with Heiko's ack for rockchip part, or vice versa. :)


Changes in v3:
- return failure if failing to enable clk_syscon

Changes in v2:
- assign NULL to clk_syscon if it's not deferral error.

Shawn Lin (4):
  Documentation: mmc: sdhci-of-arasan: Add clk_syscon as an optional one
  mmc: sdhci-of-arasan: Control clock for accessing syscon
  arm64: dts: rockchip: add clk_syscon for sdhci on rk3399
  clk: rockchip: remove CLK_IGNORE_UNUSED flag for aclk_emmc_grf on
    rk3399

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  7 +++--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  5 ++--
 drivers/clk/rockchip/clk-rk3399.c                  |  2 +-
 drivers/mmc/host/sdhci-of-arasan.c                 | 34 ++++++++++++++++++++--
 4 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.3.7


