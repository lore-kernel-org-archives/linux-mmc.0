From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 0/2] Fix issues with phy configurations
Date: Thu, 25 Apr 2019 21:27:25 +0530
Message-ID: <20190425155727.20010-1-faiz_abbas@ti.com>
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

Faiz Abbas (2):
  mmc: sdhci_am654: Fix minor phy configurations
  mmc: sdhci_am654: Fix SLOTTYPE write

 drivers/mmc/host/sdhci_am654.c | 37 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

-- 
2.19.2
