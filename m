From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 0/2] Add QUIRK for special HISPD bit in am65x-evm
Date: Fri, 29 Mar 2019 19:52:00 +0530
Message-ID: <20190329142202.15000-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

The following patches add a QUIRK for enabling HISPD bit under special
conditions and set the QUIRK for am65x-evm.

Faiz Abbas (2):
  mmc: sdhci: Add Quirk for enabling HISPD under special conditions
  mmc: sdhci_am654: Add QUIRK2_TI_HISPD_BIT

 drivers/mmc/host/sdhci.c       | 36 ++++++++++++++++++++++------------
 drivers/mmc/host/sdhci.h       |  2 ++
 drivers/mmc/host/sdhci_am654.c |  3 ++-
 3 files changed, 28 insertions(+), 13 deletions(-)

-- 
2.19.2
