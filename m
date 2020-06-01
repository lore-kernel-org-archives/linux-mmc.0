Return-Path: <SRS0=cZK/=7O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BA1C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Jun 2020 08:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63A52063A
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Jun 2020 08:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNTQKpHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFAI0T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgFAI0T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2020 04:26:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580BC05BD43
        for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2020 01:26:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so7074551ljn.2
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jun 2020 01:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2X1cV6IT2o8pkCM7hYXBasHTDS4pONixTQL7glYTeV8=;
        b=iNTQKpHsCAN9u5brgxBaXRL1GGqPaQavLDqhsNiC6c2XI29MoDb5zAq51+Aj1sbvZn
         zePdI/tXFuqNxymzW5wgZWDoJ/5z00HY5ZjQ1TzWzHo0j6T+whD78K9ihb5el4SiOdYy
         RgcH4MZxLS/UpwgPPuF5P4PMzEp+LfciiAT/K5DPyzbAj64uFCAsrrmAk9a5bUe2pLs2
         qhOvzlDSK5XbtvZRAo0AJIUOsAiMaSiihXrifzewOr4T8XPb/luTBEBvLaEIg4O2ZGrz
         hhCnygNWeH3vmQoIPHue34Mp+o71Xi+B5eyixy/WXx12KzZJ/loqk42EAyDq+qzzQFIb
         68Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2X1cV6IT2o8pkCM7hYXBasHTDS4pONixTQL7glYTeV8=;
        b=sjVw11Ssvi/8OiCHx3+8/0npAJ0CQin0LlVtS2Ed2XqZ88G9I2457jbUI/JYKd/RmA
         8/5XpI4nquIfex8kx9nLKZm9moLLZjEn/SLO5THjimZFtQdzPnAweU3j9PRB8orsW9HJ
         M6KBbgWOBJQXzla3UPkg50Y581GrnaxL8SBd9+2x3b4DsM43bEC+WqHr9B0XcpGKpEqg
         5r4l/iJzZv7HhLIs8wKT5pCAnFRWMtOAzdvP8bE4izwHQGH+DN1kNwyNeQ+4bX1uJwf9
         qLAPyciLxKOvpopjmdiWor/tQNm3zlaiAxNDkJLrNOYrb3s+JvHLlfxXIyq/rh9Nhg3d
         er0Q==
X-Gm-Message-State: AOAM533wDiXzQTs6uUgUVtISzLRW2bmcZ1kN/LIkfsbiGu1gRFoQfSGl
        05XRMMB9HnpXgmFUnygl5QWx6Q==
X-Google-Smtp-Source: ABdhPJy2qh2/1mftBFFNMVh6mWJoWsDblGCsHyZQvOb78YKoaNLO+YhFlAJ+0t9OuUtaO63ATtwAhg==
X-Received: by 2002:a2e:574c:: with SMTP id r12mr5428191ljd.12.1590999976000;
        Mon, 01 Jun 2020 01:26:16 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id y199sm4562221lff.6.2020.06.01.01.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 01:26:14 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.8
Date:   Mon,  1 Jun 2020 10:26:13 +0200
Message-Id: <20200601082613.4566-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with MMC and MEMSTICK updates for v5.8. Details about the
highlights are as usual found in the signed tag.

Note that, there are couple of changes included that touches arch/m68k code,
those have been acked accordingly and no merge conflict has been reported. The
similar applies to some bluetooth/wifi drivers, which is using the SDIO
functional API.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8

for you to fetch changes up to ae5c0585dfc2168c589de5878df2e591dfbd4bf0:

  dt-bindings: mmc: Convert sdhci-pxa to json-schema (2020-06-01 08:05:13 +0200)

----------------------------------------------------------------
MMC core:
 - Enable erase/discard/trim support for all (e)MMC/SD hosts
 - Export information through sysfs about enhanced RPMB support (eMMC v5.1+)
 - Align the initialization commands for SDIO cards
 - Fix SDIO initialization to prevent memory leaks and NULL pointer errors
 - Do not export undefined MMC_NAME/MODALIAS for SDIO cards
 - Export device/vendor field from common CIS for SDIO cards
 - Move SDIO IDs from functional drivers to the common SDIO header
 - Introduce the ->request_atomic() host ops

MMC host:
 - Improve support for HW busy signaling for several hosts
 - Converting some DT bindings to the json-schema
 - meson-mx-sdhc: Add driver and DT doc for the Amlogic Meson SDHC controller
 - meson-mx-sdio: Run a soft reset to recover from timeout/CRC error
 - mmci: Convert to use mmc_regulator_set_vqmmc()
 - mmci_stm32_sdmmc: Fix a couple of DMA bugs
 - mmci_stm32_sdmmc: Fix power on issue
 - renesas,mmcif,sdhci: Document r8a7742 DT bindings
 - renesas_sdhi: Add support for M3-W ES1.2 and 1.3 revisions
 - renesas_sdhi: Improvements to the TAP selection
 - renesas_sdhi/tmio: Further fixup runtime PM management at ->remove()
 - sdhci: Introduce ops to dump vendor specific registers
 - sdhci-cadence: Fix PHY write sequence
 - sdhci-esdhc-imx: Improve tunings
 - sdhci-esdhc-imx: Enable GPIO card detect as system wakeup
 - sdhci-esdhc-imx: Add HS400 support for i.MX6SLL
 - sdhci-esdhc-mcf: Add driver for the Coldfire/M5441X esdhc controller
   - m68k: mcf5441x: Add platform data to enable esdhc mmc controller
 - sdhci-msm: Improve HS400 tuning
 - sdhci-msm: Dump vendor specific registers at error
 - sdhci-msm: Add support for DLL/DDR properties provided from DT
 - sdhci-msm: Add support for the sm8250 variant
 - sdhci-msm: Add support for DVFS by converting to dev_pm_opp_set_rate()
 - sdhci-of-arasan: Add support for Intel Keem Bay variant
 - sdhci-of-arasan: Add support for Xilinx Versal SD variant
 - sdhci-of-dwcmshc: Add support for system suspend/resume
 - sdhci-of-dwcmshc: Fix UHS signaling support
 - sdhci-of-esdhc: Fix tuning for eMMC HS400 mode
 - sdhci-pci-gli: Add Genesys Logic GL9763E support
 - sdhci-sprd: Add support for the ->request_atomic() ops
 - sdhci-tegra: Avoid reading autocal timeout values when not applicable

MEMSTICK:
 - Minor trivial update.

----------------------------------------------------------------
Adrian Hunter (6):
      mmc: sdhci: Fix SDHCI_QUIRK_BROKEN_CQE
      mmc: sdhci: Add helpers for the auto-CMD23 flag
      mmc: sdhci: Stop exporting sdhci_send_command()
      mmc: sdhci: Remove unneeded forward declaration of sdhci_finish_data()
      mmc: sdhci: Tidy sdhci_request() a bit
      mmc: sdhci: Reduce maximum time under spinlock in sdhci_send_command()

Angelo Dureghello (5):
      m68k: mcf5441x: add support for esdhc mmc controller
      mmc: sdhci: add quirks for be to le byte swapping
      mmc: host: add Coldfire esdhc support
      MAINTAINERS: add myself to maintain M5441X mmc host driver
      m68k: coldfire/clk.c: move m5441x specific code

Baolin Wang (3):
      mmc: host: Introduce the request_atomic() for the host
      mmc: host: sdhci: Implement the request_atomic() API
      mmc: host: sdhci-sprd: Implement the request_atomic() API

Ben Chuang (1):
      mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support

Eugen Hristev (1):
      mmc: sdhci-of-at91: fix CALCR register being rewritten

Gustavo A. R. Silva (1):
      memstick: Replace zero-length array with flexible-array

Haibo Chen (5):
      mmc: sdhci: add spin lock for sdhci_set_default_irqs in sdhci_init
      mmc: sdhci-esdhc-imx: Add HS400 support for i.MX6SLL
      mmc: host: sdhci-esdhc-imx: add wakeup feature for GPIO CD pin
      mmc: sdhci-esdhc-imx: fix the mask for tuning start point
      mmc: sdhci-esdhc-imx: disable the CMD CRC check for standard tuning

Jisheng Zhang (3):
      mmc: sd: use HIGH_SPEED_BUS_SPEED in mmc_sd_switch_hs()
      mmc: sdhci-of-dwcmshc: implement specific set_uhs_signaling
      mmc: sdhci-of-dwcmshc: add suspend/resume support

Jérôme Pouiller (1):
      mmc: fix compilation of user API

Krishna Konda (1):
      mmc: core: expose info about enhanced rpmb support

Lad Prabhakar (2):
      dt-bindings: mmc: renesas,mmcif: Document r8a7742 DT bindings
      dt-bindings: mmc: renesas,sdhi: Document r8a7742 support

Lubomir Rintel (1):
      dt-bindings: mmc: Convert sdhci-pxa to json-schema

Ludovic Barre (3):
      mmc: mmci_sdmmc: fix power on issue due to pwr_reg initialization
      mmc: mmci_sdmmc: fix DMA API warning overlapping mappings
      mmc: mmci_sdmmc: fix DMA API warning max segment size

Manish Narani (6):
      dt-bindings: mmc: arasan: Document 'xlnx,versal-8.9a' controller
      sdhci: arasan: Add support for Versal Tap Delays
      mmc: sdhci-of-arasan: Rename sdhci_arasan_data to avoid confusion
      mmc: sdhci-of-arasan: Rearrange the platform data structs for modularity
      mmc: sdhci-of-arasan: Modify clock operations handling
      mmc: sdhci-of-arasan: Fix kernel-doc warnings

Marek Vasut (3):
      mmc: host: Prepare host drivers for mmc_regulator_set_vqmmc() returning > 0
      mmc: core: Return 1 from mmc_regulator_set_vqmmc() if switch skipped
      mmc: mmci: Switch to mmc_regulator_set_vqmmc()

Martin Blumenstingl (6):
      mmc: meson-mx-sdio: trigger a soft reset after a timeout or CRC error
      dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
      mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host
      mmc: meson-mx-sdhc: Fix building with CONFIG_MMC_MESON_MX_SDHC=m
      mmc: meson-mx-sdhc: Fix manual RX FIFO flushing
      mmc: meson-mx-sdhc: Don't use literal 0 to initialize structs

Masahiro Yamada (5):
      mmc: sdhci: move SDHCI_CAPABILITIES_1 to a more suitable place
      mmc: sdhci: use FIELD_GET/PREP for capabilities bit masks
      mmc: sdhci-of-at91: make MMC_SDHCI_OF_AT91 depend on HAVE_CLK
      mmc: uniphier-sd: call devm_request_irq() after tmio_mmc_host_probe()
      mmc: sdhci: use FIELD_GET/PREP for current capabilities bit masks

Nathan Chancellor (1):
      mmc: sdhci-of-arasan: Remove uninitialized ret variables

Pali Rohár (13):
      mmc: sdio: Fix macro name for Marvell device with ID 0x9134
      mmc: sdio: Change macro names for Marvell 8688 modules
      mmc: sdio: Move SDIO IDs from mwifiex driver to common include file
      mmc: sdio: Move SDIO IDs from btmrvl driver to common include file
      mmc: sdio: Move SDIO IDs from btmtksdio driver to common include file
      mmc: sdio: Move SDIO IDs from smssdio driver to common include file
      mmc: sdio: Move SDIO IDs from ath6kl driver to common include file
      mmc: sdio: Move SDIO IDs from ath10k driver to common include file
      mmc: sdio: Move SDIO IDs from b43-sdio driver to common include file
      mmc: sdio: Fix Cypress SDIO IDs macros in common include file
      mmc: sdio: Sort all SDIO IDs in common include file
      mmc: core: Do not export MMC_NAME= and MODALIAS=mmc:block for SDIO cards
      mmc: core: Export device/vendor ids from Common CIS for SDIO cards

Peng Hao (1):
      mmc: block: Fix use-after-free issue for rpmb

Rajendra Nayak (2):
      mmc: sdhci-msm: Use OPP API to set clk/perf state
      mmc: sdhci-msm: Fix error handling for dev_pm_opp_of_add_table()

Sarthak Garg (7):
      dt-bindings: mmc: Add new compatible string for sm8250 target
      dt-bindings: mmc: Add information for DLL register properties
      mmc: sdhci-msm: Update dll_config_3 as per HSR
      mmc: sdhci-msm: Update DDR_CONFIG as per device tree file
      mmc: sdhci-msm: Read and use DLL Config property from device tree file
      mmc: sdhci-msm: Introduce new ops to dump vendor specific registers
      mmc: sdhci-msm: dump vendor specific registers during error

Sowjanya Komatineni (1):
      sdhci: tegra: Avoid reading autocal timeout values when not applicable

Takeshi Saito (1):
      mmc: renesas_sdhi: Avoid bad TAP in HS400

Ulf Hansson (33):
      mmc: android-goldfish: Enable MMC_CAP2_NO_SDIO
      mmc: sdhci-sprd: Drop redundant cap flags
      mmc: au1xmmc: Drop redundant code in au1xmmc_send_command()
      mmc: s3cmci: Drop redundant code in s3cmci_setup_data()
      mmc: wbsd: Replace hardcoded command numbers with existing defines
      mmc: atmel-mci: Keep timer enabled when queuing a next request
      mmc: atmel-mci: Set the timer per command rather than per request
      mmc: atmel-mci: Respect the cmd->busy_timeout from the mmc core
      mmc: usdhi6rol0: Inform the mmc core about the maximum busy timeout
      staging: greybus: sdio: Respect the cmd->busy_timeout from the mmc core
      mmc: jz4740: Inform the mmc core about the maximum busy timeout
      mmc: owl-mmc: Respect the cmd->busy_timeout from the mmc core
      mmc: sdricoh_cs: Drop unused defines
      mmc: sdricoh_cs: Use MMC_APP_CMD rather than a hardcoded number
      mmc: sdricoh_cs: Move MMC_APP_CMD handling to sdricoh_mmc_cmd()
      mmc: sdricoh_cs: Drop redundant in-parameter to sdricoh_query_status()
      mmc: tifm_sd: Inform the mmc core about the maximum busy timeout
      mmc: via-sdmmc: Respect the cmd->busy_timeout from the mmc core
      mmc: mmc_spi: Add/rename defines for timeouts
      mmc: mmc_spi: Respect the cmd->busy_timeout from the mmc core
      mmc: sdio: Fix potential NULL pointer error in mmc_sdio_init_card()
      mmc: sdio: Fix several potential memory leaks in mmc_sdio_init_card()
      mmc: sdio: Re-use negotiated OCR mask when re-sending CMD8
      mmc: sdio: Align the initialization commands in retry path for UHS-I
      mmc: cb710: Inform the mmc core about the maximum busy timeout
      mmc: sdricoh_cs: Throttle polling rate for data transfers
      mmc: sdricoh_cs: Throttle polling rate for commands
      mmc: sdricoh_cs: Respect the cmd->busy_timeout from the mmc core
      mmc: core: Enable erase/discard/trim support for all mmc hosts
      mmc: host: Drop redundant MMC_CAP_ERASE
      mmc: tmio: Further fixup runtime PM management at remove
      mmc: tmio: Make sure the PM domain is 'started' while probing
      Merge branch 'fixes' into next

Veerabhadrarao Badiganti (4):
      mmc: sdhci-msm: Set SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk
      mmc: sdhci-msm: Enable ADMA length mismatch error interrupt
      mmc: host: sdhci-msm: Configure dll-user-control in dll init sequence
      mmc: sdhci-msm: Clear tuning done flag while hs400 tuning

Vladimir Kondratiev (1):
      mmc: sdhci-cadence: fix PHY write

Wan Ahmad Zainie (2):
      dt-bindings: mmc: arasan: Add compatible strings for Intel Keem Bay
      mmc: sdhci-of-arasan: Add support for Intel Keem Bay

Wolfram Sang (8):
      mmc: renesas_sdhi: refactor calculation of best TAP
      mmc: renesas_sdhi: clarify handling of selecting TAPs
      mmc: renesas_sdhi: improve TAP selection if all TAPs are good
      mmc: renesas_sdhi: simplify summary output
      mmc: renesas_sdhi: shorten types after refactorization
      mmc: renesas_sdhi: handle M3-W ES1.2 and 1.3 revisions
      mmc: sdhci-esdhc: update contact email
      mmc: renesas_sdhi: remove manual clk handling

Yangbo Lu (1):
      mmc: sdhci-of-esdhc: exit HS400 properly before setting any speed mode

Zou Wei (2):
      mmc: core: Use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
      mmc: sdhci-pci-o2micro: Make some symbols static

 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml        |  68 ++
 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  57 ++
 .../devicetree/bindings/mmc/renesas,mmcif.txt      |   5 +-
 .../devicetree/bindings/mmc/renesas,sdhi.txt       |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |  14 +
 .../devicetree/bindings/mmc/sdhci-pxa.txt          |  50 --
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 102 +++
 MAINTAINERS                                        |   7 +
 arch/m68k/coldfire/device.c                        |  33 +-
 arch/m68k/coldfire/m5441x.c                        |  27 +-
 arch/m68k/include/asm/m5441xsim.h                  |  15 +
 arch/m68k/include/asm/mcfclk.h                     |   2 +
 drivers/bluetooth/btmrvl_sdio.c                    |  18 +-
 drivers/bluetooth/btmtksdio.c                      |   4 +-
 drivers/media/mmc/siano/smssdio.c                  |  10 +-
 drivers/mmc/core/block.c                           |   2 +-
 drivers/mmc/core/bus.c                             |  14 +
 drivers/mmc/core/core.c                            |   6 +-
 drivers/mmc/core/debugfs.c                         |   6 +-
 drivers/mmc/core/mmc.c                             |   6 +
 drivers/mmc/core/quirks.h                          |   2 +-
 drivers/mmc/core/regulator.c                       |  17 +-
 drivers/mmc/core/sd.c                              |  30 +-
 drivers/mmc/core/sdio.c                            | 136 +--
 drivers/mmc/host/Kconfig                           |  29 +-
 drivers/mmc/host/Makefile                          |   3 +
 drivers/mmc/host/android-goldfish.c                |  10 +-
 drivers/mmc/host/atmel-mci.c                       |  12 +-
 drivers/mmc/host/au1xmmc.c                         |  20 +-
 drivers/mmc/host/bcm2835.c                         |   3 +-
 drivers/mmc/host/cavium.c                          |   3 +-
 drivers/mmc/host/cb710-mmc.c                       |   8 +
 drivers/mmc/host/dw_mmc-k3.c                       |   2 +-
 drivers/mmc/host/dw_mmc.c                          |   9 +-
 drivers/mmc/host/jz4740_mmc.c                      |  13 +-
 drivers/mmc/host/meson-gx-mmc.c                    |   5 +-
 drivers/mmc/host/meson-mx-sdhc-clkc.c              | 158 ++++
 drivers/mmc/host/meson-mx-sdhc-mmc.c               | 914 +++++++++++++++++++++
 drivers/mmc/host/meson-mx-sdhc.h                   | 141 ++++
 drivers/mmc/host/meson-mx-sdio.c                   |   5 +-
 drivers/mmc/host/mmc_hsq.c                         |  29 +-
 drivers/mmc/host/mmc_hsq.h                         |   1 +
 drivers/mmc/host/mmc_spi.c                         |  20 +-
 drivers/mmc/host/mmci.c                            |  30 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c                |  15 +-
 drivers/mmc/host/mtk-sd.c                          |  21 +-
 drivers/mmc/host/mvsdio.c                          |   2 -
 drivers/mmc/host/mxs-mmc.c                         |   3 +-
 drivers/mmc/host/omap.c                            |   2 +-
 drivers/mmc/host/omap_hsmmc.c                      |   2 +-
 drivers/mmc/host/owl-mmc.c                         |   8 +-
 drivers/mmc/host/renesas_sdhi.h                    |   5 +-
 drivers/mmc/host/renesas_sdhi_core.c               | 146 ++--
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   2 +-
 drivers/mmc/host/s3cmci.c                          |   7 -
 drivers/mmc/host/sdhci-cadence.c                   |  10 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  45 +-
 drivers/mmc/host/sdhci-esdhc-mcf.c                 | 521 ++++++++++++
 drivers/mmc/host/sdhci-esdhc.h                     |   2 +-
 drivers/mmc/host/sdhci-msm.c                       | 162 +++-
 drivers/mmc/host/sdhci-of-arasan.c                 | 594 ++++++++++---
 drivers/mmc/host/sdhci-of-at91.c                   |  12 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |  74 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  34 +
 drivers/mmc/host/sdhci-pci-core.c                  |   9 +-
 drivers/mmc/host/sdhci-pci-gli.c                   | 106 +++
 drivers/mmc/host/sdhci-pci-o2micro.c               |   8 +-
 drivers/mmc/host/sdhci-pci.h                       |   2 +
 drivers/mmc/host/sdhci-sprd.c                      |  28 +-
 drivers/mmc/host/sdhci-tegra.c                     |  57 +-
 drivers/mmc/host/sdhci.c                           | 293 +++++--
 drivers/mmc/host/sdhci.h                           |  38 +-
 drivers/mmc/host/sdricoh_cs.c                      | 105 +--
 drivers/mmc/host/sunxi-mmc.c                       |  10 +-
 drivers/mmc/host/tifm_sd.c                         |   9 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  10 +-
 drivers/mmc/host/uniphier-sd.c                     |  12 +-
 drivers/mmc/host/usdhi6rol0.c                      |   9 +-
 drivers/mmc/host/via-sdmmc.c                       |   7 +-
 drivers/mmc/host/wbsd.c                            |  26 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |  25 +-
 drivers/net/wireless/ath/ath10k/sdio.h             |   8 -
 drivers/net/wireless/ath/ath6kl/hif.h              |   6 -
 drivers/net/wireless/ath/ath6kl/sdio.c             |  17 +-
 drivers/net/wireless/broadcom/b43/sdio.c           |   4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |   6 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   4 +-
 drivers/net/wireless/marvell/libertas/if_sdio.c    |   2 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |  38 +-
 drivers/staging/greybus/sdio.c                     |  11 +-
 include/linux/memstick.h                           |   2 +-
 include/linux/mmc/card.h                           |   1 +
 include/linux/mmc/host.h                           |   4 +-
 include/linux/mmc/mmc.h                            |   1 +
 include/linux/mmc/sdio_ids.h                       |  94 ++-
 include/linux/platform_data/mmc-esdhc-imx.h        |   2 +-
 include/linux/platform_data/mmc-esdhc-mcf.h        |  17 +
 include/uapi/linux/mmc/ioctl.h                     |   1 +
 99 files changed, 3888 insertions(+), 800 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
 create mode 100644 drivers/mmc/host/meson-mx-sdhc-clkc.c
 create mode 100644 drivers/mmc/host/meson-mx-sdhc-mmc.c
 create mode 100644 drivers/mmc/host/meson-mx-sdhc.h
 create mode 100644 drivers/mmc/host/sdhci-esdhc-mcf.c
 create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h
