From: Philip Rakity <prakity@marvell.com>
Subject: RE: [RFC Patch] SDHCI: add quirk for data timeout value when card
 busy.
Date: Mon, 29 Nov 2010 22:42:11 -0800
Message-ID: <43E4817426ED174AA81263BCECB4351D13200C545A@sc-vexch3.marvell.com>
References: <4CF4961C.5020606@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44480 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752484Ab0K3GuU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Nov 2010 01:50:20 -0500
In-Reply-To: <4CF4961C.5020606@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, kyungmin Park <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>


The problem is a little more complicated then this.  During out testing of multiple sd/mmc cards we found some cards that gave incorrect timeout values.   The solution was to define the existing quirk to force the timeout to 0xe.

The timeout problems had nothing to do with the controller being broken nor with suspend/resume.

________________________________________
From: linux-mmc-owner@vger.kernel.org [linux-mmc-owner@vger.kernel.org] On Behalf Of Jaehoon Chung [jh80.chung@samsung.com]
Sent: Monday, November 29, 2010 10:13 PM
To: linux-mmc@vger.kernel.org
Cc: Chris Ball; kyungmin Park; Andrew Morton; matt@console-pimps.org
Subject: [RFC Patch] SDHCI: add quirk for data timeout value when card busy.

This patch is added quirks for data timeout value.

Some card have problem when suspend/resume.
CMD6(switch command) to switch the bus to high speed mode
and to set the bus width.

After resuming, the card was initialized...in that time, some
card need set a correct timeout value.
so we add SDHCI_QUIRK_SET_DATA_TIMEOUT_VAL.

Let me know any comment, plz.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
 Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---
 drivers/mmc/host/sdhci.c  |    6 +++++-
 include/linux/mmc/sdhci.h |    3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..3b93d97 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -655,8 +655,12 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)

        WARN_ON(host->data);

-       if (data == NULL)
+       if (data == NULL) {
+               if ((host->quirks & SDHCI_QUIRK_SET_DATA_TIMEOUT_VAL) &&
+                               (host->cmd->flags & MMC_RSP_BUSY))
+                       sdhci_writel(host, 0xE, SDHCI_TIMEOUT_CONTROL);
                return;
+       }

        /* Sanity checks */
        BUG_ON(data->blksz * data->blocks > 524288);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1fdc673..315ff49 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -83,7 +83,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12             (1<<28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
 #define SDHCI_QUIRK_NO_HISPD_BIT                       (1<<29)
-
+/* Controller need set data timeout value when card is busy */
+#define SDHCI_QUIRK_SET_DATA_TIMEOUT_VAL               (1<<30)
        int irq;                /* Device IRQ */
        void __iomem *ioaddr;   /* Mapped address */

--
1.6.0.4

Thanks
Jaehoon Chung

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
