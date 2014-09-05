From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Date: Sat, 06 Sep 2014 01:42:29 +0400
Message-ID: <2535223.qa7H57Aml3@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:59006 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaIEVmd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Sep 2014 17:42:33 -0400
Received: by mail-la0-f45.google.com with SMTP id pn19so14680188lab.18
        for <linux-mmc@vger.kernel.org>; Fri, 05 Sep 2014 14:42:31 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ian.molton@codethink.co.uk, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-sh@vger.kernel.org

I spent a couple of days with the driver just hanging due to me forgetting to
specify the external crystal frequency,  so that clk_get_rate() returned 0 and
thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
acceptable behavior, so I suggest that the minimum frequency is checked for 0
in tmio_mmc_host_probe().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' branch.

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

