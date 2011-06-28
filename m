From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Wed, 29 Jun 2011 01:04:46 +0300
Message-ID: <BANLkTi=fwnNVwtxOo66k7M-4Jxu=3eD2xQ@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
 <BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com> <BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
 <BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com> <BANLkTik9y_N18EtsUTznaaa188GNusfiSA@mail.gmail.com>
 <BANLkTinDzj4206zLK7i6K9k9vWjVC9hH0w@mail.gmail.com> <BANLkTi=O4hg=ig5WOSeCWA4x03_5kAJsXw@mail.gmail.com>
 <BANLkTimzgiXpb0v30KYsfvoPAb4iu2K5kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab1F1WFH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 18:05:07 -0400
Received: by wyg8 with SMTP id 8so475932wyg.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jun 2011 15:05:06 -0700 (PDT)
In-Reply-To: <BANLkTimzgiXpb0v30KYsfvoPAb4iu2K5kw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Wed, Jun 29, 2011 at 12:54 AM, Daniel Drake <dsd@laptop.org> wrote:
> Too many patches floating around, just trying to be sure of what I'm doing!

Ok, let's start from fresh :)

Let's take 3.0-rc5, it already includes our work:

297c7f2 mmc: sdio: fix runtime PM path during driver removal
c6e633a mmc: sdio: reset card during power_restore

Then apply these hunks:

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index d29b9c3..73dc3c2 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -167,11 +167,8 @@ static int sdio_bus_remove(struct device *dev)
       int ret = 0;

       /* Make sure card is powered before invoking ->remove() */
-       if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD) {
-               ret = pm_runtime_get_sync(dev);
-               if (ret < 0)
-                       goto out;
-       }
+       if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
+               pm_runtime_get_sync(dev);

       drv->remove(func);

@@ -191,7 +188,6 @@ static int sdio_bus_remove(struct device *dev)
       if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
               pm_runtime_put_noidle(dev);

-out:
       return ret;
 }

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 58d5436..ce3e2e2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2488,7 +2488,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	} else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;

-	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23 |
MMC_CAP_POWER_OFF_CARD;

 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
 		host->flags |= SDHCI_AUTO_CMD12;


I think this should be enough (I don't remember anything else pending).

Thanks,
Ohad.
