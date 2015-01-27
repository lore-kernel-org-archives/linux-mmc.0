From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [RFC PATCH 0/7] msdc: Add mediatek MMC driver
Date: Tue, 27 Jan 2015 14:15:25 +0800
Message-ID: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream@mediatek.com, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, bin.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This series enables MMC support on the MT8135/MT8173 platform.
MT8135 has 5 MMC controllers and MT8173 has 4 MMC controllers.
These controllers share one source clock.

This depends on 3.19-rc1 + Hongzhou's mt8135 pinctrl support[1] + James's mt8135 clock support[2].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318450.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313793.html 

Chaotian Jing (6):
  mmc: mediatek: Add Mediatek MMC driver
  ARM: mediatek: Add Mediatek MMC support in multi_v7_defconfig
  arm64: mediatek: Add Mediatek MMC support in defconfig
  mmc: dt-bindings: add Mediatek MMC bindings
  dts: mediatek: Add MT8135 mmc dts
  arm64: dts: mediatek: Add MT8173 MMC dts

Yingjoe Chen (1):
  pinctrl: mediatek: emulate GPIO interrupt on both-edges

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   33 +
 arch/arm/boot/dts/mt8135-evbp1.dts               |  137 ++
 arch/arm/boot/dts/mt8135.dtsi                    |   27 +
 arch/arm/configs/multi_v7_defconfig              |    1 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  115 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   19 +-
 arch/arm64/configs/defconfig                     |    1 +
 drivers/mmc/host/Kconfig                         |    8 +
 drivers/mmc/host/Makefile                        |    1 +
 drivers/mmc/host/mtk-sd.c                        | 1786 ++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mt8135.c        |    3 +
 drivers/pinctrl/mediatek/pinctrl-mt8173.c        |    3 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c    |   76 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h    |    4 +
 14 files changed, 2210 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
 create mode 100644 drivers/mmc/host/mtk-sd.c
