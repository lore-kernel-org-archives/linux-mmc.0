From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: add host->ops to configure f_max
Date: Fri, 21 Jan 2011 11:27:35 -0800
Message-ID: <3B8D8528-C323-44DD-9AB5-813464801E30@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52061 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753971Ab1AUT1h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:27:37 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


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
index 0afc763..4c2a252 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -53,7 +53,15 @@ static void enable_clock(struct sdhci_host *host)
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
+	.get_f_max_clock = NULL,
 };
 
 /*****************************************************************************\
@@ -131,15 +139,17 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
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


