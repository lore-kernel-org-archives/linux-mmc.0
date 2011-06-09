From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 9 Jun 2011 19:30:13 +0300
Message-ID: <BANLkTimbxSA_86a=2QH1pEGg1-O9neEyhw@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com> <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
 <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com> <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
 <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com> <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
 <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com> <BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
 <BANLkTimg08VnOMrUwnH6dKzXPJO1fpOh6w@mail.gmail.com> <BANLkTinfeGUADyi1dTSjPRMnbP+TCtN0dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57673 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1FIQae convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 12:30:34 -0400
Received: by wya21 with SMTP id 21so1257761wya.19
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 09:30:33 -0700 (PDT)
In-Reply-To: <BANLkTinfeGUADyi1dTSjPRMnbP+TCtN0dQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, Jun 9, 2011 at 7:21 PM, Daniel Drake <dsd@laptop.org> wrote:
> With this version of the patch:
> http://dev.laptop.org/~dsd/20110609/sd-pwr-debug2.patch
>
> bash-4.1# mount -t debugfs none /sys/kernel/debug
> bash-4.1# cat /sys/kernel/debug/mmc1/ios
> clock: =A0 =A0 =A0 =A0 =A00 Hz
> vdd: =A0 =A0 =A0 =A0 =A0 =A00 (invalid)
> bus mode: =A0 =A0 =A0 1 (open drain)
> chip select: =A0 =A00 (don't care)
> power mode: =A0 =A0 0 (off)
> bus width: =A0 =A0 =A00 (1 bits)
> timing spec: =A0 =A00 (legacy)
> bash-4.1#
> bash-4.1# insmod /media/4E11-1D7C/libertas_sdio.ko
> [ =A0 53.917466] libertas_sdio: Libertas SDIO driver
> [ =A0 53.922718] libertas_sdio: Copyright Pierre Ossman
> [ =A0 54.839032] libertas_sdio mmc1:0001:1: (unregistered net_device)=
:
> 00:17:c4:a7:50:57, fw 9.70.3p36, cap 0x000003a3
> [ =A0 54.855479] libertas_sdio mmc1:0001:1: wlan0: Marvell WLAN 802.1=
1 adapter
> bash-4.1# [ =A0 54.941099] udev[985]: renamed network interface wlan0=
 to eth0
> [ =A0 54.997656] ieee80211 phy0: assoc: bss =A0 (null) not in scan re=
sults
> [ =A0 56.310846] ieee80211 phy0: assoc: bss =A0 (null) not in scan re=
sults
> [ =A0 56.360840] cfg80211: Calling CRDA for country: EU

Looks good.

At this point everything works ?
(can you bring up the interface and scan/connect)

Can you now do a series of insmod-rmmod-insmod.. and see if things
always work (with no runtime pm errors) after you insmod ?

If yes, we're good.

> Note that the patch includes the mmc_select_voltage() call

Good, keep that one please.

> With a version of the patch that just does the reset, the post-poweru=
p
> "vdd" figure does change:
> http://dev.laptop.org/~dsd/20110609/sd-pwr-debug3.patch
=2E..
> bash-4.1# cat /sys/kernel/debug/mmc1/ios
> clock: =A0 =A0 =A0 =A0 =A025000000 Hz
> vdd: =A0 =A0 =A0 =A0 =A0 =A021 (3.3 ~ 3.4 V)

Without even looking exactly why it happens, it doesn't look too good.
I don't see a reason to stick to that version. Let's use the
mmc_select_voltage.

>
> For reference, here is the equivalent test performed without runtime
> PM enabled (i.e. all changes reverted)

you mean runtime PM disabled, right ?

Thanks,
Ohad.
