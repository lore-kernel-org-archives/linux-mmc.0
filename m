From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 0/9] Add tune support of Mediatek MMC driver
Date: Tue, 20 Oct 2015 17:13:02 +0800
Message-ID: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Barry Song <baohua@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Howard Chen <ibanezchen@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Kristina Martsenko <kristina.martsenko@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cog>
List-Id: linux-mmc@vger.kernel.org

Change in v2:
Drop the 400mhz and use assigned-clock-parents to instead
Split the original tune patch to several independent patches
Re-write the mmc_send_tuning()
Fix GPD checksum error
Move the HS400 setting to ops->prepare_hs400_tuning()	
Modify SD driving settings

Change in v1:
Add DT bindings for eMMC hardware reset
Add pinctrl of data strobe pin for HS400 mode
Modify eMMC driving settings
Add 400mhz source clock for HS400 mode
Add eMMC HS200/HS400 mode support
Add SD SDR50/SDR104 mode support
Add implement of tune function with CMD19/CMD21

Chaotian Jing (9):
  mmc: core: Add DT bindings for eMMC hardware reset support
  mmc: dt-bindings: update Mediatek MMC bindings
  mmc: mediatek: make cmd_ints_mask to const
  mmc: mediatek: change the argument "ddr" to "timing"
  mmc: mediatek: fix got GPD checksum error interrupt when data transfer
  mmc: mediatek: add implement of ops->hw_reset()
  mmc: mmc: extend the mmc_send_tuning()
  mmc: mediatek: add HS400 support
  arm64: dts: mediatek: add HS200/HS400/SDR50/SDR104 support

 Documentation/devicetree/bindings/mmc/mmc.txt    |   1 +
 Documentation/devicetree/bindings/mmc/mtk-sd.txt |  11 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  27 ++-
 drivers/mmc/core/host.c                          |   2 +
 drivers/mmc/core/mmc_ops.c                       |   8 +-
 drivers/mmc/host/dw_mmc-exynos.c                 |   4 +-
 drivers/mmc/host/dw_mmc.c                        |   2 +-
 drivers/mmc/host/dw_mmc.h                        |   2 +-
 drivers/mmc/host/mtk-sd.c                        | 296 ++++++++++++++++++++---
 drivers/mmc/host/sdhci-esdhc-imx.c               |   6 +-
 drivers/mmc/host/sdhci-msm.c                     |   2 +-
 drivers/mmc/host/sdhci-sirf.c                    |   2 +-
 include/linux/mmc/core.h                         |   2 +-
 13 files changed, 314 insertions(+), 51 deletions(-)

-- 
1.8.1.1.dirty
