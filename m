From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 0/2] Fixes for command errors during tuning
Date: Tue, 26 Feb 2019 21:46:04 +0530
Message-ID: <20190226161606.18569-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

These patches fix the following error message in dra7xx boards:

[4.833198] mmc1: Got data interrupt 0x00000002 even though no data
operation was in progress.

Tested with 100 times boot tests on dra71x-evm, dra72x-evm and
dra7xx-evm.

Faiz Abbas (2):
  mmc: sdhci: Add platform_cmd_err() to sdhci_ops
  mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning

 drivers/mmc/host/sdhci-omap.c | 24 +++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      | 37 ++++++++++++++++++++++-------------
 drivers/mmc/host/sdhci.h      |  4 ++++
 3 files changed, 51 insertions(+), 14 deletions(-)

-- 
2.19.2
