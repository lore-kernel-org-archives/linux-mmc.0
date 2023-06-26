Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A175CEB64DC
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Jun 2023 14:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjFZOCV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Jun 2023 10:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFZOCU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Jun 2023 10:02:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E47DD
        for <linux-mmc@vger.kernel.org>; Mon, 26 Jun 2023 07:02:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so4113371e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 26 Jun 2023 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687788137; x=1690380137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdBkkycqxXcREXc5D1EbWSkmzo6fbVJHSEggnxlVBus=;
        b=cSgwPIfBnxw4YImYMCYQwiR4LIzRtzR8OuQA7SFtROcUnooNYKZdalS2NoDJc7Rtan
         qw9kyjIUfzdUIBzs2WtKrjgw8L4lkOLXzHFZ+6F/DP+hKfbkCZAe7XXVPMcC9uq6dHr7
         PEPW3KxHrkUTECJXHnYTLGVR67sqhQVGQ1ka3IuwwIamRe46QkmP/37tqlcundgKDrJi
         S3CUkFZmOh5lIlC1hSvatlEXp/Ymfn3Y9dkdTEEx0lwMHzvuAe8zP2qtTkY+5knnyr+u
         zvwchZcba0HDWeIT7yarhgtTDWazX1DFqg2MwIg2+0ZHUCL9pwKjNApvSWA7o9M2HDMg
         P8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687788137; x=1690380137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdBkkycqxXcREXc5D1EbWSkmzo6fbVJHSEggnxlVBus=;
        b=Msfj635vgUhE9CxUdLB3TvZTQrIPg4rHkcCPFMYd1WJ1v0JSQG4+zjN39xuA7YfYCs
         s0IyhR9pxes7fk8wga82sdVV8ptgQ3JzIAthTBQdDlj+n4afLFSaZXjGeaLAwyoFxCsg
         GQnc9Tlg4D1eXaiN8nbCX3lZ+3monBc519oYGvCrSz5ceY96N3ASx2Z4ZXfJ+8OWwbZR
         cFcSIRQ5HnTnQR/6Y6ZoFBj7w8UCO86bUIR4CBruafTUnBhA4oFEuAyggj8sUnD2IIW0
         BZD10G9l93cI3f4+/2PEp70hq5ntXXui6v6VVbjBL6tdlzqBtF8sQY8wx5ylz0Bqyb2i
         Qchw==
X-Gm-Message-State: AC+VfDzJBOm/AUtLahhNOrsc+k85hmiGuuHborq9yw5av3WzGO4gP1vy
        p7ZmjRjHlzy493zZwxaLMay4KA==
X-Google-Smtp-Source: ACHHUZ6guu75xegoJflpSHUYz+Owu59yY4CK8/Xn5iyPrJDu5TgonHrH6K2vCwWkyiIujtRA2XQjLw==
X-Received: by 2002:a05:6512:110a:b0:4fb:7bf8:51c8 with SMTP id l10-20020a056512110a00b004fb7bf851c8mr152072lfg.1.1687788136905;
        Mon, 26 Jun 2023 07:02:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id d13-20020ac241cd000000b004db1a7e6decsm1117454lfi.205.2023.06.26.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:02:16 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.5
Date:   Mon, 26 Jun 2023 16:02:15 +0200
Message-Id: <20230626140215.83367-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with the MMC and MEMSTICK updates for v6.5-rc1. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 413db499730248431c1005b392e8ed82c4fa19bf:

  mmc: usdhi60rol0: fix deferred probing (2023-06-19 13:32:39 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5

for you to fetch changes up to 06b5d4fea89cd699408af12c14b6915d77ceffb0:

  dt-bindings: mmc: fsl-imx-esdhc: Add imx6ul support (2023-06-22 11:08:10 +0200)

----------------------------------------------------------------
MMC core:
 - Allow synchronous detection of (e)MMC/SD/SDIO cards
 - Fixup error check for ioctls for SPI hosts
 - Disable broken SD-Cache support for Kingston Canvas Go Plus from 11/2019
 - Disable broken eMMC-Trim support for Kingston EMMC04G-M627
 - Disable broken eMMC-Trim support for Micron MTFC4GACAJCN-1M

MMC host:
 - bcm2835: Convert DT bindings to YAML
 - mmci: Enable asynchronous probe
 - mmci: Transform the ux500 HW-busy detection into a proper state machine
 - mmci: Add support for SW busy-end timeouts for the ux500 variants
 - mmci_stm32: Add support for sdm32 variant revision v3.0 used on STM32MP25
 - mmci_stm32: Improve the tuning sequence
 - mtk-sd: Tune polling-period to improve performance
 - sdhci: Fixup DMA configuration for 64-bit DMA mode
 - sdhci-bcm-kona: Convert DT bindings to YAML
 - sdhci-msm: Switch to use the new ICE API
 - sdhci-msm: Add support for the SC8280XP/IPQ6018/QDU1000/QRU1000 variants
 - sdhci-pci-gli: Add support SD Express cards for GL9767
 - sdhci-pci-gli: Add support for the Genesys Logic GL9767 variant

----------------------------------------------------------------
Abel Vesa (1):
      mmc: sdhci-msm: Switch to the new ICE API

Arnd Bergmann (1):
      memstick r592: make memstick_debug_get_tpc_name() static

Bjorn Andersson (1):
      dt-bindings: mmc: sdhci-msm: Document SC8280XP SDHCI

Chevron Li (1):
      mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.

Christian Loehle (1):
      mmc: block: ioctl: do write error check for spi

Dennis Zhou (1):
      mmc: core: Allow mmc_start_host() synchronously detect a card

Douglas Anderson (1):
      mmc: mediatek: Avoid ugly error message when SDIO wakeup IRQ isn't used

Florian Fainelli (1):
      mmc: block: Suppress empty whitespaces in prints

Komal Bajaj (1):
      dt-bindings: mmc: sdhci-msm: Document the QDU1000/QRU1000 compatible

Linus Walleij (9):
      mmc: mmci: Clear busy_status when starting command
      mmc: mmci: Unwind big if() clause
      mmc: mmci: Stash status while waiting for busy
      mmc: mmci: Break out error check in busy detect
      mmc: mmci: Make busy complete state machine explicit
      mmc: mmci: Retry the busy start condition
      mmc: mmci: Use state machine state as exit condition
      mmc: mmci: Use a switch statement machine
      mmc: mmci: Break out a helper function

Mantas Pucka (1):
      dt-bindings: mmc: sdhci-msm: add IPQ6018 compatible

Marek Vasut (1):
      mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019

Oleksij Rempel (1):
      dt-bindings: mmc: fsl-imx-esdhc: Add imx6ul support

Robert Marko (2):
      mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M
      mmc: core: disable TRIM on Kingston EMMC04G-M627

Simon Horman (1):
      mmc: meson-mx-sdhc: Avoid cast to incompatible function type

Stanislav Jakubek (1):
      dt-bindings: mmc: brcm,kona-sdhci: convert to YAML

Stefan Wahren (1):
      dt-bindings: mmc: convert bcm2835-sdhost bindings to YAML

Ulf Hansson (5):
      mmc: Merge branch fixes into next
      mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: mmci: Add support for SW busy-end timeouts

Uwe Kleine-König (1):
      mmc: dw_mmc: Make dw_mci_pltfm_remove() return void

Victor Shih (4):
      mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support
      mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL9767
      mmc: sdhci: Add VDD2 definition for power control register
      mmc: sdhci-pci-gli: Add support SD Express card for GL9767

Wenbin Mei (1):
      mmc: mtk-sd: reduce CIT for better performance

Yann Gautier (7):
      mmc: mmci: stm32: set feedback clock when using delay block
      dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2 compatible
      mmc: mmci: add stm32_idmabsize_align parameter
      mmc: mmci: Add support for sdmmc variant revision v3.0
      mmc: mmci: stm32: manage block gap hardware flow control
      mmc: mmci: stm32: prepare other delay block support
      mmc: mmci: stm32: add delay block support for STM32MP25

Yeqi Fu (1):
      mmc: core: Remove unnecessary error checks and change return type

 .../devicetree/bindings/mmc/arm,pl18x.yaml         |   7 +-
 .../bindings/mmc/brcm,bcm2835-sdhost.txt           |  23 --
 .../bindings/mmc/brcm,bcm2835-sdhost.yaml          |  54 +++
 .../devicetree/bindings/mmc/brcm,kona-sdhci.txt    |  21 --
 .../devicetree/bindings/mmc/brcm,kona-sdhci.yaml   |  48 +++
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   3 +
 drivers/memstick/host/r592.c                       |   4 +-
 drivers/mmc/core/block.c                           |  35 +-
 drivers/mmc/core/card.h                            |  30 +-
 drivers/mmc/core/core.c                            |  15 +-
 drivers/mmc/core/quirks.h                          |  27 ++
 drivers/mmc/core/sd.c                              |   2 +-
 drivers/mmc/host/Kconfig                           |   2 +-
 drivers/mmc/host/cqhci.h                           |   3 +
 drivers/mmc/host/dw_mmc-bluefield.c                |   2 +-
 drivers/mmc/host/dw_mmc-k3.c                       |   2 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   5 +-
 drivers/mmc/host/dw_mmc-pltfm.h                    |   2 +-
 drivers/mmc/host/dw_mmc-starfive.c                 |   2 +-
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |   8 +-
 drivers/mmc/host/mmci.c                            | 208 +++++++++--
 drivers/mmc/host/mmci.h                            |  25 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c                | 179 +++++++--
 drivers/mmc/host/mtk-sd.c                          |  48 ++-
 drivers/mmc/host/sdhci-msm.c                       | 223 +++--------
 drivers/mmc/host/sdhci-pci-core.c                  |   1 +
 drivers/mmc/host/sdhci-pci-gli.c                   | 406 +++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h                       |   2 +
 drivers/mmc/host/sdhci.c                           |   4 +-
 drivers/mmc/host/sdhci.h                           |   7 +
 include/linux/mmc/card.h                           |   1 +
 32 files changed, 1067 insertions(+), 333 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.yaml
