Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F184AC433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 12:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CBA601FC
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 12:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhBOMh5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Feb 2021 07:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhBOMhx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2021 07:37:53 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDD1C061756
        for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2021 04:37:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u25so9892975lfc.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2021 04:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3gXrmEhazg+jU5VkZP915PlzxsLsxfBnr/qYrJmR/s=;
        b=zvTarkF83ePM9M2RfsBVoXD2pdcYy2xkQWBGAQl+72GkazyXI5TopBnM7fgXAKvHI5
         rqI4mWvNBTzeAB0Me0/fnbss1qq5KmVKw5f5dOUO0yRXjdBSGGypBglpznghi+wx+6ei
         hTuQh/gPcj9BajfGxCW6k/IQ5KLf/7frpiWq76H2Cfb4KbY7JiiO87kHCf5SweC34Rjr
         5rMnr5eF+L6W/snVnfQSMwmT3o+9jBjNUQAJfY/lXa1u92N916upCuLM0AYvTQJGGW8a
         ahABI71oJ6HWz2jPGYwvTuu1A3xr901RqblAUW0LKmtU+rTFg+sI5FpNOx9wGnJ0Edw3
         OsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3gXrmEhazg+jU5VkZP915PlzxsLsxfBnr/qYrJmR/s=;
        b=FS83ncoVJ/Xpan/SffVrDhiKLp8DDmPIgiV3mFW4e9avAeC+PtZkGJhTTH0XLggT9s
         DrhMztR9ldZmAe3Us7g1D3PWxmWPkNt2Mpq2I/KDMHKcXobW+IHeFZc15QnjR+s+GPQp
         kD5hs/M1Zcw8ApQSDYRGn9d88PdhASki31IgfnZ+8Z3rONu4eJuzLcE3IMggghzj//xZ
         xzQ1r2nm7zWVXxCgYUikOHTdKdZMYz3shnUl7AcyCh0nvHrcPf/jyh+OCE8WFE0FjxNp
         fOw9z0CBU1dsPQBgBn6hKJw9036TIASX0y1rXZST502ClNJVyJrKdjWn+hIc2Mg66WGW
         C61Q==
X-Gm-Message-State: AOAM530ZDW6He7NOra+gIEfL2Cldfm0zXJwE0QvM65B8z+48zp6XNlum
        JC0WznGILSEDI/oHL9iMu8Ge7Q==
X-Google-Smtp-Source: ABdhPJxZirZ3DAWl5zvoOfs/d1yDCCRfPQ4zx5oyYjlchRq2+VEmN+EMsR+UZUbzqYJ4hx9bLa+KNA==
X-Received: by 2002:ac2:54ac:: with SMTP id w12mr8260909lfk.487.1613392631461;
        Mon, 15 Feb 2021 04:37:11 -0800 (PST)
Received: from localhost.localdomain (h-98-128-181-28.NA.cust.bahnhof.se. [98.128.181.28])
        by smtp.gmail.com with ESMTPSA id u4sm1574594lfs.61.2021.02.15.04.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 04:37:10 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v5.12
Date:   Mon, 15 Feb 2021 13:37:09 +0100
Message-Id: <20210215123709.7781-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with updates for MMC for v5.12 (nothing for MEMSTICK this cycle).
Details about the highlights are as usual found in the signed tag.

Some changes are included for drivers/scsi/ufs/*. These shouldn't cause you any
merge conflicts, I think, but just ping me if you need me to take some actions.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d7fb9c24209556478e65211d7a1f056f2d43cceb:

  mmc: sdhci-pltfm: Fix linking err for sdhci-brcmstb (2021-02-01 11:13:09 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12

for you to fetch changes up to a56f44138a2c57047f1ea94ea121af31c595132b:

  mmc: sdhci-esdhc-imx: fix kernel panic when remove module (2021-02-15 10:43:23 +0100)

----------------------------------------------------------------
MMC core:
 - Add support for eMMC inline encryption
 - Add a helper function to parse DT properties for clock phases
 - Some improvements and cleanups for the mmc_test module

MMC host:
 - android-goldfish: Remove driver
 - cqhci: Add support for eMMC inline encryption
 - dw_mmc-zx: Remove driver
 - meson-gx: Extend support for scatter-gather to allow SD_IO_RW_EXTENDED
 - mmci: Add support for probing bus voltage level translator
 - mtk-sd: Address race condition for request timeouts
 - sdhci_am654: Add Support for the variant on TI's AM64 SoC
 - sdhci-esdhc-imx: Prevent kernel panic at ->remove()
 - sdhci-iproc: Add ACPI bindings for the RPi to enable SD and WiFi on RPi4
 - sdhci-msm: Add Inline Crypto Engine support
 - sdhci-msm: Use actual_clock to improve timeout calculations
 - sdhci-of-aspeed: Add Andrew Jeffery as maintainer
 - sdhci-of-aspeed: Extend clock support for the AST2600 variant
 - sdhci-pci-gli: Increase idle period for low power state for GL9763E
 - sdhci-pci-o2micro: Make tuning for SDR104 HW more robust
 - sdhci-sirf: Remove driver
 - sdhci-xenon: Add support for the AP807 variant
 - sunxi-mmc: Add support for the A100 variant
 - sunxi-mmc: Ensure host is suspended during system sleep
 - tmio: Add detection of data timeout errors
 - tmio/renesas_sdhi: Extend support for retuning
 - renesas_sdhi_internal_dmac: Add support for the ->pre|post_req() ops

----------------------------------------------------------------
Andrew Jeffery (6):
      mmc: core: Add helper for parsing clock phase properties
      mmc: sdhci-of-aspeed: Expose clock phase controls
      mmc: sdhci-of-aspeed: Add AST2600 bus clock support
      mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
      MAINTAINERS: Add entry for the ASPEED SD/MMC driver
      mmc: sdhci-of-aspeed: Fix kunit-related build error

Arnd Bergmann (2):
      mmc: remove dw_mmc-zx driver
      mmc: remove sirf prima/atlas driver

Aswath Govindraju (1):
      dt-bindings: mmc: sdhci-am654: Add compatible string for AM64 SoC

ChanWoo Lee (2):
      mmc: core: Exclude unnecessary header file
      mmc: queue: Remove unused define

Chaotian Jing (1):
      mmc: mediatek: fix race condition between msdc_request_timeout and irq

Christophe JAILLET (4):
      mmc: mxs-mmc: Fix a resource leak in an error handling path in 'mxs_mmc_probe()'
      mmc: owl-mmc: Fix a resource leak in an error handling path and in the remove function
      mmc: sdhci-sprd: Fix some resource leaks in the remove function
      mmc: usdhi6rol0: Fix a resource leak in the error handling path of the probe

Dmitry Lebed (1):
      mmc: meson-gx: check for scatterlist size alignment in block mode

Douglas Anderson (2):
      mmc: sdhci-msm: Warn about overclocking SD/MMC
      mmc: sdhci-msm: Actually set the actual clock

Emil Renner Berthing (10):
      mmc: atmel-mci: Use new tasklet API
      mmc: au1xmmc: Use new tasklet API
      mmc: dw_mmc: Use new tasklet API
      mmc: omap: Use new tasklet API
      mmc: s3cmci: Use new tasklet API
      mmc: tifm_sd: Use new tasklet API
      mmc: uniphier-sd: Use new tasklet API
      mmc: via-sdmmc: Use new tasklet API
      mmc: wbsd: Use new tasklet API
      mmc: cb710: Use new tasklet API

Eric Biggers (10):
      block/keyslot-manager: introduce devm_blk_ksm_init()
      scsi: ufs: use devm_blk_ksm_init()
      mmc: core: Add basic support for inline encryption
      mmc: cqhci: rename cqhci.c to cqhci-core.c
      mmc: cqhci: initialize upper 64 bits of 128-bit task descriptors
      mmc: cqhci: add support for inline encryption
      mmc: cqhci: add cqhci_host_ops::program_key
      firmware: qcom_scm: update comment for ICE-related functions
      dt-bindings: mmc: sdhci-msm: add ICE registers and clock
      mmc: sdhci-msm: add Inline Crypto Engine support

Faiz Abbas (1):
      mmc: sdhci_am654: Add Support for TI's AM64 SoC

Frank Li (1):
      mmc: sdhci-esdhc-imx: fix kernel panic when remove module

Grygorii Strashko (1):
      dt-bindings: mmc: sdhci-am654: fix compatible for j7200

H. Nikolaus Schaller (2):
      mmc: jz4740: remove unused struct component card_detect_irq
      mmc: omap: remove unused struct component card_detect_irq

Jeremy Linton (1):
      mmc: sdhci-iproc: Add ACPI bindings for the RPi

Jiapeng Zhong (1):
      mmc: atmel-mci: Assign boolean values to a bool variable

Jisheng Zhang (1):
      mmc: sdhci-of-dwcmshc: set SDHCI_QUIRK2_PRESET_VALUE_BROKEN

Linus Walleij (1):
      mmc: mmci: Convert bindings to DT schema

Manivannan Sadhasivam (1):
      dt-bindings: mmc: sdhci-msm: Document the SDX55 compatible

Marcin Wojtas (2):
      dt-bindings: mmc: xenon: add AP807 compatible string
      mmc: xenon: add AP807 compatible string

Marek Vasut (2):
      mmc: mmci: Add bindings to operate CMD, CK, CKIN pins as GPIO
      mmc: mmci: Add support for probing bus voltage level translator

Masaharu Hayakawa (1):
      mmc: tmio: Add data timeout error detection

Muhammad Husaini Zulkifli (6):
      mmc: sdhci-of-arasan: Fixed kernel-doc format warning
      mmc: sdhci-of-arasan: Change code style of mapping the syscon field
      mmc: sdhci-of-arasan: use of_device_get_match_data()
      mmc: sdhci-of-arasan: Convert to use np instead of pdev->dev.of_node
      mmc: sdhci-of-arasan: Add structure device pointer in probe function
      mmc: sdhci-of-arasan: Use dev_err_probe() to avoid spamming logs

Renius Chen (3):
      mmc: sdhci-pci-gli: Add a switch to enable/disable CQHCI support
      mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL9763E
      mmc: sdhci-pci-gli: Finetune HS400 RX delay for GL9763E

Ricky Wu (2):
      mmc: rtsx: Add MMC_CAP2_NO_SDIO flag
      mmc: rtsx: add delay before power on

Roman Kiryanov (1):
      mmc: host: Retire MMC_GOLDFISH

Samuel Holland (1):
      mmc: sunxi-mmc: Ensure host is suspended during system sleep

Shirley Her (1):
      mmc: sdhci-pci-o2micro: Bug fix for SDR104 HW tuning failure

Takeshi Saito (1):
      mmc: renesas_sdhi_internal_dmac: Fix DMA buffer alignment from 8 to 128-bytes

Ulf Hansson (3):
      Merge branch 'fixes' into next
      mmc: core: Drop redundant member in struct mmc host
      mmc: core: Drop redundant bouncesz from struct mmc_card

Wolfram Sang (1):
      dt-bindings: mmc: renesas,sdhi: Add r8a779a0 support

Xiaofei Tan (1):
      mmc: cavium: Replace spin_lock_irqsave with spin_lock in hard IRQ

Yang Li (1):
      mmc: omap_hsmmc: Simplify bool comparison and conversion

Yangtao Li (2):
      dt-bindings: mmc: sunxi: Add Allwinner A100 and H616 compatibles
      mmc: sunxi: add support for A100 mmc controller

Yann Gautier (1):
      mmc: mmc_test: use erase_arg for mmc_erase command

Yoshihiro Shimoda (2):
      mmc: renesas_internal_dmac: add pre_req and post_req support
      mmc: renesas_sdhi: Add a condition of cmd/data timeout for retune

Yue Hu (6):
      mmc: core: remove needless err = 0 in mmc_init_card()
      mmc: core: remove redundant card null check to mmc_can_sleep()
      mmc: core: remove unused host parameter of mmc_sd_get_csd()
      mmc: test: remove the shutdown function
      mmc: test: clean up mmc_test_cleanup()
      mmc: core: Use host instead of card argument to mmc_spi_send_csd()

Zheng Yongjun (1):
      mmc: core: convert comma to semicolon

 Documentation/block/inline-encryption.rst          |  12 +-
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |   8 +
 .../devicetree/bindings/mmc/arm,pl18x.yaml         | 223 +++++++++
 .../bindings/mmc/marvell,xenon-sdhci.txt           |   1 +
 Documentation/devicetree/bindings/mmc/mmci.txt     |  74 ---
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   1 +
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |  19 +-
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   8 +-
 .../devicetree/bindings/mmc/sdhci-sirf.txt         |  18 -
 .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  31 --
 MAINTAINERS                                        |   9 +
 block/keyslot-manager.c                            |  29 ++
 drivers/firmware/qcom_scm.c                        |  16 +-
 drivers/mmc/core/Kconfig                           |   8 +
 drivers/mmc/core/Makefile                          |   1 +
 drivers/mmc/core/block.c                           |   3 +
 drivers/mmc/core/core.c                            |  11 +-
 drivers/mmc/core/crypto.c                          |  48 ++
 drivers/mmc/core/crypto.h                          |  40 ++
 drivers/mmc/core/host.c                            |  45 ++
 drivers/mmc/core/mmc.c                             |   6 +-
 drivers/mmc/core/mmc_ops.c                         |   6 +-
 drivers/mmc/core/mmc_test.c                        |  31 +-
 drivers/mmc/core/queue.c                           |   6 +-
 drivers/mmc/core/queue.h                           |   1 -
 drivers/mmc/core/sd.c                              |   4 +-
 drivers/mmc/core/sd.h                              |   2 +-
 drivers/mmc/core/sdio.c                            |   2 +-
 drivers/mmc/host/Kconfig                           |  43 +-
 drivers/mmc/host/Makefile                          |   5 +-
 drivers/mmc/host/android-goldfish.c                | 545 ---------------------
 drivers/mmc/host/atmel-mci.c                       |  52 +-
 drivers/mmc/host/au1xmmc.c                         |  14 +-
 drivers/mmc/host/cavium.c                          |   5 +-
 drivers/mmc/host/cb710-mmc.c                       |  12 +-
 drivers/mmc/host/{cqhci.c => cqhci-core.c}         |  69 ++-
 drivers/mmc/host/cqhci-crypto.c                    | 242 +++++++++
 drivers/mmc/host/cqhci-crypto.h                    |  47 ++
 drivers/mmc/host/cqhci.h                           |  84 +++-
 drivers/mmc/host/dw_mmc-zx.c                       | 234 ---------
 drivers/mmc/host/dw_mmc-zx.h                       |  32 --
 drivers/mmc/host/dw_mmc.c                          |   6 +-
 drivers/mmc/host/jz4740_mmc.c                      |   1 -
 drivers/mmc/host/meson-gx-mmc.c                    |  37 +-
 drivers/mmc/host/mmci.c                            |  70 ++-
 drivers/mmc/host/mtk-sd.c                          |  18 +-
 drivers/mmc/host/mxs-mmc.c                         |   2 +-
 drivers/mmc/host/omap.c                            |   7 +-
 drivers/mmc/host/omap_hsmmc.c                      |  18 +-
 drivers/mmc/host/owl-mmc.c                         |   9 +-
 drivers/mmc/host/renesas_sdhi_core.c               |  16 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  91 +++-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   5 +-
 drivers/mmc/host/s3cmci.c                          |   6 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   3 +-
 drivers/mmc/host/sdhci-iproc.c                     |  18 +
 drivers/mmc/host/sdhci-msm.c                       | 322 +++++++++++-
 drivers/mmc/host/sdhci-of-arasan.c                 |  65 ++-
 drivers/mmc/host/sdhci-of-aspeed-test.c            | 105 ++++
 drivers/mmc/host/sdhci-of-aspeed.c                 | 289 ++++++++++-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |   1 +
 drivers/mmc/host/sdhci-pci-gli.c                   |  23 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               |  20 +
 drivers/mmc/host/sdhci-sirf.c                      | 235 ---------
 drivers/mmc/host/sdhci-sprd.c                      |   6 +-
 drivers/mmc/host/sdhci-xenon.c                     |   1 +
 drivers/mmc/host/sdhci_am654.c                     |  28 ++
 drivers/mmc/host/sunxi-mmc.c                       |  30 +-
 drivers/mmc/host/tifm_sd.c                         |   7 +-
 drivers/mmc/host/tmio_mmc.h                        |   2 +-
 drivers/mmc/host/tmio_mmc_core.c                   |   8 +-
 drivers/mmc/host/uniphier-sd.c                     |  14 +-
 drivers/mmc/host/usdhi6rol0.c                      |   4 +-
 drivers/mmc/host/via-sdmmc.c                       |   9 +-
 drivers/mmc/host/wbsd.c                            |  35 +-
 drivers/scsi/ufs/ufshcd-crypto.c                   |   9 +-
 drivers/scsi/ufs/ufshcd-crypto.h                   |   5 -
 drivers/scsi/ufs/ufshcd.c                          |   1 -
 include/linux/keyslot-manager.h                    |   3 +
 include/linux/mmc/card.h                           |   1 -
 include/linux/mmc/core.h                           |   6 +
 include/linux/mmc/host.h                           |  25 +-
 include/linux/platform_data/mmc-omap.h             |   3 +-
 83 files changed, 2089 insertions(+), 1522 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmci.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
 create mode 100644 drivers/mmc/core/crypto.c
 create mode 100644 drivers/mmc/core/crypto.h
 delete mode 100644 drivers/mmc/host/android-goldfish.c
 rename drivers/mmc/host/{cqhci.c => cqhci-core.c} (94%)
 create mode 100644 drivers/mmc/host/cqhci-crypto.c
 create mode 100644 drivers/mmc/host/cqhci-crypto.h
 delete mode 100644 drivers/mmc/host/dw_mmc-zx.c
 delete mode 100644 drivers/mmc/host/dw_mmc-zx.h
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c
 delete mode 100644 drivers/mmc/host/sdhci-sirf.c
