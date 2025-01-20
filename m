Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C91E3DEB
	for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384616; cv=none; b=F8Af7nk93CGl6aJFnlvam6Z7cQ9HTZxaFcg/PdNS/bftXXF86nTEgHOdu9PoV49h59shhpfbVaZLqiVHylqdnrpkWcuFq0fUeMJ1ZHK2IMzaWLsgMTjNOeOos0fnbKng/n80rSmNkTJdmrDswNnC5y3i4k0jgiGiuhqlCQVqxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384616; c=relaxed/simple;
	bh=rTYmGmmUe8YZQSUYaRNr42VTA3FCM2KAHteUByiV0fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHbEV3Q45N802H0RItItsapFa3Uo4z1fWCdHisT3y0EVl4dCwG+i43QC3KkSIawYqzTfGHUcX+/FIBYoQrsP4R9jgFRMYDdkGNEVR10DKwyOs5Thmp9aGQVic7CDvkV8S19gAoqlgA0456WO8SxAwMk6bYfLz2uvbHBcTaJ970Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GxO7jzIi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxO7jzIi"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54287a3ba3cso5172632e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2025 06:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737384612; x=1737989412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8j6laY3kdmDRUN1iszstnogxR7IMwgHQ28XCnbDbhMc=;
        b=GxO7jzIiIkEdn4K+y4Sba96oulxWXAoXmb3oCZe4PrPRftBZ0+n4RbuSpafiQot8xs
         TZVwl3UWY7AgzwhcK9oGz1xHuUkTrdxOiiHDO+D/tvX1CuNr7mkotI+kE8KqUMT0ykT2
         as0InTXQNNBAlZ5UKyh8dxKTpLIMD8BFSpD07YO7CIQF2jv5hZKAJX3lxjM/noXPUJPB
         +RPbNHjsSJxwEfM4vMONLGMiuJbh9OVh09weqd0Ld+VPnPYtbWR29ptgUvyU/FtiP2Do
         wtkwq5/eCTywvqFaeaOGcL9zu+p4sO6w0mqrhNYsX3SLaMwnUiN+mBsgiS3N3p6wcqfF
         en7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737384612; x=1737989412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j6laY3kdmDRUN1iszstnogxR7IMwgHQ28XCnbDbhMc=;
        b=cczfDMJGZTEQT9BKo8YP/J9ySfgqiq6HGXDaFwhYaTdRSdara2beHkJXFbwnBEE0Z9
         T1ag0smNZD/IFloqPlQZbw+tDZNnVjTn14tZGn8lmZyf9ef/mTJB5wCsLYBp5U4AJ0ep
         IoDLjIo8F3b43gq/OI4IXW/Cle3rjeiXt0CmMbXODChKLW7tljCkoEYWcJvw3roznmDk
         BXvjbyg6S7EiMWp6ck6fSnGW766e0smvkI3iJC0QuTDWHlst+9Eutib9SZ7rrB+kf07x
         pSNWdJDcut0G9czKJCpkrOnJIX4krcYKZizBtNW2Ga7x7xnKm2fpmej96AIASHu3ACIO
         Hgyg==
X-Forwarded-Encrypted: i=1; AJvYcCVueKnknddQ/TNBf/Pcaxb0lfRFqBO5ZVgFyNZYuYKCz6DyH5Ddn8evb+NrQdIoRkVgqrcHbTuM5/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgE+wfsMJ2qQVhAP5KZ94Y0zcudv9sGHArp7qGj6/NsBt0Lv+
	NYiCwyAnsYqbpjJ8ag7w80Ei5rNq23sWqLI/YNlsU/BlDqg2HES/ECTyuOz18pI=
X-Gm-Gg: ASbGncusUTEnf4mNAgHFdxXjqkXS+4IvZY+aXyWZM4JrZLYLvCLR/onTjb7P2z5fMDu
	TRhQO7Oe1OImVM09Pkcr690Md9VHRWIT26R/hIWl2y1xFzuccsb4deEb+doOGkCvuv7Fbq1nMiw
	+NjBRetQqZ3iiHrKqEMBqR1vKl4sfmYxAOLq3PvR3bwnq7HOD2Fv87y818IvxExwaN4qYmd8PMz
	moJuVmaDHi2hEHTtTBHTSbEFnfIn1eysViXqAZQomHJj0eaRj7m0D//cnVBfQy0p+rBPcLFLpRg
	azSNLE/se2AM344ubMC9dMu5/OTXm0I1dqiV88gf1Bum
X-Google-Smtp-Source: AGHT+IEpqj7FSYljTmS53yT8d+L37BTDjKS4tnhfYeMPa2KxoMasEO0lLboeQC8nlVPdZUPFC25eTQ==
X-Received: by 2002:ac2:5e82:0:b0:542:8cf1:1a46 with SMTP id 2adb3069b0e04-5439bf7a8eamr3593187e87.9.1737384611733;
        Mon, 20 Jan 2025 06:50:11 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af067f7sm1375987e87.10.2025.01.20.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:50:10 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v6.14
Date: Mon, 20 Jan 2025 15:50:09 +0100
Message-ID: <20250120145009.175499-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with updates for MMC for v6.14. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8d90a86ed053226a297ce062f4d9f4f521e05c4c:

  mmc: sdhci-msm: fix crypto key eviction (2024-12-19 14:42:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14

for you to fetch changes up to 20a0c37e44063997391430c4ae09973e9cbc3911:

  mmc: sdhci-msm: Correctly set the load for the regulator (2025-01-17 12:31:03 +0100)

----------------------------------------------------------------
MMC core:
 - Share a helper to convert from crypto_profile to mmc_host
 - Respect quirk_max_rate for non-UHS SDIO card too

MMC host:
 - Add DT bindings for the mmc-slot
 - Clarify DT bindings for the mmc-controller
 - bcm2835: Add support for system-wide suspend/resume PM
 - dw_mmc-exynos: Add support for the exynos8895 variant
 - meson-mx-sdio: Convert DT bindings to dtschema
 - mtk-sd: Fixup use of two register ranges
 - mtk-sd: Add support for ignoring cmd response CRC
 - sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk for S32G
 - sdhci-msm: Correctly set the load for the regulator
 - sdhci-msm: Convert to use custom crypto profile
 - sdhci-of-at91: Add support for the microchip sama7d65 variant

----------------------------------------------------------------
Andy Shevchenko (2):
      mmc: sdhci-acpi: Remove not so useful error message
      mmc: sdhci-acpi: Use devm_platform_ioremap_resource()

Andy-ld Lu (2):
      mmc: core: Introduce the MMC_RSP_R1B_NO_CRC response
      mmc: mtk-sd: Add support for ignoring cmd response CRC

Chen-Yu Tsai (2):
      dt-bindings: mmc: mtk-sd: Document compatibles that need two register ranges
      mmc: mtk-sd: Limit getting top_base to SoCs that require it

Ciprian Marian Costea (1):
      mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk for S32G

Dharma Balasubiramani (1):
      dt-bindings: mmc: atmel,sama5d2-sdhci: add microchip,sama7d65-sdhci

Eric Biggers (2):
      mmc: crypto: add mmc_from_crypto_profile()
      mmc: sdhci-msm: convert to use custom crypto profile

Ivaylo Ivanov (1):
      dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for exynos8895

Krzysztof Kozlowski (2):
      dt-bindings: Drop Bhupesh Sharma from maintainers
      mmc: hi3798mv200: Use syscon_regmap_lookup_by_phandle_args

Neil Armstrong (5):
      dt-bindings: mmc: controller: clarify the address-cells description
      dt-bindings: mmc: controller: move properties common with slot out to mmc-controller-common
      dt-bindings: mmc: controller: remove '|' when not needed
      dt-bindings: mmc: document mmc-slot
      dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt to dtschema

Rob Herring (Arm) (2):
      dt-bindings: mmc: marvell,xenon-sdhci: Simplify Armada 3700 if/then schema
      mmc: Use of_property_present() for non-boolean properties

Shawn Lin (1):
      mmc: core: Respect quirk_max_rate for non-UHS SDIO card

Stefan Wahren (1):
      mmc: bcm2835: add suspend/resume pm support

Ulf Hansson (3):
      mmc: core: Drop the MMC_RSP_R1_NO_CRC response
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Wolfram Sang (1):
      mmc: core: don't include 'pm_wakeup.h' directly

Yuanjie Yang (1):
      mmc: sdhci-msm: Correctly set the load for the regulator

 .../devicetree/bindings/crypto/qcom-qce.yaml       |   3 +-
 .../bindings/mmc/amlogic,meson-mx-sdio.txt         |  54 ----
 .../bindings/mmc/amlogic,meson-mx-sdio.yaml        |  94 ++++++
 .../bindings/mmc/atmel,sama5d2-sdhci.yaml          |   1 +
 .../bindings/mmc/marvell,xenon-sdhci.yaml          |  48 ++-
 .../bindings/mmc/mmc-controller-common.yaml        | 357 +++++++++++++++++++++
 .../devicetree/bindings/mmc/mmc-controller.yaml    | 346 +-------------------
 .../devicetree/bindings/mmc/mmc-slot.yaml          |  49 +++
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |  10 +-
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   3 +-
 .../devicetree/bindings/net/qcom,ethqos.yaml       |   3 +-
 .../bindings/remoteproc/qcom,sm6115-pas.yaml       |   3 +-
 drivers/mmc/core/core.c                            |   7 +-
 drivers/mmc/core/host.c                            |   1 -
 drivers/mmc/core/sdio.c                            |   2 +
 drivers/mmc/host/bcm2835.c                         |  20 ++
 drivers/mmc/host/cqhci-crypto.c                    |  38 +--
 drivers/mmc/host/cqhci.h                           |   8 +-
 drivers/mmc/host/dw_mmc-hi3798mv200.c              |   8 +-
 drivers/mmc/host/mtk-sd.c                          |  21 +-
 drivers/mmc/host/mxcmmc.c                          |   8 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   2 -
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   3 -
 drivers/mmc/host/sdhci-acpi.c                      |  20 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   3 +-
 drivers/mmc/host/sdhci-msm.c                       | 147 +++++++--
 drivers/mmc/host/tmio_mmc_core.c                   |   1 -
 include/linux/mmc/core.h                           |   4 +-
 include/linux/mmc/host.h                           |   8 +
 30 files changed, 750 insertions(+), 523 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-slot.yaml
