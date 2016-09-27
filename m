From: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v4 0/2] Add power domain support for eMMC node on rk3399
Date: Tue, 27 Sep 2016 14:15:56 +0800
Message-ID: <20160927061558.2110-1-xzy.xu@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This series add power domain for eMMC node which will be controlled by
genpd to make sure it's available in probing state, and will be gate
once suspend/resume.

Changes in v4:
- add heiko's review-tag

Changes in v3:
- fix a typo
- add Rob's ack-tag

Changes in v2:
- fix a typo
- add an example code for power-domain
- add Shawn's review-tag and Doug's review-tag

Ziyuan Xu (2):
  Documentation: mmc: sdhci-of-arasan: add description of power domain
  arm64: dts: rockchip: add eMMC's power domain support for rk3399

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt |  7 ++++++-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi               | 11 +++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.9.3


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
