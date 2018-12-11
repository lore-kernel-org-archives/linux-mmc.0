From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 0/2] Workaround errata i929
Date: Tue, 11 Dec 2018 19:52:51 +0530
Message-ID: <20181211142253.23747-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, kishon@ti.com, faiz_abbas@ti.com, j-keerthy@ti.com
List-Id: linux-mmc@vger.kernel.org

The following patches workaround errata i929 by implementing
a new tuning algorithm.

Changes in v2:
 1. Added patch to document the name of the thermal_zone "cpu_thermal"
 2. Rebased to latest linux-next

Faiz Abbas (2):
  dt-bindings: sdhci-omap: Add note for cpu_thermal
  mmc: sdhci-omap: Workaround errata regarding SDR104/HS200 tuning
    failures (i929)

 .../devicetree/bindings/mmc/sdhci-omap.txt    |  2 +
 drivers/mmc/host/Kconfig                      |  2 +
 drivers/mmc/host/sdhci-omap.c                 | 90 ++++++++++++++++++-
 3 files changed, 93 insertions(+), 1 deletion(-)

-- 
2.19.2
