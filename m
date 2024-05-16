Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2A14D2B8
	for <linux-mmc@vger.kernel.org>; Thu, 16 May 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872817; cv=none; b=IJfUWa4eWRGsbjnhjBJY2xrVa+Vc5g65EUH8STeIuxupOS+N8HuyqISxFKrTTe92lxz4CwojmuwGSoG3cCMFsgeJ6MzvLrP5kS00i6a37cz9MxcSa4fRQDi7FlNVKYqfvHtswE6v9nX7CbOOFZXtW9480d7P8h2bFdowTzy2tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872817; c=relaxed/simple;
	bh=ViIbbucNYqTJFJTgNuD1P1jdn5qFqKL2oR9BnOPDp2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I7kvuunyOvcd4OEBb13ITv8IZTmgrV6T/racK0pATyc4b/SLJEyNgDjXNl9NRXZC+fXgwe/s1p7okir36k4Pz9lEDbBDYts54Tcyk54I+zi+x0ZhfwoI/Kmtb8Cy4gy0bT475+wYtYI7/zc02iA/pabvCKuWbkLjiJRZTk8TwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9XskHOq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9XskHOq"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5727dc6d3edso3726301a12.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 May 2024 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715872814; x=1716477614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yceyVNE4oy37H9VVToLAQUBY2IzkisD+0516yGQ8vc=;
        b=a9XskHOqNB1MZhnwkIpK0QbUc7dE6yrWiXl8WJ86bboXfzzKFcnjXGJfV59SZxgWJW
         n9k65wjvTDSb72U/NM+f1JXUYrzxKvV4NUt7DGuMcZL0lZd1WRoeUp2yfd8vMka41S30
         BdlRToo3y2toCIR05ge8eCe0T2BV30LiBQd/sIlLUP79Xubii89fPVcLtJratNzbNZS0
         xsqmGnnf7q2n9gQDOzQUm7TlHdw7BMPztqeYujBLAuRFYw4StBku3Pc/8m3eWb46mQwi
         ijBwTt91jVgl5S9YMy5YOa3DeELPSWv7Icu+FnjIBaE0ApbW1kgZQRPm8jXLpcQThBru
         2O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872814; x=1716477614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yceyVNE4oy37H9VVToLAQUBY2IzkisD+0516yGQ8vc=;
        b=Y9qhzGw/SYtN1NoUxKswQYntjnTKxfrSBHPmVOwJqvufyFRMPZk/yQhJ29d7RaDO8Z
         hnP4wx0uhygGLDx7T+xsF43GZF5J8GTX9BayHBJmd7jH+IG9ye9opRji6A80g2DUM+2w
         XeV6Ayhj0whBdkMufc04QWh9CQY6pWLP+X7LSlqBoBuivtuX3ou1NjCntFAgBuQdVLg6
         zq1XuoNxGJ9q8g8LkprL+uRrfJB+rEnlBpqEvhz8tYTZle6o50LWWvz+bcFaa7yEVpSP
         GY5bEoXOe+Jp8zYWPcScoRo8xFe2KXAZGWPfkvyEoNByhR/NVgwv3FvllBc/UszUJjGH
         EVqg==
X-Forwarded-Encrypted: i=1; AJvYcCXkQzaUp4UCxAWXCCCWnNkbBYox9ktnGx8c4Z7/Yk3kw2fFVf/2KreiP9DTpaZ/8x7lU1mUf9EbPcasRDvoqwkLbtSkpP7PSjZ9
X-Gm-Message-State: AOJu0YwVzISlFfxcxqIhIPRD7OZkFx2GzC17JqujgfPWwPrJOrl8gCnr
	15szDzGnjRwNrLeBbob5MvkJfklaBTGo5tNFLN/GnhtHB49clmQ5zOj2KXPLC/Q=
X-Google-Smtp-Source: AGHT+IFQzCLtumyQHqtxZKAIA7z5pVSX8Mvgd3C/OaL16FwLja4nneI7I0mhgOjmmZdZr+XJTDwIjA==
X-Received: by 2002:a17:907:31c3:b0:a5a:88a9:3ef5 with SMTP id a640c23a62f3a-a5a88a94025mr664171466b.39.1715872813921;
        Thu, 16 May 2024 08:20:13 -0700 (PDT)
Received: from uffe-tuxpro14.. ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5ce877ece2sm85849666b.13.2024.05.16.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:20:13 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.10
Date: Thu, 16 May 2024 17:20:12 +0200
Message-Id: <20240516152012.30550-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request for MMC and MEMSTICK for v6.10. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e027e72ecc1683e04f33aedf0196ad6c3278d309:

  mmc: moxart: fix handling of sgm->consumed, otherwise WARN_ON triggers (2024-04-25 17:48:46 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10

for you to fetch changes up to 35eea0defb6e46b26e286066e0e77ac5d53e7fba:

  mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S, and RZ/V2M SoCs (2024-05-03 14:33:05 +0200)

----------------------------------------------------------------
MMC core:
 - Increase the timeout period of the ACMD41 command
 - Add card entry for quirks to debugfs
 - Add mmc_gpiod_set_cd_config() function
 - Store owner from SDIO modules with sdio_register_driver()

MMC host:
 - atmel-mci: Some cleanups and a switch to use dev_err_probe()
 - renesas_sdhi: Add support for RZ/G2L, RZ/G3S and RZ/V2M variants
 - renesas_sdhi: Set the SDBUF after reset
 - sdhci: Add support for "Tuning Error" interrupts
 - sdhci-acpi: Add quirk to enable pull-up on the card-detect GPIO on Asus T100TA
 - sdhci-acpi: Disable write protect detection on Toshiba WT10-A
 - sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not working
 - sdhci_am654: Re-work and fix the tuning support for multiple speed-modes
 - sdhci_am654: Add tuning algorithm for delay chain
 - sdhci-esdhc-imx: Add NXP S32G3 support
 - sdhci-of-dwcmshc: Add tuning support for Sophgo CV1800B and SG200X
 - sdhci-of-dwcmshc: Implement SDHCI CQE support
 - sdhci-pci-gli: Use the proper pci_set_power_state() instead of PMCSR writes

MEMSTICK:
 - Convert a couple of drivers to use the ->remove_new() callback

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Add support for "Tuning Error" interrupts

Andy Shevchenko (10):
      mmc: core: Remove unused of_gpio.h
      mmc: mtk-sd: Remove unused of_gpio.h
      mmc: sdhci-s3c: Replace deprecated of_get_named_gpio()
      mmc: sdhci-sprd: Remove unused of_gpio.h
      mmc: slot-gpio: Use irq_handler_t type
      mmc: atmel-mci: Get rid of platform data leftovers
      mmc: atmel-mci: Use temporary variable for struct device
      mmc: atmel-mci: Replace platform device pointer by generic one
      mmc: atmel-mci: Incapsulate used to be a platform data into host structure
      mmc: atmel-mci: Switch to use dev_err_probe()

Angelo Dureghello (1):
      MAINTAINERS: update Angelo Dureghello e-mail address

Bjorn Helgaas (2):
      mmc: sdhci-pci-gli: Use PCI AER definitions, not hard-coded values
      mmc: sdhci-pci-gli: Use pci_set_power_state(), not direct PMCSR writes

Claudiu Beznea (1):
      mmc: renesas_sdhi: Set the SDBUF after reset

Felix Qin (1):
      mmc: core: Increase the timeout period of the ACMD41 command

Hans de Goede (5):
      mmc: core: Add mmc_gpiod_set_cd_config() function
      mmc: sdhci-acpi: Sort DMI quirks alphabetically
      mmc: sdhci-acpi: Fix Lenovo Yoga Tablet 2 Pro 1380 sdcard slot not working
      mmc: sdhci-acpi: Disable write protect detection on Toshiba WT10-A
      mmc: sdhci-acpi: Add quirk to enable pull-up on the card-detect GPIO on Asus T100TA

Jisheng Zhang (2):
      mmc: sdhci-of-dwcmshc: Remove useless "&" of th1520_execute_tuning
      mmc: sdhci-of-dwcmshc: Add tuning support for Sophgo CV1800B and SG200X

Judith Mendez (7):
      mmc: sdhci_am654: Add tuning algorithm for delay chain
      mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
      mmc: sdhci_am654: Add OTAP/ITAP delay enable
      mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
      mmc: sdhci_am654: Fix ITAPDLY for HS400 timing
      mmc: sdhci_am654: Fix itapdly/otapdly array type
      mmc: sdhci_am654: Update comments in sdhci_am654_set_clock

Krzysztof Kozlowski (13):
      mmc: sdio: store owner from modules with sdio_register_driver()
      Bluetooth: btmrvl_sdio: drop driver owner initialization
      Bluetooth: btmtksdio: drop driver owner initialization
      wifi: ath10k: sdio: simplify module initialization
      wifi: ath10k: sdio: drop driver owner initialization
      wifi: brcm80211: drop driver owner initialization
      wifi: mwifiex: drop driver owner initialization
      wifi: wfx: drop driver owner initialization
      mmc: sdhci-esdhc-mcf: Constify struct sdhci_ops
      mmc: sdhci-omap: Constify struct sdhci_ops
      mmc: sdhci-sprd: Constify struct sdhci_ops
      mmc: sdhci_am654: Constify struct sdhci_ops
      mmc: sdhci-s3c: Choose sdhci_ops based on variant

Lad Prabhakar (3):
      dt-bindings: mmc: renesas,sdhi: Group single const value items into an enum list
      dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
      mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S, and RZ/V2M SoCs

Li Zhijian (1):
      mmc: core: Convert sprintf/snprintf to sysfs_emit

Muhammad Usama Anjum (2):
      mmc: dw_mmc-hi3798mv200: Remove unneeded assignment
      mmc: dw_mmc-hi3798cv200: Remove unneeded assignment

Rouven Czerwinski (2):
      mmc: debugfs: convert permissions to octal
      mmc: debugfs: add card entry for quirks

Sergey Khimich (2):
      mmc: cqhci: Add cqhci set_tran_desc() callback
      mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support

Ulf Hansson (4):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: core: Convert to use __mmc_poll_for_busy() SD_APP_OP_COND too

Uwe Kleine-König (4):
      mmc: davinci: Don't strip remove function when driver is builtin
      memstick: rtsx_pci_ms: Drop if block with always false condition
      memstick: rtsx_pci_ms: Convert to platform remove callback returning void
      memstick: rtsx_usb_ms: Convert to platform remove callback returning void

Wadim Mueller (1):
      dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3 support

 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   3 +
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |  39 ++-
 MAINTAINERS                                        |   2 +-
 drivers/bluetooth/btmrvl_sdio.c                    |   1 -
 drivers/bluetooth/btmtksdio.c                      |   1 -
 drivers/memstick/host/rtsx_pci_ms.c                |   9 +-
 drivers/memstick/host/rtsx_usb_ms.c                |   6 +-
 drivers/mmc/core/block.c                           |   8 +-
 drivers/mmc/core/debugfs.c                         |   7 +-
 drivers/mmc/core/host.c                            |   1 -
 drivers/mmc/core/sd_ops.c                          |  83 ++++--
 drivers/mmc/core/sdio_bus.c                        |   9 +-
 drivers/mmc/core/slot-gpio.c                       |  25 +-
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/atmel-mci.c                       | 309 +++++++++------------
 drivers/mmc/host/cqhci-core.c                      |  11 +-
 drivers/mmc/host/cqhci.h                           |   4 +
 drivers/mmc/host/davinci_mmc.c                     |   4 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 -
 drivers/mmc/host/dw_mmc-hi3798mv200.c              |   1 -
 drivers/mmc/host/mtk-sd.c                          |   1 -
 drivers/mmc/host/renesas_sdhi_core.c               |   3 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   9 +-
 drivers/mmc/host/sdhci-acpi.c                      |  61 +++-
 drivers/mmc/host/sdhci-esdhc-mcf.c                 |   2 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 305 +++++++++++++++++++-
 drivers/mmc/host/sdhci-omap.c                      |   2 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |  46 ++-
 drivers/mmc/host/sdhci-s3c.c                       |  35 +--
 drivers/mmc/host/sdhci-sprd.c                      |   3 +-
 drivers/mmc/host/sdhci.c                           |  10 +-
 drivers/mmc/host/sdhci.h                           |   3 +-
 drivers/mmc/host/sdhci_am654.c                     | 182 +++++++++---
 drivers/net/wireless/ath/ath10k/sdio.c             |  21 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |   1 -
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   1 -
 drivers/net/wireless/silabs/wfx/bus_sdio.c         |   1 -
 include/linux/mmc/sdio_func.h                      |   5 +-
 include/linux/mmc/slot-gpio.h                      |   6 +-
 39 files changed, 826 insertions(+), 396 deletions(-)
