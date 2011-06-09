From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 9 Jun 2011 17:21:21 +0100
Message-ID: <BANLkTinfeGUADyi1dTSjPRMnbP+TCtN0dQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39776 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab1FIQVV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 12:21:21 -0400
Received: by pzk9 with SMTP id 9so817066pzk.19
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 09:21:21 -0700 (PDT)
In-Reply-To: <BANLkTimg08VnOMrUwnH6dKzXPJO1fpOh6w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 9 June 2011 16:59, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Now can you please repeat this, but this time add your original patch
> (which only added the CMD5 arg=0 cmd, no sdio reset yet) ?

With this version of the patch:
http://dev.laptop.org/~dsd/20110609/sd-pwr-debug2.patch

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
[   53.917466] libertas_sdio: Libertas SDIO driver
[   53.922718] libertas_sdio: Copyright Pierre Ossman
[   54.839032] libertas_sdio mmc1:0001:1: (unregistered net_device):
00:17:c4:a7:50:57, fw 9.70.3p36, cap 0x000003a3
[   54.855479] libertas_sdio mmc1:0001:1: wlan0: Marvell WLAN 802.11 adapter
bash-4.1# [   54.941099] udev[985]: renamed network interface wlan0 to eth0
[   54.997656] ieee80211 phy0: assoc: bss   (null) not in scan results
[   56.310846] ieee80211 phy0: assoc: bss   (null) not in scan results
[   56.360840] cfg80211: Calling CRDA for country: EU

bash-4.1#
bash-4.1# cat /sys/kernel/debug/mmc1/ios
clock:		25000000 Hz
vdd:		20 (3.2 ~ 3.3 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	0 (legacy)

Full log: http://dev.laptop.org/~dsd/20110609/sd-pwr-debug2.txt

Note that the patch includes the mmc_select_voltage() call that I was
originally unsure about, and later did decide that equivalent code was
already being called elsewhere, thats why it was removed from the most
recent revision of the patch.



With a version of the patch that just does the reset, the post-powerup
"vdd" figure does change:
http://dev.laptop.org/~dsd/20110609/sd-pwr-debug3.patch

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
[   64.947624] libertas_sdio: Libertas SDIO driver
[   64.952866] libertas_sdio: Copyright Pierre Ossman
[   65.878171] libertas_sdio mmc1:0001:1: (unregistered net_device):
00:17:c4:a7:50:57, fw 9.70.3p36, cap 0x000003a3
[   65.896642] libertas_sdio mmc1:0001:1: wlan0: Marvell WLAN 802.11 adapter
bash-4.1# [   65.991205] udev[984]: renamed network interface wlan0 to eth0
[   66.048887] ieee80211 phy0: assoc: bss   (null) not in scan results
[   67.373572] ieee80211 phy0: assoc: bss   (null) not in scan results
[   67.423422] cfg80211: Calling CRDA for country: EU

bash-4.1# cat /sys/kernel/debug/mmc1/ios
clock:		25000000 Hz
vdd:		21 (3.3 ~ 3.4 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	0 (legacy)

Full log: http://dev.laptop.org/~dsd/20110609/sd-pwr-debug3.txt



For reference, here is the equivalent test performed without runtime
PM enabled (i.e. all changes reverted)

bash-4.1# mount -t debugfs none /sys/kernel/debug
bash-4.1# cat /sys/kernel/debug/mmc1/ios
clock:		25000000 Hz
vdd:		20 (3.2 ~ 3.3 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	0 (legacy)
bash-4.1#
bash-4.1# insmod /media/4E11-1D7C/libertas_sdio.ko
[   69.067761] libertas_sdio: Libertas SDIO driver
[   69.072995] libertas_sdio: Copyright Pierre Ossman
[   69.919033] libertas_sdio mmc1:0001:1: (unregistered net_device):
00:17:c4:a7:50:57, fw 9.70.3p36, cap 0x000003a3
[   69.935429] libertas_sdio mmc1:0001:1: wlan0: Marvell WLAN 802.11 adapter
[   70.021111] udev[991]: renamed network interface wlan0 to eth0
[   70.075870] ieee80211 phy0: assoc: bss   (null) not in scan results
[   71.460776] ieee80211 phy0: assoc: bss   (null) not in scan results
[   71.509660] cfg80211: Calling CRDA for country: EU
bash-4.1# cat /sys/kernel/debug/mmc1/ios
clock:		25000000 Hz
vdd:		20 (3.2 ~ 3.3 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	0 (legacy)

Full log: http://dev.laptop.org/~dsd/20110609/sd-pwr-debug0.txt


What next?

Thanks,
Daniel
