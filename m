From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Date: Sun, 14 Sep 2014 23:51:24 +0400
Message-ID: <3179866.4yEKrAKQ30@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, ian.molton@codethink.co.uk, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

I spent a couple of days with the driver just hanging due to me forgetting to
specify the external crystal frequency,  so that clk_get_rate() returned 0 and
thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
acceptable behavior, so I suggest that the minimum frequency is checked for 0
in tmio_mmc_host_probe().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: stable@vger.kernel.org

---
The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' branch.

Changes in version 3:
- added Cc: stable.

Changes in version 2:
- fixed grammar in the changelog.

 drivers/mmc/host/tmio_mmc_pio.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: mmc/drivers/mmc/host/tmio_mmc_pio.c
===================================================================
--- mmc.orig/drivers/mmc/host/tmio_mmc_pio.c
+++ mmc/drivers/mmc/host/tmio_mmc_pio.c
@@ -1044,6 +1044,15 @@ int tmio_mmc_host_probe(struct tmio_mmc_
 	}
 
 	/*
+	 * Check the sanity of mmc->f_min to prevent tmio_mmc_set_clock() from
+	 * looping forever...
+	 */
+	if (mmc->f_min == 0) {
+		ret = -EINVAL;
+		goto pm_disable;
+	}
+
+	/*
 	 * There are 4 different scenarios for the card detection:
 	 *  1) an external gpio irq handles the cd (best for power savings)
 	 *  2) internal sdhi irq handles the cd

