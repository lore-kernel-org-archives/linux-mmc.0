From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 2/2] sdhci: sdhci-pxa.c add host->ops to configure f_max
Date: Sun, 13 Feb 2011 23:11:03 -0800
Message-ID: <7B48DA54-6A2E-4736-90AA-F8D8D9C0BA02@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58340 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751358Ab1BNHQK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:16:10 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>

>From e398ddd41423158830b2be937cc210833932c8c6 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Tue, 14 Dec 2010 17:02:19 -0800
Subject: [PATCH 2/2] sdhci: sdhci-pxa.c add host->ops to configure f_max

sdhci-pxa.c sets f_max after sdhci_add_host was called.

Rather then do this after the call, define a callback to allow
f_max to be obtained from platform specific code if the callback is
defined.

We cannot use the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
since the clock is not broken and on mmp2 is fixed at 200MHz.
On some pxa platforms and changing this value
a) does not work
b) causes bad clock dividers
c) mmc errors

On other platforms defining
SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN is the right thing to do
(pxa168 and pxa910) since the clock is configured via system
registers and not known via the CAPABILITY Register.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 0e64d66..3d01f94 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -94,8 +94,16 @@ static void platform_reset_exit(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static unsigned int get_f_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pxa *pxa = sdhci_priv(host);
+
+	return pxa->pdata->max_speed;
+}
+
 static struct sdhci_ops sdhci_pxa_ops = {
 	.platform_reset_exit = platform_reset_exit,
+	.get_f_max_clock = NULL,
 };
 
 /*****************************************************************************\
@@ -184,15 +192,17 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	/* do not rely on u-boot to enable the clocks */
 	enable_clock(host);
 
+	if (pxa->pdata->max_speed)
+		sdhci_pxa_ops.get_f_max_clock = get_f_max_clock;
+	else
+		sdhci_pxa_ops.get_f_max_clock = NULL;
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
 		goto out;
 	}
 
-	if (pxa->pdata->max_speed)
-		host->mmc->f_max = pxa->pdata->max_speed;
-
 	platform_set_drvdata(pdev, host);
 
 	return 0;
-- 
1.7.0.4


