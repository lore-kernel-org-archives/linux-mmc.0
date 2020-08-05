Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EC4C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 07:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F2422B40
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 07:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hkbbgb9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgHEHfC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEHfC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 03:35:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A8EC06174A
        for <linux-mmc@vger.kernel.org>; Wed,  5 Aug 2020 00:35:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w25so11083594ljo.12
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2020 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fRPBVj60nMtWa/s2FrntXxpL29tailGK8Vk9a7Gnxg=;
        b=hkbbgb9Nh8Ur2QAAQJhk45tBdNu0ROW3nUm3ymah+mjuvndV+8c0GFs6gS9RV0oKEs
         TPN00wliTfZZOduKJeskawh7ar0K7rjqSDF/sRzz4tnrKob8JQjBLjqlaVtgBcCWfscL
         XMj/mlEDx2r7Y4Bm5BCTcs5ad2DJCFJeWao3HE8gdHCShItCKIGLgEx6Wi1S136wao2M
         cCcjn1+vOYJ32pHcUPbjlsxcYdDYktrtaFy7b9hUKlrzyOjuZJCt2M2fQ96Md2zCTIUC
         zZmhPmQjUr0Sw9O2K0wQY65aUUNAiBf6n3A8Qi9zD4EiNSky5yPRcfFCW25TtG897Qxz
         3xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fRPBVj60nMtWa/s2FrntXxpL29tailGK8Vk9a7Gnxg=;
        b=Uic+0PJueD3+tVm48nfgrIcBKDvw1j5f80IJ+O4XvqSkVb4Ec7I9R02jdOxVpo/hgt
         7Txs3UplevQJWWWLx3K4wQ3/SSa9gTpcdYeCFjvjudTdwNpLEUicgTEQgxkOmzlz6nbU
         2pVmeRRG2wu9PhI+KBN/Blvl5jPt062lrs+lckEr40CLwAgvTwAkwzd1bhP4FTP/GdAZ
         JTVe5l+mJuzH04f1BE72aSIqhBomig49V7VAmYCFpJakDcDAZntSLTu0NPfWcpjI1GI5
         wgMqCPe8YcnK5Fghzm9n4b3KVVx9XTVyrEgxfGlw7TDa/8q5ECmi/kKBhu7gEH/fbVvU
         U2RQ==
X-Gm-Message-State: AOAM533dTRDODf2DofmVOCFOv0z+4hxbvMnPHGnO25+P0f+qmskL+Xsz
        JsOFmXpaWpkLULw58YIPBIguoA==
X-Google-Smtp-Source: ABdhPJxyk3P8FnX/bSYK2YD11kIgnWrAd44vtnxHIg2XTGhZey+MA7HbyAt2AuOmtIhINgzZoZZsMQ==
X-Received: by 2002:a2e:b051:: with SMTP id d17mr805630ljl.231.1596612900142;
        Wed, 05 Aug 2020 00:35:00 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id h21sm514864ljk.31.2020.08.05.00.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 00:34:58 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.9
Date:   Wed,  5 Aug 2020 09:34:57 +0200
Message-Id: <20200805073457.11906-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with MMC and MEMSTICK updates for v5.9. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ebd4050c6144b38098d8eed34df461e5e3fa82a9:

  mmc: sdhci-of-aspeed: Fix clock divider calculation (2020-07-13 12:17:34 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9

for you to fetch changes up to 7f4bc2e8687ecea52177aac30fb153cc076f7022:

  mmc: mediatek: make function msdc_cqe_disable() static (2020-08-05 08:28:15 +0200)

----------------------------------------------------------------
MMC core:
 - Add a new host cap bit and a corresponding DT property, to support power
cycling of the card by FW at system suspend/resume.
 - Fix clock rate setting for SDIO in SDR12/SDR25 speed-mode
 - Fix switch to 1/4-bit mode at system suspend/resume for SD-combo cards
 - Convert the mmc-pwrseq DT bindings to the json-schema
 - Always allow the card detect uevent to be consumed by userspace

MMC host:
 - Convert a few DT bindings to the json-schema
 - mtk-sd: Add support for command queue through cqhci
 - mtk-sd: Add support for the MT6779 variant
 - renesas_sdhi_internal_dmac: Fix dma unmapping in the error path
 - sdhci_am654: Add support for the AM65x PG2.0 variant
 - sdhci_am654: Extend support for phys/clocks
 - sdhci-cadence: Drop incorrect HW tuning for SD mode
 - sdhci-msm: Add support for interconnect bandwidth scaling
 - sdhci-msm: Enable internal voltage control
 - sdhci-msm: Enable low power state for pinctrls
 - sdhci-of-at91: Ludovic Desroches handovers maintenance to Eugen Hristev
 - sdhci-pci-gli: Improve clock handling for GL975x
 - sdhci-pci-o2micro: Add HW tuning for SDR104 mode
 - sdhci-pci-o2micro: Fix support for O2 host controller Seabird1

----------------------------------------------------------------
Akshu Agrawal (1):
      mmc: sdhci-acpi: For amd device set driver type as MMC_SET_DRIVER_TYPE_A

Ben Chuang (2):
      mmc: cqhci: Fix a print format for the task descriptor
      mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL975x

Chuhong Yuan (1):
      mmc: sdhci-of-arasan: Add missed checks for devm_clk_register()

Chun-Hung Wu (4):
      mmc: mediatek: add MT6779 MMC driver support
      mmc: mediatek: refine msdc timeout api
      mmc: mediatek: command queue support
      dt-bindings: mmc: mediatek: Add document for mt6779

Colin Ian King (1):
      mmc: dw_mmc-exynos: remove redundant initialization of variable 'found'

Dan Carpenter (1):
      mmc: sdhci: Fix a potential uninitialized variable

Faiz Abbas (6):
      dt-bindings: mmc: sdhci-am654: Add ti,clkbuf-sel binding
      mmc: sdhci_am654: Add flag for PHY calibration
      mmc: sdhci_am654: Add Support for SR2.0
      mmc: sdhci_am654: Fix conditions for enabling dll
      mmc: sdhci_am654: Update delay chain configuration
      mmc: sdhci_am654: Add support for clkbuf_sel property

Flavio Suligoi (1):
      mmc: sdhci-msm: Fix spelling mistake

Geert Uytterhoeven (1):
      mmc: sh_mmcif: Use "kHz" for kilohertz

Haibo Chen (2):
      mmc: sdio: fix clock rate setting for SDR12/SDR25 mode
      mmc: sdhci-esdhc-imx: dump internal IC debug status during error

Hulk Robot (1):
      mmc: sdhci-msm: Make function sdhci_msm_dump_vendor_regs() static

Jisheng Zhang (1):
      dt-bindings: mmc: Convert pwrseq to json-schema

Lee Jones (15):
      mmc: core: Mark fixups as __maybe_unused
      mmc: core: Provide description for sdio_set_host_pm_flags()'s 'flag' arg
      mmc: core: Add missing documetation for 'mmc' and 'ios'
      mmc: sdhci-s3c: Provide documentation for missing struct properties
      mmc: mtk-sd: Demote msdc_recheck_sdio_irq() function header
      mmc: atmel-mci: Provide 2 new and correct 1 existing property description
      mmc: core: Correct misspelling of 'mq' in mmc_init_request()'s docs
      mmc: dw_mmc-exynos: Add kerneldoc descriptions of for 'dev' args
      mmc: rtsx_pci_sdmmc: Remove set but unused variable 'err'
      mmc: rtsx_usb_sdmmc: Remove set but unused variable 'err'
      mmc: sdhci-of-arasan: Correct formatting and provide missing function arg(s)
      mmc: sdhci-msm: Demote faux kerneldoc header down to basic comment block
      mmc: cqhci: Demote faux kerneldoc header down to basic comment block
      arch: arm: mach-omap2: mmc: Move omap_mmc_notify_cover_event() prototype
      mmc: sdhci-iproc: Do not define 'struct acpi_device_id' when !CONFIG_ACPI

Ludovic Barre (1):
      mmc: mmci: add sdio datactrl mask for sdmmc revisions

Ludovic Desroches (1):
      MAINTAINERS: mmc: sdhci-of-at91: handover maintenance to Eugen Hristev

Manish Narani (1):
      mmc: sdhci-of-arasan: fix timings allocation code

Masahiro Yamada (1):
      mmc: sdhci-cadence: do not use hardware tuning for SD mode

Pali Rohár (1):
      mmc: sdio: Move SDIO IDs from rsi_sdio driver to common include file

Pradeep P V K (2):
      mmc: sdhci-msm: Add interconnect bandwidth scaling support
      dt-bindings: mmc: sdhci-msm: Add interconnect BW scaling strings

Sowjanya Komatineni (1):
      mmc: sdhci-tegra: Add comment for PADCALIB and PAD_CONTROL NVQUIRKS

Ulf Hansson (2):
      mmc: core: Always allow the card detect uevent to be consumed
      Merge branch 'fixes' into next

Vaibhav Gupta (2):
      memstick: jmb38x_ms: use generic power management
      mmc: via-sdmmc: use generic power management

Veerabhadrarao Badiganti (4):
      mmc: core: Set default power mode in mmc_alloc_host()
      mmc: sdhci-msm: Use internal voltage control
      mmc: sdhci-msm: Set IO pins in low power state during suspend
      mmc: sdhci: Fix potential null pointer access while accessing vqmmc

Vijay Viswanath (1):
      mmc: sdhci: Allow platform controlled voltage switching

Wan Ahmad Zainie (1):
      dt-bindings: mmc: convert arasan sdhci bindings to yaml

Wei Yongjun (1):
      mmc: mediatek: make function msdc_cqe_disable() static

Yoshihiro Shimoda (6):
      mmc: tmio: core: Add end operation into tmio_mmc_dma_ops
      mmc: renesas_sdhi_internal_dmac: clean up the code for dma complete
      mmc: renesas_sdhi_internal_dmac: Fix dma unmapping in error cases
      dt-bindings: mmc: Add full-pwr-cycle-in-suspend property
      mmc: core: Add MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND
      dt-bindings: mmc: renesas,sdhi: convert to YAML

Yue Hu (3):
      mmc: sdio: Return ret if sdio_disable_func() fails
      mmc: sdio: Enable SDIO 4-bit bus if not support SD_SCR_BUS_WIDTH_4 for SD combo card
      mmc: sdio: Fix 1-bit mode for SD-combo cards during suspend

shirley her (2):
      mmc: sdhci-pci-o2micro: Bug fix for O2 host controller Seabird1
      mmc: sdhci-pci-o2micro: Add HW tuning for SDR104 mode

 .../devicetree/bindings/mmc/arasan,sdhci.txt       | 192 -------------
 .../devicetree/bindings/mmc/arasan,sdhci.yaml      | 299 +++++++++++++++++++++
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   5 +
 .../devicetree/bindings/mmc/mmc-pwrseq-emmc.txt    |  25 --
 .../devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml   |  46 ++++
 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt  |  16 --
 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml |  39 +++
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  31 ---
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.yaml |  62 +++++
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |   1 +
 .../devicetree/bindings/mmc/renesas,sdhi.txt       | 114 --------
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      | 191 +++++++++++++
 .../devicetree/bindings/mmc/sdhci-am654.txt        |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |  18 ++
 MAINTAINERS                                        |   2 +-
 arch/arm/mach-omap2/mmc.h                          |   4 -
 drivers/memstick/host/jmb38x_ms.c                  |  38 +--
 drivers/mmc/core/core.c                            |  11 +-
 drivers/mmc/core/host.c                            |   6 +
 drivers/mmc/core/mmc.c                             |   3 +-
 drivers/mmc/core/queue.c                           |   2 +-
 drivers/mmc/core/quirks.h                          |   6 +-
 drivers/mmc/core/regulator.c                       |   2 +
 drivers/mmc/core/sdio.c                            |  64 +++--
 drivers/mmc/core/sdio_io.c                         |   3 +-
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/atmel-mci.c                       |   4 +-
 drivers/mmc/host/cqhci.c                           |   4 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
 drivers/mmc/host/mmci.c                            |   2 +
 drivers/mmc/host/mtk-sd.c                          | 163 ++++++++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  28 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   4 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   5 +-
 drivers/mmc/host/sdhci-acpi.c                      |   1 +
 drivers/mmc/host/sdhci-cadence.c                   | 123 ++++-----
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  39 +++
 drivers/mmc/host/sdhci-iproc.c                     |   2 +
 drivers/mmc/host/sdhci-msm.c                       | 235 +++++++++++++++-
 drivers/mmc/host/sdhci-of-arasan.c                 |  32 ++-
 drivers/mmc/host/sdhci-pci-gli.c                   | 220 ++++++++++++++-
 drivers/mmc/host/sdhci-pci-o2micro.c               |  39 ++-
 drivers/mmc/host/sdhci-s3c.c                       |   4 +
 drivers/mmc/host/sdhci-tegra.c                     |   9 +
 drivers/mmc/host/sdhci.c                           |  24 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sdhci_am654.c                     |  86 ++++--
 drivers/mmc/host/sh_mmcif.c                        |   6 +-
 drivers/mmc/host/tmio_mmc.h                        |   3 +
 drivers/mmc/host/tmio_mmc_core.c                   |   8 +
 drivers/mmc/host/via-sdmmc.c                       |  33 +--
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |   8 +-
 drivers/net/wireless/rsi/rsi_sdio.h                |   4 -
 include/linux/mmc/host.h                           |   2 +
 include/linux/mmc/sdio_ids.h                       |   4 +
 include/linux/platform_data/mmc-omap.h             |   3 +
 56 files changed, 1655 insertions(+), 627 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
