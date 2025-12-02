Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEFE26ED3C
	for <linux-mmc@vger.kernel.org>; Tue,  2 Dec 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669376; cv=none; b=aGRKPBxVVNFsSGjzWsFbLkaTeXVrHNayhBMJ4X/+UO6LHo8lE1472au164JTAwyrI/8yEEcFJ0p6pUI0dc0FqGDoHl6Xn+QlykO83vLaiW8hESm5HOFTGPPyVYaY8hCgqVanXpJmXGM1bfuvi87EXl282XhCVYoCc/llqixT0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669376; c=relaxed/simple;
	bh=XIQQgbzkvL9fDWPQSc10hErsc9a3EvYuLmuQ6jc+Xw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVGG9/KMJxG8eocMUeoebBDeaUKbqB4uz7nhgvmlG/fzHui/5YXTdYgqRMHEDFikAMtjbJFEVquKSQ7D5A+lDac0UZnTYd2xigRv4szk/akwt9L7hre8wYi5n0vKPwnnlGhlumv9p5rtStFub9tXL608AX8MSh0YGQzD74on7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PZxBZN1v; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZxBZN1v"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37902f130e1so49873331fa.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Dec 2025 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764669372; x=1765274172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndtZYPk4dLQlRNBoYmHgWhE0vm9K/fuuEprX4FUocoU=;
        b=PZxBZN1vapZ3kagbDiSxp1hTLfto6qhQm9we940Ao7BTrcN1iYZF+2uQ2l2VM95O3p
         cisRzd6e4gPDTx9R8UhuXg7FID3ZOvybat21bR1iDDTe8Dbn5i/I45wCb3+J+qVpADZA
         KaPdKbLhrVbH6OzBS8T0RgdP7XRGjqdrRYbKOqe5o85DLLd4lqo0gx//YIgF+KwmQsLL
         ieiJ+vdWpxhZpFdpQ7XcQ56BtezbT0MU+it22iTI93ldZQPfg1ws8s4GuNfcQHHbwlxf
         rNvmTFXRYZkqoWXKDdG92gjVO0CxqIcmdFznGVXdOySHyL1RvfeTKX6mbz4/B0H1tiWy
         6aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764669372; x=1765274172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndtZYPk4dLQlRNBoYmHgWhE0vm9K/fuuEprX4FUocoU=;
        b=rPykCyrlUZeKoJCGxQSEZXQrOgtHSxcdFuSqkQ6ZkVg5col3/HAUao6vnLaeIeAIEd
         se2BOb/cYv/4wNRxZnI79Lw+7SLSEZq+NWjvHeQq2kcZ8bZbxef7KlWiBhA4RIxQO9ef
         oFY86tXn81v71ciwu7Cl0hBAcLOBLEF2W2zlO2p/5d/42i/Nw9WZYTy2v/GLw8R3JRwJ
         EtXRtA0QVuZHDrPt47qrIhP8VHDgJN3CQ3xRz/buk5TAYzmXFJfqCfqMkRXxdBWaHeNY
         sKEGVPNILw4Q1QpQRiH8YDV2ysbuKP76AWGPlcoT8ig64yS62JwpKa74XAKXS0QnYZSm
         YcMw==
X-Forwarded-Encrypted: i=1; AJvYcCUUVdbc+dcJDJCjEQcQ+Yn3K9HOWnkz632ZuFjh27xRcvMdaIK1dGx+FZKD83cuw7UZ8vvQJdmhmus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlRSlRvUO5fxNRg2G4n7fFPLv9XUyFKd58Byc/MwnRTHt0xkvL
	14xnwhgCXrKFNP/k1MEoMrFgEG41O6493UvL8i8VodQyJAQMErN+YYuBEFjgg4sZqvlOU0oU0N4
	kfZCB
X-Gm-Gg: ASbGncsQqnVbc6nhL25Ltkkw4sdbNO6SUh8tjrpi3v5kK03ybtzVZJaYt1OPhzIMiG4
	Ot8mCqAAqKQLTVOIRz067fsAyYnVWJx3msdIRpcDE6vEpfB8SKlOkPQjfzmLUqRL1g5SzP757Vw
	+nEaesEK5b0nt9ZCmaJTHVyc2DQ/FpIbr1nDCkzPtxKFh5/5u5i71b/2P9YtH0E7u7+P3ZFan4r
	VStB2sIcu7dDUBVh7EQIB0feZtkWIpuN7uPxRGg/jM6hp4LmGmtMuhkVnl1GNKP/vZIlWCi2UX7
	fTXJ12hBSePk6nTUAfSd5lznF9P3tzoeun1okt7+eKp00tWCrpkjFmS0eEC06HXuHlwBPJDuL73
	uAYSuSdBP5lOxTkLgOnJS/hh+RD6hfEHut28GHre0FV6DOiAPnC6Bwino/k1cWMUZfrGRTkyIkj
	FodR9e9HvXGuyjkLsZpyB66ssKPggne/BSLmX4XEex9g8YiAnMIfjtggUNsqss
X-Google-Smtp-Source: AGHT+IEMfuQp/+kUZnZU4B3i+YoKBy9eXmSw4feB5D6k+sO7uOPQ4/LorpCROMnI98k46TnDluV/2g==
X-Received: by 2002:a05:651c:2156:b0:37b:9b58:dcfc with SMTP id 38308e7fff4ca-37cd92895d9mr100159331fa.40.1764669371470;
        Tue, 02 Dec 2025 01:56:11 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37d24128cf6sm36890931fa.48.2025.12.02.01.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 01:56:10 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v6.19
Date: Tue,  2 Dec 2025 10:56:09 +0100
Message-ID: <20251202095609.42463-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with updates for MMC for v6.19. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 747528729c9b6733839f9c95f300d5bef95ee52c:

  mmc: sdhci-of-dwcmshc: Promote the th1520 reset handling to ip level (2025-11-25 13:44:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.19

for you to fetch changes up to 79cf71c0b177c0e23d411e2469435e2c2f83f563:

  mmc: sdhci-of-dwcmshc: reduce CIT for better performance (2025-11-26 11:47:05 +0100)

----------------------------------------------------------------
MMC core:
 - Allow more host caps to be modified through debugfs
 - Skip to set the default 200mA SD current limit

MMC host:
 - Convert a few more DT bindings to the DT schema
 - dw_mmc: Add Shawn Lin as co-maintainer for the dw_mmc drivers
 - dw_mmc-rockchip: Add memory clock auto-gating support
 - dw_mmc-rockchip: Add support for the RK3506 variant
 - meson-mx-sdio: Ignore disabled "mmc-slot" child-nodes
 - meson-mx-sdio: Refactoring and general code improvements
 - renesas_sdhi: Enable bigger data ports where available
 - renesas_sdhi: Manage reset in probe and during system-wide suspend/resume
 - sdhci-brcmstb: Add support for the BCM72116 and BCM74371 variants
 - sdhci-brcmstb: Save/restore registers during system-wide suspend/resume
 - sdhci-msm: Add support for the sm8750 and the Kaanapali variants
 - sdhci-msm: Avoid early clock doubling during HS400 transition
 - sdhci-of-dwcmshc: Add command queue support for Rockchip SOCs
 - sdhci-of-dwcmshc: Add support for the Eswin EIC7700 variant

----------------------------------------------------------------
Avri Altman (1):
      mmc: core: Skip to set the default 200mA SD current limit

Binbin Zhou (1):
      mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper

Charan Pedumuru (2):
      dt-bindings: mmc: ti,da830-mmc: convert to DT schema
      dt-bindings: mmc: socionext,milbeaut-m10v-sdhci-3.0: convert to DT schema

Claudiu Beznea (3):
      mmc: renesas_sdhi: Deassert the reset signal on probe
      mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
      mmc: renesas_sdhi: Add suspend/resume hooks

Heiko Stuebner (1):
      dt-bindings: mmc: rockchip-dw-mshc: Add compatible string for RK3506

Huan He (2):
      dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC7700
      mmc: sdhci-of-dwcmshc: Add support for Eswin EIC7700

Kamal Dasu (5):
      dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host controller
      mmc: sdhci-brcmstb: move SDIO_CFG_CQ_CAPABILITY define
      mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
      mmc: sdhci-brcmstb: Add BCM74371 support
      mmc: sdhci-brcmstb: save and restore registers during PM

Krzysztof Kozlowski (1):
      dt-bindings: mmc: am654: Simplify dma-coherent property

Manish Pandey (1):
      dt-bindings: mmc: sdhci-msm: Add Kaanapali compatible

Marco Crivellari (3):
      mmc: mtk-sd: replace use of system_wq with system_percpu_wq
      mmc: omap: add WQ_PERCPU to alloc_workqueue users
      mmc: core: add WQ_PERCPU to alloc_workqueue users

Markus Elfring (1):
      mmc: sdhci-of-arasan: Omit a variable reassignment in sdhci_arasan_probe()

Martin Blumenstingl (6):
      mmc: meson-mx-sdio: Switch to regmap for register access
      mmc: meson-mx-sdio: Use devm_clk_get_enabled()
      mmc: meson-mx-sdio: Refactor internal clock initialization
      mmc: meson-mx-sdio: Use dev_err_probe() where appropriate
      mmc: meson-mx-sdio: Fix indentation in meson_mx_mmc_irq_thread()
      mmc: meson-mx-sdio: Ignore disabled "mmc-slot" child-nodes

Oliver Neukum (1):
      mmc: core: remove uselss memalloc_noio_save

Pedro Demarchi Gomes (1):
      mmc: use octal file permissions instead of symbolic

Sarthak Garg (2):
      dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
      mmc: sdhci-msm: Avoid early clock doubling during HS400 transition

Sebastian Reichel (2):
      mmc: sdhci-of-dwcmshc: Add command queue support for rockchip SOCs
      mmc: sdhci-of-dwcmshc: Fix command queue support for RK3576

Shawn Lin (5):
      mmc: dw_mmc: Use dma_set_mask_and_coherent() helper
      mmc: core: Allow more host caps to be modified through debugfs
      mmc: dw_mmc-rockchip: Add memory clock auto-gating support
      mmc: sdhci-of-dwcmshc: Disable internal clock auto gate for Rockchip SOCs
      mmc: sdhci-of-dwcmshc: reduce CIT for better performance

Ulf Hansson (5):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      MAINTAINERS: Add Shawn Lin as co-maintainer for dw_mmc drivers
      mmc: Merge branch fixes into next

Wolfram Sang (1):
      mmc: renesas_sdhi: enable bigger data ports where available

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml           |   2 +
 .../devicetree/bindings/mmc/davinci_mmc.txt        |  32 --
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   1 +
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |   3 +-
 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     |  30 -
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   2 +
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |  57 +-
 .../mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml     |  79 +++
 .../devicetree/bindings/mmc/ti,da830-mmc.yaml      |  61 +++
 MAINTAINERS                                        |   1 +
 drivers/mmc/core/block.c                           |  14 +-
 drivers/mmc/core/bus.h                             |   2 +-
 drivers/mmc/core/debugfs.c                         |  10 +-
 drivers/mmc/core/mmc.c                             |   4 +-
 drivers/mmc/core/mmc_test.c                        |   4 +-
 drivers/mmc/core/sd.c                              |   9 +-
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/atmel-mci.c                       |  10 +-
 drivers/mmc/host/cqhci.h                           |   1 +
 drivers/mmc/host/davinci_mmc.c                     |   6 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |   6 +
 drivers/mmc/host/dw_mmc.c                          |  15 +-
 drivers/mmc/host/meson-mx-sdio.c                   | 339 ++++++------
 drivers/mmc/host/mtk-sd.c                          |   4 +-
 drivers/mmc/host/omap.c                            |   6 +-
 drivers/mmc/host/omap_hsmmc.c                      |   4 +-
 drivers/mmc/host/renesas_sdhi.h                    |   3 +
 drivers/mmc/host/renesas_sdhi_core.c               |  39 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  15 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   3 +-
 drivers/mmc/host/sdhci-brcmstb.c                   | 154 +++++-
 drivers/mmc/host/sdhci-msm.c                       |  27 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   2 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 604 ++++++++++++++++++++-
 drivers/mmc/host/tmio_mmc.h                        |   2 -
 include/linux/mmc/card.h                           |   1 -
 36 files changed, 1219 insertions(+), 334 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
