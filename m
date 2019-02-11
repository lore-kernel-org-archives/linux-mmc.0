From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/3] mmc: Introduce support for WP GPIO in the core SDHCI
Date: Mon, 11 Feb 2019 14:23:39 +0100
Message-ID: <20190211132342.31009-1-thomas.petazzoni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-mmc@vger.kernel.org

Hello,

While doing the bring up of a Zynq 7000 platform where the WP signal
of a SD slot is connected to a regular GPIO rather than through the
SDHCI WP pin, I realized that the GPIO described by wp-gpios was
properly requested, but it was in fact not used at all.

Indeed, the SDHCI core implements sdhci_check_ro() by:

 - Calling a controller-specific ->get_ro() callback if it exists. A
   few controller-specific drivers implement this, but not
   sdhci-of-arasan, which is used on Zynq 7000.

 - Using the SDHCI_PRESENT_STATE register, which reports the state of
   the SDHCI interface WP pin, and obvisouly not the state of a
   separate WP GPIO.

This patch series therefore changes sdhci_check_ro() to behave like
sdhci_get_cd(): use a GPIO first if available, and if not, fallback to
using the SDHCI_PRESENT_STATE register. Indeed, if there's a wp-gpios
described in the DT, it quite certainly indicates that the SDHCI WP
signal is not used, and the WP GPIO should be used instead.

As part of this series, two SDHCI drivers are modified to no longer
implement their custom ->get_ro() hook, since the core SDHCI now does
the right thing with the WP GPIO.

Changes since v1:
- Call the ->get_ro() callback before using the WP GPIO in the core,
  as suggested by Adrian Hunter.
- Fix typoes in commit logs.
- Collect Reviewed-by/Tested-by/Acked-by tags.

Best regards,

Thomas

Thomas Petazzoni (3):
  mmc: sdhci: use WP GPIO in sdhci_check_ro()
  mmc: sdhci-omap: drop ->get_ro() implementation
  mmc: sdhci-tegra: drop ->get_ro() implementation

 drivers/mmc/host/sdhci-omap.c  | 1 -
 drivers/mmc/host/sdhci-tegra.c | 9 ---------
 drivers/mmc/host/sdhci.c       | 9 ++++++---
 3 files changed, 6 insertions(+), 13 deletions(-)

-- 
2.20.1
