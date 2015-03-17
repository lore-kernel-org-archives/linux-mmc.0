From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/5] Add Mediatek MMC driver
Date: Tue, 17 Mar 2015 11:13:50 +0800
Message-ID: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This series enables MMC support on the MT8135/MT8173 platform.
MT8135 has 5 MMC controllers and MT8173 has 4 MMC controllers.

Changes base on Ulf's comment in HKG15:
Remove useless #include and make it sorted
Remove BIT(x), only use (1 << x)
Remove useless structure
Move all defines to begin of the code
Remove useless defines
Move PM/Runtime PM as an extra patch
Remove "BUG()" in the code
Take place core-power, io-power with mmc_regulator APIs
Handle MMC_POWER_ON in set_ios
Remove msdc_of_parse, call these methods in probe directly

Chaotian Jing (3):
  mmc: dt-bindings: add Mediatek MMC bindings
  mmc: mediatek: Add Mediatek MMC driver
  mmc: mediatek: Add PM support for MMC driver

Eddie Huang (2):
  arm64: mediatek: Add Mediatek MMC support in defconfig
  arm64: dts: mediatek: Add MT8173 MMC dts

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   33 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  115 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   19 +-
 arch/arm64/configs/defconfig                     |    1 +
 drivers/mmc/host/Kconfig                         |    8 +
 drivers/mmc/host/Makefile                        |    1 +
 drivers/mmc/host/mtk-sd.c                        | 1504 ++++++++++++++++++++++
 7 files changed, 1680 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
 create mode 100644 drivers/mmc/host/mtk-sd.c


Chaotian Jing (3):
  mmc: dt-bindings: add Mediatek MMC bindings
  mmc: mediatek: Add Mediatek MMC driver
  mmc: mediatek: Add PM support for MMC driver

Eddie Huang (2):
  arm64: mediatek: Add Mediatek MMC support in defconfig
  arm64: dts: mediatek: Add MT8173 MMC dts

 Documentation/devicetree/bindings/mmc/mtk-sd.txt |   33 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  115 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   19 +-
 arch/arm64/configs/defconfig                     |    1 +
 drivers/mmc/host/Kconfig                         |    8 +
 drivers/mmc/host/Makefile                        |    1 +
 drivers/mmc/host/mtk-sd.c                        | 1504 ++++++++++++++++++++++
 7 files changed, 1680 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
 create mode 100644 drivers/mmc/host/mtk-sd.c
