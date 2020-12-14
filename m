Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7942C4361B
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 13:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624A922571
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 13:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439365AbgLNN3L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Dec 2020 08:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439790AbgLNN3I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2020 08:29:08 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE6EC0613D3
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2020 05:28:26 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y19so29955884lfa.13
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2020 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3NHQKjpN3iPPvef8aMgnFXeX1PMSrH+Mm3NM0UoQLA=;
        b=m5U4ajEWvYYlIKsigL0IegzLhhWAKmGwzKXkxEJnz342PW6XguCfrD30mUpHCdf0vB
         E/OaDtsrog/RHITuwK4E1ZawPyuxPFgXfDXY3eO6HFoS9AWMCOidD90ABkuDZEgYjwFC
         /fKeqRQDWpAl0vp9Pp0+9CAIRzRSD1Lk21zbGUq5ev8AFoEj2otDwPIrnzR6V1bDetyR
         16YS0AQzXjs+SXFqAXa+StpybikzcIvTds4aRySEvKOyfDTVXuieSFdGZYRauK25+UKo
         n4R2GgHl9zty73jwhvN5mbBS8r2UkgJ+aZNgrzZU0e4LNHCAd3lL24x6+QyBEQ/2CuZR
         KASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3NHQKjpN3iPPvef8aMgnFXeX1PMSrH+Mm3NM0UoQLA=;
        b=nxBsRbeEjR5wI4TFbUW/NejEDS/IPapgimQMSumO+OLSA854M5GPGSz7j2Bws0Qaak
         k6USDlvcvGZ2tK2A0zN7LF7GxTg+9ogakNmrQSkjsoXtuD12i8rbRMiTBLTRxdoS2C7o
         34woWCsFQ22IXgAZ5dVGJbgYtM9JonEcbI4lm+qsSyVYrkwdwmXy488L7lmwgoOb7+jq
         e2YpdwPPMhKlRY2Mpvtfq1YQu/UB92y73fBHVGvYQJKVhRFzEgzvz9U0N4rZL3rBGwwF
         6+iZnYM6FgJvY0zpN9jVvT9mbb3n/dOyxjuYtA0uF37LgDbQOA9tuEbW0/1U14/l7ipm
         KrNQ==
X-Gm-Message-State: AOAM531StjdQojxhJO8SG5p/uNE7tv9fD+jAlc+2sgE0IGOw0pkxyqQ1
        mnnb5C20ArPCjUN2/9K0rxRc1akohvRoTT83
X-Google-Smtp-Source: ABdhPJzM23LNPHMLz5JUxIP6nw87PDgiWIR88pmFGl4+Exs6PvaGdF7lERB46BoOodYZb2wl5JZNbg==
X-Received: by 2002:a2e:9296:: with SMTP id d22mr1387927ljh.197.1607952505125;
        Mon, 14 Dec 2020 05:28:25 -0800 (PST)
Received: from localhost.localdomain (h-98-128-180-179.NA.cust.bahnhof.se. [98.128.180.179])
        by smtp.gmail.com with ESMTPSA id x67sm2081685lff.82.2020.12.14.05.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 05:28:23 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.11
Date:   Mon, 14 Dec 2020 14:28:22 +0100
Message-Id: <20201214132822.248987-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with updates for MMC and MEMSTICK for v5.11. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c0d638a03bc5dfdb08fb95d0a79ecada25f40da8:

  mmc: mediatek: mark PM functions as __maybe_unused (2020-12-04 15:35:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11

for you to fetch changes up to 72b248cfbf3fd308807afe7cc30d05fefeff7fb1:

  dt-bindings: mmc: eliminate yamllint warnings (2020-12-11 10:08:58 +0100)

----------------------------------------------------------------
MMC core:
 - Initial support for SD express card/host

MMC host:
 - mxc: Convert the driver to DT-only
 - mtk-sd: Add HS400 enhanced strobe support
 - mtk-sd: Add support for the MT8192 SoC variant
 - sdhci-acpi: Allow changing HS200/HS400 driver strength for AMDI0040
 - sdhci-esdhc-imx: Convert the driver to DT-only
 - sdhci-pci-gli: Improve performance for HS400 mode for GL9763E
 - sdhci-pci-gli: Reduce power consumption for GL9755
 - sdhci-xenon: Introduce ACPI support
 - tmio: Fix command error processing
 - tmio: Inform the core about the max_busy_timeout
 - tmio/renesas_sdhi: Support custom calculation of busy-wait time
 - renesas_sdhi: Reset SCC only when available
 - rtsx_pci: Add SD Express mode support for RTS5261
 - rtsx_pci: Various fixes and improvements for RTS5261

MEMSTICK:
 - Minor fixes/improvements.

----------------------------------------------------------------
Ben Chuang (2):
      mmc: sdhci-pci-gli: Reduce power consumption for GL9755
      mmc: sdhci-pci-gli: Disable slow mode in HS400 mode for GL9763E

Colin Ian King (1):
      mmc: host: Kconfig: fix spelling mistake "hardare" -> "hardware"

Cristian Ciocaltea (1):
      dt-bindings: mmc: owl: Add compatible string for Actions Semi S500 SoC

Dmitry Baryshkov (1):
      mmc: sdhci-msm: detect if tassadar_dll is used by using core version

Dong Aisheng (1):
      dt-bindings: mmc: imx: fix the wrongly dropped imx8qm compatible string

Fabio Estevam (3):
      mmc: sdhci-esdhc-imx: Convert the driver to DT-only
      mmc: mxs: Remove the unused .id_table
      mmc: mxc: Convert the driver to DT-only

Gustavo A. R. Silva (1):
      mmc: sdhci-of-arasan: Fix fall-through warnings for Clang

Jeremy Linton (2):
      mmc: sdhci: Update firmware interface API
      mmc: sdhci: Use more concise device_property_read_u64

Jing Xiangfeng (1):
      memstick: r592: Fix error return in r592_probe()

Kaixu Xia (1):
      mmc: sdhci-pic32: Make pic32_sdhci_probe_platform() void

Krzysztof Kozlowski (8):
      mmc: s3cmci: include GPIO descriptor consumer header
      mmc: s3cmci: enable compile testing
      mmc: sunxi: drop of_match_ptr from of_device_id table
      mmc: meson-gx: drop of_match_ptr from of_device_id table
      mmc: tmio: do not print real IOMEM pointer
      mmc: sdhci-sprd: drop of_match_ptr from of_device_id table
      mmc: sdhci-st: drop of_match_ptr from of_device_id table
      mmc: mediatek: depend on COMMON_CLK to fix compile tests

Marcin Wojtas (4):
      mmc: sdhci-xenon: use match data for controllers variants
      mmc: sdhci-xenon: switch to device_* API
      mmc: sdhci-xenon: use clk only with DT
      mmc: sdhci-xenon: introduce ACPI support

Masaharu Hayakawa (1):
      mmc: tmio: Fix command error processing

Michal Simek (1):
      dt-bindings: mmc: Fix xlnx,mio-bank property values for arasan driver

Qinglang Miao (1):
      memstick: fix a double-free bug in memstick_check

Raul E Rangel (1):
      mmc: sdhci-acpi: AMDI0040: Allow changing HS200/HS400 driver strength

Rui Feng (10):
      misc: rtsx: Add SD Express mode support for RTS5261
      mmc: rtsx_pci: Add SD Express mode support for RTS5261
      mmc: rtsx: Add test mode for RTS5261
      misc: rtsx: Fix OCP function for RTS5261
      misc: rtsx: Fix aspm for RTS5261
      misc: rtsx: Fix PAD driving for RTS5261
      misc: rtsx: Check mmc support for RTS5261
      misc: rtsx: Add CD & WP reverse support for RTS5261
      misc: rtsx: Add hardware auto power off for RTS5261
      misc: rtsx: Fix clock timing for RTS5261

Tian Tao (5):
      mmc: mediatek: Replace spin_lock_irqsave by spin_lock in hard IRQ
      mmc: moxart: replace spin_lock_irqsave by spin_lock in hard IRQ
      mmc: meson-mx-sdio: replace spin_lock_irqsave by spin_lock in hard IRQ
      mmc: owl-mmc: replace spin_lock_irqsave by spin_lock in hard IRQ
      mmc: dw_mmc: replace spin_lock_irqsave by spin_lock in hard IRQ

Tom Rix (4):
      memstick: jmb38x_ms: remove unneeded semicolon
      memstick: mspro_block: remove unneeded semicolon
      memstick: tifm: remove unneeded semicolon
      mmc: davinci: remove unneeded semicolon

Ulf Hansson (5):
      mmc: core: Initial support for SD express card/host
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next

Wenbin Mei (4):
      dt-bindings: mmc: Convert mtk-sd to json-schema
      dt-bindings: mmc: Add support for MT8192 SoC
      mmc: mediatek: Add subsys clock control for MT8192 msdc
      mmc: mediatek: add HS400 enhanced strobe support

Wolfram Sang (14):
      mmc: renesas_sdhi: only reset SCC when its pointer is populated
      mmc: renesas_sdhi: probe into TMIO after SCC parameters have been setup
      mmc: renesas_sdhi: populate SCC pointer at the proper place
      mmc: renesas_sdhi: simplify reset routine a little
      mmc: renesas_sdhi: clear TAPEN when resetting, too
      mmc: renesas_sdhi: merge the SCC reset functions
      mmc: renesas_sdhi: remove superfluous SCLKEN
      mmc: renesas_sdhi: improve HOST_MODE usage
      mmc: renesas_sdhi: don't hardcode SDIF values
      mmc: renesas_sdhi: sort includes
      mmc: sdhci: tegra: fix wrong unit with busy_timeout
      mmc: tmio: set max_busy_timeout
      mmc: tmio: add hook for custom busy_wait calculation
      mmc: renesas_sdhi: populate hook for longer busy_wait

Zhen Lei (1):
      dt-bindings: mmc: eliminate yamllint warnings

Zheng Liang (1):
      mmc: mediatek: fix mem leak in msdc_drv_probe

Zhihao Cheng (1):
      mmc: pxamci: Fix error return code in pxamci_probe

Zou Wei (1):
      mmc: owl-mmc: use true and false for bool variables

 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |   2 +-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   1 +
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |  75 ---------
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  | 176 +++++++++++++++++++++
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml |   4 +-
 drivers/memstick/core/memstick.c                   |   1 -
 drivers/memstick/core/mspro_block.c                |   2 +-
 drivers/memstick/host/jmb38x_ms.c                  |   2 +-
 drivers/memstick/host/r592.c                       |  12 +-
 drivers/memstick/host/tifm_ms.c                    |   2 +-
 drivers/misc/cardreader/rts5261.c                  |  61 +++++--
 drivers/misc/cardreader/rts5261.h                  |  39 +----
 drivers/misc/cardreader/rtsx_pcr.c                 |   5 +
 drivers/mmc/core/core.c                            |  15 +-
 drivers/mmc/core/host.h                            |   6 +
 drivers/mmc/core/sd_ops.c                          |  49 +++++-
 drivers/mmc/core/sd_ops.h                          |   1 +
 drivers/mmc/host/Kconfig                           |   7 +-
 drivers/mmc/host/davinci_mmc.c                     |   2 +-
 drivers/mmc/host/dw_mmc.c                          |  17 +-
 drivers/mmc/host/meson-gx-mmc.c                    |   2 +-
 drivers/mmc/host/meson-mx-sdio.c                   |   5 +-
 drivers/mmc/host/moxart-mmc.c                      |   5 +-
 drivers/mmc/host/mtk-sd.c                          | 125 ++++++++++++---
 drivers/mmc/host/mxcmmc.c                          |  33 +---
 drivers/mmc/host/mxs-mmc.c                         |  18 +--
 drivers/mmc/host/owl-mmc.c                         |   9 +-
 drivers/mmc/host/pxamci.c                          |   1 +
 drivers/mmc/host/renesas_sdhi_core.c               | 119 ++++++++------
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  71 +++++++++
 drivers/mmc/host/s3cmci.c                          |   2 +-
 drivers/mmc/host/sdhci-acpi.c                      |  38 ++++-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  91 +----------
 drivers/mmc/host/sdhci-msm.c                       |  13 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   4 +
 drivers/mmc/host/sdhci-pci-gli.c                   |  27 ++++
 drivers/mmc/host/sdhci-pic32.c                     |  11 +-
 drivers/mmc/host/sdhci-sprd.c                      |   2 +-
 drivers/mmc/host/sdhci-st.c                        |   2 +-
 drivers/mmc/host/sdhci-tegra.c                     |   2 +-
 drivers/mmc/host/sdhci-xenon-phy.c                 |  40 ++---
 drivers/mmc/host/sdhci-xenon.c                     |  91 +++++++----
 drivers/mmc/host/sdhci-xenon.h                     |  12 +-
 drivers/mmc/host/sdhci.c                           |   8 +-
 drivers/mmc/host/sunxi-mmc.c                       |   3 +-
 drivers/mmc/host/tmio_mmc.c                        |   3 +-
 drivers/mmc/host/tmio_mmc.h                        |   6 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  26 ++-
 drivers/mmc/host/uniphier-sd.c                     |   1 +
 include/linux/mfd/tmio.h                           |   7 +-
 include/linux/mmc/host.h                           |   7 +
 include/linux/rtsx_pci.h                           |  30 ++++
 52 files changed, 839 insertions(+), 454 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.yaml
