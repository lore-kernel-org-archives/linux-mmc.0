Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FBBC433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Apr 2021 08:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0A361407
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Apr 2021 08:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbhD1ItY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Apr 2021 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbhD1ItX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Apr 2021 04:49:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46553C061574
        for <linux-mmc@vger.kernel.org>; Wed, 28 Apr 2021 01:48:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n138so98075404lfa.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 Apr 2021 01:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo1DQZgkZFuQ8qcL0iDQe+mzarmHAfHBfy6FMT32uN8=;
        b=ZCe24t63LrE2Zt7czAXkPoibg/ftyHq4H8W31NN7UtYST0kZApMBtb7vB18kAQTruQ
         8OmHSCzUlgI4dzJwlNDrvBUFZv2RFWdnACZ7E+0GtWuSgvkrjxpGImkgisGcV2QoTfOu
         6f8Y99vzub4bDqqgIi2pT+7CNg96bDvmd+VGWfauYmiREru9Qk92rhn4kndVOcxKtAWE
         P9xAnW78/aJAhgZeBf9dUYWnOUHaEEkKISwLQ5+PKmb8hdfwODS4V6QzQ1T+Z8BYMbOf
         QUbPGEcd2vybyjgzlZklFmpX1PSJSupGmMvqVeplskHQK3ooFdae5uTy4cLTnxdcaDZW
         ZBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo1DQZgkZFuQ8qcL0iDQe+mzarmHAfHBfy6FMT32uN8=;
        b=fpxxM8/Fse77e0E1b8vPaTU5Cl0K7Wh5EiVGzgIDjZC/WBBTimaCQ0eAsAXqYK+8vv
         O4ynJnMI6NYg+j8Jo6eyw6pvyR4oTZ1Yv3xEoPTFIG2Mc2hiWrVnecR/6t54OJLN4tVJ
         /aPlw3xR5b/vMMypDzWcnVfwyummxfC2STCDgpg0mkE6rrY3lXZmYANW3O4yKdqcas40
         jQ0FxSJuFs8j02FxqpwZRXbffNqVT+qLKbjIKmN8NVWgtNbKUWxA3wK4dw2YAqUHd3KX
         4cRnTqeoLvYAPw32QcIcJfHlS5TptiMCPWpkENGA8bOQSiIH30SSdqs3kYrSjjIb6Kus
         MYSA==
X-Gm-Message-State: AOAM533R5idgeedKL5BJKcrf7Rq2H7rfIub9Zp8g9j2iNBQBAzGeCcuI
        AjGU/8ogh0uF3TzWu7qitsdi/w==
X-Google-Smtp-Source: ABdhPJxN0rtLcbEMFpBx84Gdm7fr+i47C4h5Ue2THwSeUqFEhB+yGLy8TJxAPNJQHixLeClbU9jTXQ==
X-Received: by 2002:a05:6512:12c3:: with SMTP id p3mr20234712lfg.595.1619599715737;
        Wed, 28 Apr 2021 01:48:35 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id p23sm564702lfc.210.2021.04.28.01.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 01:48:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.13
Date:   Wed, 28 Apr 2021 10:48:33 +0200
Message-Id: <20210428084833.72831-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with updates for MMC and MEMSTICK for v5.13. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7412dee9f1fd3e224202b633fdfa6eeaebe0307e:

  mmc: meson-gx: replace WARN_ONCE with dev_warn_once about scatterlist size alignment in block mode (2021-04-19 09:49:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13

for you to fetch changes up to 97fce126e279690105ee15be652b465fd96f9997:

  mmc: block: Issue a cache flush only when it's enabled (2021-04-26 11:37:23 +0200)

----------------------------------------------------------------
MMC core:
 - Fix hanging on I/O during system suspend for removable cards
 - Set read only for SD cards with permanent write protect bit
 - Power cycle the SD/SDIO card if CMD11 fails for UHS voltage
 - Issue a cache flush for eMMC only when it's enabled
 - Adopt to updated cache ctrl settings for eMMC from MMC ioctls
 - Use use device property API when parsing voltages
 - Don't retry eMMC sanitize cmds
 - Use the timeout from the MMC ioctl for eMMC santize cmds

MMC host:
 - mmc_spi: Make of_mmc_spi.c resource provider agnostic
 - mmc_spi: Use polling for card detect even without voltage-ranges
 - sdhci: Check for reset prior to DMA address unmap
 - sdhci-acpi: Add support for the AMDI0041 eMMC controller variant
 - sdhci-esdhc-imx: Depending on OF Kconfig and cleanup code
 - sdhci-pci: Add PCI IDs for Intel LKF
 - sdhci-pci: Fix initialization of some SD cards for Intel BYT
 - sdhci-pci-gli: Various improvements for GL97xx variants
 - sdhci-of-dwcmshc: Enable support for MMC_CAP_WAIT_WHILE_BUSY
 - sdhci-of-dwcmshc: Add ACPI support for BlueField-3 SoC
 - sdhci-of-dwcmshc: Add Rockchip platform support
 - tmio/renesas_sdhi: Extend support for reset and use a reset controller
 - tmio/renesas_sdhi: Enable support for MMC_CAP_WAIT_WHILE_BUSY
 - tmio/renesas_sdhi: Various improvements

MEMSTICK:
 - Minor improvements/cleanups.

----------------------------------------------------------------
Adrian Hunter (2):
      mmc: sdhci-pci: Add PCI IDs for Intel LKF
      mmc: sdhci-pci: Fix initialization of some SD cards for Intel BYT-based controllers

Al Cooper (1):
      mmc: sdhci-brcmstb: Remove CQE quirk

Andy Shevchenko (6):
      mmc: core: Correct descriptions in mmc_of_parse()
      mmc: core: Convert mmc_of_parse_voltage() to use device property API
      mmc: mmc_spi: Set up polling even if voltage-ranges is not present
      mmc: mmc_spi: Drop unused NO_IRQ definition
      mmc: mmc_spi: Use already parsed IRQ
      mmc: mmc_spi: Make of_mmc_spi.c resource provider agnostic

Aniruddha Tvs Rao (1):
      mmc: sdhci-tegra: Add required callbacks to set/clear CQE_EN bit

Arnd Bergmann (1):
      memstick: r592: ignore kfifo_out() return code again

Avri Altman (2):
      mmc: block: Update ext_csd.cache_ctrl if it was written
      mmc: block: Issue a cache flush only when it's enabled

Bean Huo (4):
      mmc: cavium: Use '"%s...", __func__' to print function name
      mmc: core: Use userland specified timeout value for eMMC sanitize
      mmc: core: Add a retries parameter to __mmc_switch function
      mmc: core: Let eMMC sanitize not retry in case of timeout/failure

Ben Chuang (2):
      mmc: sdhci-pci-gli: Improve GL9763E L1 entry delay to increase battery life
      mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL975x

Christophe JAILLET (2):
      mmc: uniphier-sd: Fix an error handling path in uniphier_sd_probe()
      mmc: uniphier-sd: Fix a resource leak in the remove function

Dinghao Liu (1):
      mmc: sdhci-pci-o2micro: Add missing checks in sdhci_pci_o2_probe

DooHyun Hwang (1):
      mmc: core: Do a power cycle when the CMD11 fails

Fabio Estevam (2):
      mmc: sdhci-esdhc-imx: Remove non-DT stub
      mmc: sdhci-esdhc-imx: Use device_get_match_data()

Hao Fang (1):
      mmc: dw_mmc-k3: use the correct HiSilicon copyright

James Young (1):
      mmc: sdhci-acpi: Add device ID for the AMDI0041 variant of the AMD eMMC controller.

Jia Yang (1):
      mmc: sdhci-msm: Remove unnecessary error log

Jia-Ju Bai (1):
      memstick: core: Assign error code of mspro_block_resume()

Jiapeng Chong (1):
      memstick: r592: remove unused variable

Jisheng Zhang (5):
      mmc: sdhci-pci: Avoid comma separated statements
      mmc: sdhci: Use "mmc" directly rather than "host->mmc"
      mmc: sdio: fix a typo in the comment of SDIO_SD_REV_3_00
      mmc: sdhci-of-dwcmshc: set MMC_CAP_WAIT_WHILE_BUSY
      mmc: sdhci: replace mmc->parent with mmc_dev() for consistency

Joey Pabalan (1):
      memstick: Remove useless else branch

Krzysztof Kozlowski (3):
      mmc: sdhci-s3c: simplify getting of_device_id match data
      mmc: sdhci-s3c: correct kerneldoc of sdhci_s3c_drv_data
      mmc: sdhci-s3c: constify uses of driver/match data

Laibin Qiu (2):
      mmc: owl-mmc: Remove unnecessary error log
      mmc: sdhci-st: Remove unnecessary error log

Liming Sun (1):
      mmc: sdhci-of-dwcmshc: add ACPI support for BlueField-3 SoC

Luca Porzio (1):
      mmc: core: Remove mq->use_cqe from the struct mmc_queue

Nicolas Saenz Julienne (1):
      dt-bindings: mmc: iproc-sdhci: Convert to json-schema

Peng Fan (3):
      dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
      dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
      mmc: sdhci-esdhc-imx: validate pinctrl before use it

Philipp Zabel (2):
      mmc: sdhci-st: simplify optional reset handling
      mmc: dw_mmc: simplify optional reset handling

Pradeep P V K (1):
      mmc: sdhci: Check for reset prior to DMA address unmap

Renius Chen (1):
      mmc: sdhci-pci-gli: Enable short circuit protection mechanism of GL9755

Seiya Wang (1):
      dt-bindings: mmc: Add compatible for Mediatek MT8195

Seunghui Lee (1):
      mmc: core: Set read only for SD cards with permanent write protect bit

Shawn Guo (1):
      mmc: sdhci-esdhc-imx: separate 100/200 MHz pinctrl states check

Shawn Lin (4):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Convert to yaml file
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add rockchip support
      mmc: sdhci-of-dwcmshc: add rockchip platform support
      mmc: dw_mmc-rockchip: Just set default sample value for legacy mode

Takeshi Saito (1):
      mmc: tmio: restore bus width when resetting

Ulf Hansson (8):
      mmc: core: Drop superfluous validations in mmc_hw|sw_reset()
      mmc: core: Drop reference counting of the bus_ops
      mmc: dw_mmc: Drop redundant call to ->card_event callback
      mmc: block: Drop use of unlikely() in mmc_blk_probe()
      mmc: block: Simplify logging during probe about added partitions
      mmc: block: Fix error path in mmc_blk_probe()
      mmc: core: Fix hanging on I/O during system suspend for removable cards
      Merge branch 'fixes' into next

Wei Yongjun (1):
      mmc: sdhci-of-dwcmshc: fix error return code in dwcmshc_probe()

Wolfram Sang (9):
      mmc: tmio: remove workaround for NON_REMOVABLE
      mmc: tmio: support custom irq masks
      mmc: renesas_sdhi: use custom mask for TMIO_MASK_ALL
      mmc: tmio: abort DMA before reset
      mmc: renesas_sdhi: break SCC reset into own function
      mmc: renesas_sdhi: do hard reset if possible
      mmc: tmio: always flag retune when resetting and a card is present
      mmc: renesas_sdhi: enable WAIT_WHILE_BUSY
      mmc: tmio: always restore irq register

Yang Li (2):
      mmc: via-sdmmc: remove unneeded variable 'ret'
      mmc: moxart: Remove unused variable 'dma_time' and 'pio_time'

Yue Hu (1):
      mmc: core: Reduce code duplication to mmc_spi_send_{csd|cid}

 .../devicetree/bindings/mmc/brcm,iproc-sdhci.yaml  |  63 +++++
 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  37 ---
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  20 ++
 .../devicetree/bindings/mmc/mmc-spi-slot.txt       |   6 +-
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   1 +
 .../devicetree/bindings/mmc/sdhci-of-dwcmshc.txt   |  20 --
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |  87 ++++++
 drivers/memstick/core/memstick.c                   |  21 +-
 drivers/memstick/core/mspro_block.c                |   3 +-
 drivers/memstick/host/r592.c                       |   6 +-
 drivers/mmc/core/block.c                           |  76 +++--
 drivers/mmc/core/core.c                            | 186 +-----------
 drivers/mmc/core/core.h                            |  17 +-
 drivers/mmc/core/host.c                            |  90 ++++--
 drivers/mmc/core/mmc.c                             |  29 +-
 drivers/mmc/core/mmc_ops.c                         |  59 ++--
 drivers/mmc/core/mmc_ops.h                         |   4 +-
 drivers/mmc/core/queue.c                           |  11 +-
 drivers/mmc/core/queue.h                           |   1 -
 drivers/mmc/core/sd.c                              |   6 +
 drivers/mmc/core/sdio.c                            |  28 +-
 drivers/mmc/host/Kconfig                           |   2 +
 drivers/mmc/host/Makefile                          |   2 -
 drivers/mmc/host/cavium.c                          |   3 +-
 drivers/mmc/host/dw_mmc-k3.c                       |   2 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |   2 +-
 drivers/mmc/host/dw_mmc.c                          |  16 +-
 drivers/mmc/host/mmc_spi.c                         |   8 +-
 drivers/mmc/host/moxart-mmc.c                      |  10 +-
 drivers/mmc/host/of_mmc_spi.c                      |  18 +-
 drivers/mmc/host/owl-mmc.c                         |   1 -
 drivers/mmc/host/renesas_sdhi.h                    |   2 +
 drivers/mmc/host/renesas_sdhi_core.c               |  38 ++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   4 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   8 +-
 drivers/mmc/host/sdhci-acpi.c                      |   2 +
 drivers/mmc/host/sdhci-brcmstb.c                   |   1 -
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  26 +-
 drivers/mmc/host/sdhci-esdhc-mcf.c                 |   8 +-
 drivers/mmc/host/sdhci-msm.c                       |   8 +-
 drivers/mmc/host/sdhci-of-aspeed.c                 |   2 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 313 +++++++++++++++++++--
 drivers/mmc/host/sdhci-of-esdhc.c                  |   2 +-
 drivers/mmc/host/sdhci-pci-core.c                  |  31 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |  46 ++-
 drivers/mmc/host/sdhci-pci-o2micro.c               |   8 +
 drivers/mmc/host/sdhci-pci.h                       |   2 +
 drivers/mmc/host/sdhci-s3c.c                       |  22 +-
 drivers/mmc/host/sdhci-st.c                        |  23 +-
 drivers/mmc/host/sdhci-tegra.c                     |  66 +++--
 drivers/mmc/host/sdhci.c                           | 113 ++++----
 drivers/mmc/host/sdhci_am654.c                     |   2 +-
 drivers/mmc/host/tmio_mmc.h                        |   3 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  61 ++--
 drivers/mmc/host/uniphier-sd.c                     |   5 +-
 drivers/mmc/host/via-sdmmc.c                       |   3 +-
 include/linux/mmc/host.h                           |   7 +-
 include/linux/mmc/sdio.h                           |   2 +-
 include/linux/spi/mmc_spi.h                        |   9 -
 59 files changed, 1010 insertions(+), 642 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
