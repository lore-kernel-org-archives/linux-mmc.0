From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 0/3] Tuning Fixes for sdhci-omap
Date: Wed, 21 Nov 2018 16:03:54 +0530
Message-ID: <20181121103357.3448-1-faiz_abbas@ti.com>
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

v2:
Added Fixes and stable tags for patch 1.
Re-enable DCRC in patch 1 only if it was enabled before
Squashed patches 2 & 3

Faiz Abbas (3):
  mmc: sdhci-omap: Fix DCRC error handling during tuning
  mmc: sdhci-omap: Add platform specific reset callback
  mmc: sdhci-omap: Remove redundant structure assignments

 drivers/mmc/host/sdhci-omap.c | 36 ++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

-- 
2.19.1
