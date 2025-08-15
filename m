Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F6126BF1;
	Fri, 15 Aug 2025 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222690; cv=none; b=E6kUP3dCMQKZQRRgCU3zACd/XPrHu+vX6KA9xa00oxcZktRb9M2vRLiaUr6RYL2IUn1r4nQWLrNU7RFfUvi7HBXajufjJ5jIkV4XJGBOggCmk6LpGHY/6BO1a8MSSJ0R3LmE8m2v7Nj8n77Ap1UeZ8MpIKEoNpyKpxt4W9eKqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222690; c=relaxed/simple;
	bh=w4+YwtEAkPe4985SePVgY/LRMzHNZ0Qt2SJ2zYKn0Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyk+oQjYG/tLfYQg+WrRz2PzkGrkHB5lFO/tlO928xx6+hkwRvtN+axTTfow8/uB9lM6uqjhvgt+9k2ajnincytj8u/5dro9VMtwgZqMognky161gjQsANE7ThrtEXqzgMD6VY/gBKNxwbWtJ6hc20BmEO3rd1+dLVz/8U49PZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8yOI6wr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8yOI6wr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F79C4CEED;
	Fri, 15 Aug 2025 01:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222689;
	bh=w4+YwtEAkPe4985SePVgY/LRMzHNZ0Qt2SJ2zYKn0Lc=;
	h=From:To:Cc:Subject:Date:From;
	b=f8yOI6wr7cV32cnojAH515/oagDRyfdJtGWHf9FR2gvZPspVY0Arxl1BWQbIClgDG
	 8vnBY0hrX6Ts3ycMwAs5zy7N5JZrIsZ0WBev3AAq/efZOFTVUfMqoTiio/PQ77uaD4
	 sg27RKGdnXrKttVXSTqwdsVZQWo43lfrncJrDNq4+rlgUHwX1TO9DIyEaZoJZXG0gJ
	 ZnbLj00HojZ9A/QuNXk9LCOdlZmyqfAQ6pKW11t7jsck//3BxkRU1d8pxooq/ScGqF
	 LA/Nu5TKIJykK4yTfrYF14kfhk9rb/Cu7Ub2e4piDjdxZuNlLYHdATTi/ifp01YXDO
	 2lp6Jy9YOokaw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@armlinux.org.uk>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Michal Simek <michal.simek@amd.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/38] mmc: host: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:35 +0800
Message-ID: <20250815013413.28641-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the modern PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM or
CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards or
__maybe_unused.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Previously, I only cleaned up the host drivers which I used, e.g
sdhci-of-dwcmshc, sdhci-pxav3 and sdhci-xenon, these are both compile
tested and functionality tested. But then I also cleaned up other
host drivers, but they are compile-tested only.

Jisheng Zhang (38):
  sdhci: add some simple inline functions for !CONFIG_PM
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

 drivers/mmc/host/alcor.c            |  8 +++-----
 drivers/mmc/host/atmel-mci.c        |  9 +++------
 drivers/mmc/host/au1xmmc.c          | 18 +++++++-----------
 drivers/mmc/host/cb710-mmc.c        | 19 +++++++++----------
 drivers/mmc/host/davinci_mmc.c      | 14 +++-----------
 drivers/mmc/host/dw_mmc-exynos.c    | 13 +++----------
 drivers/mmc/host/dw_mmc-k3.c        |  9 +++------
 drivers/mmc/host/dw_mmc-pci.c       |  9 +++------
 drivers/mmc/host/dw_mmc-rockchip.c  |  9 +++------
 drivers/mmc/host/dw_mmc.h           |  3 +++
 drivers/mmc/host/mmci.c             |  9 +++------
 drivers/mmc/host/mtk-sd.c           | 14 +++++++-------
 drivers/mmc/host/mxs-mmc.c          |  6 ++----
 drivers/mmc/host/omap_hsmmc.c       | 13 ++++---------
 drivers/mmc/host/rtsx_usb_sdmmc.c   |  7 ++-----
 drivers/mmc/host/sdhci-acpi.c       | 18 ++++--------------
 drivers/mmc/host/sdhci-brcmstb.c    |  8 ++------
 drivers/mmc/host/sdhci-cadence.c    |  8 ++------
 drivers/mmc/host/sdhci-esdhc-imx.c  | 13 +++----------
 drivers/mmc/host/sdhci-msm.c        | 21 +++++++++------------
 drivers/mmc/host/sdhci-of-arasan.c  |  8 +++-----
 drivers/mmc/host/sdhci-of-at91.c    | 12 +++---------
 drivers/mmc/host/sdhci-of-dwcmshc.c | 13 +++----------
 drivers/mmc/host/sdhci-of-esdhc.c   |  8 ++------
 drivers/mmc/host/sdhci-omap.c       | 18 +++++++-----------
 drivers/mmc/host/sdhci-pxav3.c      | 11 +++--------
 drivers/mmc/host/sdhci-s3c.c        | 11 +++--------
 drivers/mmc/host/sdhci-spear.c      |  6 ++----
 drivers/mmc/host/sdhci-sprd.c       | 10 +++-------
 drivers/mmc/host/sdhci-st.c         |  6 ++----
 drivers/mmc/host/sdhci-tegra.c      | 13 +++++--------
 drivers/mmc/host/sdhci-xenon.c      | 13 +++----------
 drivers/mmc/host/sdhci.h            |  7 +++++++
 drivers/mmc/host/sdhci_am654.c      | 10 +++-------
 drivers/mmc/host/sh_mmcif.c         |  8 ++------
 drivers/mmc/host/sunxi-mmc.c        | 11 +++--------
 drivers/mmc/host/toshsd.c           |  8 ++------
 drivers/mmc/host/via-sdmmc.c        | 10 +++++-----
 drivers/mmc/host/wmt-sdmmc.c        | 16 ++--------------
 39 files changed, 141 insertions(+), 286 deletions(-)

-- 
2.50.0

