Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1119004B
	for <linux-mmc@vger.kernel.org>; Tue, 25 Mar 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897759; cv=none; b=J3zwqACy9RNN3mwmoPm8FsQnZkcguX9QwYSmV72QEhzXGCoaFpXL9pPWF7G/xD7JJpjFTbjpNM/WJNejhaF7QUidwGjO+OuHeWjqjPeo0YN8hu/uOZTsp0ItqRLK+uUYa9b5X8M489fMS1WLG8DZCKE8gEYJOsy3Kq9KyiAhVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897759; c=relaxed/simple;
	bh=kq3z/F+bkdyrEEPxLj4aaSVutwseYeIy5wfytTS54JM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sz98kmRX4O6NF7xP6XoMYL4dR6Oun+Pj3WVTf0M+09Kdh6tkJR1PfK+APvK6o15qkYSid96Cq068l622DbjjFFaDvr9LYD22sGeAswalOGOIyhKx60yKVZClGb28+N5YIqz0GkauR160F+jVfOy6Yss3e0NjRWyc2Md8GB6gwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RY4b7Rdb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY4b7Rdb"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30db2c2c609so4044721fa.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Mar 2025 03:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742897753; x=1743502553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUX8G/ipswWdxea2g5yuXYGySDqu/Dr7lyepw+RoYJc=;
        b=RY4b7RdbZBgZdMFPyRwUCqyXTtEeVadQnmXCPRBMq7C0+f6RYTGjvkE1nt1x/xtaNr
         NFfLe0v2r6TBPI7WsaCofNSwZ8zc15PIz+pkQCNqPXdBM9G1TEAWhfPeAhuJAsXrz2A+
         VThanqzu+c3WJy8N+CWJMjK/mfhP6fnbZNIeJcN+bCgSyDPR1ZXalflozN8woji/FmDR
         Pq+6MrWgBflrGArCVQ7ZgDzHnnBI5qqZQqeYEwlQbCUQLBTSV+vV1OoZlsP/BJ+Zv/KL
         J7qVV4B80ocBbuj0UOEUlUpU/X0T+FJrKItGGoiKT48eeeEtW9LC1lknsFF0jmHsgw17
         ulKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742897753; x=1743502553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUX8G/ipswWdxea2g5yuXYGySDqu/Dr7lyepw+RoYJc=;
        b=COD0p4tRLiLJ2DtDbSIDClYvWqK5GB72sL8PfcVGbMW13HM9EiF2KKNHr7L6ruYzdh
         cswWXutkNQuJSNNGU/29jLiKoxfWppVulTszXPv7bIBV4UlJEvMvEZyL5+tm8pexTJ7g
         X9KbiUW6Hyj3vRPPMLdmFcc/RhKF2nAUrkuW0tzxFPEr+Xm31k6JBFYf8dXDkzQcVroo
         78yR4y9+HVFwt+vdIdgSQMg0QDmO1KUnobYgEmfufI99i3N22+knc5ZJdQ5VND2sA4i/
         PmVU2mdxhDZ2EYX7xyZv77vIWLxoZ5YIlcR+765xz2QEKk0EI9txru851KM6bZHPVJyF
         STWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+PNfbg7UxSg1hbHMJ4Jxc3tRXCp4tZFsqAD4eAZD7y5aXihlSGoGHZZQPDWrDNFhZ3f7bb6PB6kU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7fJd8b6qKfTJPMQZ6PcDpFZvYIp77Mb68HyDnfyMAmFUs2ag+
	DdbmCGuMdMcb0aO5R2eZne/TTQngEQC9QVpi2+niN2E9xGRybYZZ3fR4G3IfDD0=
X-Gm-Gg: ASbGncuH/44u3FSEV2nKrqRZz01nQDPTR5lQiZ448PVlW3GIgXsvteWn/Tu+wR8V3vD
	e/tlxhtOwJGeEiSYMeN4wjOUNiG9HTusqQ51VAfPG3nlwGcTx763DoZkBbWbF2KtVVYEuXtPL/a
	Jg9vUd3Bu+oMotsx8ZsTl7TK6nAWKR9IE5E0sT1r1S14bEX9E50X3hGJ3vtkdy5WeHXITlj+L9G
	Ag0Co3CDvNqIwiBUfoz39O62ZmJJdP+08bPRX1oHYYp+BMCrPmK8f8ki8hkJiLotIy2HwYVHmv3
	8LbUz4uwpA0qLycxsQssaQ2ZG8V42WE9W8I1yUKNjz6Gz3UrgY7pZECA1KEK6uy/egEf6GgH+fV
	F04t7TQ3m6cB5ujYHcdI=
X-Google-Smtp-Source: AGHT+IHnO39V4+b6f1jfx33CjnYElfBanHZKx/akSem4UqrpMiaVwGrwOnGjhZ0e5y3d7myuygRTsQ==
X-Received: by 2002:a05:651c:1546:b0:30b:b7c3:ea71 with SMTP id 38308e7fff4ca-30d7e222a65mr64186041fa.15.1742897753356;
        Tue, 25 Mar 2025 03:15:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d910e86sm17475501fa.102.2025.03.25.03.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:15:52 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.15
Date: Tue, 25 Mar 2025 11:15:51 +0100
Message-ID: <20250325101551.26387-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with updates for MMC and MEMSTICK for v6.15. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 723ef0e20dbb2aa1b5406d2bb75374fc48187daa:

  mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops (2025-03-17 11:42:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.15

for you to fetch changes up to c48e13e83513bd7eb4efffeeb562df9e4e1452d0:

  mmc: core: Remove redundant null check (2025-03-21 09:48:37 +0100)

----------------------------------------------------------------
MMC host:
 - atmel-mci: Convert DT bindings to json schema
 - dw_mmc: Add support for the Exynos7870 variant
 - dw_mmc-rockchip: Add support for the RK3562/3528 variants
 - omap: Fix potential memory leak in the probe error path
 - renesas_sdhi: Add support for RZ/G3E variants
 - sdhci: Disable SD card clock before changing parameters
 - sdhci-esdhc-imx: Add support for the i.MX94 variant
 - sdhci-of-dwcmshc: Add support for the RK3562/RK3528 variants
 - sdhci-omap: Disable aggressive PM for eMMC/SD-cards
 - sdhci-pci-core: Wait for VDD to settle on card power off
 - sdhci-pxav3: Fix busy-signalling by using MMC_CAP_NEED_RSP_BUSY
 - sunxi-mmc: Add support for the A523 variant

MEMSTICK:
 - rtsx_usb_ms: Fix potential use-after-free during remove

----------------------------------------------------------------
Andre Przywara (2):
      dt-bindings: mmc: sunxi: Simplify compatible string listing
      dt-bindings: mmc: sunxi: add compatible strings for Allwinner A523

Avri Altman (1):
      mmc: core: Remove redundant null check

Biju Das (2):
      dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
      mmc: renesas_sdhi: Add support for RZ/G3E SoC

Dan Carpenter (1):
      mmc: renesas_sdhi: fix error code in renesas_sdhi_probe()

Dharma Balasubiramani (2):
      dt-bindings: mmc: mmc-slot: Make compatible property optional
      dt-bindings: mmc: atmel,hsmci: Convert to json schema

Dr. David Alan Gilbert (1):
      mmc: slot-gpio: Remove unused mmc_gpio_set_cd_isr

Dragan Simic (1):
      mmc: core: Trim trailing whitespace from card product names

Erick Shepherd (2):
      mmc: sdhci: Disable SD card clock before changing parameters
      mmc: host: Wait for Vdd to settle on card power off

Frank Li (2):
      dt-bindings: mmc: Change to additionalProperties to fix fail detect Unevaluated property
      dt-bindings: mmc: fsl-imx-esdhc: Add i.MX94 support

Jaehoon Chung (1):
      mmc: sdhci-of-dwcmshc: Change to dwcmshc_phy_init for reusing codes

Jiri Slaby (SUSE) (1):
      tty: mmc: sdio: use bool for cts and remove parentheses

Jonas Karlman (1):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add compatible string for RK3528

Karel Balej (1):
      mmc: sdhci-pxav3: set NEED_RSP_BUSY capability

Kaustabh Chakraborty (3):
      dt-bindings: mmc: samsung,exynos-dw-mshc: add exynos7870 support
      mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves
      mmc: dw_mmc: add exynos7870 DW MMC support

Kever Yang (2):
      dt-bindings: mmc: Add support for rk3562 eMMC
      dt-bindings: mmc: rockchip-dw-mshc: Add support for rk3562

Luo Qiu (1):
      memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove

Miaoqian Lin (1):
      mmc: omap: Fix memory leak in mmc_omap_new_slot

Ulf Hansson (3):
      mmc: Merge branch fixes into next
      mmc: sdhci-omap: Disable MMC_CAP_AGGRESSIVE_PM for eMMC/SD
      mmc: Merge branch fixes into next

Yao Zi (1):
      dt-bindings: mmc: rockchip-dw-mshc: Add compatible string for RK3528

 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |  38 +++---
 .../bindings/mmc/amlogic,meson-mx-sdio.yaml        |   3 +
 .../devicetree/bindings/mmc/atmel,hsmci.yaml       | 106 +++++++++++++++++
 .../devicetree/bindings/mmc/atmel-hsmci.txt        |  73 ------------
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |   1 +
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   2 +-
 .../devicetree/bindings/mmc/mmc-slot.yaml          |   1 -
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |  16 +++
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   2 +
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |   2 +
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   5 +-
 drivers/memstick/host/rtsx_usb_ms.c                |   1 +
 drivers/mmc/core/core.c                            |   2 +-
 drivers/mmc/core/mmc.c                             |   6 +-
 drivers/mmc/core/sd.c                              |   4 +
 drivers/mmc/core/sdio_uart.c                       |   2 +-
 drivers/mmc/core/slot-gpio.c                       |  12 --
 drivers/mmc/host/dw_mmc-exynos.c                   |  41 ++++++-
 drivers/mmc/host/dw_mmc.c                          |  94 ++++++++++++++-
 drivers/mmc/host/dw_mmc.h                          |  27 +++++
 drivers/mmc/host/omap.c                            |  19 ++-
 drivers/mmc/host/renesas_sdhi.h                    |   1 +
 drivers/mmc/host/renesas_sdhi_core.c               | 131 +++++++++++++++++++++
 drivers/mmc/host/sdhci-of-dwcmshc.c                |  72 +++--------
 drivers/mmc/host/sdhci-omap.c                      |   4 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   6 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   1 +
 drivers/mmc/host/sdhci.c                           |   9 +-
 drivers/mmc/host/tmio_mmc.h                        |  10 ++
 include/linux/mmc/slot-gpio.h                      |   1 -
 30 files changed, 508 insertions(+), 184 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
