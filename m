From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 0/4] Control clock for accessing syscon provided by arasan IP
Date: Wed, 31 Aug 2016 09:37:24 +0800
Message-ID: <1472607448-4462-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


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
 drivers/mmc/host/sdhci-of-arasan.c                 | 33 ++++++++++++++++++++--
 4 files changed, 39 insertions(+), 8 deletions(-)

-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
