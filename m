From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 0/2] Tegra SDHCI rerun pad calibration periodically
Date: Mon, 20 Aug 2018 12:23:31 +0300
Message-ID: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Hi all,

This series implements pad drive strength recalibration. The calibration
is rerun to compensate possible changes in temperature. The calibration
procedure is rerun as part of mmc_host_ops.request before
sdhci_request() is run. The calibration is executed only if the 100 ms
recalibration interval has passed.

This series depends on the "Tegra SDHCI add support for HS200 and UHS
signaling" series.

Aapo Vienamo (2):
  mmc: sdhci: Export sdhci_request()
  mmc: tegra: Implement periodic pad calibration

 drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
 drivers/mmc/host/sdhci.c       |  3 ++-
 drivers/mmc/host/sdhci.h       |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.7.4
