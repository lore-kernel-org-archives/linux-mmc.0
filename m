Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713C1990C7
	for <linux-mmc@vger.kernel.org>; Mon, 18 Nov 2024 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936391; cv=none; b=lt20wvVGQaCMAAVLZXrOk5VPA4NZxGDWeBvuKnSS5XyqH23lApwE8N6qdOPZGTR5LeJWuJrAEFzpw/IHrOyJ+dHffAYOpkVLc10PWSs+IpJsIhhOp05E0LTzi66yxIKGiiPAVN6+mlQvfaMXTcCW5TyQXTj135LeEhZ7QNQAN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936391; c=relaxed/simple;
	bh=2MVTUfen1RWZT5hJmZCePwCRZMgcIj+pQYCwhfY7tW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vp+4WYDvhIopzZGZnoJ1Cc+6vQ0dl7V9O+MEh3NBKNIkRS53Xgi09WvkFPrf7JVJIDpgs08xcYv09pHSR8QCmr/AMKnhq0AM5nzmVrpLeuOX4eQeHXviCuH1TXY2e24fQ6wuZdWzYhThGefaVWCsLADCnvMPbwhdhox/UaROgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YqxrlWMZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqxrlWMZ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f8490856so3187826e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Nov 2024 05:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731936387; x=1732541187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJmngtdVFPw1k6bMA8TBSEtjQSwpb2SPnmx7DsuiM3w=;
        b=YqxrlWMZ9BVb6uZNMG/K0U1VFnIn8XGwrz6/NwBMlxP0PYvn09dlqYb2c9tRHAGarF
         /oSd8cDqaliKKapNnpXFC7UM+eKijM8xRkSAjbp2ebwowKh4t2sFi4lLPeHcZXKp73KE
         YgQsMOkx06Z16n/eHJ/hmbXQKO9ZiLa3SzFaoHz2E9s8YApt+hjqMlKLBE4mLpejXASm
         VAbEN24UC9fdk0BBMIlpYpbP9zJUBVck0+xi9p2pBYv3dHwf9UD+DlTnSrZ/1DTBeG77
         tu/7bSuaf7LPHw8yl16YLpFWzj53Ry5zSmcTSUODrhYs1cJ20K1qAZx1g6OKBxSoLSfY
         Xr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731936387; x=1732541187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJmngtdVFPw1k6bMA8TBSEtjQSwpb2SPnmx7DsuiM3w=;
        b=vqF8CJJJqgdqUfEJznJaLafMzvkQ0Kza5dDB9QLNy/eaQEbGA0NUKjwnnL0nIQH0//
         qTNZ9F9tnd8tixg05MmcZB7ZrjiK41kDu2neLHQX+cQNMXJ4CBeqdBqsn2P+adIEEKsd
         nPqziBoSyb1yTlgtDQBlFsqlfZvL74JlF4bxHcKKwdOKJDO8uHB0a4yAe43BDAcZ71/g
         MzYkcPIM9DWZ9F57PwFMsKUgdC3B/PylnCqUesMT3GC6oHIPkoyPb3MHfqC9SdLcbkHj
         lff1w803KhWsbSZy5dpV1XOuvXoUoiSKfz9vEnf7v9mdYX6EyqwZuD/Nu0VWzGp4iK7y
         9Eiw==
X-Forwarded-Encrypted: i=1; AJvYcCW4culyS2c3Cst+hNfPlpPqZX5H/Ny+2PfR4Wev8A4J2JiERaLzjjn7vuLCuMI2s9VerAVq5xYityo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrr5Zywp4SNbv74sbQq5bvD9/6MHz9OerlvyBdaNBoZRlgTxZ
	rqaMeq30p+v7kHxhZV5fct936EW5hP2Yii2TZPswy4zXZ6OVivKoKwCH0GFz+Cg=
X-Google-Smtp-Source: AGHT+IEh6GXKWTDakzWsiCEpUPxaMtj5HhoHBUCOdIygj+PoJZ4K7ArSL0KdovIiw1C/HlOgGaD8JQ==
X-Received: by 2002:a05:6512:118d:b0:53d:a4f9:6141 with SMTP id 2adb3069b0e04-53dab29caa4mr4989795e87.14.1731936386755;
        Mon, 18 Nov 2024 05:26:26 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da653124bsm1615338e87.157.2024.11.18.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 05:26:25 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.13
Date: Mon, 18 Nov 2024 14:26:13 +0100
Message-ID: <20241118132623.154217-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with updates for MMC and MEMSTICK for v6.13. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 1635e407a4a64d08a8517ac59ca14ad4fc785e75:

  Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K" (2024-11-12 19:40:40 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13

for you to fetch changes up to c0baf6ead75d6db16798ae48a4ac38c3af4e9280:

  mmc: Merge branch fixes into next (2024-11-12 19:41:24 +0100)

----------------------------------------------------------------
MMC core:
 - Add support for Ultra Capacity SD cards (SDUC, 2TB to 128TB)
 - Add support for Ultra High-Speed II SD cards (UHS-II)
 - Use a reset control for pwrseq_simple
 - Add SD card quirk for broken poweroff notification
 - Use GFP_NOIO for SD ACMD22

MMC host:
 - bcm2835: Introduce proper clock handling
 - mtk-sd: Add support for the Host-Software-Queue interface
 - mtk-sd: Add support for the mt7988/mt8196 variants
 - mtk-sd: Fix a couple of error paths in ->probe()
 - sdhci: Add interface to support UHS-II SD cards
 - sdhci_am654: Fixup support for changing the signal voltage level
 - sdhci-cadence: Add support for the Microchip PIC64GX variant
 - sdhci-esdhc-imx: Add support for eMMC HW-reset
 - sdhci-msm: Add support for the X1E80100/IPQ5424/SAR2130P/QCS615 variants
 - sdhci-of-arasan: Add support for eMMC HW-reset
 - sdhci-pci-gli: Add UHS-II support for the GL9767/GL9755 variants

MEMSTICK:
 - A couple of minor updates

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: mmc: sdhci-msm: Document the X1E80100 SDHCI Controller

Andy-ld Lu (5):
      dt-bindings: mmc: mtk-sd: Add support for MT8196
      mmc: mtk-sd: Add stop_dly_sel and pop_en_cnt to platform data
      mmc: mtk-sd: Add support for MT8196
      mmc: mtk-sd: Fix error handle of probe function
      mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting

AngeloGioacchino Del Regno (1):
      mmc: mtk-sd: Implement Host Software Queue for eMMC and SD Card

Avri Altman (11):
      mmc: sd: SDUC Support Recognition
      mmc: sd: Add Extension memory addressing
      mmc: core: Don't use close-ended rw for SDUC
      mmc: core: Add open-ended Ext memory addressing
      mmc: core: Allow mmc erase to carry large addresses
      mmc: core: Add Ext memory addressing for erase
      mmc: core: Adjust ACMD22 to SDUC
      mmc: core: Disable SDUC for mmc_test
      mmc: core: Prevent HSQ from enabling for SDUC
      mmc: core: Enable SDUC
      mmc: core: Use GFP_NOIO in ACMD22

Bartosz Golaszewski (3):
      mmc: davinci: order includes alphabetically
      mmc: davinci: use generic device_get_match_data()
      mmc: mmc_spi: drop buggy snprintf()

Ben Chuang (2):
      mmc: sdhci-uhs2: add pre-detect_init hook
      mmc: sdhci-uhs2: Remove unnecessary NULL check

Catalin Popescu (1):
      mmc: pwrseq_simple: add support for one reset control

Christophe JAILLET (1):
      memstick: Constify struct memstick_device_id

Dmitry Baryshkov (1):
      dt-bindings: mmc: sdhci-msm: Add SAR2130P compatible

Frank Wunderlich (2):
      dt-bindings: mmc: mtk-sd: Add mt7988 SoC
      mmc: mtk-sd: add support for mt7988

Geert Uytterhoeven (1):
      mmc: sdhci: Make MMC_SDHCI_UHS2 config symbol invisible

Josua Mayer (2):
      mmc: sdhci-esdhc-imx: Implement emmc hardware reset
      mmc: sdhci-esdhc-imx: Update esdhc sysctl dtocv bitmask

Judith Mendez (1):
      mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch

Keita Aihara (1):
      mmc: core: Add SD card quirk for broken poweroff notification

Paul Alvin (1):
      mmc: sdhci-of-arasan: Support for emmc hardware reset

Peng Fan (1):
      mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED

Pierre-Henry Moussay (2):
      dt-bindings: mmc: cdns: document Microchip PIC64GX MMC/SDHCI controller
      dt-bindings: mmc: cdns,sdhci: ref sdhci-common.yaml

Rosen Penev (3):
      mmc: mtk-sd: use devm_mmc_alloc_host
      mmc: mtd-sd: use devm_platform_ioremap_resource
      mmc: mtk-sd: fix devm_clk_get_optional usage

Sricharan Ramabadhran (1):
      dt-bindings: mmc: sdhci-msm: add IPQ5424 compatible

Stefan Wahren (3):
      mmc: bcm2835: Fix type of current clock speed
      mmc: bcm2835: Introduce proper clock handling
      mmc: pwrseq_simple: Handle !RESET_CONTROLLER properly

Ulf Hansson (9):
      mmc: core: Cleanup printing of speed mode at card insertion
      mmc: core: Prepare to support SD UHS-II cards
      mmc: core: Announce successful insertion of an SD UHS-II card
      mmc: core: Extend support for mmc regulators with a vqmmc2
      mmc: Merge branch fixes into next
      mmc: core: Simplify sd_uhs2_power_up()
      mmc: core: Add error handling of sd_uhs2_power_up()
      mmc: core: Fix error paths for UHS-II card init and re-init
      mmc: Merge branch fixes into next

Uwe Kleine-König (1):
      mmc: Switch back to struct platform_driver::remove()

Victor Shih (22):
      mmc: core: Add definitions for SD UHS-II cards
      mmc: core: Factor out some of the code in mmc_go_idle()
      mmc: core: Support UHS-II card control and access
      mmc: sdhci: add UHS-II related definitions in headers
      mmc: sdhci: add UHS-II module and add a kernel configuration
      mmc: sdhci-uhs2: dump UHS-II registers
      mmc: sdhci-uhs2: add reset function
      mmc: sdhci-uhs2: add set_power() to support vdd2
      mmc: sdhci-uhs2: add set_timeout()
      mmc: sdhci-uhs2: add add_host() and others to set up the driver
      mmc: sdhci-uhs2: add set_ios()
      mmc: sdhci-uhs2: add related functions to initialize the interface
      mmc: sdhci-uhs2: add irq() and others
      mmc: sdhci-uhs2: add request() and others
      mmc: sdhci-pci: add UHS-II support framework
      mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
      mmc: sdhci-pci-gli: enable UHS-II mode for GL9767
      mmc: sdhci-uhs2: Correct incorrect type in argument
      mmc: sdhci-uhs2: Remove unnecessary variables
      mmc: sdhci-uhs2: correction a warning caused by incorrect type in argument
      mmc: core: Correct type in variable assignment for UHS-II
      mmc: core: Correction a warning caused by incorrect type in assignment for UHS-II

Wolfram Sang (1):
      mmc: sh_mmcif: correctly report success when obtaining DMA channels

Yu Jiaoliang (2):
      memstick: Fix typo in comment
      mmc: host: Fix typos in comments across various files

Yuanjie Yang (1):
      dt-bindings: mmc: Add sdhci compatible for QCS615

 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |    3 +-
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   24 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |    4 +
 drivers/memstick/core/memstick.c                   |    4 +-
 drivers/memstick/core/ms_block.c                   |    8 +-
 drivers/memstick/core/mspro_block.c                |    2 +-
 drivers/memstick/host/r592.c                       |    2 +-
 drivers/mmc/core/Makefile                          |    2 +-
 drivers/mmc/core/block.c                           |   39 +-
 drivers/mmc/core/bus.c                             |   42 +-
 drivers/mmc/core/card.h                            |   10 +
 drivers/mmc/core/core.c                            |   73 +-
 drivers/mmc/core/core.h                            |   17 +-
 drivers/mmc/core/mmc_ops.c                         |   24 +-
 drivers/mmc/core/mmc_ops.h                         |    1 +
 drivers/mmc/core/mmc_test.c                        |    6 +
 drivers/mmc/core/pwrseq_emmc.c                     |    2 +-
 drivers/mmc/core/pwrseq_sd8787.c                   |    2 +-
 drivers/mmc/core/pwrseq_simple.c                   |   48 +-
 drivers/mmc/core/quirks.h                          |    9 +
 drivers/mmc/core/regulator.c                       |   34 +
 drivers/mmc/core/sd.c                              |   44 +-
 drivers/mmc/core/sd.h                              |    4 +-
 drivers/mmc/core/sd_ops.c                          |   24 +
 drivers/mmc/core/sd_ops.h                          |    3 +
 drivers/mmc/core/sd_uhs2.c                         | 1304 ++++++++++++++++++++
 drivers/mmc/core/sdio.c                            |    2 +-
 drivers/mmc/host/Kconfig                           |   11 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/alcor.c                           |    2 +-
 drivers/mmc/host/atmel-mci.c                       |    4 +-
 drivers/mmc/host/au1xmmc.c                         |    4 +-
 drivers/mmc/host/bcm2835.c                         |   33 +-
 drivers/mmc/host/cavium-octeon.c                   |    4 +-
 drivers/mmc/host/cb710-mmc.c                       |    2 +-
 drivers/mmc/host/davinci_mmc.c                     |   25 +-
 drivers/mmc/host/dw_mmc-bluefield.c                |    2 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |    2 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |    2 +-
 drivers/mmc/host/dw_mmc-hi3798mv200.c              |    2 +-
 drivers/mmc/host/dw_mmc-k3.c                       |    2 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |    2 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |    2 +-
 drivers/mmc/host/dw_mmc-starfive.c                 |    2 +-
 drivers/mmc/host/dw_mmc.c                          |    2 +-
 drivers/mmc/host/jz4740_mmc.c                      |    2 +-
 drivers/mmc/host/litex_mmc.c                       |    2 +-
 drivers/mmc/host/meson-gx-mmc.c                    |    4 +-
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |    2 +-
 drivers/mmc/host/meson-mx-sdio.c                   |    2 +-
 drivers/mmc/host/mmc_spi.c                         |    9 +-
 drivers/mmc/host/mmci.h                            |    2 +-
 drivers/mmc/host/moxart-mmc.c                      |    2 +-
 drivers/mmc/host/mtk-sd.c                          |  292 +++--
 drivers/mmc/host/mvsdio.c                          |    2 +-
 drivers/mmc/host/mxcmmc.c                          |    2 +-
 drivers/mmc/host/mxs-mmc.c                         |    2 +-
 drivers/mmc/host/omap.c                            |    2 +-
 drivers/mmc/host/omap_hsmmc.c                      |    2 +-
 drivers/mmc/host/owl-mmc.c                         |    2 +-
 drivers/mmc/host/pxamci.c                          |    2 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |    2 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |    2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |    2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |    2 +-
 drivers/mmc/host/sdhci-acpi.c                      |    2 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |    2 +-
 drivers/mmc/host/sdhci-brcmstb.c                   |    2 +-
 drivers/mmc/host/sdhci-cadence.c                   |    2 +-
 drivers/mmc/host/sdhci-dove.c                      |    2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   31 +-
 drivers/mmc/host/sdhci-esdhc-mcf.c                 |    2 +-
 drivers/mmc/host/sdhci-iproc.c                     |    2 +-
 drivers/mmc/host/sdhci-milbeaut.c                  |    2 +-
 drivers/mmc/host/sdhci-msm.c                       |    4 +-
 drivers/mmc/host/sdhci-npcm.c                      |    2 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   20 +-
 drivers/mmc/host/sdhci-of-aspeed.c                 |    4 +-
 drivers/mmc/host/sdhci-of-at91.c                   |    2 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |    2 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |    2 +-
 drivers/mmc/host/sdhci-of-hlwd.c                   |    2 +-
 drivers/mmc/host/sdhci-of-ma35d1.c                 |    2 +-
 drivers/mmc/host/sdhci-of-sparx5.c                 |    2 +-
 drivers/mmc/host/sdhci-omap.c                      |    2 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   16 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |  437 ++++++-
 drivers/mmc/host/sdhci-pci.h                       |    3 +
 drivers/mmc/host/sdhci-pic32.c                     |    2 +-
 drivers/mmc/host/sdhci-pxav2.c                     |    2 +-
 drivers/mmc/host/sdhci-pxav3.c                     |    2 +-
 drivers/mmc/host/sdhci-s3c.c                       |    2 +-
 drivers/mmc/host/sdhci-spear.c                     |    2 +-
 drivers/mmc/host/sdhci-sprd.c                      |    2 +-
 drivers/mmc/host/sdhci-st.c                        |    2 +-
 drivers/mmc/host/sdhci-tegra.c                     |    2 +-
 drivers/mmc/host/sdhci-uhs2.c                      | 1250 +++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h                      |  188 +++
 drivers/mmc/host/sdhci-xenon.c                     |    2 +-
 drivers/mmc/host/sdhci.c                           |  281 +++--
 drivers/mmc/host/sdhci.h                           |   75 +-
 drivers/mmc/host/sdhci_am654.c                     |   32 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |    2 +-
 drivers/mmc/host/sh_mmcif.c                        |    7 +-
 drivers/mmc/host/sunplus-mmc.c                     |    2 +-
 drivers/mmc/host/sunxi-mmc.c                       |    2 +-
 drivers/mmc/host/uniphier-sd.c                     |    2 +-
 drivers/mmc/host/usdhi6rol0.c                      |    2 +-
 drivers/mmc/host/wbsd.c                            |    2 +-
 drivers/mmc/host/wmt-sdmmc.c                       |    2 +-
 include/linux/memstick.h                           |    2 +-
 include/linux/mmc/card.h                           |   39 +-
 include/linux/mmc/core.h                           |   21 +
 include/linux/mmc/host.h                           |   80 ++
 include/linux/mmc/sd.h                             |    4 +
 include/linux/mmc/sd_uhs2.h                        |  240 ++++
 116 files changed, 4580 insertions(+), 398 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h
 create mode 100644 include/linux/mmc/sd_uhs2.h
