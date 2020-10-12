Return-Path: <SRS0=rM9+=DT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BC6C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 10:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184AB20E65
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 10:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxRp7sMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgJLKBd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Oct 2020 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbgJLKBc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2020 06:01:32 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58743C0613CE
        for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2020 03:01:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h20so16354138lji.9
        for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2020 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieamwB3zmGvy19m/eNlB/InMbH7St08rAsEJKQn2jbA=;
        b=IxRp7sMb1lbVC6r6isklV6piCUJ/DGW1tsaZRw98CINL/2d0FQh+71ix5iFDf46o4w
         Bh8tTXaNr5sXIFcBHB+4XZktgVoRe5C9HNnQecCTg0Y5/88Nd/wXYaPYyxM6DwFdzaLw
         0WIbA7TI9L14DAuoGaudsU1XG00qfvbOKequnKzwjJAewsb8e0NTHxzSmtMaWMGAEyb9
         heHQe2Qs38C2Vc7eaP5S/Ol0G5BgSLO2kDkBrt7vhN0v4qZSTC4goi0apFuAarWe1i/D
         gvXy//LjXD7UoAJ5LM4uexiMR4/rKgjK6kQG+ASOHrd30nk7mKePQY2czSjh5cQFCfrw
         KTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieamwB3zmGvy19m/eNlB/InMbH7St08rAsEJKQn2jbA=;
        b=EF5uhPmk8IjdieEkWcIZ4wXh7iWFmmPQuFrEHSwrCPlIfCjnLYyA2ZpCmeoTGwZAU1
         fFwUpQPRBwlYFBAvPn4R/w5tSWnZf/LZxMSTEcP7qiahql+GgJINiLB/kIfOBgPeRnNY
         jjhwZIAZM0Ilb7KHR6xflpH3Reiy+9VCELQ5/R7w36RBv7iTaaA2gsBwA2x4Fq2Co8rs
         BHtCFRyA6AvstQEeEA0z6fvqCilBK+/g/zueJtEtoGeuNWX31Y0LmVwbdf0eqKDM0Ea4
         IwC+goZsoYStn9WBOo+umVi/0LfWBVHzbiNXOIJpvchYV0jZsw9QvBryr70+H5+1sKSB
         OW4g==
X-Gm-Message-State: AOAM533ThbcNUxRDV2pQdSdehW0LEoMinhSIpyYdTzcbiktScZcQtt0R
        OSLqmg4RqKhtzmqCgx5RU9HyBA==
X-Google-Smtp-Source: ABdhPJxlLuO9/bXJHvkTF1GOZaZ6FpIQ3RCZ0qxAz7rUpS6RSdRWMjqCAYbfaNszAu/8LPaN7cG5pQ==
X-Received: by 2002:a2e:8e83:: with SMTP id z3mr9722522ljk.165.1602496890399;
        Mon, 12 Oct 2020 03:01:30 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-91.NA.cust.bahnhof.se. [98.128.180.91])
        by smtp.gmail.com with ESMTPSA id u10sm3864879lja.110.2020.10.12.03.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 03:01:29 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v5.10
Date:   Mon, 12 Oct 2020 12:01:27 +0200
Message-Id: <20201012100127.339152-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with the updates for MMC for v5.10. Details about the highlights
are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4243219141b67d7c2fdb2d8073c17c539b9263eb:

  mmc: core: don't set limits.discard_granularity as 0 (2020-10-09 08:26:09 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10

for you to fetch changes up to 1e23400f1a7342a2805cc647e6314cd12bfb5526:

  mmc: sdhci_am654: Fix module autoload (2020-10-09 08:58:58 +0200)

----------------------------------------------------------------
MMC core:
 - Export SDIO revision and info strings to userspace
 - Add support for specifying mmc/mmcblk index via mmc aliases in DT

MMC host:
 - Enable support for async probe for all mmc host drivers
 - Enable compile testing of multiple host drivers
 - dw_mmc: Enable the Synopsys DesignWare driver for RISCV and CSKY
 - mtk-sd: Fixup support for CQHCI
 - owl-mmc: Add support for the actions,s700-mmc variant
 - renesas_sdhi: Fix regression (temporary) for re-insertion of SD cards
 - renesas_sdhi: Add support for the r8a774e1 variant
 - renesas_sdhi/tmio: Improvements for tunings
 - renesas_sdhi/tmio: Rework support for reset of controller
 - sdhci-acpi: Fix HS400 tuning for devices with invalid presets on AMDI0040
 - sdhci_am654: Improve support for tunings
 - sdhci_am654: Add support for input tap delays
 - sdhci_am654: Add workaround for card detect debounce timer
 - sdhci-am654: Add support for the TI's J7200 variants
 - sdhci-esdhc-imx: Fix support for manual tuning
 - sdhci-iproc: Enable support for eMMC DDR 3.3V for bcm2711
 - sdhci-msm: Fix stability issues with HS400 for sc7180
 - sdhci-of-sparx5: Add Sparx5 SoC eMMC driver
 - sdhci-of-esdhc: Fixup reference clock source selection
 - sdhci-pci: Add LTR support for some Intel BYT controllers
 - sdhci-pci-gli: Add CQHCI Support for GL9763E

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Add LTR support for some Intel BYT based controllers

Alex Dewar (1):
      mmc: sdhci-msm: enable compile-testing on !ARM

Alexander A. Klimov (1):
      mmc: sdhci_am654: Replace HTTP links with HTTPS ones

Amey Narkhede (1):
      mmc: mediatek: Drop pointer to mmc_host from msdc_host

Amit Singh Tomar (1):
      dt-bindings: mmc: owl: add compatible string actions,s700-mmc

Ben Chuang (1):
      mmc: sdhci-pci-gli: Add CQHCI Support for GL9763E

Chun-Hung Wu (2):
      mmc: cqhci: add new cqhci_host_ops pre_enable() and post_disable()
      mmc: mediatek: add pre_enable() and post_disable() hook function

Colin Ian King (1):
      ms_block: fix spelling mistake "doesn'" -> "doesn't"

Douglas Anderson (7):
      mmc: sdhci-msm: Prefer asynchronous probe
      mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4
      mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.9
      mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.14
      mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.19
      mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v5.4
      mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that are newer than 5.4

Faiz Abbas (9):
      dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's J7200 devices
      mmc: sdhci_am654: Add workaround for card detect debounce timer
      dt-bindings: mmc: sdhci-am654: Convert sdhci-am654 controller documentation to json schema
      dt-bindings: mmc: sdhci-am654: Add documentation for input tap delay
      mmc: sdhci_am654: Fix hard coded otap delay array size
      mmc: sdhci_am654: Add support for input tap delay
      mmc: sdhci_am654: Add support for software tuning
      mmc: sdhci_am654: Enable tuning for SDR50
      mmc: sdhci_am654: Fix module autoload

Guo Ren (1):
      mmc: Kconfig: Add RISCV and CSKY for MMC_DW

Haibo Chen (2):
      mmc: sdhci-esdhc-imx: Reset before sending tuning command for manual tuning
      mmc: sdhci-esdhc-imx: remove unused code

Krzysztof Kozlowski (22):
      mmc: s3cmci: remove empty kerneldoc comment
      dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching
      dt-bindings: mmc: mmc-pwreq-simple: Accept more than one reset GPIO
      mmc: bcm2835: Simplify with dev_err_probe()
      mmc: davinci: Simplify with dev_err_probe()
      mmc: dw_mmc-zx: Simplify with dev_err_probe()
      mmc: jz4740: Simplify with dev_err_probe()
      mmc: meson: Simplify with dev_err_probe()
      mmc: sdhci-of-arasan: Simplify with dev_err_probe()
      mmc: sdhci-tegra: Simplify with dev_err_probe()
      mmc: dw_mmc: Simplify with dev_err_probe()
      mmc: sdhci-of-sparx5: Use proper printk format for dma_addr_t
      mmc: sdhci-brcmstb: Simplify with optional clock and dev_err_probe()
      mmc: davinci: Fix -Wpointer-to-int-cast on compile test
      mmc: s3cmci: Use proper printk format for iomem pointer
      mmc: s3cmci: Cast driver data through long
      mmc: s3cmci: Drop unused variables in dbg_dumpregs
      mmc: host: Drop unneeded MMC dependency in Kconfig
      mmc: host: Enable compile testing of multiple drivers
      mmc: moxart: remove unneeded check for drvdata
      mmc: sdhci: fix indentation mistakes
      mmc: sdhci-s3c: hide forward declaration of of_device_id behind CONFIG_OF

Lad Prabhakar (1):
      dt-bindings: mmc: renesas,sdhi: Add r8a774e1 support

Lars Povlsen (2):
      dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
      mmc: sdhci-of-sparx5: Add Sparx5 SoC eMMC driver

Madhuparna Bhowmik (1):
      mmc: via-sdmmc: Fix data race bug

Matthias Schiffer (2):
      dt-bindings: mmc: document alias support
      mmc: core: Allow setting slot index via device tree alias

Pali Rohár (4):
      mmc: sdio: Check for CISTPL_VERS_1 buffer size
      mmc: sdio: Parse CISTPL_VERS_1 major and minor revision numbers
      mmc: sdio: Extend sdio_config_attr macro and use it also for modalias
      mmc: sdio: Export SDIO revision and info strings to userspace

Qinglang Miao (1):
      mmc: rtsx_usb_sdmmc: simplify the return expression of sd_change_phase()

Randy Dunlap (1):
      mmc: host: fix depends for MMC_MESON_GX w/ COMPILE_TEST

Raul E Rangel (1):
      mmc: sdhci-acpi: AMDI0040: Set SDHCI_QUIRK2_PRESET_VALUE_BROKEN

Robin Murphy (1):
      mmc: renesas_sdhi: Drop local dma_parms

Stefan Wahren (1):
      mmc: sdhci-iproc: Enable eMMC DDR 3.3V support for bcm2711

Tian Tao (1):
      mmc: sd: Use kobj_to_dev() instead of container_of()

Tobias Schramm (1):
      mmc: mmc_spi: fix timeout calculation

Ulf Hansson (5):
      Merge branch 'fixes' into next
      mmc: Drop COMPILE_TEST Kconfig option for MMC_S3C
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next

Veerabhadrarao Badiganti (1):
      mmc: sdhci-msm: Enable restore_dll_config flag for sc7180 target

Viresh Kumar (1):
      mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()

Wolfram Sang (19):
      mmc: test: remove ambiguity in test description
      mmc: core: Improve documentation of MMC_CAP_HW_RESET
      mmc: renesas_sdhi: move wrong 'hw_reset' to 'reset'
      Revert "mmc: tmio: fix reset operation"
      mmc: tmio: remove indirection of 'hw_reset' callback
      mmc: tmio: factor out common parts of the reset routine
      mmc: tmio: don't reset whole IP core when tuning fails
      mmc: tmio: remove indirection of 'execute_tuning' callback
      mmc: meson-gx: use wrapper to avoid accessing internal vars
      mmc: core: when downgrading HS400, callback into drivers earlier
      mmc: core: add a 'doing_init_tune' flag and a 'mmc_doing_tune' helper
      mmc: renesas_sdhi: keep SCC clock active when tuning
      mmc: core: simplify an expression
      mmc: tmio: add generic hook to fixup after a completed request
      mmc: renesas_sdhi: support manual calibration
      mmc: core: clear 'doing_init_tune' also after failures
      mmc: core: document mmc_hw_reset()
      mmc: renesas_sdhi: drop local flag for tuning
      mmc: renesas_sdhi: workaround a regression when reinserting SD cards

Xu Wang (1):
      mmc: omap-hsmmc: remove redundant null check

Yangbo Lu (1):
      mmc: sdhci-of-esdhc: fix reference clock source selection

 .../devicetree/bindings/clock/imx8qxp-lpcg.yaml    |   2 +-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  37 +--
 .../bindings/mmc/microchip,dw-sparx5-sdhci.yaml    |  65 +++++
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   4 +
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.yaml |   2 +
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml |   6 +-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   1 +
 .../devicetree/bindings/mmc/sdhci-am654.txt        |  61 -----
 .../devicetree/bindings/mmc/sdhci-am654.yaml       | 218 +++++++++++++++++
 drivers/memstick/core/ms_block.c                   |   2 +-
 drivers/mmc/core/bus.c                             |  12 +
 drivers/mmc/core/core.c                            |  10 +
 drivers/mmc/core/host.c                            |  26 +-
 drivers/mmc/core/mmc.c                             |  22 +-
 drivers/mmc/core/mmc_test.c                        |   8 +-
 drivers/mmc/core/sd.c                              |  38 ++-
 drivers/mmc/core/sdio.c                            |  24 ++
 drivers/mmc/core/sdio_bus.c                        |  54 +++--
 drivers/mmc/core/sdio_cis.c                        |  11 +
 drivers/mmc/host/Kconfig                           |  53 ++--
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/alcor.c                           |   1 +
 drivers/mmc/host/android-goldfish.c                |   1 +
 drivers/mmc/host/atmel-mci.c                       |   1 +
 drivers/mmc/host/au1xmmc.c                         |   1 +
 drivers/mmc/host/bcm2835.c                         |   5 +-
 drivers/mmc/host/cavium-octeon.c                   |   1 +
 drivers/mmc/host/cqhci.c                           |   6 +
 drivers/mmc/host/cqhci.h                           |   2 +
 drivers/mmc/host/davinci_mmc.c                     |   8 +-
 drivers/mmc/host/dw_mmc-bluefield.c                |   1 +
 drivers/mmc/host/dw_mmc-exynos.c                   |   1 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 +
 drivers/mmc/host/dw_mmc-k3.c                       |   1 +
 drivers/mmc/host/dw_mmc-pltfm.c                    |   1 +
 drivers/mmc/host/dw_mmc-rockchip.c                 |   1 +
 drivers/mmc/host/dw_mmc-zx.c                       |  12 +-
 drivers/mmc/host/dw_mmc.c                          |   9 +-
 drivers/mmc/host/jz4740_mmc.c                      |   5 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  19 +-
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |   1 +
 drivers/mmc/host/meson-mx-sdio.c                   |   1 +
 drivers/mmc/host/mmc_spi.c                         |   4 +-
 drivers/mmc/host/moxart-mmc.c                      |  24 +-
 drivers/mmc/host/mtk-sd.c                          |  68 ++++--
 drivers/mmc/host/mvsdio.c                          |   1 +
 drivers/mmc/host/mxcmmc.c                          |   1 +
 drivers/mmc/host/mxs-mmc.c                         |   1 +
 drivers/mmc/host/omap.c                            |   1 +
 drivers/mmc/host/omap_hsmmc.c                      |  19 +-
 drivers/mmc/host/owl-mmc.c                         |   1 +
 drivers/mmc/host/pxamci.c                          |   1 +
 drivers/mmc/host/renesas_sdhi.h                    |   6 +-
 drivers/mmc/host/renesas_sdhi_core.c               | 233 +++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   5 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   1 +
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   1 +
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   8 +-
 drivers/mmc/host/s3cmci.c                          |  14 +-
 drivers/mmc/host/sdhci-acpi.c                      |  38 +++
 drivers/mmc/host/sdhci-bcm-kona.c                  |   1 +
 drivers/mmc/host/sdhci-brcmstb.c                   |  13 +-
 drivers/mmc/host/sdhci-cadence.c                   |   1 +
 drivers/mmc/host/sdhci-cns3xxx.c                   |   1 +
 drivers/mmc/host/sdhci-dove.c                      |   1 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  17 +-
 drivers/mmc/host/sdhci-esdhc-mcf.c                 |   1 +
 drivers/mmc/host/sdhci-iproc.c                     |   2 +
 drivers/mmc/host/sdhci-milbeaut.c                  |   1 +
 drivers/mmc/host/sdhci-msm.c                       |  16 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   8 +-
 drivers/mmc/host/sdhci-of-aspeed.c                 |   2 +
 drivers/mmc/host/sdhci-of-at91.c                   |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                |   1 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |  19 +-
 drivers/mmc/host/sdhci-of-hlwd.c                   |   1 +
 drivers/mmc/host/sdhci-of-sparx5.c                 | 270 +++++++++++++++++++++
 drivers/mmc/host/sdhci-omap.c                      |   1 +
 drivers/mmc/host/sdhci-pci-core.c                  | 154 ++++++++++++
 drivers/mmc/host/sdhci-pci-gli.c                   | 150 +++++++++++-
 drivers/mmc/host/sdhci-pic32.c                     |   1 +
 drivers/mmc/host/sdhci-pxav2.c                     |   1 +
 drivers/mmc/host/sdhci-pxav3.c                     |   1 +
 drivers/mmc/host/sdhci-s3c.c                       |   3 +
 drivers/mmc/host/sdhci-sirf.c                      |   1 +
 drivers/mmc/host/sdhci-spear.c                     |   1 +
 drivers/mmc/host/sdhci-sprd.c                      |   5 +-
 drivers/mmc/host/sdhci-st.c                        |   1 +
 drivers/mmc/host/sdhci-tegra.c                     |   8 +-
 drivers/mmc/host/sdhci-xenon.c                     |   1 +
 drivers/mmc/host/sdhci_am654.c                     | 207 +++++++++++++---
 drivers/mmc/host/sdhci_f_sdh30.c                   |   1 +
 drivers/mmc/host/sh_mmcif.c                        |   1 +
 drivers/mmc/host/sunxi-mmc.c                       |   1 +
 drivers/mmc/host/tmio_mmc.c                        |   9 +-
 drivers/mmc/host/tmio_mmc.h                        |   8 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  48 +---
 drivers/mmc/host/uniphier-sd.c                     |   6 +-
 drivers/mmc/host/usdhi6rol0.c                      |   1 +
 drivers/mmc/host/via-sdmmc.c                       |   3 +
 drivers/mmc/host/wbsd.c                            |   1 +
 drivers/mmc/host/wmt-sdmmc.c                       |   1 +
 include/linux/mmc/card.h                           |   2 +
 include/linux/mmc/host.h                           |   9 +-
 include/linux/mmc/sdio_func.h                      |   2 +
 105 files changed, 1743 insertions(+), 404 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-sparx5.c
