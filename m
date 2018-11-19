From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 0/4] Tuning Fixes for sdhci-omap
Date: Mon, 19 Nov 2018 16:46:14 +0530
Message-ID: <20181119111618.2745-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

The following patches fix tuning related errors in the
sdhci-omap driver.

Faiz Abbas (4):
  mmc: sdhci-omap: Fix DCRC error handling during tuning
  mmc: sdhci-omap: Add variable to indicate host is tuning
  mmc: sdhci-omap: Add platform specific reset callback
  mmc: sdhci-omap: Remove redundant structure assignments

 drivers/mmc/host/sdhci-omap.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-- 
2.19.1
