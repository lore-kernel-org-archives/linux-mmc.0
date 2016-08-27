From: Ziyuan Xu <xzy.xu@rock-chips.com>
Subject: [PATCH 0/2] Add power domain support for eMMC node on rk3399
Date: Sat, 27 Aug 2016 21:41:01 +0800
Message-ID: <20160827134103.28160-1-xzy.xu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, Ziyuan Xu <xzy.xu@rock-chips.com>, Frank Wang <frank.wang@rock-chips.com>, Catalin Marinas <catalin.marinas@arm.com>, Elaine Zhang <zhangqing@rock-chips.com>, David Wu <david.wu@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Will Deacon <will.deacon@arm.com>, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jianqun Xu <jay.xu@rock-chips.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Xing Zheng <zhengxing@rock-chips.com>, Shunqian Zheng <zhengsq@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

This series add power domain for eMMC node which will be controlled by
genpd to make sure it's available in probing state, and will be off
once suspend/remove.


Ziyuan Xu (2):
  Documentation: mmc: sdhci-of-arasan: add description of power domain
  arm64: dts: rockchip: add eMMC's power domain support for rk3399

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt |  6 +++++-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi               | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.9.2
