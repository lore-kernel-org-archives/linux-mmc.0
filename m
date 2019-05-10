From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 0/3] Fix issues with phy configurations in am65x MMC driver
Date: Fri, 10 May 2019 09:12:25 +0530
Message-ID: <20190510034228.32211-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

The following patches fix issues with phy configurations for
sdhci_am654 driver.

v2:
1. Split patch 1 into 2 separate patches.
2. Improved patch descriptions.

Faiz Abbas (3):
  mmc: sdhci_am654: Improve line wrapping with regmap_*() calls
  mmc: sdhci_am654: Print error message if the DLL fails to lock
  mmc: sdhci_am654: Fix SLOTTYPE write

 drivers/mmc/host/sdhci_am654.c | 37 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

-- 
2.19.2
