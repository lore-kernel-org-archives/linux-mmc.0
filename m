From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Sun, 5 Jun 2011 02:08:18 +0300
Message-ID: <BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com> <BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36834 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab1FDXIj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Jun 2011 19:08:39 -0400
Received: by wya21 with SMTP id 21so2079579wya.19
        for <linux-mmc@vger.kernel.org>; Sat, 04 Jun 2011 16:08:38 -0700 (PDT)
In-Reply-To: <BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

... going back to the call trace you provided ...

On Sat, Jun 4, 2011 at 1:18 PM, Daniel Drake <dsd@laptop.org> wrote:
> Here is the call trace:
>
> mmc_suspend_host
> mmc_sdio_remove
> sdio_remove_func
> device_del

This eventually disables runtime PM for your SDIO function.

We can stop checking the return value of pm_runtime_get_sync in
sdio_bus_remove, like pci_device_remove is doing, but I don't think
that's enough: I guess libertas' if_sdio_remove won't be so happy
dealing with a powered off card.

Can you try the following please (untested):

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4d0c15b..8af3330 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -540,6 +540,13 @@ static void mmc_sdio_remove(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);

+	/*
+	 * if this card is managed by runtime pm, make sure it is powered on
+	 * before invoking its SDIO functions' ->remove() handler
+	 */
+	if (host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_get_sync(&host->card->dev);
+
 	for (i = 0;i < host->card->sdio_funcs;i++) {
 		if (host->card->sdio_func[i]) {
 			sdio_remove_func(host->card->sdio_func[i]);
@@ -547,6 +554,9 @@ static void mmc_sdio_remove(struct mmc_host *host)
 		}
 	}

+	if (host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_put_noidle(&host->card->dev);
+
 	mmc_remove_card(host->card);
 	host->card = NULL;
 }
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index d29b9c3..73dc3c2 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -167,11 +167,8 @@ static int sdio_bus_remove(struct device *dev)
 	int ret = 0;

 	/* Make sure card is powered before invoking ->remove() */
-	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD) {
-		ret = pm_runtime_get_sync(dev);
-		if (ret < 0)
-			goto out;
-	}
+	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_get_sync(dev);

 	drv->remove(func);

@@ -191,7 +188,6 @@ static int sdio_bus_remove(struct device *dev)
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);

-out:
 	return ret;
 }
