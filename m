From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 00/10] Add tune support of Mediatek MMC driver
Date: Tue, 27 Oct 2015 14:24:20 +0800
Message-ID: <1445927070-5102-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kristina Martsenko <kristina.martsenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Change in v3:
Fix checkpatch errors and warnings for patch 8
Split patch 9, make DT parts enabling hw reset separately

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

Chaotian Jing (10):
  mmc: core: Add DT bindings for eMMC hardware reset support
  mmc: dt-bindings: update Mediatek MMC bindings
  mmc: mediatek: make cmd_ints_mask to const
  mmc: mediatek: change the argument "ddr" to "timing"
  mmc: mediatek: fix got GPD checksum error interrupt when data transfer
  mmc: mediatek: add implement of ops->hw_reset()
  arm64: dts: mediatek: add eMMC hw reset support
  mmc: mmc: extend the mmc_send_tuning()
  mmc: mediatek: add HS400 support
  arm64: dts: mediatek: add HS200/HS400/SDR50/SDR104 support

 Documentation/devicetree/bindings/mmc/mmc.txt    |   1 +
 Documentation/devicetree/bindings/mmc/mtk-sd.txt |  11 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  27 +-
 drivers/mmc/core/host.c                          |   2 +
 drivers/mmc/core/mmc_ops.c                       |   8 +-
 drivers/mmc/host/dw_mmc-exynos.c                 |   4 +-
 drivers/mmc/host/dw_mmc.c                        |   2 +-
 drivers/mmc/host/dw_mmc.h                        |   2 +-
 drivers/mmc/host/mtk-sd.c                        | 304 ++++++++++++++++++++---
 drivers/mmc/host/sdhci-esdhc-imx.c               |   6 +-
 drivers/mmc/host/sdhci-msm.c                     |   2 +-
 drivers/mmc/host/sdhci-sirf.c                    |   2 +-
 include/linux/mmc/core.h                         |   2 +-
 13 files changed, 322 insertions(+), 51 deletions(-)

-- 
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
