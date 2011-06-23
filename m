From: Philip Rakity <prakity@marvell.com>
Subject: [RFC] sdhci: suspend code correct ?
Date: Wed, 22 Jun 2011 17:09:11 -0700
Message-ID: <8E5F1A83-6949-4B4C-9482-30D582B7C54C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:59196 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757685Ab1FWALk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jun 2011 20:11:40 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arindam Nath <arindam.nath@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>


Looking at suspend in sdhci.c, it appears it does not handle errors correctly.

If suspend has an error shouldn't the code put things back to the state they were in before the suspend ?
If we are suspending then it is not clear why we need to run the re-tune timer.  resume will cause a re-tuning.

comments please.

One other issue not addressed in the code below is what error code is supposed to be returned if say sdhci-pxav3.c 
detects that it cannot suspend because it detects say dma active?  -EBUSY ?    Will the suspend code retry or should
the sdhci-pxa code wait for the dma to complete ?

Philip


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 91d9892..9c85d6d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2224,20 +2224,28 @@ out:
 int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 {
       int ret;
+       int cantune = 0;

       sdhci_disable_card_detection(host);

       /* Disable tuning since we are suspending */
       if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
-           host->tuning_mode == SDHCI_TUNING_MODE_1) {
-               host->flags &= ~SDHCI_NEEDS_RETUNING;
-               mod_timer(&host->tuning_timer, jiffies +
-                       host->tuning_count * HZ);
+               host->tuning_mode == SDHCI_TUNING_MODE_1) {
+                       host->flags &= ~SDHCI_NEEDS_RETUNING;
+                       del_timer_sync(&host->tuning_timer);
+                       cantune= 1;
       }

       ret = mmc_suspend_host(host->mmc);
-       if (ret)
+       if (ret) {
+               if (cantune) {
+                       host->flags |= SDHCI_NEEDS_RETUNING;
+                       mod_timer(&host->tuning_timer, jiffies +
+                               host->tuning_count * HZ);
+               }
+               sdhci_enable_card_detection(host);
               return ret;
+       }

       free_irq(host->irq, host);