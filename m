From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 0/3] mmc: sdhci: remove unnecessary platform_set_drvdata() call
Date: Fri, 10 Mar 2017 11:17:30 +0800
Message-ID: <20170310031733.812-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, patrice.chotard@st.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

sdhci_pltfm_init() has already set the platform drvdata for us, so its
users doesn't need to set the drvdata again. These patches clean up all
unnecessary platform_set_drvdata() call.

Jisheng Zhang (3):
  mmc: sdhci-pxav3: remove unnecessary platform_set_drvdata() call
  mmc: sdhci-pxav2: remove unnecessary platform_set_drvdata() call
  mmc: sdhci-st: remove unnecessary platform_set_drvdata() call

 drivers/mmc/host/sdhci-pxav2.c | 2 --
 drivers/mmc/host/sdhci-pxav3.c | 2 --
 drivers/mmc/host/sdhci-st.c    | 2 --
 3 files changed, 6 deletions(-)

-- 
2.11.0
