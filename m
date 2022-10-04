Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2155C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Oct 2022 14:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJDOSw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Oct 2022 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJDOSt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Oct 2022 10:18:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE1F53D10
        for <linux-mmc@vger.kernel.org>; Tue,  4 Oct 2022 07:18:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s20so5677221lfi.11
        for <linux-mmc@vger.kernel.org>; Tue, 04 Oct 2022 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=KgLIe0cYSRWlADheGH++0zaQKi6qB0jS+V4zMC7YCR0=;
        b=VbnvpS3CKThdRZ2rQFdyRJcqF7y4Di9XEYQ+qmX81cBhHKqgMrvB7TXVr/dQYyOwBt
         HhvwvJd19EkMltur69gbMc043rcQ6Wn99gDK04PbrUCJit+/eMJwImVaegvsszWKbdPV
         ZW0+oq8yA3C4uVpgM8xA5AmRO2Tlq6++HeHIaXqlKgR6UAHHvdfh7TmCi+xQ5rZzOl3X
         ZJf8pdVMy0qeyrvsIRd+GlJK00sJ0wrgrQkooib+DmF0VcLpivrusKph2NQhtd2V2FO9
         GQKs6Em4Afra5SiEoVFZMEZtAgsVhRj3cYtLxp6P3FYSajQSjXJiA7P2avp7ve+8gMN9
         ztKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=KgLIe0cYSRWlADheGH++0zaQKi6qB0jS+V4zMC7YCR0=;
        b=fqtZIyj7hgeqWbaHXsBMbxAo6ehffZ+ZXMx0MMCMu6LGFV+OT3Ec4uPC7t1mWrLMwB
         zb8bbm1WieRniBF5Ms5t5ixtseSi7UKbRgUGg14crPSeyQCILGfUWKNpjtPb3QjseB96
         0n/EiKVWCMMilyS9P0kbClciSE9hTndSXjzvKG84zQV4lVtqKqPlo1DbNEMAN+zJk1P0
         yoqzSDsWWvqUm10iHItfHrzbkyzUszgXEgiGCF9IQhTMwoxQwaay5TNZNrwzt10aWhz9
         Ng8vm/a3WDnG17emY66j9/qCedDKdkcF5qCD9KBrGBDHNZU0F88BuDwX7v1GCCMlgxVA
         D7uw==
X-Gm-Message-State: ACrzQf3y/9wmoEznSZffAcMzjJM81yDiB3I8qjCUS9v6oQgfHj54RzKV
        zuqGG1ZJkHfiPb4GeqBP/VZmpSUkHNDUmw==
X-Google-Smtp-Source: AMsMyM6dc8nAtOvBYKJvplBqKN5ixeu6YRJm+3I2ts+Kkn08BxNV/9ES56vSY2WsPGj0x1BRy/W1fw==
X-Received: by 2002:a05:6512:31d1:b0:499:fa38:3d7b with SMTP id j17-20020a05651231d100b00499fa383d7bmr8968446lfe.544.1664893125163;
        Tue, 04 Oct 2022 07:18:45 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id bz22-20020a05651c0c9600b0025ebaef9570sm1283596ljb.40.2022.10.04.07.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:18:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v6.1
Date:   Tue,  4 Oct 2022 16:18:43 +0200
Message-Id: <20221004141843.6607-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with the MMC updates for v6.1-rc1. Details about the highlights
are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e7afa79a3b35a27a046a2139f8b20bd6b98155c2:

  mmc: hsq: Fix data stomping during mmc recovery (2022-09-27 12:38:29 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1

for you to fetch changes up to 178422c27badb8eee5edfae3f6cc3048cc140364:

  mmc: Merge branch fixes into next (2022-09-28 10:09:29 +0200)

----------------------------------------------------------------
MMC host:
 - dt-bindings: Increase maximum supported frequency to 384MHz
 - dw_mmc-rockchip: Add support for the rk3128 variant
 - meson-gx: Add support for SDIO interrupts
 - mtk-sd: Add support for MT6795 Helio X10 variant
 - sdhci: Improve the code by centralizing the CMD/DATA reset handling
 - sdhci-msm: Add support for the sdm670 variant
 - sdhci-msm: Add support for the sm6115 variant
 - sdhci-omap: Make Vignesh replace Kishon as the maintainer
 - sdhci-pci-o2micro: Disable fragile support for DDR50 in favor of SDR50
 - sdhci-sprd: Fix clock divider limitation

----------------------------------------------------------------
Adam Skladowski (1):
      dt-bindings: mmc: sdhci-msm: Document the SM6115 compatible

Adrian Hunter (5):
      mmc: sdhci: Update MAINTAINERS Maintained -> Supported
      mmc: sdhci: Separate out sdhci_reset_for_all()
      mmc: sdhci: Remove misleading comment about resets
      mmc: sdhci: Get rid of SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS
      mmc: sdhci: Centralize CMD and DATA reset handling

AngeloGioacchino Del Regno (3):
      dt-bindings: mmc: Add compatible for MT6795 Helio X10 SoC
      mmc: mtk-sd: Reorder of_device_id and platform data by name
      mmc: mtk-sd: Add support for MT6795 Helio X10

Apurva Nandan (1):
      dt-bindings: mmc: Fix 'dma-coherent' was unexpected

Bhupesh Sharma (1):
      dt-bindings: mmc: Set maximum documented operating frequency as 384MHz

Chevron Li (1):
      mmc: sdhci-pci-o2micro: fix some SD cards compatibility issue at DDR50 mode

Christophe JAILLET (2):
      mmc: au1xmmc: Fix an error handling path in au1xmmc_probe()
      mmc: wmt-sdmmc: Fix an error handling path in wmt_mci_probe()

Conor Dooley (1):
      dt-bindings: mmc: cdns: remove Piotr Sroka as a maintainer

Heiner Kallweit (3):
      mmc: core: Switch to basic workqueue API for sdio_irq_work
      mmc: meson-gx: adjust and re-use constant IRQ_EN_MASK
      mmc: meson-gx: add SDIO interrupt support

Iskren Chernev (1):
      dt-bindings: mmc: sdhci-msm: Add pinctrl-1 property

Jack Wang (2):
      mmc: meson-mx-sdhc: Fix error check for dma_map_sg
      mmc: jz4740_mmc: Fix error check for dma_map_sg

Johan Jonker (1):
      dt-bindings: mmc: rockchip: add rockchip,rk3128-dw-mshc

Kishon Vijay Abraham I (1):
      MAINTAINERS: Add Vignesh as maintainer of TI SDHCI OMAP DRIVER

Krzysztof Kozlowski (1):
      dt-bindings: mmc: mmc-spi-slot: drop unneeded spi-max-frequency

Lad Prabhakar (1):
      dt-bindings: mmc: renesas,sdhi: Add iommus property

Peter Robinson (1):
      mmc: sdhci-of-aspeed: Add dependency on ARCH_ASPEED

Richard Acayan (2):
      dt-bindings: mmc: sdhci-msm: add sdm670 compatible
      mmc: sdhci-msm: add compatible string check for sdm670

Ulf Hansson (3):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix the limitation of div

ye xingchen (2):
      mmc: sdhci_am654: Remove the unneeded result variable
      mmc: rtsx_usb_sdmmc: Remove the unneeded result variable

 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |   1 -
 .../devicetree/bindings/mmc/mmc-controller.yaml    |  13 ++-
 .../devicetree/bindings/mmc/mmc-spi-slot.yaml      |   2 -
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   1 +
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   3 +
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   1 +
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |   3 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   6 ++
 MAINTAINERS                                        |   6 +-
 drivers/mmc/core/host.c                            |   2 +-
 drivers/mmc/core/sdio.c                            |   4 +-
 drivers/mmc/core/sdio_irq.c                        |   4 +-
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/au1xmmc.c                         |   3 +-
 drivers/mmc/host/jz4740_mmc.c                      |   4 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  84 ++++++++++++----
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |   4 +-
 drivers/mmc/host/mtk-sd.c                          | 109 ++++++++++++---------
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   5 +-
 drivers/mmc/host/sdhci-msm.c                       |   1 +
 drivers/mmc/host/sdhci-pci-core.c                  |  23 ++++-
 drivers/mmc/host/sdhci-pci-o2micro.c               |   7 +-
 drivers/mmc/host/sdhci-sprd.c                      |   6 +-
 drivers/mmc/host/sdhci.c                           |  84 +++++++++-------
 drivers/mmc/host/sdhci.h                           |   2 -
 drivers/mmc/host/sdhci_am654.c                     |   5 +-
 drivers/mmc/host/wmt-sdmmc.c                       |   5 +-
 include/linux/mmc/host.h                           |   2 +-
 28 files changed, 255 insertions(+), 136 deletions(-)
