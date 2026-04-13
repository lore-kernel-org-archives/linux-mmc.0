Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B932F749
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081566; cv=none; b=Fxq5cakRHtcQoWfi3SPvpthqlp/QnzU254nwRCE+F/pmPEunIJ+0tj4+QZxO2cWN5gnXIkSiiqhAUX9bZ5CAQlnARoBQQFa+TUfUPqRpYJUim0RACUqWzzy84d2Lvs7/pC52uzhfS3ozM2r2mY5pnRcXgN4y/BAyz5krF1qu2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081566; c=relaxed/simple;
	bh=qNXUwz9SovZcwTVx9SJV7LC0uXPsXuOY/QCVxEGIF1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+u2MOx/gUYLpajO44FQNihFzcijcmh4fmjJPOp/0bfmCntRwtgVFQ6pR74SxMMosZEkoFK1eQ7Hx2cCsQGuT+Z4S36+vuSSngJfXBtEbXDf7oGbpjneVnmCQAetRd2XlyEhQyZlMS9DgeXU45iOm6Kq0TPf34H+jTkm+NcmD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UJbOYZUb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJbOYZUb"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a3ffedde9aso610788e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776081563; x=1776686363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dW6nGeHNLq3KMQaApfEiW3UTZKGQiRA7yAIkeUyzwqg=;
        b=UJbOYZUbpUC8BMBDXs1BTCeFJybVC0EqoGBXTiFTzS4ryi6jkwpFbH5aeCKYBECkmA
         V5dDV5cCjQ/cxg06i2OuCh1EeeF0SPv6DfiW6HES1xrxH95AzjP73YmnAmDlRIfgLF+n
         YoNK/nI1GXDpDTG5BzUnlhbvUih9xYRkaRp3gShV+uRiF7NO8WOzfCC3nwi8pOKV4oF3
         D6V1XPctZe/SrJieW9uMwFZgsuNYYrEV7L9pHM7KYL/fwlrQFbrqeEWqnZNLlIhTCblU
         NVI8lThMLCIYVvX7tW1SxB9Uq8kvmp+00IIK1ndJ7yLOe7YM4Mm7TS+NF4NwJM7egpxb
         bhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776081563; x=1776686363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW6nGeHNLq3KMQaApfEiW3UTZKGQiRA7yAIkeUyzwqg=;
        b=b89Aub3Lim8JYOuyO2q+hLPz51YrxHd/qeH8Dto91ayf+sBgItfyBVHN/hd24g8IBa
         T8jDa6CLKs0v8GPeH9hz3nIUld5gZzr7ZU74vNOXOnQOZkurmWlHobPiWCisAkpvBg8Z
         3gcYgAfK5ZD2fjJdI006Jiea2hm7v8QMW6n8sAzeZNvXUUEIG+jhZYJ5gba/dF9o65gn
         lhnktJ/Hh1WQaabLuEVR4ps3f9cXH6IVN1KUNwj4qCyjJB8GvQayAVV5VKok7SNCeVBl
         SDv2VZJYK3ir7D72M1OCVzRutImPTN56CFcXQ5ThsRSd5WEP3nqKKffPgQGySIxtOCk8
         SRqA==
X-Forwarded-Encrypted: i=1; AFNElJ8mGicDeH+5bT+nRdRSL5Jrtv10IVZRDzVcpOfz6dFIlPTNnrqTqW0YFVEdCUmsTBPSBBhJO5OhC4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8phdghloLyfXCJ70r1H3l8fYGPHfcC2tQUNpqN7tjbdaXP97
	HryP9Mkhw6kXZObJlE/VCQw/1cQyoBtzdYH0QZU/EhlcH9Xyf9/rsMyNVNUNQd5WNkY=
X-Gm-Gg: AeBDiev6oF/XoVmzgWADf+SOOaYDuPa94cfOQMW6ynN0av64qyY2wACrRticVoaM0bp
	jSUiywpSUJzElyjqO9VdIOzX2e2lriJbia+mbPQBJisegU6U+o7S9J3nYhoMNIwsxfox2L2klav
	Akc6d6Y95lrcq77S8BJQIuzUiHo6mPI91hPC5gVvG/hO/GgvJi6zfUJltQBOpn7etpD8E7r1weh
	PlBQ0RpO7pVBxZX3vq91iDgvrvbLyr9eGc33rrPdvKvWnCT2MP4Zf5XJqp2JY+MszF7mz02aYYS
	lTSDv5O6s+dLF1cBXr2WcckTti8Et501EkNKnB3pNwGH3/LG5TC1qpz6oUo2H2+fFNnJm2e7eLE
	FYmfHplNA10jJOvaCEhkqYhgA88ERW40c5O8RAAoS2FCJlgqve+MB5I1/P6cuen1XRnz+fcmh1P
	3mTmtcgecVRBSVIBZcH3zXKVkTwjRA0EcpFbsd5qS64sEZ+rMrGzPesB0NmehzAWDNWDDi+B2r
X-Received: by 2002:a05:6512:1596:b0:5a2:b51a:6a55 with SMTP id 2adb3069b0e04-5a3efb4178cmr3851578e87.29.1776081562909;
        Mon, 13 Apr 2026 04:59:22 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eeee14bbsm2645778e87.43.2026.04.13.04.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:59:22 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v7.1
Date: Mon, 13 Apr 2026 13:59:21 +0200
Message-ID: <20260413115921.108815-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with the updates for MMC for v7.1. Details about the
highlights are as usual found in the signed tag.

Note that, this time I have picked up some changes to improve the mux subsystem
and those are also part of this pull-request, as they are needed by mmc.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8f4d20a710225ec7a565f6a0459862d3b1f32330:

  mmc: vub300: fix use-after-free on disconnect (2026-03-31 13:11:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.1

for you to fetch changes up to 52957cdad30f8011da1f4ef1338ba0339ca4c158:

  mmc: sdhci-msm: Fix the wrapped key handling (2026-04-10 10:29:58 +0200)

----------------------------------------------------------------
MMC core:
 - Add NXP vendor and IW61x device IDs for WiFi chips over SDIO
 - Add quirk for incorrect manufacturing date
 - Add support for manufacturing date beyond 2025
 - Optimize support for secure erase/trim for some Kingston eMMCs
 - Remove support for the legacy "enable-sdio-wakeup" DT property
 - Use single block writes in the retry path

MMC host:
 - dw_mmc: A great amount of cleanups/simplifications to improve the code
 - dw_mmc: Add clk_phase_map support
 - dw_mmc: Remove mshc DT alias support
 - dw_mmc-rockchip: Fix runtime PM support for internal phase
 - dw_mmc-rockchip: Add support for the RV1103B variant
 - loongson2: Add support for the Loongson-2K0300 SD/SDIO/eMMC controller
 - mtk-sd: Add support for the MT8189 variant
 - renesas_sdhi_core: Add support for selecting an optional mux
 - rtsx_pci_sdmmc: Simplify voltage switch handling
 - sdhci: Stop advertising the driver in dmesg
 - sdhci-esdhc-imx: Add 1-bit bus width support
 - sdhci-esdhc-imx: Add support for the NXP S32N79 variant
 - sdhci-msm: Add support for the IPQ5210 and IPQ9650 variants
 - sdhci-msm: Add support for wrapped keys
 - sdhci-msm: Enable ICE for CQE-capable controllers with non-CQE cards
 - sdhci-of-arasan: Add support for the Axiado AX3000 variant
 - sdhci-of-aspeed: Add support for the AST2700 variant
 - sdhci-of-bst: Add driver for the Black Sesame Technologies C1200 controller
 - sdhci-of-dwcmshc: Add support for the Canaan K230 variant
 - sdhci-of-dwcmshc: Add support for the HPE GSC variant
 - sdhci-of-dwcmshc: Prevent clock glitches to avoid malfunction
 - sdhci-of-k1: Add support for the K3 variant

mux core/consumers:
 - core: Add helper functions for getting optional and selected mux-state
 - i2c-omap: Convert to devm_mux_state_get_optional_selected()
 - phy-renesas: Convert to devm_mux_state_get_optional_selected()
 - phy-can-transceiver: Convert to devm_mux_state_get_optional()

----------------------------------------------------------------
Albert Yang (4):
      dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
      mmc: sdhci: allow drivers to pre-allocate bounce buffer
      mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
      MAINTAINERS: add MMC files to BST entry

Andre Korol (1):
      mmc: loongson2-mmc: drop redundant memset after dma_alloc_coherent()

Andy Shevchenko (1):
      mmc: sdhci-pci: Drop unused include

Arnd Bergmann (1):
      mmc: dw_mmc: move pmops into core driver

Avri Altman (2):
      mmc: core: Adjust MDT beyond 2025
      mmc: core: Add quirk for incorrect manufacturing date

Bhargav Joshi (1):
      dt-bindings: mmc: hisilicon,hi3660-dw-mshc: Convert to DT schema

Bin Liu (2):
      mmc: block: use single block write in retry
      mmc: core: Optimize size of struct mmc_queue_req

Binbin Zhou (3):
      dt-bindings: mmc: loongson,ls2k0500-mmc: Add compatible for Loongson-2K0300
      mmc: loongson2: Gathering all SoCs private data together
      mmc: loongson2: Add Loongson-2K0300 SD/SDIO/eMMC controller driver

Brian Masney (2):
      mmc: sdhci-pic32: add SPDX license identifier
      mmc: sdhci-pic32: allow driver to be compiled with COMPILE_TEST

Cathy Xu (1):
      mmc: mtk-sd: disable new_tx/rx and modify related settings for mt8189

Ciprian Marian Costea (2):
      dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
      mmc: sdhci-esdhc-imx: add NXP S32N79 support

Ethan Nelson-Moore (1):
      mmc: host: Remove unnecessary module_init/exit functions

Fabio Estevam (2):
      dt-bindings: mmc: rockchip-dw-mshc: Add RV1103B compatible
      dt-bindings: mmc: rockchip-dw-mshc: Fix the RV1103B compatible

Felix Gu (1):
      mmc: sdhci-of-bst: Fix memory leak in sdhci_bst_alloc_bounce_buffer()

Geert Uytterhoeven (1):
      mmc: renesas_sdhi_sys_dmac: Convert to DEFINE_RUNTIME_DEV_PM_OPS()

Hans Zhang (1):
      mmc: core: Simplify with scoped for each OF child loop

Huan He (1):
      dt-bindings: mmc: dwcmshc-sdhci: Fix resets array validation

Jeff Chen (1):
      mmc: sdio: add NXP vendor and IW61x device IDs

Jiayu Du (2):
      dt-bindings: mmc: Add sdhci support for Canaan k230
      mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC controller support

Johan Hovold (2):
      mmc: vub300: rename probe error labels
      mmc: vub300: clean up module init

Josua Mayer (9):
      phy: can-transceiver: rename temporary helper function to avoid conflict
      phy: renesas: rcar-gen3-usb2: rename local mux helper to avoid conflict
      mux: Add helper functions for getting optional and selected mux-state
      phy: can-transceiver: drop temporary helper getting optional mux-state
      phy: renesas: rcar-gen3-usb2: drop helper getting optional mux-state
      i2c: omap: switch to new generic helper for getting selected mux-state
      dt-bindings: mmc: renesas,sdhi: Add mux-states property
      mux: add visible config symbol to enable multiplexer subsystem
      mmc: host: renesas_sdhi_core: support selecting an optional mux

Kathiravan Thirumoorthy (2):
      dt-bindings: mmc: sdhci-msm: add IPQ5210 compatible
      dt-bindings: mmc: sdhci-msm: add IPQ9650 compatible

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

Luke Wang (6):
      mmc: sdhci-esdhc-imx: wait for data transfer completion before reset
      mmc: core: Optimize time for secure erase/trim for some Kingston eMMCs
      mmc: core: Validate UHS/DDR/HS200 timing selection for 1-bit bus width
      mmc: sdhci-esdhc-imx: add 1-bit bus width support
      mmc: sdhci-esdhc-imx: remove duplicate HS400 bus width validation
      mmc: sdhci-pltfm: remove duplicate DTS property parsing

Md Sadre Alam (1):
      mmc: sdhci-msm: Enable ICE for CQE-capable controllers with non-CQE cards

Neeraj Soni (2):
      mmc: sdhci-msm: Add support for wrapped keys
      mmc: sdhci-msm: Fix the wrapped key handling

Nick Hawkins (2):
      dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC dwcmshc compatible
      mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support

Ricky Wu (1):
      mmc: rtsx_pci_sdmmc: simplify voltage switch handling after card_busy()

Rob Herring (Arm) (3):
      dt-bindings: mmc: cdns,sdhci: Drop required "resets" on AMD Pensando ELBA
      dt-bindings: mmc: brcm,iproc-sdhci: Allow "dma-coherent" and "iommus" properties
      dt-bindings: mmc: arasan,sdhci: Allow "dma-coherent" property

Ronald Claveau (1):
      dt-bindings: mmc: amlogic: Add compatible for T7 mmc

Rosen Penev (1):
      mmc: mmc_test: use kzalloc_flex

Ryan Chen (2):
      dt-bindings: mmc: sdhci-of-aspeed: Add AST2700 compatible
      mmc: sdhci-of-aspeed: Handle optional controller reset

Shawn Lin (51):
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
      mmc: dw_mmc: Rename dw_mci_pltfm_pmops to dw_mci_pmops
      mmc: dw_mmc: Add parsing mmc_clk_phase_map support
      mmc: dw_mmc-hi3798mv200: Using phase map from dw_mmc core
      mmc: dw_mmc-rockchip: Add phase map support
      mmc: core: Remove checking MMC_CAP_4_BIT_DATA from mmc_host_can_uhs()
      mmc: dw_mmc-pltfm: Use phase_map for SoCFPGA clock phase configuration
      mmc: sdhci-of-arasan: Use standard mmc_clk_phase_map infrastructure
      mmc: core: Remove legacy 'enable-sdio-wakeup' DT property support
      mmc: core: Switch to use pm_ptr() for mmc_host_class_dev_pm_ops
      mmc: sdhci-dwcmshc: Refactor Rockchip platform data for controller revisions
      mmc: core: Replace the hard-coded shift value 9 with SECTOR_SHIFT
      mmc: block: Convert to use DEFINE_SIMPLE_DEV_PM_OPS()
      mmc: mmc_test: Replace hard-coded values with macros and consolidate test parameters
      mmc: block: Use MQRQ_XFER_SINGLE_BLOCK for both read and write recovery
      mmc: dw_mmc: Inline dw_mci_queue_request() into dw_mci_request()
      mmc: dw_mmc: Remove dw_mci_start_request wrapper and rename core function
      mmc: sdhci-of-dwcmshc: Disable clock before DLL configuration

SriNavmani A (2):
      dt-bindings: mmc: arasan,sdhci: Add Axiado AX3000 SoC
      mmc: sdhci-of-arasan: add support on Axiado AX3000 SoC

Thorsten Blum (3):
      mmc: cavium: Use clamp to simplify cvm_mmc_set_clock
      mmc: sdio: Use min3() to simplify sdio_set_block_size()
      mmc: tifm_sd: Use min3() to simplify tifm_sd_transfer_data()

Ulf Hansson (5):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge the immutable mux branch into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Vladimir Zapolskiy (1):
      dt-bindings: mmc: arm,pl18x: Do not use plural form of a proper noun PrimeCell

Yixun Lan (4):
      dt-bindings: mmc: spacemit,sdhci: add reset support
      mmc: sdhci-of-k1: add reset support
      dt-bindings: mmc: spacemit,sdhci: add support for K3 SoC
      mmc: sdhci-of-k1: spacemit: Add support for K3 SoC

 .../bindings/mmc/amlogic,meson-gx-mmc.yaml         |   4 +
 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |   5 +
 .../devicetree/bindings/mmc/arm,pl18x.yaml         |   2 +-
 .../devicetree/bindings/mmc/aspeed,sdhci.yaml      |  41 +-
 .../devicetree/bindings/mmc/brcm,iproc-sdhci.yaml  |   5 +
 .../devicetree/bindings/mmc/bst,c1200-sdhci.yaml   |  70 ++
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |   2 -
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   1 +
 .../bindings/mmc/hisilicon,hi3660-dw-mshc.yaml     | 117 +++
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |  73 --
 .../bindings/mmc/loongson,ls2k0500-mmc.yaml        |   1 +
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   3 +
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   4 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   2 +
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |  63 ++
 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  14 +-
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |   4 +-
 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts  |   4 +-
 drivers/i2c/busses/i2c-omap.c                      |  24 +-
 drivers/mmc/core/block.c                           |  86 +--
 drivers/mmc/core/card.h                            |  11 +
 drivers/mmc/core/core.c                            |   3 +-
 drivers/mmc/core/host.c                            |  29 +-
 drivers/mmc/core/host.h                            |   6 +-
 drivers/mmc/core/mmc.c                             |  12 +
 drivers/mmc/core/mmc_test.c                        | 111 ++-
 drivers/mmc/core/queue.c                           |   9 +-
 drivers/mmc/core/queue.h                           |   7 +-
 drivers/mmc/core/quirks.h                          |  21 +-
 drivers/mmc/core/sdio_io.c                         |   6 +-
 drivers/mmc/host/Kconfig                           |  16 +-
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/atmel-mci.c                       |  12 +-
 drivers/mmc/host/cavium-octeon.c                   |   5 +-
 drivers/mmc/host/cavium.c                          |   4 +-
 drivers/mmc/host/dw_mmc-bluefield.c                |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   9 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   6 +-
 drivers/mmc/host/dw_mmc-hi3798mv200.c              |  28 +-
 drivers/mmc/host/dw_mmc-k3.c                       |  51 +-
 drivers/mmc/host/dw_mmc-pci.c                      |  37 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |  34 +-
 drivers/mmc/host/dw_mmc-pltfm.h                    |   2 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |  36 +-
 drivers/mmc/host/dw_mmc-starfive.c                 |   5 +-
 drivers/mmc/host/dw_mmc.c                          | 819 ++++++++-------------
 drivers/mmc/host/dw_mmc.h                          | 148 +---
 drivers/mmc/host/jz4740_mmc.c                      |   2 +-
 drivers/mmc/host/loongson2-mmc.c                   |  60 +-
 drivers/mmc/host/mtk-sd.c                          |  32 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   6 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  12 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  88 +--
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  33 +-
 drivers/mmc/host/sdhci-msm.c                       | 124 +++-
 drivers/mmc/host/sdhci-of-arasan.c                 |  88 +--
 drivers/mmc/host/sdhci-of-aspeed.c                 |  11 +-
 drivers/mmc/host/sdhci-of-bst.c                    | 523 +++++++++++++
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 517 ++++++++++++-
 drivers/mmc/host/sdhci-of-k1.c                     |  39 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   1 -
 drivers/mmc/host/sdhci-pic32.c                     |   5 +-
 drivers/mmc/host/sdhci-pltfm.c                     |  20 -
 drivers/mmc/host/sdhci-uhs2.c                      |  13 +-
 drivers/mmc/host/sdhci.c                           |  23 +-
 drivers/mmc/host/tifm_sd.c                         |   4 +-
 drivers/mmc/host/vub300.c                          |  51 +-
 drivers/mux/Kconfig                                |  17 +-
 drivers/mux/core.c                                 | 194 ++++-
 drivers/phy/phy-can-transceiver.c                  |  10 -
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  30 +-
 include/linux/mmc/card.h                           |   2 +
 include/linux/mmc/sdio_ids.h                       |   3 +
 include/linux/mux/consumer.h                       | 108 ++-
 76 files changed, 2564 insertions(+), 1415 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/bst,c1200-sdhci.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/sdhci-of-bst.c
