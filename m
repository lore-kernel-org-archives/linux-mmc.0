Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F632157E61
	for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726498438; cv=none; b=CjzvUTIsaUsZrfkWbQnZmoRbLfkryhHnMbMF0o3ggKW0J566KehUEQWp1/X22HoJ5XwPw8nviYbbvMMkUzumEYosbAXAN615TOpjQVL0E0A5sMqkqy5axGwcck2jIOFlGYhNSggyWE8AvCn5sQJg7/7DFUmhRV5wAEoQwo/u83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726498438; c=relaxed/simple;
	bh=Mjmos+lFXDQrHLZGm3QtPep32MMtVA3+jp+sLiL6FV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b03EY0njLSr0UFldxntmje2vLKka2iGUB7JFx5/99rTgIFQP9spBqvORddMS+cvMgU75wNiu4/u5CWu4+X/9PltnowLjivxJAnhxsBJwr9OQDuq+qxY7ted/cPkbhIA4rXTdHa6kPYqOL9gCkwBUwETBjsYl0391BujLF/4sdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvMcrIpm; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvMcrIpm"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365b6bd901so5075192e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2024 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726498434; x=1727103234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hYQsqWRG/KA6HCUSesfPALyKBlmIx+m+eouyHIxt56E=;
        b=PvMcrIpmoQpF7GhJVWx/9ze0RTgNVvhIuObVpAnFJQmHPPUtUX3JB8faXpQJvmmM+d
         F6/smaXp20Snv3I1KC0mGzDtWSRsN94j3GwKyVBXh2/ME93z6q9qyo0WHAKC2FtfQjkJ
         NSt4rK7L++aFj1Cr7bwUgBq7vcDyKZQ0imeDXgA0DZg3lOpPWBFFpf2eft0Vb514gOn5
         9WE67QwEts4bnL6/qxJkltV+jdmnG8kzgKEA+SXpIdjFfP2By+ffi2F22dcdxpQchN54
         Zc57DAtX3FgAyUCSeEQebV2hCZR4V8SNwCPCBINK7wG8nZbxK33P9FzFmh3iYzpcaRXf
         UBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726498434; x=1727103234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYQsqWRG/KA6HCUSesfPALyKBlmIx+m+eouyHIxt56E=;
        b=tXUSVFvXq4fc/KcK3M6JUHBFT5pDm6OOxlob3lOdRza8d3tlhaGr+2JLvIQ4UKMky3
         ANU3NyYFEfh3D7K9GeO5s7MISPIWDX2//uHmzMGfl0IcB51V7d2SMCdd0RAo56gLKEEa
         Ov1w+8lXvkVd7yQFtY28NXfuyBXStzSOHzhFMp06fkG6YuKikzBpMMMxtM268Gzx3YZ5
         /Ag0sQDOCx9/NtRMGMoh4kI3oGR9lFGhsKzMKnAmUWBWrTL99krLQBULbYKxPCfnEoK3
         QMd6O0ycEg/LsWkex5FIaPAOryvZZpTPJDuWYTAFgmYPzwuLSs4z9CrK9MTUHWzhMUjD
         Yrpg==
X-Forwarded-Encrypted: i=1; AJvYcCWathxEZK3GDNEoUaS/1N/f5Me2cfgPr5vKT5ZbNcPBEP5od37b/itx43gcC1yZ40jK9hoQAmkut/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8wMmBdDDPTILdf4QSxJHE6PwmzZqpvl/JWruyZDjUBFfbBeB
	RP6BazbePS388Yemz0CMncThts/xwXhIqC0HgbwcXI6OkynuFWWjZZBSXttaKuZukGRAuOpUkDo
	y
X-Google-Smtp-Source: AGHT+IG+u7aKNdd/Yo34zgdyrEIYgD/ChDvyvccnDp+AHTvIcGB+POpqFRdpI5r8Jx5MDpavLi9QfQ==
X-Received: by 2002:a05:6512:1052:b0:533:508f:edf1 with SMTP id 2adb3069b0e04-53678ff4e66mr6943853e87.60.1726498434345;
        Mon, 16 Sep 2024 07:53:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704688bsm902054e87.57.2024.09.16.07.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 07:53:53 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v6.12
Date: Mon, 16 Sep 2024 16:53:52 +0200
Message-Id: <20240916145352.388340-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request for MMC v6.12.

Please note, this pull-request also introduces a new subsystem for so called
Replay Protected Memory Block (RPMB) in drivers/misc/. The first provider
that implements RPMB support is the MMC subsystem for eMMC cards, while the
consumer is the tee/optee subsystem.

More details are available in the commit message that introduces the RPMB
subsystem along with the usual highlights for MMC in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson

The following changes since commit aea62c744a9ae2a8247c54ec42138405216414da:

  mmc: cqhci: Fix checking of CQHCI_HALT state (2024-09-03 14:20:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12

for you to fetch changes up to cd3689b6772fbc1a4513934a5204fd2fa5b4426b:

  mmc: core: Use dev_err_probe for deferred regulators (2024-09-13 14:09:29 +0200)

----------------------------------------------------------------
MMC core:
 - Add documentation for the mmc-test driver
 - Register the eMMC RPMB partition with the RPMB subsystem
 - Some various cleanups

MMC host:
 - dw_mmc-rockchip: Add support for the RK3576 variant
 - renesas_sdhi: Add support for the RZ/V2H(P) variant
 - sdhci_am654: Add a retry mechanism for tuning
 - sdhci-atmel: Convert DT bindings to json schema
 - sdhci-of-dwcmshc: Add eMMC HW reset support for BlueField-3 SoC
 - sdhci-of-dwcmshc: Add support for the RK3576 variant
 - sdhci-of-dwcmshc: Add support for the Sophgo SG2042 variant
 - sdhci-of-ma35d1: Add new driver for the Nuvoton MA35D1 SDHCI

Misc/Tee:
 - Add Replay Protected Memory Block (RPMB) subsystem
 - Let optee probe RPMB device using RPMB subsystem

----------------------------------------------------------------
Alexander Stein (1):
      mmc: core: Use dev_err_probe for deferred regulators

Avri Altman (2):
      mmc: core Convert UNSTUFF_BITS macro to inline function
      Documentation: mmc: Add mmc-test doc

Chanwoo Lee (1):
      mmc: core: Replace the argument of mmc_sd_switch() with defines

Chen Wang (7):
      mmc: sdhci-of-dwcmshc: add common bulk optional clocks support
      mmc: sdhci-of-dwcmshc: move two rk35xx functions
      mmc: sdhci-of-dwcmshc: factor out code for th1520_init()
      mmc: sdhci-of-dwcmshc: factor out code into dwcmshc_rk35xx_init
      mmc: sdhci-of-dwcmshc: add dwcmshc_pltfm_data
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
      mmc: sdhci-of-dwcmshc: Add support for Sophgo SG2042

Christophe JAILLET (1):
      mmc: core: Remove struct mmc_context_info

Dan Carpenter (1):
      optee: Fix a NULL vs IS_ERR() check

Detlev Casanova (3):
      dt-bindings: mmc: Add support for rk3576 dw-mshc
      mmc: dw_mmc-rockchip: Add support for rk3576 SoCs
      dt-bindings: mmc: Add support for rk3576 eMMC

Dharma Balasubiramani (1):
      dt-bindings: mmc: sdhci-atmel: Convert to json schema

Doug Brown (1):
      mmc: sdhci-pxav2: Remove unnecessary null pointer check

Jens Wiklander (7):
      rpmb: add Replay Protected Memory Block (RPMB) subsystem
      mmc: block: register RPMB partition with the RPMB subsystem
      tee: add tee_device_set_dev_groups()
      optee: probe RPMB device using RPMB subsystem
      mmc: block: add RPMB dependency
      optee: add RPMB dependency
      rpmb: fix error path in rpmb_dev_register()

Judith Mendez (2):
      mmc: sdhci_am654: Add retry tuning
      mmc: sdhci_am654: Add prints to tuning algorithm

Krzysztof Kozlowski (1):
      dt-bindings: mmc: renesas,sdhi: add top-level constraints

Lad Prabhakar (4):
      dt-bindings: mmc: renesas,sdhi: Document RZ/V2H(P) support
      mmc: tmio: Use MMC core APIs to control the vqmmc regulator
      mmc: renesas_sdhi: Add RZ/V2H(P) compatible string
      dt-bindings: mmc: renesas,sdhi: Remove duplicate compatible and add clock checks

Liming Sun (1):
      mmc: sdhci-of-dwcmshc: Add hw_reset() support for BlueField-3 SoC

Riyan Dhiman (2):
      mmc: core: Calculate size from pointer
      mmc: core: Convert simple_stroul to kstroul

Seunghwan Baek (1):
      mmc: cqhci: Make use of cqhci_halted() routine

Shan-Chun Hung (2):
      dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI controller
      mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver

Shawn Lin (1):
      mmc: dw_mmc-rockchip: Add internal phase support

Thorsten Blum (1):
      mmc: mtk-sd: Improve data type in msdc_timeout_cal()

Ulf Hansson (3):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Vladimir Zapolskiy (1):
      mmc: core: remove left-over data structure declarations

 Documentation/ABI/testing/sysfs-class-tee          |  15 +
 .../bindings/mmc/atmel,sama5d2-sdhci.yaml          |  92 ++++
 .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml         |  87 ++++
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |  13 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   2 +
 .../devicetree/bindings/mmc/sdhci-atmel.txt        |  35 --
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |  95 ++--
 Documentation/driver-api/mmc/index.rst             |   1 +
 Documentation/driver-api/mmc/mmc-test.rst          | 299 +++++++++++++
 MAINTAINERS                                        |   8 +
 drivers/misc/Kconfig                               |  10 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/rpmb-core.c                           | 231 ++++++++++
 drivers/mmc/core/Kconfig                           |   1 +
 drivers/mmc/core/block.c                           | 250 ++++++++++-
 drivers/mmc/core/mmc.c                             | 106 ++---
 drivers/mmc/core/mmc_ops.h                         |  14 +
 drivers/mmc/core/regulator.c                       |   8 +-
 drivers/mmc/core/sd.c                              | 133 +++---
 drivers/mmc/core/sd_ops.c                          |   3 +-
 drivers/mmc/host/Kconfig                           |  12 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/cqhci-core.c                      |  14 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 | 217 +++++++++-
 drivers/mmc/host/mtk-sd.c                          |  11 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 478 ++++++++++++++-------
 drivers/mmc/host/sdhci-of-ma35d1.c                 | 314 ++++++++++++++
 drivers/mmc/host/sdhci-pxav2.c                     |   2 +-
 drivers/mmc/host/sdhci_am654.c                     |  54 ++-
 drivers/mmc/host/tmio_mmc_core.c                   |   7 +-
 drivers/tee/optee/Kconfig                          |   1 +
 drivers/tee/optee/core.c                           |  96 ++++-
 drivers/tee/optee/device.c                         |   7 +
 drivers/tee/optee/ffa_abi.c                        |  14 +
 drivers/tee/optee/optee_ffa.h                      |   2 +
 drivers/tee/optee/optee_private.h                  |  26 +-
 drivers/tee/optee/optee_rpc_cmd.h                  |  35 ++
 drivers/tee/optee/optee_smc.h                      |   2 +
 drivers/tee/optee/rpc.c                            | 177 ++++++++
 drivers/tee/optee/smc_abi.c                        |  14 +
 drivers/tee/tee_core.c                             |  19 +-
 include/linux/mmc/core.h                           |  12 -
 include/linux/mmc/host.h                           |  27 +-
 include/linux/rpmb.h                               | 123 ++++++
 include/linux/tee_core.h                           |  12 +
 46 files changed, 2633 insertions(+), 449 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tee
 create mode 100644 Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
 create mode 100644 Documentation/driver-api/mmc/mmc-test.rst
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
 create mode 100644 include/linux/rpmb.h
