Return-Path: <SRS0=N9dB=5P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CE5C2D0EF
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 16:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC10D20936
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 16:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VS2iV4cS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgC3QQz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:16:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45650 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbgC3QQz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2020 12:16:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id t17so18751310ljc.12
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2020 09:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tbwnUnjyQeKfrnt/3cYd+POS6VOgZrsvRznUNmU3R0=;
        b=VS2iV4cSp+SKR8gYF8WdCTjgc1REcTIv0xfSbzu+5UHvvF2IT7+L1NuTk/oKk4rRWM
         sRhgWLTrAtcY9uEkgoQ0/7bPe9dlb7570zLXVDErJsfjAI3TrSkBDDkXFCarQoBwKxq3
         eNceV/UYSB+GnkkqHaesHG146KyX/0dAfGyocGyH46LfW0v3djGfw4xZqtLadqpEdGvL
         RgyKnf9aOUIMBE8r1J9off7p9Co1ROc+tkKCMZslvc+yf1l5a6ISvGGV/Ue4UpocgDiT
         +llYovhsCvKPS0R3ole3dXrRVOq15DyIO6K1lkJkeFiBISpLqmOr5UdaiFz5DGOd6YRK
         Sy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tbwnUnjyQeKfrnt/3cYd+POS6VOgZrsvRznUNmU3R0=;
        b=Wa6868jFwIm9/1pvTnx6SDe0o9hC6yGnJg8/prmOGqAzyyF6Cj0N0WwaIAInbK1UBz
         oajHYIZ2qOHEib1bD68pDjXD7K2v4DCWJXcaYPzlabazsB6PhQTV0liO20PCu4VSlnxx
         gfs2rux3/ZF8/HF29yfgifnU8g0Z/Opiey0GbQY3ONBNgVfD6WTp7KbDe4NyjQNajfUu
         KW45T3ERAUK5WyflduJPWKESMuyCwoAOoKBBe1kgVnJofCd6wTKVSCAsjucNQYOMnVLG
         VtD3vybblwjw2Av7cxqUnwjKvqy5tk6u9QFnCJwZCj24jjXTGtwMfJXxjYVw7yt6q2xy
         yHeQ==
X-Gm-Message-State: AGi0PuavkQdBpBm7OSim1yL0MCquZ8RexjHqE3fs313+9U4QEDA4yRns
        +b1kpI3N2dpOK42t7NppNXT7fA==
X-Google-Smtp-Source: APiQypKAgHIc3ZLeXg3tvSh2AVo4slbEqNG7d6VeaXdm6YxW4WS9NlFmNZ77SN4tjs4EWEZ4SDq7FQ==
X-Received: by 2002:a2e:84c4:: with SMTP id q4mr4503719ljh.206.1585585011665;
        Mon, 30 Mar 2020 09:16:51 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id o68sm9247722lff.81.2020.03.30.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:16:50 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v5.7
Date:   Mon, 30 Mar 2020 18:16:49 +0200
Message-Id: <20200330161649.15352-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with the MMC updates for v5.7. Details about the highlights are as
usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7

for you to fetch changes up to 92075d98abf0f42db1cb518150364f196d4ad217:

  mmc: cavium-octeon: remove nonsense variable coercion (2020-03-27 13:26:25 +0100)

----------------------------------------------------------------
MMC core:
 - Add support for host software queue for (e)MMC/SD
 - Throttle polling rate for CMD6
 - Update CMD13 busy condition check for CMD6 commands
 - Improve busy detect polling for erase/trim/discard/HPI
 - Fixup support for HW busy detection for HPI commands
 - Re-work and improve support for eMMC sanitize commands

MMC host:
 - mmci: Add support for sdmmc variant revision 2.0
 - mmci_sdmmc: Improve support for busyend detection
 - mmci_sdmmc: Fixup support for signal voltage switch
 - mmci_sdmmc: Add support for tuning with delay block
 - mtk-sd: Fix another SDIO irq issue
 - sdhci: Disable native card detect when GPIO based type exist
 - sdhci: Add option to defer request completion
 - sdhci_am654: Add support to set a tap value per speed mode
 - sdhci-esdhc-imx: Add support for i.MX8MM based variant
 - sdhci-esdhc-imx: Fixup support for standard tuning on i.MX8 usdhc
 - sdhci-esdhc-imx: Optimize for strobe/clock dll settings
 - sdhci-esdhc-imx: Fixup support for system and runtime suspend/resume
 - sdhci-iproc: Update regulator/bus-voltage management for bcm2711
 - sdhci-msm: Prevent clock gating with PWRSAVE_DLL on broken variants
 - sdhci-msm: Fix management of CQE during SDHCI reset
 - sdhci-of-arasan: Add support for auto tuning on ZynqMP based platforms
 - sdhci-omap: Add support for system suspend/resume
 - sdhci-sprd: Add support for HW busy detection
 - sdhci-sprd: Enable support host software queue
 - sdhci-tegra: Add support for HW busy detection
 - tmio/renesas_sdhi: Enforce retune after runtime suspend
 - renesas_sdhi: Use manual tap correction for HS400 on some variants
 - renesas_sdhi: Add support for manual correction of tap values for tunings

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: cqhci: Add cqhci_deactivate()

Baolin Wang (7):
      mmc: Add MMC host software queue support
      mmc: core: Enable the MMC host software queue for the SD card
      mmc: host: sdhci: Add request_done ops for struct sdhci_ops
      mmc: host: sdhci: Add a variable to defer to complete requests if needed
      mmc: host: sdhci-sprd: Add software queue support
      mmc: host: hsq: Add missing MODULE_LICENSE() and MODULE_DESCRIPTION()
      mmc: sdhci-sprd: Set the missing MMC_CAP_WAIT_WHILE_BUSY flag

Cristian Birsan (1):
      mmc: sdhci-of-at91: Display clock changes for debug purpose only

Faiz Abbas (4):
      dt-bindings: mmc: sdhci-am654: Update Output tap delay binding
      mmc: sdhci_am654: Update OTAPDLY writes
      mmc: sdhci_am654: Enable DLL only for some speed modes
      mmc: sdhci-omap: Add Support for Suspend/Resume

Geert Uytterhoeven (1):
      mmc: renesas_sdhi: Use BITS_PER_LONG helper

Gustavo A. R. Silva (1):
      mmc: Replace zero-length array with flexible-array member

Haibo Chen (13):
      mmc: sdhci: do not enable card detect interrupt for gpio cd type
      mmc: sdhci-esdhc-imx: no fail when no pinctrl available
      mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs
      mmc: sdhci-esdhc-imx: restore the per_clk rate in PM_RUNTIME
      doc: dt: fsl-imx-esdhc: add strobe-dll-delay-target binding
      mmc: sdhci-esdhc-imx: add strobe-dll-delay-target support
      mmc: sdhci-esdhc-imx: optimize the clock setting
      mmc: sdhci-esdhc-imx: optimize the strobe dll setting
      mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_BROKEN_AUTO_CMD23
      mmc: sdhci-esdhc-imx: Add an new esdhc_soc_data for i.MX8MM
      mmc: sdhci-esdhc-imx: clear pending interrupt and halt cqhci
      mmc: sdhci-esdhc-imx: clear DMA_SEL when disable DMA mode
      mmc: sdhci-esdhc-imx: restore pin state when resume back

Johan Jonker (1):
      dt-bindings: mmc: synopsys-dw-mshc: fix clock-freq-min-max in example

Jérôme Pouiller (1):
      mmc: core: Fix indentation

Lubomir Rintel (1):
      dt-bindings: mmc: Fix node name in an example

Ludovic Barre (10):
      mmc: mmci_sdmmc: Replace sg_dma_xxx macros
      mmc: mmci_sdmmc: Rename sdmmc_priv struct to sdmmc_idma
      mmc: mmci: Add a reference at mmc_host_ops in mmci struct
      mmc: mmci: Add private pointer for variant
      dt-bindings: mmc: mmci: add delay block base register for sdmmc
      mmc: mmci_sdmmc: Add execute tuning with delay block
      mmc: mmci: Add callbacks for to manage signal voltage switch
      mmc: mmci_sdmmc: Implement signal voltage callbacks
      mmc: mmci: Add support for sdmmc variant revision 2.0
      mmc: mmci_sdmmc: Fix clear busyd0end irq flag

Manish Narani (4):
      firmware: xilinx: Add ZynqMP Tap Delay setup ioctl to the valid list
      firmware: xilinx: Add DLL reset support
      mmc: sdhci-of-arasan: Add support for DLL reset for ZynqMP platforms
      mmc: sdhci-of-arasan: Remove quirk for broken base clock

Masahiro Yamada (1):
      mmc: sdhci: use FIELD_GET for preset value bit masks

Nicolas Saenz Julienne (6):
      mmc: sdhci: Introduce sdhci_set_power_and_bus_voltage()
      mmc: sdhci: arasan: Use sdhci_set_power_and_voltage()
      mmc: sdhci: milbeaut: Use sdhci_set_power_and_voltage()
      mmc: sdhci: at91: Use sdhci_set_power_and_voltage()
      mmc: sdhci: am654: Use sdhci_set_power_and_voltage()
      mmc: sdhci: iproc: Add custom set_power() callback for bcm2711

Ritesh Harjani (1):
      mmc: sdhci-msm: Don't enable PWRSAVE_DLL for certain sdhc hosts

Sowjanya Komatineni (2):
      sdhci: tegra: Implement Tegra specific set_timeout callback
      sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability

Takashi Iwai (1):
      mmc: vub300: Use scnprintf() for avoiding potential buffer overflow

Takeshi Saito (2):
      mmc: renesas_sdhi: Add manual correction
      mmc: renesas_sdhi: only check CMD status for HS400 manual correction

Tang Bin (1):
      mmc: cavium-octeon: remove nonsense variable coercion

Ulf Hansson (12):
      mmc: core: Throttle polling rate for CMD6
      mmc: core: Drop unused define
      mmc: core: Extend mmc_switch_status() to rid of __mmc_switch_status()
      mmc: core: Drop redundant in-parameter to __mmc_switch()
      mmc: core: Split up mmc_poll_for_busy()
      mmc: core: Enable re-use of mmc_blk_in_tran_state()
      mmc: core: Update CMD13 busy check for CMD6 commands
      mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard
      mmc: core: Drop redundant out-parameter to mmc_send_hpi_cmd()
      mmc: core: Convert to mmc_poll_for_busy() for HPI commands
      mmc: core: Fixup support for HW busy detection for HPI commands
      mmc: core: Re-work the code for eMMC sanitize

Veerabhadrarao Badiganti (4):
      dt-bindings: mmc: sdhci-msm: Add CQE reg map
      mmc: mmc_test: Pass different sg lists for non-blocking requests
      mmc: sdhci-msm: Deactivate CQE during SDHC reset
      mmc: cqhci: Update cqhci memory ioresource name

Wolfram Sang (10):
      mmc: renesas_sdhi: remove double clear of automatic correction
      mmc: renesas_sdhi: enforce manual correction for Gen3
      mmc: renesas_sdhi: cleanup SCC defines
      mmc: tmio: refactor tuning execution into SDHI driver
      mmc: renesas_sdhi: complain loudly if driver needs update
      mmc: tmio: give callback a generic name
      mmc: tmio: enforce retune after runtime suspend
      mmc: tmio: factor out TAP usage
      mmc: tmio: remove superfluous callback wrappers
      mmc: renesas_sdhi: simplify execute_tuning

yong mao (1):
      mmc: mediatek: fix SDIO irq issue

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   5 +
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   2 +-
 Documentation/devicetree/bindings/mmc/mmci.txt     |   2 +
 .../devicetree/bindings/mmc/sdhci-am654.txt        |  21 +-
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   8 +-
 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml  |   2 +-
 drivers/firmware/xilinx/zynqmp.c                   |   2 +
 drivers/mmc/core/block.c                           | 125 ++++----
 drivers/mmc/core/core.c                            |  54 +---
 drivers/mmc/core/mmc.c                             |  56 ++--
 drivers/mmc/core/mmc_ops.c                         | 194 ++++++++----
 drivers/mmc/core/mmc_ops.h                         |  15 +-
 drivers/mmc/core/mmc_test.c                        |  52 ++-
 drivers/mmc/core/queue.c                           |  22 +-
 drivers/mmc/core/sd.c                              |  10 +
 drivers/mmc/core/sdio_irq.c                        |  15 +-
 drivers/mmc/host/Kconfig                           |  12 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/cavium-octeon.c                   |   4 +-
 drivers/mmc/host/cqhci.c                           |  16 +-
 drivers/mmc/host/cqhci.h                           |   6 +-
 drivers/mmc/host/mmc_hsq.c                         | 348 +++++++++++++++++++++
 drivers/mmc/host/mmc_hsq.h                         |  30 ++
 drivers/mmc/host/mmci.c                            |  43 ++-
 drivers/mmc/host/mmci.h                            |   8 +
 drivers/mmc/host/mmci_stm32_sdmmc.c                | 208 +++++++++++-
 drivers/mmc/host/mtk-sd.c                          |  41 +++
 drivers/mmc/host/renesas_sdhi.h                    |   6 +
 drivers/mmc/host/renesas_sdhi_core.c               | 183 ++++++++---
 drivers/mmc/host/sdhci-acpi.c                      |   2 +-
 drivers/mmc/host/sdhci-cadence.c                   |   2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 167 ++++++++--
 drivers/mmc/host/sdhci-esdhc.h                     |   1 +
 drivers/mmc/host/sdhci-iproc.c                     |  17 +-
 drivers/mmc/host/sdhci-milbeaut.c                  |  13 +-
 drivers/mmc/host/sdhci-msm.c                       |  27 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  74 ++++-
 drivers/mmc/host/sdhci-of-at91.c                   |  22 +-
 drivers/mmc/host/sdhci-omap.c                      |  57 ++++
 drivers/mmc/host/sdhci-pci.h                       |   2 +-
 drivers/mmc/host/sdhci-pltfm.h                     |   2 +-
 drivers/mmc/host/sdhci-sprd.c                      |  30 +-
 drivers/mmc/host/sdhci-tegra.c                     |  35 ++-
 drivers/mmc/host/sdhci.c                           |  45 ++-
 drivers/mmc/host/sdhci.h                           |  18 +-
 drivers/mmc/host/sdhci_am654.c                     | 264 ++++++++++------
 drivers/mmc/host/tmio_mmc.h                        |  11 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  77 +----
 drivers/mmc/host/vub300.c                          |   4 +-
 include/linux/firmware/xlnx-zynqmp.h               |   9 +-
 include/linux/mmc/core.h                           |   3 -
 include/linux/mmc/host.h                           |   7 +-
 include/linux/mmc/mmc.h                            |  10 +
 include/linux/mmc/sdio_func.h                      |   2 +-
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
 include/uapi/linux/mmc/ioctl.h                     |   2 +-
 56 files changed, 1825 insertions(+), 570 deletions(-)
 create mode 100644 drivers/mmc/host/mmc_hsq.c
 create mode 100644 drivers/mmc/host/mmc_hsq.h
