From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 9 Jun 2011 18:56:02 +0100
Message-ID: <BANLkTi=VWUcCQJaBChnitVq1_TT1huE30A@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
	<BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com>
	<BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
	<BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com>
	<BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
	<BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com>
	<BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
	<BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com>
	<BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
	<BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com>
	<BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
	<BANLkTimg08VnOMrUwnH6dKzXPJO1fpOh6w@mail.gmail.com>
	<BANLkTinfeGUADyi1dTSjPRMnbP+TCtN0dQ@mail.gmail.com>
	<BANLkTimbxSA_86a=2QH1pEGg1-O9neEyhw@mail.gmail.com>
	<BANLkTimQUkf9ZsanZ-czqtYnyRSSSch4nQ@mail.gmail.com>
	<BANLkTi=jsPYEQOnRDyoXD_EzKdqby-QhYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61338 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab1FIR4D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 13:56:03 -0400
Received: by pvg12 with SMTP id 12so853999pvg.19
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 10:56:03 -0700 (PDT)
In-Reply-To: <BANLkTi=jsPYEQOnRDyoXD_EzKdqby-QhYw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 9 June 2011 18:27, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Let's focus now on just this one sequence:
>
> - boot
> - cat /sys/.../ios (power should be off)
> - insmod
> - cat /sys/.../ios (power should be on)
> - rmmod
> - cat /sys/.../ios (power should be off again)
>
> You will see the problem now.

As I think you expected, everything went fine until the last "cat"
where it showed that the power is still on (no change from the
previous cat).

> And I think I know why - there was a driver core change that
> indirectly caused this.
>
> Please try to revert e1866b33b1e89f077b7132daae3dfd9a594e9a1a "PM /
> Runtime: Rework runtime PM handling during driver removal" and tell m=
e
> if it helped.

It does. Now your test case works, power gets turned off on rmmod.

> If it did, un-revert that change, and try this one patch, which adopt=
s
> SDIO runtime PM to that change:
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.=
c
> index d29b9c3..d2565df 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -189,7 +189,7 @@ static int sdio_bus_remove(struct device *dev)
>
> =A0 =A0 =A0 =A0/* Then undo the runtime PM settings in sdio_bus_probe=
() */
> =A0 =A0 =A0 =A0if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_noidle(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(dev);
>
> =A0out:
> =A0 =A0 =A0 =A0return ret;

Done, the rmmod issue remains fixed - the card gets powered down during=
 rmmod.

rmmod/insmod repeatedly works as expected. It gets powered down on
rmmod, and powered up on insmod. The power-up works fine and ios
values look fine at all steps.

Progress! :)



Next up is the problem where on this setup, if I suspend after loading
the module, and the module asks the card to shut down during suspend,
it fails to get brought up during resume.
Note that I have now rolled in a patch you made in another thread to
correctly call into the driver's remove routine during suspend when
powering down the card.
I also added a printk message to detect when the CMD5 reset command fai=
led.

New patch: http://dev.laptop.org/~dsd/20110609/sd-pwr-debug5.patch

Test case:

- boot
- mount debugfs
- insmod
- suspend
- resume
- cat /sys/.../ios

Output from resume onwards:

[   60.210326] Restarting tasks ... done.
[   60.346261] cfg80211: World regulatory domain updated:
[   60.368829] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[   60.394947] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   60.425084] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   60.433390] usb 1-2: USB disconnect, device number 2
[   60.475817] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   60.587866] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   60.611597] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   60.684817] cfg80211: Calling CRDA to update world regulatory domain
[   60.736397] cfg80211: World regulatory domain updated:
[   60.784745] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[   60.801158] usb 1-2: new high speed USB device number 3 using ehci_h=
cd
[   60.815608] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   60.841586] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   60.883868] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   60.893420] mmc1: new SDIO card at address 0001
[   60.913405] mmc_power_save_host mmc1
[   60.917148] mmc_power_restore_host mmc1
[   60.931707] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   60.983389] usb 1-2: New USB device found, idVendor=3D090c, idProduc=
t=3D1000
[   61.011508] CMD5 reset failed, err=3D-110
[   61.015475] libertas_sdio: probe of mmc1:0001:1 failed with error -1=
6

=46ull log: http://dev.laptop.org/~dsd/20110609/sd-pwr-debug5.txt

Daniel
