Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF83793D5
	for <linux-mmc@vger.kernel.org>; Mon,  9 Feb 2026 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644085; cv=none; b=mM8qpmbz5dEL8+p4ekpnIXiEcGNFY9VZpqBjWEzEI1SRW9jby9X2ynnX3PY1FEmxBxtKG2mvcbzn/Hm679joKWD+uc6/EgP0tqVTMYgYm12dE2OboktZvOG1Ge6SkP/dgtOOFpg6DmQwBi0EQa0ipkfhofFT9M1Qw69sx5ST5lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644085; c=relaxed/simple;
	bh=+Sqmt1mPMD8yS+lQk8UUCKnBTNBfFpzPWW4xIEd6JiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njwb+HCzY7vvKWJLFxQL15EnSmWF9zWMmX1EoJ7psykUblMzH5goxF5UdyzpbMsT7/MWb4E62tRXBBF9wa1ikrsVZLyOhcQUhYOMHMGrvFs7azzhJLDrU7V6Q3OG7K0dZvLaG89r232FZRkfuk5xYhN+zbyAjFuaNIn7iwpi0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmDo9/97; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmDo9/97"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-385c6c727fcso35811381fa.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 05:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770644084; x=1771248884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZctCZUmxi5g6o3wylrlKDoWZkLGHsRetjpjjz0e29jA=;
        b=GmDo9/97r23ujd6eFPU7M6O+o3VXV+ZderEgC4GPMtIee72qFs65fuJlR8RmAGfNl3
         odsldlWKd37K7XJdJzHPbCjj2zn0ZLWfAWbELlDOrksJk8jDEzcDSYQFokni3K6lx6ud
         HbEiWIdd13lz2muFwL4bw8ftvAvOnLmOTB3jl58h941Yb1DTKD9Bi5qmBfhMxws6/IWR
         IKHB+i8xkl1ViQEjbJkGY6DHikWjRDbdub1jCOkEcWR7pe5pxW705uq0V4k3SQYLmOYM
         Tx4OwpXtNqwWIfwnA4oyK48NXh7UqEZdYgryGJubw0P52PqnS4UtsQ5j+LBbTc8C5oZL
         6S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770644084; x=1771248884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZctCZUmxi5g6o3wylrlKDoWZkLGHsRetjpjjz0e29jA=;
        b=ZhvLE4AdgABsJQLGgF5KZVQt0ACuvy5jInlHdDffz9W1hgwc4Dq8Qv0FePg6d3B9hs
         dcQe1MuOZAWOqeFopL0mBCsuNG/1W0rHKl0Y2q37Kyajvy+aTLhBGZLF1pmCJOX4/pYi
         l+uOzeFlKWf02CIaiSFdV4fYU+81pB23vnlx2BUu0dnTkKX4QvGE/h9Zbf28RkIBSoNB
         awHmDg+k08w8EAWtfuRjTrCGDxInPgknrhT6QQ6RxobuYdIyaZ9jgKRA+x28nTGTMFrP
         4IyJOCmu+Y7O/o+JXPaPRx/Eh/pji/MuO3dTa/drwbAih3WHKCaRnBc5T8d1GDcdj8XF
         skRA==
X-Forwarded-Encrypted: i=1; AJvYcCVbcat2f5UIICsohLbCMgskf0yAApkszaQ/aYjdVkVkpxzAGi9i3o2yzfMs7B3a5Ilc9SkzdmUZEig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRkdtqCGdaeCFcF61XXLa0QX/Ko0O685Yc+60P4rFqWMBvDOOa
	EaG+MSXXDUiHq4P8OwiTg+9CbnSeyhPQ9N8NfoGeJ1YnxdS7MfEdZGeQwenXvdXTyY0=
X-Gm-Gg: AZuq6aKRIHPC5wFf72cIciRZWyy9UYdk8weGLjtDm+NHiwAvBNST6lKbcNbCJbQJd+r
	3B+L3VnWJnwkCosset0itOPiya8+RIOkQnv9fQtoOR+LgCcPt27WQTO7eSapPdIwxIDq/yPbKIa
	kl1WetlPJzUe4NiEki5niSkZ5/DJqbcgdAlsmE+iAfCy+CU7gHs0gXsv3TvnvJdaiuOa3XGAO+z
	1i0n+BRnsFlQn6bisLLCVHgk/ndxVid2fPT+JoQ3ZAhMDIqI+jSjoABS5UztsKeAjv0cest4zVs
	//OEPtjsiQm38n9HsA4DUUaaKk9QrrmvChKbUZT1cfhzV7acv9+RolAWfqwg5lZrYUGan2klqg/
	HaIyasq4+5KjqNrc4cnaICRjZvyLVnOBD99crS0mOJXuD1MVFWVzX9G0LAOrB9cp4l6YrWqDJMH
	kOAnJwrjvHE6Jcmn5NcYSdd95pv+7g9+g=
X-Received: by 2002:a05:651c:b26:b0:385:bd86:466e with SMTP id 38308e7fff4ca-386b50fe2a9mr39288611fa.25.1770644083540;
        Mon, 09 Feb 2026 05:34:43 -0800 (PST)
Received: from uffe-tuxpro14.. ([2a02:1406:249:f8a3:3249:60bc:db1:48cb])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b63b040dsm25186861fa.28.2026.02.09.05.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:34:43 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v7.0
Date: Mon,  9 Feb 2026 14:34:41 +0100
Message-ID: <20260209133441.556464-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with the updates for MMC for v7.0. Details about the
highlights are as usual found in the signed tag.

Note that, this time I have picked up some changes to improve the mux subsystem
and those are part of this pull-request, as these changes are required for mmc.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:

  Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.0

for you to fetch changes up to 13dc45d829d5ae06f6eee3fbd3cd1f6818c08e48:

  mmc: host: renesas_sdhi_core: support selecting an optional mux (2026-02-05 13:09:04 +0100)

----------------------------------------------------------------
MMC core:
 - Add NXP vendor and IW61x device IDs for WiFi chips over SDIO
 - Add quirk for incorrect manufacturing date
 - Add support for manufacturing date beyond 2025
 - Optimize support for secure erase/trim for some Kingston eMMCs

MMC host:
 - dw_mmc: A great amount of cleanups/simplifications to improve the code
 - dw_mmc: Remove mshc DT alias support
 - dw_mmc-rockchip: Fix runtime PM support for internal phase support
 - mtk-sd: Add support for the MT8189 variant
 - renesas_sdhi_core: Add support for selecting an optional mux
 - sdhci: Stop advertising the driver in dmesg
 - sdhci-esdhc-imx: Wait for data transfer completion before reset
 - sdhci-msm: Enable ICE for CQE-capable controllers with non-CQE cards
 - sdhci-of-bst: Add driver for the Black Sesame Technologies C1200 controller
 - sdhci-of-k1: Add support for reset
 - sdhci-of-k1: Add support for the K3 variant

mux core/consumers:
 - phy-can-transceiver: Convert to devm_mux_state_get_optional()
 - i2c-omap: Convert to devm_mux_state_get_optional_selected()
 - core: Add helper functions for getting optional and selected mux-state

----------------------------------------------------------------
Albert Yang (4):
      dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
      mmc: sdhci: allow drivers to pre-allocate bounce buffer
      mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
      MAINTAINERS: add MMC files to BST entry

Andre Korol (1):
      mmc: loongson2-mmc: drop redundant memset after dma_alloc_coherent()

Arnd Bergmann (1):
      mmc: dw_mmc: move pmops into core driver

Avri Altman (2):
      mmc: core: Adjust MDT beyond 2025
      mmc: core: Add quirk for incorrect manufacturing date

Felix Gu (1):
      mmc: mmci: Fix device_node reference leak in of_get_dml_pipe_index()

Jeff Chen (1):
      mmc: sdio: add NXP vendor and IW61x device IDs

Josua Mayer (7):
      phy: can-transceiver: rename temporary helper function to avoid conflict
      mux: Add helper functions for getting optional and selected mux-state
      mux: add help text for MULTIPLEXER config option
      phy: can-transceiver: drop temporary helper getting optional mux-state
      i2c: omap: switch to new generic helper for getting selected mux-state
      dt-bindings: mmc: renesas,sdhi: Add mux-states property
      mmc: host: renesas_sdhi_core: support selecting an optional mux

Krzysztof Kozlowski (4):
      mmc: atmel-mci: Simplify with scoped for each OF child loop
      mmc: cavium-octeon: Simplify with scoped for each OF child loop
      mmc: jz4740: Fix Wvoid-pointer-to-enum-cast warning
      mmc: sdhci-of-aspeed: Simplify with scoped for each OF child loop

Linus Walleij (1):
      mmc: sdhci: Stop advertising the driver in dmesg

Louis-Alexis Eyraud (3):
      dt-bindings: mmc: mtk-sd: Add support for MT8189 SoC
      mmc: mtk-sd: add support for SPM resource release control
      mmc: mtk-sd: add support for MT8189 SoC

Luke Wang (2):
      mmc: sdhci-esdhc-imx: wait for data transfer completion before reset
      mmc: core: Optimize time for secure erase/trim for some Kingston eMMCs

Md Sadre Alam (1):
      mmc: sdhci-msm: Enable ICE for CQE-capable controllers with non-CQE cards

Rob Herring (Arm) (3):
      dt-bindings: mmc: cdns,sdhci: Drop required "resets" on AMD Pensando ELBA
      dt-bindings: mmc: brcm,iproc-sdhci: Allow "dma-coherent" and "iommus" properties
      dt-bindings: mmc: arasan,sdhci: Allow "dma-coherent" property

Shawn Lin (35):
      mmc: dw_mmc: Remove unused struct dma_pdata
      mmc: dw_mmc: add dw_mci_prepare_desc() for both of 32bit and 64bit DMA
      mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci and update the reset
      mmc: dw_mmc: Remove check before calling mmc_regulator_set_ocr()
      mmc: dw_mmc: Remove unused header files and keep alphabetical order
      mmc: dw_mmc: Move struct mmc_host from struct dw_mci_slot to struct dw_mci
      mmc: dw_mmc: Let variant drivers to use struct dw_mci as possible
      mmc: dw_mmc: Move flags from struct dw_mci_slot to struct dw_mci
      mmc: dw_mmc: Remove id and ctype from dw_mci_slot
      mmc: dw_mmc: Remove sdio_id from struct dw_mci_slot
      mmc: dw_mmc: Move clock rate stuff from struct dw_mci_slot to struct dw_mci
      mmc: dw_mmc: Remove mrq from struct dw_mci_slot
      mmc: dw_mmc: Remove queue from dw_mci
      mmc: dw_mmc: Introduce dw_mci_alloc_host()
      mmc: dw_mmc: Remove struct dw_mci_slot
      mmc: dw_mmc-rockchip: Fix runtime PM support for internal phase support
      mmc: dw_mmc: Check return value of dma_ops->init() in resume
      mmc: dw_mmc: Remove dma_ops from struct dw_mci_board
      mmc: dw_mmc: Remove SDMMC_INT_ERROR
      mmc: dw_mmc: Remove assignment of pdata in dw_mci_pltfm_register()
      mmc: dw_mmc: Remove caps2 and pm_caps from struct dw_mci_board
      mmc: dw_mmc: Move rstc from struct dw_mci_board to struct dw_mci
      mmc: dw_mmc: Remove fifo_depth from struct dw_mci_board
      mmc: dw_mmc: Move detect_delay_ms from struct dw_mci_board to struct dw_mci
      mmc: dw_mmc: Remove bus_hz from struct dw_mci_board
      mmc: dw_mmc: Remove struct dw_mci_board
      mmc: dw_mmc: Remove redundant struct mmc_data forward declaration
      mmc: dw_mmc: Remove DW_MCI_SEND_STATUS and DW_MCI_RECV_STATUS macros
      mmc: dw_mmc: Improve dw_mci_get_cd()
      mmc: dw_mmc: Remove unused register access macros
      mmc: dw_mmc-pci: Use BAR_2 and pcim_iomap_region()
      mmc: dw_mmc-pltfm: use modern PM macros
      arm64: dts: hisilicon: hikey960/970: Convert to use standard mmc alias
      mmc: dw_mmc-k3: Remove mshc alias support
      mmc: dw_mmc: Remove mshc alias support

Thorsten Blum (1):
      mmc: cavium: Use clamp to simplify cvm_mmc_set_clock

Vladimir Zapolskiy (1):
      dt-bindings: mmc: arm,pl18x: Do not use plural form of a proper noun PrimeCell

Yixun Lan (4):
      dt-bindings: mmc: spacemit,sdhci: add reset support
      mmc: sdhci-of-k1: add reset support
      dt-bindings: mmc: spacemit,sdhci: add support for K3 SoC
      mmc: sdhci-of-k1: spacemit: Add support for K3 SoC

 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |   2 +
 .../devicetree/bindings/mmc/arm,pl18x.yaml         |   2 +-
 .../devicetree/bindings/mmc/brcm,iproc-sdhci.yaml  |   5 +
 .../devicetree/bindings/mmc/bst,c1200-sdhci.yaml   |  70 ++
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |   2 -
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   3 +
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  14 +-
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |   4 +-
 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts  |   4 +-
 drivers/i2c/busses/i2c-omap.c                      |  24 +-
 drivers/mmc/core/card.h                            |  11 +
 drivers/mmc/core/mmc.c                             |  12 +
 drivers/mmc/core/queue.c                           |   9 +-
 drivers/mmc/core/quirks.h                          |  12 +
 drivers/mmc/host/Kconfig                           |  14 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/atmel-mci.c                       |  12 +-
 drivers/mmc/host/cavium-octeon.c                   |   5 +-
 drivers/mmc/host/cavium.c                          |   4 +-
 drivers/mmc/host/dw_mmc-bluefield.c                |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   9 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   6 +-
 drivers/mmc/host/dw_mmc-hi3798mv200.c              |  17 +-
 drivers/mmc/host/dw_mmc-k3.c                       |  51 +-
 drivers/mmc/host/dw_mmc-pci.c                      |  37 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |  17 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |  47 +-
 drivers/mmc/host/dw_mmc-starfive.c                 |   5 +-
 drivers/mmc/host/dw_mmc.c                          | 768 ++++++++-------------
 drivers/mmc/host/dw_mmc.h                          | 146 +---
 drivers/mmc/host/jz4740_mmc.c                      |   2 +-
 drivers/mmc/host/loongson2-mmc.c                   |   1 -
 drivers/mmc/host/mmci_qcom_dml.c                   |   1 +
 drivers/mmc/host/mtk-sd.c                          |  32 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   6 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  18 +
 drivers/mmc/host/sdhci-msm.c                       |  77 +++
 drivers/mmc/host/sdhci-of-aspeed.c                 |   5 +-
 drivers/mmc/host/sdhci-of-bst.c                    | 521 ++++++++++++++
 drivers/mmc/host/sdhci-of-k1.c                     |  39 +-
 drivers/mmc/host/sdhci.c                           |  23 +-
 drivers/mux/Kconfig                                |   8 +-
 drivers/mux/core.c                                 | 206 +++++-
 drivers/phy/phy-can-transceiver.c                  |  10 -
 include/linux/mmc/card.h                           |   2 +
 include/linux/mmc/sdio_ids.h                       |   3 +
 include/linux/mux/consumer.h                       | 108 ++-
 49 files changed, 1590 insertions(+), 795 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/bst,c1200-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-bst.c
