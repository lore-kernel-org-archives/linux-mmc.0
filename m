Return-Path: <SRS0=8dup=3Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CE7C32771
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 11:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36441206A2
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jan 2020 11:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSd1hw3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA0LR5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:17:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34588 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgA0LR5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jan 2020 06:17:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so10176563ljc.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jan 2020 03:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KH4ITOu8HFmfSpo3QTXooiDVcVciY0roscrgdBJW03E=;
        b=lSd1hw3bvtfcQo8pFs3QYYkthwadopZSIwVADpKK+W6nkPuIAe63CgQ7PpwyUf+Qgw
         qa0r+lqWUTIDzg6zgeQxkgooE+AYbyhW9u/44/GRi/A3eVfr0AcVNXAh08EN4r+XtAlV
         Z6rjOggnzGO1YOBBCVbGeuWiRxfIPPzE9NLeUT0sLrI5CyV5ZmskrhxN9rjMvnGgE+3y
         kC7vxbKci2NzH6AwFl4W4H66DN8VnGLMl1QNz9NyFPjFEpdSfa4PDURqvkyMwSlQXwiH
         0VGkYYByXjbCv7fMhpdiaUQjdEXz/6WKciv9P6N0ObXOWgij/VlSD2C2VT0l3XXNSapy
         SNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KH4ITOu8HFmfSpo3QTXooiDVcVciY0roscrgdBJW03E=;
        b=GwA33FOuh64JzZh/fBycrma1P0bIn5vL85Q7zqaO/5I43fU+gEtdFM8g3zommH4I5V
         NNUOKumDIkTwN/t9C+oyWdr/Eob56tghljWJpC4NQ1yI2BRAOuGuFrLcBBO9gYPyKrZV
         zYqaJN8Th1Iw39iBNtSJo0aBeTzoch4rDnPU4YyaslRxDv0d82H/iNqKnMIt6X6f38r5
         jVY0/7r6KCbQUnc3iKqLNoi5ojuYeek10JtNsZJHtm5rC87ZOGEVfYHABz/Ckph30kfC
         EE+egq0/0dIwfaTzHV4FC27K4KyIeEXUgh/SJPz8MEJfXtE6Zswd5lajIqHLNVCTHRMf
         ZSPg==
X-Gm-Message-State: APjAAAXILgoswMNg//sOToiCOq14SIeWCK4wPTBV0SyZf77aH99Ippe8
        FSRKeVmAYMHWPup5ZiSXsZBCB3HOl1o=
X-Google-Smtp-Source: APXvYqzJ+59zUviNTBO9AYVWT3vL3Bg4IQ73sTDAa7FLq/UKF0kYBzfFKd7g+Q/bxubRZefL5khPMw==
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr10032819ljj.4.1580123495960;
        Mon, 27 Jan 2020 03:11:35 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id u19sm7902087lfu.68.2020.01.27.03.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 03:11:35 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v5.6
Date:   Mon, 27 Jan 2020 12:11:34 +0100
Message-Id: <20200127111134.25963-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with the updates for MMC for v5.6. There are no updates for the
MEMSTICK subsystem this time. Details about the highlights are as usual found
in the signed tag.

Note that, this time I am also carrying a patch from the pinctrl tree, which
has been shared through an immutable branch.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2a187d03352086e300daa2044051db00044cd171:

  mmc: sdhci: fix minimum clock rate for v3 controller (2020-01-20 10:36:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6

for you to fetch changes up to 533a6cfe08f96a7b5c65e06d20916d552c11b256:

  mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch() (2020-01-24 12:17:05 +0100)

----------------------------------------------------------------
MMC core:
 - Convert to reasonable timeouts for all CMD6 commands (updates for BKOPS,
   CACHE_FLUSH and INAND_CMD38_ARG_EXT_CSD) for eMMC
 - Respect f_max clock rate at card initialization
 - Add gpiod_toggle_active_low() API
 - Consolidate slot-gpio code by using gpiod_toggle_active_low()

MMC host:
 - Add pinctrl_select_default_state() API
 - Consolidate pintctrl code by using pinctrl_select_default_state()
 - mmci: Support any block sizes for SDIO for some variants
 - mmci: Enable reset control for stm32_sdmmc
 - mmc_spi: Toggle SPI_CS_HIGH polarity rather than hard-coding it
 - renesas_sdhi: Add support for the r8a77961 variant
 - renesas_sdhi: A few minor improvements
 - rockchip-dw-mshc: Add support for the rk3308 variant
 - sdhci: Enable support for external DMA controllers
 - sdhci: Fixup error path when sending CMD12
 - sdhci-brcmstb: Add support for 7216b0 variant
 - sdhci-brcmstb: Add support for command queuing (CQHCI)
 - sdhci-brcmstb: Add support for eMMC HS400ES mode
 - sdhci-msm: Add support for the sc7180 variant
 - sdhci-msm: Add support for command queuing (CQHCI)
 - sdhci-of-at91: Add support for the SAM9x60 variant
 - sdhci-of-at91: Improve support for tunings
 - sdhci-of-esdhc: A few fixups for some clock related issues
 - sdhci-omap: Add support for the am335x and the am437x variants
 - sdhci-omap: Improve support for erase operations
 - sdhci-omap: Add support for external DMA

----------------------------------------------------------------
Al Cooper (6):
      dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 7216b0
      mmc: sdhci-brcmstb: Add ability to use HS400ES transfer mode
      mmc: sdhci-brcmstb: Fix driver to defer on clk_get defer
      mmc: sdhci-brcmstb: Add shutdown callback
      mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)
      mmc: sdhci-brcmstb: Fix incorrect switch to HS mode

Anson Huang (1):
      dt-bindings: mmc: fsl-imx-esdhc: add i.MX8MP compatible string

Chuhong Yuan (1):
      mmc: cavium: Add missed pci_release_regions

Chunyan Zhang (4):
      dt-bindings: sdhci-omap: Add properties for using external dma
      mmc: sdhci: add support for using external DMA devices
      mmc: sdhci-omap: Add using external dma
      mmc: sdhci: fix an issue of mixing different types

Faiz Abbas (8):
      mmc: sdhci: Update the tuning failed messages to pr_debug level
      mmc: sdhci: Factor out some operations set to their own functions
      mmc: sdhci: Convert sdhci_set_timeout_irq() to non-static
      mmc: sdhci: Refactor sdhci_set_timeout()
      mmc: sdhci-omap: Disable data timeout interrupt during erase
      dt-bindings: sdhci-omap: Add am335x and am437x specific bindings
      mmc: sdhci-omap: Add am335x and am437x specific compatibles
      mmc: sdhci-omap: Add special reset capability

Geert Uytterhoeven (1):
      dt-bindings: mmc: renesas_sdhi: Document r8a77961 support

Johan Jonker (3):
      dt-bindings: mmc: convert synopsys dw-mshc bindings to yaml
      dt-bindings: mmc: convert rockchip dw-mshc bindings to yaml
      dt-bindings: mmc: rockchip-dw-mshc: add description for rk3308

Linus Walleij (2):
      mmc: spi: Toggle SPI polarity, do not hardcode it
      mmc: mmci: Support any block sizes for ux500v2 and qcom variant

Ludovic Barre (1):
      mmc: mmci: add threaded irq to abort DPSM of non-functional state

Ludovic Desroches (2):
      dt-bindings: sdhci-of-at91: new compatible string and update properties
      mmc: sdhci-of-at91: rework clocks management to support SAM9x60 device

Masahiro Yamada (1):
      mmc: sdhci-cadence: remove unneeded 'inline' marker

Michał Mirosław (7):
      mmc: sdhci-s3c: remove unused ext_cd_gpio field
      gpio: add gpiod_toggle_active_low()
      mmc: core: Rework wp-gpio handling
      mmc: core: Rework cd-gpio handling
      mmc: core: Remove mmc_gpiod_request_*(invert_gpio)
      mmc: sdhci-of-at91: fix memleak on clk_get failure
      mmc: core: limit probe clock frequency to configured f_max

Peter Ujfalusi (9):
      mmc: dw_mmc: Use dma_request_chan() instead dma_request_slave_channel()
      mmc: mmci: Use dma_request_chan() instead dma_request_slave_channel()
      mmc: mxcmmc: Use dma_request_chan() instead dma_request_slave_channel()
      mmc: mxs: Use dma_request_chan() instead dma_request_slave_channel()
      mmc: owl-mmc: Use dma_request_chan() instead dma_request_slave_channel()
      mmc: pxamci: Use dma_request_chan() instead dma_request_slave_channel()
      mmc: sh_mmcif: Use dma_request_chan() instead dma_request_slave_channel()
      mmc: usdhi6rol0: Use dma_request_chan() instead dma_request_slave_channel()
      mmc: bcm2835: Use dma_request_chan() instead dma_request_slave_channel()

Ritesh Harjani (1):
      mmc: sdhci-msm: Add CQHCI support for sdhci-msm

Ulf Hansson (18):
      pinctrl: core: Add pinctrl_select_default_state() and export it
      Merge branch 'fixes' into next
      mmc: meson-gx: Convert to pinctrl_select_default_state()
      mmc: mmci: Convert to pinctrl_select_default_state()
      mmc: usdhi6rol0: Convert to pinctrl_select_default_state()
      mmc: omap_hsmmc: Convert to pinctrl_select_default_state()
      mmc: sdhci-esdhc-imx: Convert to pinctrl_select_default_state()
      mmc: atmel-mci: Convert to pinctrl_select_default_state()
      mmc: jz4740: Convert to pinctrl_select_default_state()
      mmc: uniphier-sd: Convert to pinctrl_select_default_state()
      Merge branch 'mmc_pinctrl' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
      mmc: block: Use generic_cmd6_time when modifying INAND_CMD38_ARG_EXT_CSD
      mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()

Veerabhadrarao Badiganti (2):
      dt-bindings: mmc: sdhci-msm: Add compatible string for sc7180
      mmc: sdhci: Let a vendor driver supply and update ADMA descriptor size

Wolfram Sang (6):
      mmc: renesas_sdhi: remove whitelist for internal DMAC
      mmc: renesas_sdhi: keep sorting for quirk entries
      mmc: renesas_sdhi: make warning more precise
      mmc: renesas_sdhi: make quirks info accessible outside probe()
      mmc: renesas_sdhi: remove 4taps as a TMIO flag
      mmc: renesas_sdhi: use recent tap values for HS400

Yangbo Lu (8):
      mmc: sdhci: fix up CMD12 sending
      mmc: sdhci-of-esdhc: use 1/2 periperhal clock for ls1088a
      mmc: sdhci-of-esdhc: convert to use esdhc_tuning_window_ptr()
      mmc: sdhci-of-esdhc: update tuning erratum A-008171
      mmc: sdhci-of-esdhc: fix esdhc_reset() for different controller versions
      mmc: sdhci-of-esdhc: fix clock setting for different controller versions
      mmc: sdhci-of-esdhc: fix transfer mode register reading
      mmc: sdhci-of-esdhc: fix serious issue clock is always disabled

Yangtao Li (13):
      mmc: sunxi-mmc: convert to devm_platform_ioremap_resource
      mmc: tmio: convert to devm_platform_ioremap_resource
      mmc: meson-mx-sdio: convert to devm_platform_ioremap_resource
      mmc: sdhci-s3c: convert to devm_platform_ioremap_resource
      mmc: sdhci-spear: convert to devm_platform_ioremap_resource
      mmc: sh_mmcif: convert to devm_platform_ioremap_resource
      mmc: sdhci_f_sdh30: convert to devm_platform_ioremap_resource
      mmc: sdhci_am654: convert to devm_platform_ioremap_resource
      mmc: sdhci-milbeaut: convert to devm_platform_ioremap_resource
      mmc: sdhci-msm: convert to devm_platform_ioremap_resource
      mmc: mvsdio: convert to devm_platform_ioremap_resource
      mmc: mtk-sd: convert to devm_platform_ioremap_resource
      mmc: au1xmmc: switch to platform_get_irq

YueHaibing (1):
      mmc: sdhci-milbeaut: Remove redundant platform_get_irq error message

 .../devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt |  41 ++-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   1 +
 .../devicetree/bindings/mmc/renesas,sdhi.txt       |   3 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  49 ---
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  | 125 +++++++
 .../devicetree/bindings/mmc/sdhci-atmel.txt        |  13 +-
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 .../devicetree/bindings/mmc/sdhci-omap.txt         |  11 +
 .../bindings/mmc/synopsys-dw-mshc-common.yaml      |  68 ++++
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 141 --------
 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml  |  70 ++++
 MAINTAINERS                                        |   1 +
 drivers/gpio/gpiolib-of.c                          |  21 --
 drivers/gpio/gpiolib.c                             |  11 +
 drivers/mmc/core/block.c                           |   6 +-
 drivers/mmc/core/core.c                            |  10 +-
 drivers/mmc/core/host.c                            |  33 +-
 drivers/mmc/core/mmc_ops.c                         |  34 +-
 drivers/mmc/core/slot-gpio.c                       |  31 +-
 drivers/mmc/host/Kconfig                           |   6 +
 drivers/mmc/host/atmel-mci.c                       |   2 +-
 drivers/mmc/host/au1xmmc.c                         |   7 +-
 drivers/mmc/host/bcm2835.c                         |  12 +-
 drivers/mmc/host/cavium-thunderx.c                 |  16 +-
 drivers/mmc/host/davinci_mmc.c                     |   4 +-
 drivers/mmc/host/dw_mmc.c                          |   8 +-
 drivers/mmc/host/jz4740_mmc.c                      |   2 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  10 +-
 drivers/mmc/host/meson-mx-sdio.c                   |   4 +-
 drivers/mmc/host/mmc_spi.c                         |  15 +-
 drivers/mmc/host/mmci.c                            | 114 ++++--
 drivers/mmc/host/mmci.h                            |  10 +-
 drivers/mmc/host/mtk-sd.c                          |   3 +-
 drivers/mmc/host/mvsdio.c                          |   6 +-
 drivers/mmc/host/mxcmmc.c                          |  11 +-
 drivers/mmc/host/mxs-mmc.c                         |   6 +-
 drivers/mmc/host/omap_hsmmc.c                      |  10 +-
 drivers/mmc/host/owl-mmc.c                         |   6 +-
 drivers/mmc/host/pxamci.c                          |  26 +-
 drivers/mmc/host/renesas_sdhi.h                    |  10 +-
 drivers/mmc/host/renesas_sdhi_core.c               |  22 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  25 +-
 drivers/mmc/host/s3cmci.c                          |   4 +-
 drivers/mmc/host/sdhci-acpi.c                      |   2 +-
 drivers/mmc/host/sdhci-brcmstb.c                   | 270 +++++++++++++-
 drivers/mmc/host/sdhci-cadence.c                   |   2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  18 +-
 drivers/mmc/host/sdhci-milbeaut.c                  |   8 +-
 drivers/mmc/host/sdhci-msm.c                       | 139 +++++++-
 drivers/mmc/host/sdhci-of-at91.c                   | 112 +++---
 drivers/mmc/host/sdhci-of-esdhc.c                  | 248 ++++++++-----
 drivers/mmc/host/sdhci-omap.c                      |  60 +++-
 drivers/mmc/host/sdhci-pci-core.c                  |   4 +-
 drivers/mmc/host/sdhci-s3c.c                       |   6 +-
 drivers/mmc/host/sdhci-sirf.c                      |   2 +-
 drivers/mmc/host/sdhci-spear.c                     |   6 +-
 drivers/mmc/host/sdhci.c                           | 387 ++++++++++++++++-----
 drivers/mmc/host/sdhci.h                           |  13 +-
 drivers/mmc/host/sdhci_am654.c                     |   4 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |   4 +-
 drivers/mmc/host/sh_mmcif.c                        |  12 +-
 drivers/mmc/host/sunxi-mmc.c                       |   3 +-
 drivers/mmc/host/tmio_mmc_core.c                   |   6 +-
 drivers/mmc/host/uniphier-sd.c                     |  14 +-
 drivers/mmc/host/usdhi6rol0.c                      |  27 +-
 drivers/pinctrl/core.c                             |  33 +-
 include/linux/gpio/consumer.h                      |   7 +
 include/linux/mfd/tmio.h                           |   3 -
 include/linux/mmc/slot-gpio.h                      |   5 +-
 include/linux/pinctrl/consumer.h                   |   6 +
 70 files changed, 1648 insertions(+), 762 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
