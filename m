Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F71C432BE
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Aug 2021 10:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5525F610A2
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Aug 2021 10:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhH3KJy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Aug 2021 06:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhH3KJy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2021 06:09:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8968CC061575
        for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2021 03:09:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id l2so22025844lfp.2
        for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2021 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YnGp5XaY7ZHqLVWmH/snqm4N1oXNH1vIvABIY33EwNg=;
        b=lTtd+mi0DHlkFG5JfYWhv9jduG36oLneKzLl09Li4JQEpFXiBPLrq1oV/flmcWoGnT
         H7pZeFC/2K7P9RfRtR6GA2eWQD/K0Ku4F/WLRaH+ykO+FJXMqwGAhWpbwJJtu09ipBFG
         b5Eu3Tn/tyrha244Da35tnnaqa27oEdZEyXzawi6rSGjMQXxnf/Uv9z4sdYJ1OIEHF4J
         RVG+/tXF0afQOOgU3ziEgqkQANdlTZVSyemRWfgCsLncpX9ZBz2Pm0X/JX8NS+CmRSDi
         20/nB6yQfn49rDiFvZc5T3gEVlLcIRaLHCQgVCocQUB01/ppB1tw09UiEszl1a+LPHsH
         KXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YnGp5XaY7ZHqLVWmH/snqm4N1oXNH1vIvABIY33EwNg=;
        b=SEm7M+TrVMoIy/CCkc0j6jyxYhCz3skIdspJqlVDq5JppW8K4VPB5dIDKEyPXZFaes
         4D3JgwdSu6yO/Ze0ZSPlCgTsNhH/xhkNZK7ca56rZDmot/aOO6uNMJwK9Ok+DJmJeCct
         qIoMo3AWYo+zkOvYZhq98GZ4Dp/KoiIlfl+T6Ef57Hg9MDHY0Y8mvDCHvAHw3Y0qZcDi
         ymqcqwHlfqvwIiRad+MXuwZxVdlX0g0FAr3DgNKNwNCzDz5h9/Kju/9drwUSkkFwN9fs
         dwmx8CcBmiiQJHgxiIiKecNHl9RvQ7H9ir0HaXo6sfh6vQi5VXJz+SB61o9lJzvCYady
         9ADg==
X-Gm-Message-State: AOAM532lpWWhEieziIom70dAr6KLKt2ihVMJpv3Pp5EoL2zXQqIfAriG
        I/nHwXgcWoTrZz0h4dDFlxeSJQ==
X-Google-Smtp-Source: ABdhPJw8LIk+z1MqKCusb5z2r0Vwg6tbPsWSyvYUD42tmMVGQ3Tm9s25ysh/QsUI+idnEiSAt2Ur2A==
X-Received: by 2002:ac2:4e0f:: with SMTP id e15mr12439517lfr.262.1630318138031;
        Mon, 30 Aug 2021 03:08:58 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id f29sm1348429lfj.119.2021.08.30.03.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:08:57 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.15
Date:   Mon, 30 Aug 2021 12:08:56 +0200
Message-Id: <20210830100856.512711-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's the pull-request with updates for MMC and MEMSTICK for v5.15. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 885814a97f5a1a2daf66bde5f2076f0bf632c174:

  Revert "mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711" (2021-08-27 16:30:36 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15

for you to fetch changes up to a75c956162978097c0a60d95971c97ae486a68d7:

  Merge branch 'fixes' into next (2021-08-27 16:35:55 +0200)

----------------------------------------------------------------
MMC core:
 - Return a proper response in case of an ioctl error
 - Issue HPI to interrupt BKOPS for eMMC if it timed out
 - Avoid hogging the CPU while polling for busy
 - Extend sd8787 pwrseq to support the wilc1000 SDIO
 - Remove a couple of confusing warning messages
 - Clarify comment for ->card_busy() host ops

MMC host:
 - dw_mmc: Add data CRC error injection
 - mmci: De-assert reset during ->probe()
 - rtsx_pci: Fix long reads when clock is pre-scaled
 - sdhci: Correct the tuning command handle for PIO mode
 - sdhci-esdhc-imx: Improve support for auto tuning
 - sdhci-msm: Add support for the sc7280
 - sdhci-of-arasan: Don't auto tune for DDR50 mode for ZynqMP
 - sdhci-of-arasan: Enable support for auto cmd12
 - sdhci-of-arasan: Use 19MHz for SD default speed for ZynqMP for level shifter
 - usdhi6rol0: Implement the ->card_busy() host ops

MEMSTICK:
 - A couple of minor cleanups.

----------------------------------------------------------------
Andy Shevchenko (1):
      mmc: mmc_spi: Simplify busy loop in mmc_spi_skip()

Bean Huo (1):
      mmc: core: Issue HPI in case the BKOPS timed out

Biju Das (2):
      dt-bindings: mmc: renesas,sdhi: Fix dtbs-check warning
      dt-bindings: mmc: renesas,sdhi: Document RZ/G2L bindings

ChanWoo Lee (2):
      mmc: queue: Match the data type of max_segments
      mmc: queue: Remove unused parameters(request_queue)

Christophe JAILLET (3):
      memstick: r592: Change the name of the 'pci_driver' structure to be consistent
      memstick: switch from 'pci_' to 'dma_' API
      mmc: switch from 'pci_' to 'dma_' API

Claudiu Beznea (4):
      dt-bindings: mmc: Extend pwrseq-sd8787 binding for wilc1000
      mmc: pwrseq: sd8787: add support for wilc1000
      mmc: pwrseq: add wilc1000_sdio dependency for pwrseq_sd8787
      mmc: pwrseq: sd8787: fix compilation warning

Colin Ian King (1):
      memstick: ms_block: Fix spelling contraction "cant" -> "can't"

Eric Biggers (1):
      mmc: core: Store pointer to bio_crypt_ctx in mmc_request

Fabio Estevam (1):
      mmc: sdhci-esdhc-imx: Remove unneeded mmc-esdhc-imx.h header

Haibo Chen (5):
      mmc: sdhci: Correct the tuning command handle for PIO mode
      dt-bindings: mmc: fsl-imx-esdhc: add a new compatible string
      dt-bindings: mmc: fsl-imx-esdhc: change the pinctrl-names rule
      mmc: sdhci-esdhc-imx: Remove redundant code for manual tuning
      mmc: sdhci-esdhc-imx: Select the correct mode for auto tuning

Linus Walleij (1):
      mmc: mmci: De-assert reset on probe

Manish Narani (6):
      mmc: sdhci-of-arasan: Modified SD default speed to 19MHz for ZynqMP
      mmc: sdhci-of-arasan: Add "SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12" quirk.
      mmc: sdhci-of-arasan: Skip Auto tuning for DDR50 mode in ZynqMP platform
      mmc: sdhci-of-arasan: Check return value of non-void funtions
      mmc: sdhci-of-arasan: Use appropriate type of division macro
      mmc: sdhci-of-arasan: Modify data type of the clk_phase array

Mårten Lindahl (2):
      mmc: usdhi6rol0: Implement card_busy function
      mmc: core: Update ->card_busy() callback comment

Nishad Kamdar (1):
      mmc: core: Return correct emmc response in case of ioctl error

Sahitya Tummala (1):
      mmc: sdhci-msm: Use maximum possible data timeout value

Sai Krishna Potthuri (1):
      mmc: arasan: Fix the issue in reading tap values from DT

Sarthak Garg (1):
      mmc: sdhci: Introduce max_timeout_count variable in sdhci_host

Sean Anderson (2):
      mmc: sdio: Don't warn about vendor CIS tuples
      mmc: sdio: Print contents of unknown CIS tuples

Shaik Sajida Bhanu (1):
      dt-bindings: mmc: sdhci-msm: Add compatible string for sc7280

Thomas Hebb (1):
      mmc: rtsx_pci: Fix long reads when clock is prescaled

Tony Lindgren (3):
      mmc: sdhci: Fix issue with uninitialized dma_slave_config
      mmc: dw_mmc: Fix issue with uninitialized dma_slave_config
      mmc: moxart: Fix issue with uninitialized dma_slave_config

Ulf Hansson (4):
      mmc: core: Avoid hogging the CPU while polling for busy in the I/O err path
      mmc: core: Avoid hogging the CPU while polling for busy for mmc ioctls
      mmc: core: Avoid hogging the CPU while polling for busy after I/O writes
      Merge branch 'fixes' into next

Vincent Whitchurch (1):
      mmc: dw_mmc: Add data CRC error injection

Wolfram Sang (6):
      mmc: host: add kdoc for mmc_retune_{en|dis}able
      mmc: host: factor out clearing the retune state
      mmc: renesas_sdhi_sys_dmac: use proper DMAENGINE API for termination
      mmc: sh_mmcif: use proper DMAENGINE API for termination
      mmc: usdhi6rol0: use proper DMAENGINE API for termination
      mmc: core: Only print retune error when we don't check for card removal

Yoshihiro Shimoda (1):
      mmc: renesas_sdhi: Refactor renesas_sdhi_probe()

 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  18 ++-
 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml |   4 +-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      | 133 +++++++++++++-------
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 drivers/memstick/core/ms_block.c                   |   2 +-
 drivers/memstick/host/r592.c                       |   9 +-
 drivers/memstick/host/tifm_ms.c                    |  12 +-
 drivers/mmc/core/Kconfig                           |   2 +-
 drivers/mmc/core/block.c                           |  77 +++++-------
 drivers/mmc/core/core.c                            |  13 +-
 drivers/mmc/core/crypto.c                          |  15 +--
 drivers/mmc/core/host.c                            |  13 +-
 drivers/mmc/core/host.h                            |   6 +
 drivers/mmc/core/mmc_ops.c                         |  16 ++-
 drivers/mmc/core/mmc_ops.h                         |   1 +
 drivers/mmc/core/pwrseq_sd8787.c                   |  14 ++-
 drivers/mmc/core/queue.c                           |  34 ++----
 drivers/mmc/core/sdio_cis.c                        |  22 +++-
 drivers/mmc/host/cqhci-crypto.h                    |   7 +-
 drivers/mmc/host/dw_mmc.c                          |  74 +++++++++++
 drivers/mmc/host/dw_mmc.h                          |   7 ++
 drivers/mmc/host/mmc_spi.c                         |  15 +--
 drivers/mmc/host/mmci.c                            |   3 +
 drivers/mmc/host/moxart-mmc.c                      |   1 +
 drivers/mmc/host/renesas_sdhi.h                    |   9 +-
 drivers/mmc/host/renesas_sdhi_core.c               |  90 +-------------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      | 135 +++++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   7 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  36 ++++--
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  78 ++++++++++--
 drivers/mmc/host/sdhci-msm.c                       |   3 +
 drivers/mmc/host/sdhci-of-arasan.c                 |  51 ++++++--
 drivers/mmc/host/sdhci.c                           |  27 +++--
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sh_mmcif.c                        |   4 +-
 drivers/mmc/host/tifm_sd.c                         |  16 +--
 drivers/mmc/host/usdhi6rol0.c                      |  14 ++-
 drivers/mmc/host/via-sdmmc.c                       |   4 +-
 include/linux/mmc/core.h                           |   3 +-
 include/linux/mmc/host.h                           |   2 +-
 include/linux/platform_data/mmc-esdhc-imx.h        |  42 -------
 41 files changed, 647 insertions(+), 374 deletions(-)
 delete mode 100644 include/linux/platform_data/mmc-esdhc-imx.h
