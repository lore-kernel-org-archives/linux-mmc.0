Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59970270ED9
	for <linux-mmc@vger.kernel.org>; Mon, 29 Sep 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149748; cv=none; b=lGlOB6XbzL89t7OtDMlRalzFqhsDUMXC7mxxszS8j/x6E6D82ULoRO53G5xqzipLZiIS1Sst5te/Ylls8eFJBsj00yKVntetJ9Oe2/+PlOCkjSI1gFNNHML5rn8WZcy0S/SXfg/WME4WgvDGqSVXWsMLxAgAutMQ1l05kYPEEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149748; c=relaxed/simple;
	bh=jjZy6UkBfPj+MxOy7/7UZ2wPnKGSNtL3ZvEYwlgGnec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O9yEV6JvDM7XZ9ZQwVSBw0zhCXNQrChHgSwyXz4TZ+bsb92DdxBVkB079C6xaLybwzjlICZI5uEIAhrGbS+1uu/XhfH3ZiVIeQSwCAYJhAsbQvgpfR5RYvkk3RoyWQ6vSqPMh8JCp9PnfpE+hE9WaPAbJykfk1fKOF5E4//SAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fr5sj2sC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fr5sj2sC"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57f1b88354eso4720070e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Sep 2025 05:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759149743; x=1759754543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5yce84UiJOXCwi/vHCN+GF/VWSjDuegEM+VLQPICFs=;
        b=Fr5sj2sCzzQTe5Dy8smSzsntwM2Ez7dB2kWJw79bIqDmjZiMj8KKSiWkWqKlR7bq+k
         o7T5PiaDdS2aBw0IftB9/+/Cr03Eg0HTH0vNJU1ZNOPQPUMh/RGexIQF72wsfwWbfHcg
         xpqM2s4ckIWwsX4vd5IJc/zQ2yBZefcPvHvDBHXsU9GJWYFig3PHEo4/AfDq6FiSe3sQ
         MdlqgKu8ImvaZabZI9LlT07RJuMCoI9vBIGKbHMp1WdHGREPSFuth4++hkIzcuOnY4YF
         0OStWBonblvEudGBAVJUparP3cB1hP8y8kaL/itxECxDN9rviFqoPgDDVmSsKP6ubPXe
         QFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759149743; x=1759754543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5yce84UiJOXCwi/vHCN+GF/VWSjDuegEM+VLQPICFs=;
        b=dZZVGUCpEcnIOUKWQoXlZtXSAKLoENDVcj5XRrI7l/X/en+ik8IGDgvjN/zZI27gFP
         uVQP13sE5rI6hV4puIEiOd5HZ66WqVFt9y6JXKfXJA3Llo+u9832MZmYnxJxE1qDqXLr
         8vhylwDmvY5VDUPB3ZzaggxYPZ48kbi4N1nrxK59qY/V8ylRwmuxzVvFM1Dz2s9HrGuw
         j85rs+s1nwzXuOi/+quH56pX0eb6OJZyR+4gBes6xbqrmQvghU8P5ClsydTrwmKQz8li
         BpCu+oglvSdHYal2SlcuwrvfUkbqVPBVYOJVloVfS/RPNKZ0IFeMw5FBHR8JX7rF5Toj
         Q+vw==
X-Forwarded-Encrypted: i=1; AJvYcCVMVZmPe9RNwiivpYA9K3LYG1R2b/OUi8KDQuuUWpBOJmyx4L6ZpMtChpC5TxJ1GCdyf2TMZ0FxVYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVaF7jJJ3RmV/M0z+1gZ9m02BXXdKkFHEazNyDSP6AUTjqvoL
	3J1dQxCMK+RXaCbVjvnbXrZ88sqyanUKq2NAyqPjoq2Tr1eTZHp8re2ImghCpBKlvaw=
X-Gm-Gg: ASbGncuBVCAszML05LyF3mzZrfYA0UempwWWjt2BINWUIwKowlaWBglxY99fWQqiQCi
	K6NFX+xkooNPSOcTCRp1zIGnoUXdZ2fcbYQ4kTBaA8c0l8d9HJdcCciYl2uzvWMLDrPi8GSpooP
	V79E0Zcw2d2padIG+tQcYgsRhLnTIZqFcL7UYuUb18kP8yGwsczPtvSjBgEVrGfbrOUcHqgPNM9
	JbR5mCQ6yi75y1TJMhgt2Gl8byZg1rcW91gqL+ZFUkfkWKqN6/vUNrNhg6GGpck+Ujex6gOQ0Mp
	mFwteiSk4qAQXLQRlqF05EN9k16jhNiJxPozTZLuTww+TQ/Aw2uPN9SNt4nJpZhZV6L29Nbt1Vm
	KKwKGY0JC26F+R8+0dVJX3L5KAIwhbSwLhRE0FoVNdFCzg1SNoXuY+Gux4OdndNhMr5vY5DHASw
	aSEiGoytn3sMdioN583g==
X-Google-Smtp-Source: AGHT+IHE/mJGSWDJNW4qd7NNhHKqmjQxQKVuNZed5r+j7Mr1bTFOPXbGy6rOJOkWuQqomzgkFqhD+g==
X-Received: by 2002:a05:6512:234b:b0:57b:5f02:e9f1 with SMTP id 2adb3069b0e04-582d073f8c2mr5185983e87.6.1759149743313;
        Mon, 29 Sep 2025 05:42:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313dd67c4sm4131982e87.55.2025.09.29.05.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:42:22 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC/MEMSTICK updates for v6.18
Date: Mon, 29 Sep 2025 14:42:12 +0200
Message-ID: <20250929124221.229605-1-ulf.hansson@linaro.org>
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

Here's the pull-request with the updates for MMC and MEMSTICK for v6.18.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 77a436c93d10d68201bfd4941d1ca3230dfd1f40:

  mmc: sdhci-pci-gli: GL9767: Fix initializing the UHS-II interface during a power-on (2025-09-12 15:00:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18

for you to fetch changes up to 7aada81cd75ad844c84fb1dcdce2d67ec41763f8:

  dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for exynos8890 (2025-09-23 16:45:04 +0200)

----------------------------------------------------------------
MMC core:
 - Improve RPMB frame handling code
 - Add support for a new max-sd-hs-hz DT property to limit frequency
 - Add support to manage regulator-under-voltage events
 - Support regulator-under-voltage for eMMC to mitigate data corruptions
 - Add mmc_read_tuning() to allow a host to validate its tuning sequence
 - Add some helpers to align checks for CMD23 support
 - Read the CCCR register for SDIO over SPI rather than the unsupported CMD7

MMC host:
 - Add COMPILE_TEST option for a couple of drivers
 - Convert drivers to use the modern PM macros
 - dw_mmc-exynos: Enable support for the Exynos8890 variant
 - mmc_spi: Don't use crc ack during multiple block read
 - renesas_sdhi: Enable 64-bit polling mode for R-Car gen3 and RZ/G2L SoCs
 - rtsx_usb: Add support for over-current-protection
 - sdhci-cadence: Add support for multi-block read gap tuning
 - sdhci-msm: Add support for tuning for SDR50 mode for SD cards
 - sdhci-msm: Enable support for the Lemans variant
 - sdhci-pci: Disable SD card clock before update for a few Intel platforms
 - sdhci-pxav3: Add support for UHS pinctrl settings
 - tmio: Add 64-bit read/write support in polling mode

MEMSTICK:
 - Convert to use timeouts to prevent indefinite waiting
 - rtsx_usb: Add support for over-current-protection

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: mmc: fsl,esdhc: Add explicit reference to mmc-controller-common

Bean Huo (2):
      mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()
      mmc: core: Improve RPMB frame handling code

Benoît Monin (6):
      mmc: core: add mmc_card_can_cmd23
      mmc: card: add mmc_card_blk_no_cmd23
      mmc: mmc_test: use mmc_card cmd23 helpers
      mmc: block: use mmc_card cmd23 helpers
      mmc: core: add mmc_read_tuning
      mmc: sdhci-cadence: implement multi-block read gap tuning

Biju Das (4):
      mmc: host: renesas_sdhi: Fix the actual clock
      mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
      mmc: renesas_sdhi: Enable 64-bit polling mode
      mmc: renesas_sdhi: Replace magic number '0xff' in renesas_sdhi_set_clock()

Claudiu Beznea (1):
      mmc: sdio: Drop dev_pm_domain_detach() call

Colin Ian King (2):
      mmc: Kconfig: Fix spelling mistake "referrered" -> "referred"
      mmc: davinci: Remove space before newline

Dan Carpenter (2):
      mmc: mmc_spi: remove unnecessary check in mmc_spi_setup_data_message()
      mmc: rtsx_usb_sdmmc: Fix uninitialized variable issue

Duje Mihanović (3):
      dt-bindings: mmc: sdhci-pxa: add state_uhs pinctrl
      mmc: sdhci-pxav3: add state_uhs pinctrl setting
      dt-bindings: mmc: sdhci-pxa: Add minItems to pinctrl-names

Erick Shepherd (1):
      mmc: sdhci: Disable SD card clock before changing parameters

Geert Uytterhoeven (1):
      mmc: sh_mmcif: Remove dummy PM resume callback

Ivaylo Ivanov (1):
      dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for exynos8890

Jiayi Li (1):
      memstick: Add timeout to prevent indefinite waiting

Jisheng Zhang (38):
      mmc: sdhci: add some simple inline functions for !CONFIG_PM
      mmc: sdhci-of-dwcmshc: use modern PM macros
      mmc: sdhci-xenon: use modern PM macros
      mmc: sdhci-pxav3: use modern PM macros
      mmc: sunxi: use modern PM macros
      mmc: alcor: use modern PM macros
      mmc: atmel: use modern PM macros
      mmc: au1xmmc: use modern PM macros
      mmc: cb710-mmc: use modern PM macros
      mmc: davinci_mmc: use modern PM macros
      mmc: mmci: use modern PM macros
      mmc: mxs-mmc: use modern PM macros
      mmc: omap_hsmmc: use modern PM macros
      mmc: rtsx_usb_sdmmc: use modern PM macros
      mmc: sdhci-acpi: use modern PM macros
      mmc: sdhci_am654: use modern PM macros
      mmc: sdhci-brcmstb: use modern PM macros
      mmc: sdhci-esdhc-imx: use modern PM macros
      mmc: sdhci-of-arasan: use modern PM macros
      mmc: sdhci-of-at91: use modern PM macros
      mmc: sdhci-of-esdhc: use modern PM macros
      mmc: sdhci-omap: use modern PM macros
      mmc: sdhci-cadence: use modern PM macros
      mmc: sdhci-s3c: use modern PM macros
      mmc: sdhci-spear: use modern PM macros
      mmc: sdhci-sprd: use modern PM macros
      mmc: sdhci-st: use modern PM macros
      mmc: sdhci-tegra: use modern PM macros
      mmc: sh_mmicf: use modern PM macros
      mmc: toshsd: use modern PM macros
      mmc: wmt-sdmmc: use modern PM macros
      mmc: mtk-sd: use modern PM macros
      mmc: sdhci-msm: use modern PM macros
      mmc: via-sdmmc: use modern PM macros
      mmc: dw_mmc: exynos: use modern PM macros
      mmc: dw_mmc-k3: use modern PM macros
      mmc: dw_mmc-pci: use modern PM macros
      mmc: dw_mmc-rockchip: use modern PM macros

Mikko Rapeli (2):
      mmc: add COMPILE_TEST to multiple drivers
      mmc: select REGMAP_MMIO with MMC_LOONGSON2

Monish Chunara (1):
      dt-bindings: mmc: sdhci-msm: Document the Lemans compatible

Nathan Chancellor (1):
      mmc: sdhci-cadence: Fix -Wuninitialized in sdhci_cdns_tune_blkgap()

Oleksij Rempel (2):
      mmc: core: Add infrastructure for undervoltage handling
      mmc: core: add undervoltage handler for MMC/eMMC devices

Rex Chen (2):
      mmc: core: SPI mode remove cmd7
      mmc: mmc_spi: multiple block read remove read crc ack

Ricky Wu (1):
      misc: rtsx: usb card reader: add OCP support

Sarthak Garg (3):
      mmc: sdhci-msm: Enable tuning for SDR50 mode for SD card
      dt-bindings: mmc: controller: Add max-sd-hs-hz property
      mmc: core: Parse and use the new max-sd-hs-hz DT property

Ulf Hansson (3):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Wolfram Sang (1):
      mmc: remove unneeded 'fast_io' parameter in regmap_config

Xichao Zhao (1):
      mmc: meson-mx-sdhc: use PTR_ERR_OR_ZERO() to simplify code

 .../devicetree/bindings/mmc/fsl,esdhc.yaml         |  1 +
 .../bindings/mmc/mmc-controller-common.yaml        |  8 +++
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |  1 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |  1 +
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 31 ++++++++-
 drivers/memstick/core/memstick.c                   |  8 ++-
 drivers/memstick/host/rtsx_usb_ms.c                |  5 +-
 drivers/misc/cardreader/rtsx_usb.c                 |  7 ++
 drivers/mmc/core/block.c                           | 46 ++++++-------
 drivers/mmc/core/bus.c                             | 12 ++++
 drivers/mmc/core/card.h                            |  9 ++-
 drivers/mmc/core/core.c                            | 32 +++++++++
 drivers/mmc/core/core.h                            |  6 ++
 drivers/mmc/core/host.c                            |  4 ++
 drivers/mmc/core/mmc.c                             | 70 +++++++++++++++++++-
 drivers/mmc/core/mmc_ops.c                         | 72 ++++++++++++++++++++
 drivers/mmc/core/mmc_test.c                        | 10 +--
 drivers/mmc/core/regulator.c                       | 77 ++++++++++++++++++++++
 drivers/mmc/core/sd.c                              |  2 +-
 drivers/mmc/core/sdio.c                            |  6 +-
 drivers/mmc/core/sdio_bus.c                        |  3 -
 drivers/mmc/host/Kconfig                           | 14 ++--
 drivers/mmc/host/alcor.c                           |  8 +--
 drivers/mmc/host/atmel-mci.c                       |  9 +--
 drivers/mmc/host/au1xmmc.c                         | 18 ++---
 drivers/mmc/host/cb710-mmc.c                       | 19 +++---
 drivers/mmc/host/davinci_mmc.c                     | 16 ++---
 drivers/mmc/host/dw_mmc-exynos.c                   | 13 +---
 drivers/mmc/host/dw_mmc-k3.c                       |  9 +--
 drivers/mmc/host/dw_mmc-pci.c                      |  9 +--
 drivers/mmc/host/dw_mmc-rockchip.c                 |  9 +--
 drivers/mmc/host/dw_mmc.h                          |  3 +
 drivers/mmc/host/meson-mx-sdhc-clkc.c              |  4 +-
 drivers/mmc/host/mmc_spi.c                         |  4 +-
 drivers/mmc/host/mmci.c                            |  9 +--
 drivers/mmc/host/mtk-sd.c                          | 14 ++--
 drivers/mmc/host/mxs-mmc.c                         |  6 +-
 drivers/mmc/host/omap_hsmmc.c                      | 13 ++--
 drivers/mmc/host/renesas_sdhi_core.c               |  6 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  3 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  | 40 ++++++++---
 drivers/mmc/host/sdhci-acpi.c                      | 18 ++---
 drivers/mmc/host/sdhci-brcmstb.c                   |  8 +--
 drivers/mmc/host/sdhci-cadence.c                   | 70 ++++++++++++++++++--
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 13 +---
 drivers/mmc/host/sdhci-msm.c                       | 36 ++++++----
 drivers/mmc/host/sdhci-of-arasan.c                 |  8 +--
 drivers/mmc/host/sdhci-of-at91.c                   | 12 +---
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 13 +---
 drivers/mmc/host/sdhci-of-esdhc.c                  |  8 +--
 drivers/mmc/host/sdhci-omap.c                      | 18 ++---
 drivers/mmc/host/sdhci-pci-core.c                  | 15 ++++-
 drivers/mmc/host/sdhci-pxav3.c                     | 52 ++++++++++++---
 drivers/mmc/host/sdhci-s3c.c                       | 11 +---
 drivers/mmc/host/sdhci-spear.c                     |  6 +-
 drivers/mmc/host/sdhci-sprd.c                      | 10 +--
 drivers/mmc/host/sdhci-st.c                        |  6 +-
 drivers/mmc/host/sdhci-tegra.c                     | 13 ++--
 drivers/mmc/host/sdhci-xenon.c                     | 13 +---
 drivers/mmc/host/sdhci.h                           |  7 ++
 drivers/mmc/host/sdhci_am654.c                     | 11 +---
 drivers/mmc/host/sh_mmcif.c                        | 13 +---
 drivers/mmc/host/sunxi-mmc.c                       | 11 +---
 drivers/mmc/host/tmio_mmc.h                        | 15 +++++
 drivers/mmc/host/tmio_mmc_core.c                   | 33 ++++++++++
 drivers/mmc/host/toshsd.c                          |  8 +--
 drivers/mmc/host/via-sdmmc.c                       | 10 +--
 drivers/mmc/host/wmt-sdmmc.c                       | 16 +----
 include/linux/mmc/host.h                           | 13 ++++
 include/linux/platform_data/tmio.h                 |  3 +
 include/linux/rtsx_usb.h                           | 11 ++++
 71 files changed, 754 insertions(+), 364 deletions(-)
