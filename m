From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/5] Add power domain support for dw_mmc/sdhci-of-arasan
Date: Fri, 29 Jul 2016 12:14:58 +0800
Message-ID: <1469765703-30999-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Feng Xiao <xf@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org


We need to enable the power domain manually while probing as the
power policy will turn off the pd which is not referenced. Otherwise
we may take risk of breaking kernel once Feng Xiao land the rockchip pd
relate stuff. So, let's do it in advance.

This pachset is based on the latest linux-next[1] which should contain
the next branch of linux-mmc and dt stuff. It's ideal to pack these all
into Ulf' tree with Heiko's ack for dts, Rob's ack for Doc and Jaehoon's
ack for dw_mmc. But it's okay to be merged seperately.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Thanks.



Shawn Lin (5):
  Documentation: mmc: synopsys-dw-mshc: add power domain description
  Documentation: mmc: sdhci-of-arasan: add power domain description
  arm64: dts: rockchip: Provide power-domains for sd/sdio/emmc
    controllers
  mmc: dw_mmc: add power domain support
  mmc: sdhci-of-arasan: add power domain support

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt     |  1 +
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  2 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                   |  3 +++
 drivers/mmc/host/dw_mmc.c                                  | 11 +++++++++++
 drivers/mmc/host/sdhci-of-arasan.c                         | 10 ++++++++++
 5 files changed, 27 insertions(+)

-- 
2.3.7
