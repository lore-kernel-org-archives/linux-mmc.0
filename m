From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 9 Jun 2011 17:44:26 +0100
Message-ID: <BANLkTimQUkf9ZsanZ-czqtYnyRSSSch4nQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:52106 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab1FIQo1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 12:44:27 -0400
Received: by pxi2 with SMTP id 2so1156464pxi.10
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 09:44:26 -0700 (PDT)
In-Reply-To: <BANLkTimbxSA_86a=2QH1pEGg1-O9neEyhw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 9 June 2011 17:30, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Looks good.
>
> At this point everything works ?
> (can you bring up the interface and scan/connect)

Yes.

> Can you now do a series of insmod-rmmod-insmod.. and see if things
> always work (with no runtime pm errors) after you insmod ?
>
> If yes, we're good.

See below.

>> Note that the patch includes the mmc_select_voltage() call
>
> Good, keep that one please.

OK

>> For reference, here is the equivalent test performed without runtime
>> PM enabled (i.e. all changes reverted)
>
> you mean runtime PM disabled, right ?

Yes.


Latest test, as suggested, based on this patch:
http://dev.laptop.org/~dsd/20110609/sd-pwr-debug4.patch
Note that I added in printk's to show when mmc_power_save_host() and
mmc_power_restore_host() get called.

bash-4.1# mount -t debugfs none /sys/kernel/debug
bash-4.1# cat /sys/kernel/debug/mmc1/ios
clock:		0 Hz
vdd:		0 (invalid)
bus mode:	1 (open drain)
chip select:	0 (don't care)
power mode:	0 (off)
bus width:	0 (1 bits)
timing spec:	0 (legacy)
bash-4.1#
bash-4.1# insmod /media/4E11-1D7C/libertas_sdio.ko
[   82.537594] libertas_sdio: Libertas SDIO driver
[   82.542838] libertas_sdio: Copyright Pierre Ossman
[   82.547792] mmc_power_restore_host mmc1
[   83.478197] libertas_sdio mmc1:0001:1: (unregistered net_device):
00:17:c4:a7:50:57, fw 9.70.3p36, cap 0x000003a3
[   83.496623] libertas_sdio mmc1:0001:1: wlan0: Marvell WLAN 802.11 adapter
bash-4.1# [   83.581679] udev[987]: renamed network interface wlan0 to eth0
[   83.635749] ieee80211 phy0: assoc: bss   (null) not in scan results
[   85.032955] ieee80211 phy0: assoc: bss   (null) not in scan results
[   85.087132] cfg80211: Calling CRDA for country: EU

bash-4.1# cat /sys/kernel/debug/mmc1/ios
clock:		25000000 Hz
vdd:		20 (3.2 ~ 3.3 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	0 (legacy)
bash-4.1#
bash-4.1# rmmod libertas_sdio
[   92.782496] cfg80211: Calling CRDA to update world regulatory domain
[   92.805661] cfg80211: World regulatory domain updated:
[   92.825864] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[   92.837401] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   92.845708] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   92.854000] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   92.865497] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   92.877042] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   92.885562] cfg80211: Calling CRDA to update world regulatory domain
[   92.905832] cfg80211: World regulatory domain updated:
[   92.916165] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[   92.928171] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   92.939651] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   92.950209] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   92.958179] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   92.971593] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
bash-4.1#
bash-4.1# insmod /media/4E11-1D7C/libertas_sdio.ko
[  104.187988] libertas_sdio: Libertas SDIO driver
[  104.192840] libertas_sdio: Copyright Pierre Ossman
[  104.201237] libertas_sdio mmc1:0001:1: (unregistered net_device):
00:17:c4:a7:50:57, fw 9.70.3p36, cap 0x000003a3
[  104.230342] cfg80211: Calling CRDA for country: EU
[  104.238936] libertas_sdio mmc1:0001:1: wlan0: Marvell WLAN 802.11 adapter
[  104.320479] udev[2114]: renamed network interface wlan0 to eth0
[  104.366506] ieee80211 phy1: assoc: bss   (null) not in scan results
[  105.703988] ieee80211 phy1: assoc: bss   (null) not in scan results
[  105.746816] cfg80211: Calling CRDA to update world regulatory domain
[  105.780078] cfg80211: World regulatory domain updated:
[  105.800084] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[  105.808555] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  105.850076] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  105.871870] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  105.879887] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  105.900256] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)

bash-4.1# rmmod libertas_sdio
[  109.652081] cfg80211: Calling CRDA to update world regulatory domain
[  109.673075] cfg80211: World regulatory domain updated:
[  109.678279] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[  109.692581] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  109.713624] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  109.724811] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  109.733089] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  109.741521] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)

bash-4.1# insmod /media/4E11-1D7C/libertas_sdio.ko
[  112.378005] libertas_sdio: Libertas SDIO driver
[  112.382826] libertas_sdio: Copyright Pierre Ossman
[  112.391190] libertas_sdio mmc1:0001:1: (unregistered net_device):
00:17:c4:a7:50:57, fw 9.70.3p36, cap 0x000003a3
[  112.420334] cfg80211: Calling CRDA for country: EU
[  112.428883] libertas_sdio mmc1:0001:1: wlan0: Marvell WLAN 802.11 adapter
bash-4.1# [  112.510471] udev[2302]: renamed network interface wlan0 to eth0
[  112.556438] ieee80211 phy2: assoc: bss   (null) not in scan results
[  113.915702] ieee80211 phy2: assoc: bss   (null) not in scan results
[  113.955631] cfg80211: Calling CRDA to update world regulatory domain
[  113.993444] cfg80211: World regulatory domain updated:
[  113.998631] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[  114.025508] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  114.052885] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  114.070131] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  114.078125] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  114.102197] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)

bash-4.1# rmmod libertas_sdio
[  118.272469] cfg80211: Calling CRDA to update world regulatory domain
[  118.296325] cfg80211: World regulatory domain updated:
[  118.315555] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[  118.324822] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  118.333074] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  118.341331] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  118.349327] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  118.360932] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)

bash-4.1# insmod /media/4E11-1D7C/libertas_sdio.ko
[  120.557985] libertas_sdio: Libertas SDIO driver
[  120.562817] libertas_sdio: Copyright Pierre Ossman
[  120.572314] libertas_sdio mmc1:0001:1: (unregistered net_device):
00:17:c4:a7:50:57, fw 9.70.3p36, cap 0x000003a3
[  120.595998] cfg80211: Calling CRDA for country: EU
[  120.605524] libertas_sdio mmc1:0001:1: wlan0: Marvell WLAN 802.11 adapter
[  120.680466] udev[2474]: renamed network interface wlan0 to eth0
[  120.750792] ieee80211 phy3: assoc: bss   (null) not in scan results
[  121.966221] ieee80211 phy3: assoc: bss   (null) not in scan results
[  122.006462] cfg80211: Calling CRDA to update world regulatory domain
[  122.042731] cfg80211: World regulatory domain updated:
[  122.047938] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[  122.081694] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  122.089714] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  122.116718] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  122.130095] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  122.138125] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)

bash-4.1# cat /sys/kernel/debug/mmc1/ios
clock:		25000000 Hz
vdd:		20 (3.2 ~ 3.3 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	0 (legacy)




Full log: http://dev.laptop.org/~dsd/20110609/sd-pwr-debug4.txt

Note that during the insmod/rmmod calls, runtime PM did not touch the
power state - the card remained powered ever since the first insmod.
Not sure if this is in-line with your expectations.

Thanks!
Daniel
