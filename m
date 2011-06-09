From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 9 Jun 2011 21:25:08 +0300
Message-ID: <BANLkTinG-CmEh9yXL9Sp+W7PyatvEdOhZQ@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com> <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
 <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com> <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
 <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com> <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
 <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com> <BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
 <BANLkTimg08VnOMrUwnH6dKzXPJO1fpOh6w@mail.gmail.com> <BANLkTinfeGUADyi1dTSjPRMnbP+TCtN0dQ@mail.gmail.com>
 <BANLkTimbxSA_86a=2QH1pEGg1-O9neEyhw@mail.gmail.com> <BANLkTimQUkf9ZsanZ-czqtYnyRSSSch4nQ@mail.gmail.com>
 <BANLkTi=jsPYEQOnRDyoXD_EzKdqby-QhYw@mail.gmail.com> <BANLkTi=VWUcCQJaBChnitVq1_TT1huE30A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62937 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab1FISZ3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 14:25:29 -0400
Received: by wwa36 with SMTP id 36so1990634wwa.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 11:25:28 -0700 (PDT)
In-Reply-To: <BANLkTi=VWUcCQJaBChnitVq1_TT1huE30A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, Jun 9, 2011 at 8:56 PM, Daniel Drake <dsd@laptop.org> wrote:
> Done, the rmmod issue remains fixed - the card gets powered down during rmmod.

great !

> Next up is the problem where on this setup, if I suspend after loading
> the module, and the module asks the card to shut down during suspend,
> it fails to get brought up during resume.

we need to take into account that driver core change I spotted.

> Note that I have now rolled in a patch you made in another thread to
> correctly call into the driver's remove routine during suspend when
> powering down the card.

let's update that patch. I'd send you an updated one, but I have to go
for awhile, so here's the quick change you need to do.

replace the put_noidle() call in the hunk below with a put_sync():

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4d0c15b..e23888a 100644
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
+		pm_runtime_put_noidle(&host->card->dev);   //<==============  use
pm_runtime_put_sync here
+
 	mmc_remove_card(host->card);
 	host->card = NULL;
 }

tell me how it goes...
