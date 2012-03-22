From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: Occasional crashes in suspend-resume with MMC transactions
Date: Thu, 22 Mar 2012 13:20:53 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D12143317FF773@DBDE01.ent.ti.com>
References: <B5906170F1614E41A8A28DE3B8D12143317FDFBB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <B5906170F1614E41A8A28DE3B8D12143317FDFBB@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 22, 2012 at 09:53:23, Bedia, Vaibhav wrote:
> Hi,
> 
> I am trying to do suspend-resume test with a file copy on MMC/SD going on
> in the background. The test involves simply copying a 450MB file on an ext3
> partition to the same partition under a different name.
> 
> This is on an AM335x board which uses the omap_hsmmc driver. 
> The kernel is v3.2 and I have also applied the following patch 
> 

[...]

I found that whenever this issue crops up, mmc_host_suspend() is not able to claim the host
And returns -EBUSY. omap_hsmmc driver does not pass on this error code to the PM core and
hence the suspend process continues. When the driver is made to return -EBUSY, the suspend
process gets aborted and the user can try suspending again. I am not sure whether this sort
of suspend failure is acceptable or the driver is doing something wrong. The following
workaround is what I came up with. Do this look a reasonable thing to do?

---

>From a4040dd1869b351a5fa29dacd08facf6e24df609 Mon Sep 17 00:00:00 2001
From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Date: Thu, 22 Mar 2012 17:14:49 +0530
Subject: [PATCH 1/1] mmc: omap_hsmmc: Pass on the suspend failure to the PM core

In some cases mmc_host_suspend() is not able to claim the
host and proceed with the suspend process. The core returns
-EBUSY to the host controller driver. Unfortunately, the
host controller driver does not pass on this information
to the PM core and hence the system suspend process continues.

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
---
 drivers/mmc/host/omap_hsmmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 3d8dbbb..1f938d9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2238,6 +2238,7 @@ static int omap_hsmmc_suspend(struct device *dev)
                                        dev_dbg(mmc_dev(host->mmc),
                                                "Unmask interrupt failed\n");
                        }
+                       ret = -EBUSY;
                        goto err;
                }

--
1.7.0.4
