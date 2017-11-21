From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: sdhci broke in 4.14 [was: MMC fixes for v.4.14-rc4]
Date: Tue, 21 Nov 2017 16:08:43 +0100
Message-ID: <CAPDyKFrzVaE=upRbJ+sq2rRcR1uitw2QEvTzt=pjtoNh1bij9Q@mail.gmail.com>
References: <1507361610-31577-1-git-send-email-ulf.hansson@linaro.org> <2248b8b6-a80f-52ef-943f-54c1351d5a36@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:42983 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbdKUPIp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Nov 2017 10:08:45 -0500
Received: by mail-it0-f68.google.com with SMTP id n134so2345780itg.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Nov 2017 07:08:44 -0800 (PST)
In-Reply-To: <2248b8b6-a80f-52ef-943f-54c1351d5a36@suse.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Linus <torvalds@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad@kernel.org>

+ Yoshihiro, Geert, Konrad

On 20 November 2017 at 14:12, Jiri Slaby <jslaby@suse.cz> wrote:
> On 10/07/2017, 09:33 AM, Ulf Hansson wrote:
>> Here's a PR with a couple of MMC fixes intended for v4.14-rc4. Details about the
>> highlights are as usual found in the signed tag.
> ...
>> ----------------------------------------------------------------
>> MMC core:
>>  - Delete bounce buffer handling:
>>    This change fixes a problem related to how bounce buffers are being
>>    allocated. However, instead of trying to fix that, let's just remove
>>    the mmc bounce buffer code altogether, as it has practically no use.
>
> That is completely false, this breaks my sd card reader in 4.14 so that
> the system is mostly unusable during transfers -- it is stuttering:
> sdhci-pci 0000:02:00.0: swiotlb buffer is full (sz: 311296 bytes)
> sdhci-pci 0000:02:00.0: DMA: Out of SW-IOMMU space for 311296 bytes
> sdhci-pci 0000:02:00.0: swiotlb buffer is full (sz: 311296 bytes)
> sdhci-pci 0000:02:00.0: DMA: Out of SW-IOMMU space for 311296 bytes

Thanks for reporting!

This is a similar problem that was reported for the tmio mmc driver,
which got fixed in commit e90e8da72ad6 ("mmc: tmio: fix swiotlb buffer
is full").

It seems like we need something along those lines for the sdhci-pci
case as well. I cooked a patch, perhaps you have some time for test?

I also looped in the folkz involved in the fix for tmio mmc, let's see
if they can comment. My worries is only that there seems to be yet
some additional cases that may set mmc->max_segs = 1, so perhaps we
should actually try to deal with these case from mmc_add_host()
instead. Anyway, let's try this out first.


Subject: [PATCH] mmc: sdhci: Fix bounce buffer overflow

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2f14334..e9290a3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -21,6 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
+#include <linux/swiotlb.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
@@ -3651,22 +3652,29 @@ int sdhci_setup_host(struct sdhci_host *host)
        spin_lock_init(&host->lock);

        /*
+        * Maximum number of sectors in one transfer. Limited by SDMA boundary
+        * size (512KiB). Note some tuning modes impose a 4MiB limit, but this
+        * is less anyway.
+        */
+       mmc->max_req_size = 524288;
+
+       /*
         * Maximum number of segments. Depends on if the hardware
         * can do scatter/gather or not.
         */
-       if (host->flags & SDHCI_USE_ADMA)
+       if (host->flags & SDHCI_USE_ADMA) {
                mmc->max_segs = SDHCI_MAX_SEGS;
-       else if (host->flags & SDHCI_USE_SDMA)
+       } else if (host->flags & SDHCI_USE_SDMA) {
                mmc->max_segs = 1;
-       else /* PIO */
+               if (swiotlb_max_segment()) {
+                       unsigned int max_req_size = (1 << IO_TLB_SHIFT) *
+                                               IO_TLB_SEGSIZE;
+                       mmc->max_req_size = min(mmc->max_req_size,
+                                               max_req_size);
+               }
+       } else { /* PIO */
                mmc->max_segs = SDHCI_MAX_SEGS;
-
-       /*
-        * Maximum number of sectors in one transfer. Limited by SDMA boundary
-        * size (512KiB). Note some tuning modes impose a 4MiB limit, but this
-        * is less anyway.
-        */
-       mmc->max_req_size = 524288;
+       }

        /*
         * Maximum segment size. Could be one segment with the maximum number
-- 

[...]

Kind regards
Uffe
