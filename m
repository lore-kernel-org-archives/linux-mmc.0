Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5207C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Nov 2021 11:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9841F60E9C
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Nov 2021 11:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhKALaK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Nov 2021 07:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhKALaK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Nov 2021 07:30:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20120C061764
        for <linux-mmc@vger.kernel.org>; Mon,  1 Nov 2021 04:27:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j9so35699427lfu.7
        for <linux-mmc@vger.kernel.org>; Mon, 01 Nov 2021 04:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeotrPS3rdBX1USKb/5NtMVDZOi8KqGLEiVDrgkTmHs=;
        b=i9DBa5gmpRzrYjNr1CnN1aBx39kYOuADV0kZ2vV6y/6IbimKemr96yXkNztEudHZrq
         2E7g3bRHzv7QDlyZQQG32ZZl3li/oHhfdyQ35IisSwuXbtWEVY+63FPjtfIQ2KNWH0de
         5yjZA2VaZQqNuKOacCLfyaKsQ0bee6aA/RLrFe8hx/40a8WcnCpRiEAnh+vrWDNtJgRp
         RwBE3vMZPYcBLhnh4lkivsK2xJiPdFDFUDPsNalHTWN1q1olDigSvIU/SU3LQ6WFYOPq
         uUqvjhKwwxHd7M1KroqFk0zXNsrAF8MYOiAGXryD6P5gzHHNc0fmVKkMiu6zYK6aniG6
         jm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeotrPS3rdBX1USKb/5NtMVDZOi8KqGLEiVDrgkTmHs=;
        b=AJa2vxXRNOfmIIEb2ThDe0v5IfU9c+CZE84ycnL9edzYjFMKH0q2X3F0Zp3Ke/UoOu
         mERCJ8xV+fxoOeOMfT7JLcuwXfhFZLLEyIeJ/F63DZgHrepObGW3aLJrCGqu5I2VnGJc
         0rOIEBfy4342MVzJEe4MCP2UcCUjG/ISMjCZ1PoPnb3s2Fjxf8x1pV2E/mArwmUv8r6X
         Al04DqVJExkoZcS15MHBdSTi8UrZFsUTHVovwICKx5zKzygrjP7L6v26aVW5Z0BPcNsc
         8XzFiAgJtbQNHtKaKQQ4pv4SevXSPXy37RXbLMDVqU+msnnR2uv5GKg8epVumDvtRpVb
         yAFw==
X-Gm-Message-State: AOAM533bh7tQPYOZq3yMtfKrAbV+A6Umpy+iPhpA57k2ozucjVttafjY
        ziDXMWviJmBc9x+BkT2IuD1O9vyycn0rpA==
X-Google-Smtp-Source: ABdhPJxWw5aWzHchnUw4XvZ6BPzKNxkc1v8lhLPiAOb/BJ4jWVhG/dZw+hI+ZYBTp3erlP8WYjr6ig==
X-Received: by 2002:a05:6512:1594:: with SMTP id bp20mr9441231lfb.145.1635766055458;
        Mon, 01 Nov 2021 04:27:35 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id bt11sm1388335lfb.208.2021.11.01.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 04:27:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.16
Date:   Mon,  1 Nov 2021 12:27:34 +0100
Message-Id: <20211101112734.9239-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with updates for MMC and MEMSTICK for v5.16. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 90935eb303e0d12f3d3d0383262e65290321f5f6:

  mmc: tmio: reenable card irqs after the reset callback (2021-10-28 23:19:32 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16

for you to fetch changes up to 348ecd61770f6aca0d060fea2bb538e749775638:

  Merge branch 'fixes' into next (2021-10-28 23:20:27 +0200)

----------------------------------------------------------------
MMC core:
 - Update maintainer and URL for the mmc-utils
 - Set default label for slot-gpio in case of no con-id
 - Convert MMC card DT bindings to a schema
 - Add optional host specific tuning support for eMMC HS400
 - Add error handling of add_disk()

MMC host:
 - mtk-sd: Add host specific tuning support for eMMC HS400
 - mtk-sd: Make DMA handling more robust
 - dw_mmc: Prevent hangs for some data writes
 - dw_mmc: Move away from using the ->init_card() callback
 - mxs-mmc: Manage the regulator in the error path and in ->remove()
 - sdhci-cadence: Add support for the Microchip MPFS variant
 - sdhci-esdhc-imx: Add support for the NXP S32G2 variant
 - sdhci-of-arasan: Add support for the Intel Thunder Bay variant
 - sdhci-omap: Prepare to support more SoCs
 - sdhci-omap: Add support for omap3 and omap4 variants
 - sdhci-omap: Add support for power management
 - sdhci-omap: Add support for system wakeups
 - sdhci-msm: Add support for the msm8226 variant
 - sdhci-sprd: Verify that the DLL locks according to spec

MEMSTICK:
 - Add error handling of add_disk()
 - A couple of small fixes and improvements

----------------------------------------------------------------
Andy Isaacson (1):
      docs: mmc: update maintainer name and URL

Andy Shevchenko (7):
      mmc: slot-gpio: Refactor mmc_gpio_alloc()
      mmc: slot-gpio: Update default label when no con_id provided
      mmc: sdhci: Deduplicate sdhci_get_cd_nogpio()
      mmc: sdhci: Remove unused prototype declaration in the header
      mmc: sdhci-pci: Remove dead code (struct sdhci_pci_data et al)
      mmc: sdhci-pci: Remove dead code (cd_gpio, cd_irq et al)
      mmc: sdhci-pci: Remove dead code (rst_n_gpio et al)

Arnd Bergmann (1):
      memstick: avoid out-of-range warning

Bean Huo (2):
      mmc: cqhci: Print out qcnt in case of timeout
      mmc: sdhci: Return true only when timeout exceeds capacity of the HW timer

Cai Huoqing (1):
      mmc: omap_hsmmc: Make use of the helper macro SET_RUNTIME_PM_OPS()

ChanWoo Lee (3):
      mmc: sdhci: Change the code to check auto_cmd23
      mmc: mtk-sd: Remove unused parameters(mrq)
      mmc: mtk-sd: Remove unused parameters

Chester Lin (2):
      dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G2 support
      mmc: sdhci-esdhc-imx: add NXP S32G2 support

Christian Löhle (1):
      mmc: dw_mmc: Dont wait for DRTO on Write RSP error

Christophe JAILLET (1):
      mmc: mxs-mmc: disable regulator on error and in the remove function

Colin Ian King (3):
      mmc: sdhci-pci-o2micro: Fix spelling mistake "unsupport" -> "unsupported"
      mmc: moxart: Fix null pointer dereference on pointer host
      mmc: dw_mmc: exynos: Fix spelling mistake "candiates" -> candidates

Dan Carpenter (1):
      memstick: jmb38x_ms: use appropriate free function in jmb38x_ms_alloc_host()

Derong Liu (1):
      mmc: mtk-sd: Add wait dma stop done flow

Geert Uytterhoeven (1):
      mmc: sdhci-omap: Remove forward declaration of sdhci_omap_context_save()

Krzysztof Kozlowski (4):
      mmc: sdhci-s3c: drop unneeded MODULE_ALIAS
      mmc: sdhci-s3c: Describe driver in KConfig
      dt-bindings: mmc: cdns: document Microchip MPFS MMC/SDHCI controller
      dt-bindings: mmc: arasan,sdci: Drop clock-output-names from dependencies

Len Baker (1):
      memstick: jmb38x_ms: Prefer struct_size over open coded arithmetic

Linus Walleij (1):
      mmc: mmci: Add small comment about reset thread

Luca Weiss (1):
      dt-bindings: mmc: sdhci-msm: Add compatible string for msm8226

Luis Chamberlain (3):
      mmc: block: Add error handling support for add_disk()
      memstick: ms_block: Add error handling support for add_disk()
      memstick: mspro_block: Add error handling support for add_disk()

Lukas Bulwahn (1):
      MAINTAINERS: drop obsolete file pattern in SDHCI DRIVER section

Mauro Carvalho Chehab (1):
      dt-bindings: mmc: update mmc-card.yaml reference

Maxime Ripard (1):
      dt-bindings: mmc: Convert MMC Card binding to a schema

Rashmi A (2):
      dt-bindings: mmc: Add bindings for Intel Thunder Bay SoC
      mmc: sdhci-of-arasan: Add intel Thunder Bay SOC support to the arasan eMMC driver

Tony Lindgren (13):
      mmc: sdhci-omap: Fix NULL pointer exception if regulator is not configured
      mmc: sdhci-omap: Fix context restore
      mmc: sdhci-omap: Restore sysconfig after reset
      mmc: sdhci-omap: Parse legacy ti,non-removable property
      mmc: sdhci-omap: Check MMCHS_HL_HWINFO register for ADMA
      dt-bindings: sdhci-omap: Document ti,non-removable property as deprecated
      dt-bindings: sdhci-omap: Update binding for legacy SoCs
      mmc: sdhci-omap: Handle voltages to add support omap4
      mmc: sdhci-omap: Add omap_offset to support omap3 and earlier
      mmc: sdhci-omap: Implement PM runtime functions
      mmc: sdhci-omap: Allow SDIO card power off and enable aggressive PM
      mmc: sdhci-omap: Configure optional wakeirq
      mmc: sdhci-omap: Fix build if CONFIG_PM_SLEEP is not set

Ulf Hansson (7):
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      mmc: dw_mmc: Drop use of ->init_card() callback
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next

Wenbin Mei (3):
      dt-bindings: mmc: mtk-sd: Add hs400 dly3 setting
      mmc: core: Add host specific tuning support for eMMC HS400 mode
      mmc: mtk-sd: Add HS400 online tuning support

Xin Xiong (1):
      mmc: moxart: Fix reference count leaks in moxart_probe

Zhenxiong Lai (1):
      mmc: sdhci-sprd: Wait until DLL locked after being configured

Zheyu Ma (1):
      memstick: r592: Fix a UAF bug when removing the driver

 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |  26 +-
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |   1 +
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   1 +
 Documentation/devicetree/bindings/mmc/mmc-card.txt |  30 --
 .../devicetree/bindings/mmc/mmc-card.yaml          |  48 +++
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   6 -
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |  12 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 .../devicetree/bindings/mmc/sdhci-omap.txt         |   9 +-
 Documentation/driver-api/mmc/mmc-tools.rst         |   4 +-
 MAINTAINERS                                        |   1 -
 drivers/memstick/core/ms_block.c                   |   8 +-
 drivers/memstick/core/mspro_block.c                |   6 +-
 drivers/memstick/host/jmb38x_ms.c                  |   5 +-
 drivers/memstick/host/r592.c                       |   8 +-
 drivers/mmc/core/block.c                           |   7 +-
 drivers/mmc/core/mmc.c                             |   8 +
 drivers/mmc/core/mmc_ops.h                         |   1 -
 drivers/mmc/core/slot-gpio.c                       |  42 +--
 drivers/mmc/host/Kconfig                           |   8 +-
 drivers/mmc/host/Makefile                          |   1 -
 drivers/mmc/host/cqhci-core.c                      |   4 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |  20 +-
 drivers/mmc/host/dw_mmc.c                          |  42 ++-
 drivers/mmc/host/mmci.c                            |   4 +
 drivers/mmc/host/moxart-mmc.c                      |  29 +-
 drivers/mmc/host/mtk-sd.c                          |  99 ++++++-
 drivers/mmc/host/mxs-mmc.c                         |  10 +
 drivers/mmc/host/omap_hsmmc.c                      |  12 +-
 drivers/mmc/host/sdhci-acpi.c                      |  14 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  17 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  29 +-
 drivers/mmc/host/sdhci-omap.c                      | 322 ++++++++++++++++-----
 drivers/mmc/host/sdhci-pci-core.c                  | 152 +---------
 drivers/mmc/host/sdhci-pci-data.c                  |   6 -
 drivers/mmc/host/sdhci-pci-o2micro.c               |   2 +-
 drivers/mmc/host/sdhci-pci.h                       |   5 -
 drivers/mmc/host/sdhci-s3c.c                       |   1 -
 drivers/mmc/host/sdhci-sprd.c                      |  13 +
 drivers/mmc/host/sdhci.c                           |  42 ++-
 drivers/mmc/host/sdhci.h                           |   2 +-
 include/linux/mmc/host.h                           |   4 +
 include/linux/mmc/sdhci-pci-data.h                 |  18 --
 43 files changed, 670 insertions(+), 410 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.yaml
 delete mode 100644 drivers/mmc/host/sdhci-pci-data.c
 delete mode 100644 include/linux/mmc/sdhci-pci-data.h
