From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v4 0/2] Fix command errors during tuning
Date: Tue, 26 Mar 2019 16:30:55 +0530
Message-ID: <20190326110057.7055-1-faiz_abbas@ti.com>
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

v4:
Fixed commit description for patch 1.
Added SDHCI_INT_TIMEOUT to CMD_ERR_MASK in patch 2.

v3:
Removed the command error specific callback and using the already
existing sdhci_irq callback instead. No measurable drop in performance.

v2:
Added EXPORT_SYMBOL_GPL for sdhci_cmd_err and sdhci_send_command to fix
errors when built as module.

Faiz Abbas (2):
  mmc: sdhci: Export sdhci_finish_command()
  mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning

 drivers/mmc/host/sdhci-omap.c | 37 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      |  3 ++-
 drivers/mmc/host/sdhci.h      |  1 +
 3 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.19.2
