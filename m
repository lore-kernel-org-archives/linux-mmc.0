Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB96C2B9F4
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 10:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1B561C6A
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 10:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhF1KWO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Jun 2021 06:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1KWN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jun 2021 06:22:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC4C061766
        for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2021 03:19:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t17so31719613lfq.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2021 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ine6V2enSE0x/gosxEwrCjqckJ3LAzUMWP8HGmmuSp8=;
        b=dmit0bhDxjwxxkNzc6y69zsxk8K62fC6Oh2Hynkzee4xKWPdOIFj/9gm2V07uy9k+s
         b3r6SI5Fv+OHWhHJ6gQB+odqHPlk3RP50oRJ0ETJeSvGsWRsvZ+RPEX1VXg8DTKgTGKq
         8C7PKhu41vhD8ZjeuHIcIT+15QtOSsB2dvsbq13HMdyIv10h9g6JvSwfvlFsRQcGdhNN
         y4AVEbd79B/DTqnLwMrGrdMfkRYAcGd72Q5f6pAFw7L8xz1o2g+XsJ9mVlBVzuzuhjRw
         FJG+LiFnmPkMChxD6iFA1AA9IM4LxHQQltMGyIk80xgjmnNS8tYxSmiqfwY+c3+ywtk/
         H+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ine6V2enSE0x/gosxEwrCjqckJ3LAzUMWP8HGmmuSp8=;
        b=CtMjTLgFDsdusv1qPWFwOkWoVVCFoxqMY22fOUI+tFlJ5k8RlJ6EY3aKYOx8C8NRtN
         2STlCMTvUC3Bkna1oAEtdr/9RiUShIXVKv1Uoy8eSRYR+R7GZpV+ORXcYsbAz+M5Gy90
         VCjkvGsi71bP2g3fX7KxorgdOdYDMNzATl7PgNTxSSYyriFddn8MbhrbXXgDNo+PSQuJ
         C2+dnpIYIYNj9biF5wcpHffSgqR2Gm4jRloFlT5tLGxi1xKH6lbznGrZWBroQbUlWomc
         BdVp9vFf7W+zCpnKIIdK7tEalQM2Ow/iWxjyY8KMZ83rlWdfeI8Ivu5WxzzujxTEPWh/
         I3HQ==
X-Gm-Message-State: AOAM533rBLjxPi/j9EMV96YCTtIs6FrTOkcj1W5f+0B/+eLkLkuA54oA
        oAhLuB08puH0atCT6CrtFPz2mQ==
X-Google-Smtp-Source: ABdhPJxylk55IZcQEpHZ1aNHKTgfXb/YAfHWHH5bzzl7xMim3P9ix5tygRImbuIcWBz1RI1d8zls4w==
X-Received: by 2002:a19:6a05:: with SMTP id u5mr18542582lfu.628.1624875585976;
        Mon, 28 Jun 2021 03:19:45 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id z1sm1136221lfh.137.2021.06.28.03.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:19:45 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.14
Date:   Mon, 28 Jun 2021 12:19:44 +0200
Message-Id: <20210628101944.205357-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the pull-request with updates for MMC and MEMSTICK for v5.14. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 103a5348c22c3fca8b96c735a9e353b8a0801842:

  mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk (2021-06-14 14:02:33 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14

for you to fetch changes up to 98b5ce4c08ca85727888fdbd362d574bcfa18e3c:

  mmc: sdhci-iproc: Add support for the legacy sdhci controller on the BCM7211 (2021-06-15 17:27:48 +0200)

----------------------------------------------------------------
MMC core:
 - Add support for Cache Ctrl for SD cards
 - Add support for Power Off Notification for SD cards
 - Add support for read/write of the SD function extension registers
 - Allow broken eMMC HS400 mode to be disabled via DT
 - Allow UHS-I voltage switch for SDSC cards if supported
 - Disable command queueing in the ioctl path
 - Enable eMMC sleep commands to use HW busy polling to minimize delay
 - Extend re-use of the common polling loop to standardize behaviour
 - Take into account MMC_CAP_NEED_RSP_BUSY for eMMC HPI commands

MMC host:
 - jz4740: Add support for the JZ4775 variant
 - sdhci-acpi: Disable write protect detection on Toshiba Encore 2 WT8-B
 - sdhci-esdhc-imx: Advertise HS400 support through MMC caps
 - sdhci-esdhc-imx: Enable support for system wakeup for SDIO
 - sdhci-iproc: Add support for the legacy sdhci controller on the BCM7211
 - vub3000: Fix control-request direction

MEMSTICK:
 - A couple of fixes/cleanups.

----------------------------------------------------------------
Al Cooper (2):
      dt-bindings: mmc: sdhci-iproc: Add brcm,bcm7211a0-sdhci
      mmc: sdhci-iproc: Add support for the legacy sdhci controller on the BCM7211

Andreas Färber (1):
      dt-bindings: mmc: rockchip-dw-mshc: Add Rockchip RK1808

Andrew Jeffery (1):
      mmc: sdhci-of-aspeed: Turn down a phase correction warning

Andy Shevchenko (2):
      mmc: mmc_spi: Drop duplicate 'mmc_spi' in the debug messages
      mmc: mmc_spi: Imply container_of() to be no-op

Aviral Gupta (1):
      mmc: core: Add a missing SPDX license header

Bean Huo (1):
      mmc: block: Disable CMDQ on the ioctl path

Ben Chuang (1):
      mmc: sdhci-pci-gli: Fine tune GL9763E L1 entry delay

Christian Löhle (1):
      mmc: core: Allow UHS-I voltage switch for SDSC cards if supported

Geert Uytterhoeven (2):
      dt-bindings: mmc: renesas,mmcif: Convert to json-schema
      mmc: dw_mmc-pltfm: Remove unused <linux/clk.h>

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: Enable support for system wakeup for SDIO

Hans de Goede (1):
      mmc: sdhci-acpi: Disable write protect detection on Toshiba Encore 2 WT8-B

Johan Hovold (1):
      mmc: vub3000: fix control-request direction

Krzysztof Kozlowski (2):
      mmc: sdhci-esdhc-imx: remove unused is_imx6q_usdhc
      mmc: sdhci-sprd: use sdhci_sprd_writew

Liang Chen (1):
      dt-bindings: mmc: rockchip-dw-mshc: add description for rk3568

Lucas Stach (3):
      dt-bindings: mmc: add no-mmc-hs400 flag
      mmc: sdhci-esdhc-imx: advertise HS400 mode through MMC caps
      mmc: core: add support for disabling HS400 mode via DT

Rob Herring (1):
      dt-bindings: mmc: Clean-up examples to match documented bindings

Shubhankar Kuranagatti (1):
      drivers: memstick: core:ms_block.c: Fix alignment of block comment

Steven Lee (1):
      mmc: sdhci-of-aspeed: Configure the SDHCIs as specified by the devicetree.

Suman Anna (1):
      dt-bindings: mmc: sdhci-am654: Remove duplicate ti,j721e-sdhci-4bit

Tian Tao (4):
      mmc: s3cmci: move to use request_irq by IRQF_NO_AUTOEN flag
      mmc: core: Use pm_runtime_resume_and_get() to replace open coding
      mmc: sdhci_am654: Use pm_runtime_resume_and_get() to replace open coding
      mmc: sdhci-omap: Use pm_runtime_resume_and_get() to replace open coding

Tong Zhang (1):
      memstick: rtsx_usb_ms: fix UAF

Ulf Hansson (14):
      mmc: core: Drop open coding when preparing commands with busy signaling
      mmc: core: Take into account MMC_CAP_NEED_RSP_BUSY for eMMC HPI commands
      mmc: core: Re-structure some code in __mmc_poll_for_busy()
      mmc: core: Extend re-use of __mmc_poll_for_busy()
      mmc: core: Enable eMMC sleep commands to use HW busy polling
      mmc: core: Prepare mmc_send_cxd_data() to be re-used for additional cmds
      mmc: core: Drop open coding in mmc_sd_switch()
      mmc: core: Parse the SD SCR register for support of CMD48/49 and CMD58/59
      mmc: core: Read the SD function extension registers for power management
      mmc: core: Read performance enhancements registers for SD cards
      mmc: core: Add support for Power Off Notification for SD cards
      mmc: core: Move eMMC cache flushing to a new bus_ops callback
      mmc: core: Add support for cache ctrl for SD cards
      Merge branch 'fixes' into next

Wolfram Sang (2):
      mmc: debugfs: add description for module parameter
      mmc: Improve function name when aborting a tuning cmd

Yue Hu (4):
      mmc: mediatek: use data instead of mrq parameter from msdc_{un}prepare_data()
      mmc: mediatek: remove useless data parameter from msdc_data_xfer_next()
      mmc: cqhci: fix typo
      mmc: cqhci: introduce get_trans_desc_offset()

Zhen Lei (2):
      mmc: usdhi6rol0: fix error return code in usdhi6_probe()
      mmc: jz4740: Remove redundant error printing in jz4740_mmc_probe()

Zheyu Ma (1):
      mmc: via-sdmmc: add a check against NULL pointer dereference

周琰杰 (Zhou Yanjie) (2):
      dt-bindings: mmc: JZ4740: Add bindings for JZ4775
      mmc: JZ4740: Add support for JZ4775

 .../devicetree/bindings/mmc/brcm,iproc-sdhci.yaml  |   1 +
 .../devicetree/bindings/mmc/ingenic,mmc.yaml       |   1 +
 .../devicetree/bindings/mmc/mmc-controller.yaml    |  25 +-
 .../devicetree/bindings/mmc/renesas,mmcif.txt      |  53 ---
 .../devicetree/bindings/mmc/renesas,mmcif.yaml     | 135 ++++++
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |  10 +-
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |   1 -
 drivers/memstick/core/ms_block.c                   |  37 +-
 drivers/memstick/host/rtsx_usb_ms.c                |  10 +-
 drivers/mmc/core/block.c                           |  11 +-
 drivers/mmc/core/core.c                            |  22 +-
 drivers/mmc/core/core.h                            |   9 +
 drivers/mmc/core/debugfs.c                         |   1 +
 drivers/mmc/core/host.c                            |   3 +
 drivers/mmc/core/mmc.c                             |  68 ++-
 drivers/mmc/core/mmc_ops.c                         | 163 ++++---
 drivers/mmc/core/mmc_ops.h                         |  12 +-
 drivers/mmc/core/sd.c                              | 481 ++++++++++++++++++++-
 drivers/mmc/core/sd_ops.c                          |  38 +-
 drivers/mmc/core/sdio.c                            |   6 +-
 drivers/mmc/host/Kconfig                           |   2 +-
 drivers/mmc/host/cqhci-core.c                      |  21 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   1 -
 drivers/mmc/host/jz4740_mmc.c                      |   6 +-
 drivers/mmc/host/mmc_spi.c                         |  12 +-
 drivers/mmc/host/mtk-sd.c                          |  25 +-
 drivers/mmc/host/of_mmc_spi.c                      |   2 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   2 +-
 drivers/mmc/host/s3cmci.c                          |   7 +-
 drivers/mmc/host/sdhci-acpi.c                      |  11 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  18 +-
 drivers/mmc/host/sdhci-iproc.c                     |  30 ++
 drivers/mmc/host/sdhci-of-aspeed.c                 |  50 ++-
 drivers/mmc/host/sdhci-omap.c                      |   5 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |   4 +-
 drivers/mmc/host/sdhci-sprd.c                      |   1 +
 drivers/mmc/host/sdhci.c                           |   2 +-
 drivers/mmc/host/sdhci.h                           |   2 +
 drivers/mmc/host/sdhci_am654.c                     |   6 +-
 drivers/mmc/host/usdhi6rol0.c                      |   1 +
 drivers/mmc/host/via-sdmmc.c                       |   3 +
 drivers/mmc/host/vub300.c                          |   2 +-
 include/linux/mmc/card.h                           |  23 +
 include/linux/mmc/host.h                           |   2 +-
 include/linux/mmc/sd.h                             |   4 +
 45 files changed, 987 insertions(+), 342 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/renesas,mmcif.yaml
