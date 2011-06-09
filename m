From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 9 Jun 2011 20:27:48 +0300
Message-ID: <BANLkTi=jsPYEQOnRDyoXD_EzKdqby-QhYw@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com> <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
 <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com> <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
 <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com> <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
 <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com> <BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
 <BANLkTimg08VnOMrUwnH6dKzXPJO1fpOh6w@mail.gmail.com> <BANLkTinfeGUADyi1dTSjPRMnbP+TCtN0dQ@mail.gmail.com>
 <BANLkTimbxSA_86a=2QH1pEGg1-O9neEyhw@mail.gmail.com> <BANLkTimQUkf9ZsanZ-czqtYnyRSSSch4nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36048 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab1FIR2J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 13:28:09 -0400
Received: by wya21 with SMTP id 21so1301300wya.19
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 10:28:08 -0700 (PDT)
In-Reply-To: <BANLkTimQUkf9ZsanZ-czqtYnyRSSSch4nQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, Jun 9, 2011 at 7:44 PM, Daniel Drake <dsd@laptop.org> wrote:
> Note that during the insmod/rmmod calls, runtime PM did not touch the
> power state - the card remained powered ever since the first insmod.
> Not sure if this is in-line with your expectations.

It definitely isn't. And that may very well be our culprit here.

Let's focus now on just this one sequence:

- boot
- cat /sys/.../ios (power should be off)
- insmod
- cat /sys/.../ios (power should be on)
- rmmod
- cat /sys/.../ios (power should be off again)

You will see the problem now.

And I think I know why - there was a driver core change that
indirectly caused this.

Please try to revert e1866b33b1e89f077b7132daae3dfd9a594e9a1a "PM /
Runtime: Rework runtime PM handling during driver removal" and tell me
if it helped.

If it did, un-revert that change, and try this one patch, which adopts
SDIO runtime PM to that change:

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index d29b9c3..d2565df 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -189,7 +189,7 @@ static int sdio_bus_remove(struct device *dev)

        /* Then undo the runtime PM settings in sdio_bus_probe() */
        if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
-               pm_runtime_put_noidle(dev);
+               pm_runtime_put_sync(dev);

 out:
        return ret;

Thanks,
Ohad.
