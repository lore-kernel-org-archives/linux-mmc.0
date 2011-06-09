From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 9 Jun 2011 16:51:33 +0100
Message-ID: <BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47531 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab1FIPvd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 11:51:33 -0400
Received: by pwi15 with SMTP id 15so802314pwi.19
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 08:51:33 -0700 (PDT)
In-Reply-To: <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 8 June 2011 21:05, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Please reboot, and immediately after booting (without insmoding the
> driver) tell me what's the output of :
>
> mount -t debugfs none /sys/kernel/debug
> cat /sys/kernel/debug/mmc1/ios
>
> Then insmod the driver, and tell me again what's the output of
> /sys/.../mmc1/ios.

bash-4.1# mount -t debugfs none /sys/kernel/debug
bash-4.1# cat /sys/kernel/debug/mmc1/ios
clock:		0 Hz
vdd:		0 (invalid)
bus mode:	1 (open drain)
chip select:	0 (don't care)
power mode:	0 (off)
bus width:	0 (1 bits)
timing spec:	0 (legacy)
bash-4.1# insmod /media/4E11-1D7C/libertas_sdio.ko
[   67.917748] libertas_sdio: Libertas SDIO driver
[   67.922976] libertas_sdio: Copyright Pierre Ossman
[   67.972073] libertas_sdio: probe of mmc1:0001:1 failed with error -16
bash-4.1# cat /sys/kernel/debug/mmc1/ios
clock:		400000 Hz
vdd:		21 (3.3 ~ 3.4 V)
bus mode:	1 (open drain)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	0 (1 bits)
timing spec:	0 (legacy)

> Please send a contiguous terminal session of these steps (incl. the
> boot messages), thanks !

Full log: http://dev.laptop.org/~dsd/20110609/sd-pwr-debug1.txt

Thanks
Daniel
