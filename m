From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 9 Jun 2011 18:59:02 +0300
Message-ID: <BANLkTimg08VnOMrUwnH6dKzXPJO1fpOh6w@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com> <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
 <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com> <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
 <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com> <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
 <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com> <BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56266 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab1FIP7X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 11:59:23 -0400
Received: by wwa36 with SMTP id 36so1856610wwa.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 08:59:22 -0700 (PDT)
In-Reply-To: <BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, Jun 9, 2011 at 6:51 PM, Daniel Drake <dsd@laptop.org> wrote:
> bash-4.1# mount -t debugfs none /sys/kernel/debug
> bash-4.1# cat /sys/kernel/debug/mmc1/ios
> clock: =A0 =A0 =A0 =A0 =A00 Hz
> vdd: =A0 =A0 =A0 =A0 =A0 =A00 (invalid)
> bus mode: =A0 =A0 =A0 1 (open drain)
> chip select: =A0 =A00 (don't care)
> power mode: =A0 =A0 0 (off)
> bus width: =A0 =A0 =A00 (1 bits)
> timing spec: =A0 =A00 (legacy)
> bash-4.1# insmod /media/4E11-1D7C/libertas_sdio.ko
> [ =A0 67.917748] libertas_sdio: Libertas SDIO driver
> [ =A0 67.922976] libertas_sdio: Copyright Pierre Ossman
> [ =A0 67.972073] libertas_sdio: probe of mmc1:0001:1 failed with erro=
r -16
> bash-4.1# cat /sys/kernel/debug/mmc1/ios
> clock: =A0 =A0 =A0 =A0 =A0400000 Hz
> vdd: =A0 =A0 =A0 =A0 =A0 =A021 (3.3 ~ 3.4 V)
> bus mode: =A0 =A0 =A0 1 (open drain)
> chip select: =A0 =A00 (don't care)
> power mode: =A0 =A0 2 (on)
> bus width: =A0 =A0 =A00 (1 bits)
> timing spec: =A0 =A00 (legacy)

Ok, cool.

Now can you please repeat this, but this time add your original patch
(which only added the CMD5 arg=3D0 cmd, no sdio reset yet) ?

Thanks,
Ohad.
