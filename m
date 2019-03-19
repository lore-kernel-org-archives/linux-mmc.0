From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v3 0/2] Fixes for commands errors during tuning
Date: Tue, 19 Mar 2019 12:05:31 +0530
Message-ID: <20190319063533.12171-1-faiz_abbas@ti.com>
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

v3:
Removed the command error specific callback and using the already
existing sdhci_irq callback instead. No measurable drop in performance.

v2:
Added EXPORT_SYMBOL_GPL for sdhci_cmd_err and sdhci_send_command to fix
errors when built as module.

Faiz Abbas (2):
  mmc: sdhci: Make sdhci_send_command() public
  mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning

 drivers/mmc/host/sdhci-omap.c | 30 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      |  3 ++-
 drivers/mmc/host/sdhci.h      |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.19.2
