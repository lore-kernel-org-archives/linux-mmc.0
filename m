From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: [PATCH V2] mmc: omap_hsmmc: Pass on the suspend failure to the PM core
Date: Thu, 13 Sep 2012 12:01:03 +0530
Message-ID: <1347517863-30017-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, svenkatr@ti.com
Cc: rob.herring@calxeda.com, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, cjb@laptop.org, nsekhar@ti.com, sudhakar.raj@ti.com, gururaja.hebbar@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

In some cases mmc_suspend_host() is not able to claim the
host and proceed with the suspend process. The core returns
-EBUSY to the host controller driver. Unfortunately, the
host controller driver does not pass on this information
to the PM core and hence the system suspend process continues.

	ret = mmc_suspend_host(host->mmc);
	if (ret) {
		host->suspended = 0;
		if (host->pdata->resume) {
			ret = host->pdata->resume(dev, host->slot_id);

The return status from mmc_suspend_host() is overwritten by return
status from host->pdata->resume. So the original return status is lost.

In these cases the MMC core gets to an unexpected state
during resume and multiple issues related to MMC crop up.
1. Host controller driver starts accessing the device registers
before the clocks are enabled which leads to a prefetch abort.
2. A file copy thread which was launched before suspend gets
stuck due to the host not being reclaimed during resume.

To avoid such problems pass on the -EBUSY status to the PM core
from the host controller driver. With this change, MMC core
suspend might still fail but it does not end up making the
system unusable. Suspend gets aborted and the user can try
suspending the system again.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
Changes from V1:
	- Instead of forcibly returning -EBUSY on err, retain old
	status and pass on the same to the caller.
	- add more detail to commit message (explanation with code
	snippet)

:100644 100644 9afdd20... d9af5f1... M	drivers/mmc/host/omap_hsmmc.c
 drivers/mmc/host/omap_hsmmc.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9afdd20..d9af5f1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2050,8 +2050,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 	if (ret) {
 		host->suspended = 0;
 		if (host->pdata->resume) {
-			ret = host->pdata->resume(dev, host->slot_id);
-			if (ret)
+			if (host->pdata->resume(dev, host->slot_id))
 				dev_dbg(dev, "Unmask interrupt failed\n");
 		}
 		goto err;
-- 
1.7.0.4
