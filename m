From: Harry Pan <harry.pan@intel.com>
Subject: [PATCH] mmc: sdhci-pci: mitigate Intel BXT/APL card detection race in early boot
Date: Fri, 13 Apr 2018 00:08:46 +0800
Message-ID: <20180412160846.12776-1-harry.pan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, Harry Pan <harry.pan@intel.com>, adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

When the APL platform is configured to use card detection GPIO, it is
observed a race in early boot that makes the inserted card temporary
malfunction because the driver does not detect the card then it would
turn off the mmc until user manually remove/insert card, or wait a
period of time for runtime suspend/resume to revive it automatically;
from the trace it is generalized the driver has inconsistent status
between GPIO status and the present state of the host controller.

i.e.
kworker/0:3-88    [000] ....     0.812523: mmc_rescan <-process_one_work
...
kworker/0:3-88    [000] ....     0.812527: bxt_get_cd <-mmc_rescan
kworker/0:3-88    [000] ....     0.812546: mmc_power_off <-mmc_rescan
kworker/0:3-88    [000] ....     0.812546: mmc_pwrseq_power_off <-mmc_power_off

Also proved it by adding a hacky dump of GPIO status and present state
register; the GPIO says card existing while controller says not present.

Further investigation I realized when the driver successfully configures
and routes card detection signal to GPIO domain, it immediately decays
the host controller card detection: pin level follows by inserted status,
they disappear a while then they would propagate back automatically,
this generates a small window (while it is one time only) against the card
detection routine; namely when it falls into this window, it behaves like
the above trace. While in case the platform software is not required to
switch the card detection to GPIO, this odd does not happen.

To tackle this odd, did experiment to observe the race window period,
enqueue a mmc detection in 200 ms later when it successfully routes the
card detection to GPIO, this allows margin to make consensus in between
the GPIO and the host controller.

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 82c4f05f91d8..519a3a5a2be0 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1719,6 +1719,9 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	if (slot->cd_idx >= 0) {
 		ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
 					   slot->cd_override_level, 0, NULL);
+		if (ret == 0)
+			mmc_detect_change(host->mmc, msecs_to_jiffies(200));
+
 		if (ret == -EPROBE_DEFER)
 			goto remove;
 
-- 
2.13.5
