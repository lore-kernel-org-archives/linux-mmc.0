From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: SDIO wifi card works with 2.6.36, not with 3.2
Date: Sat, 26 Nov 2011 09:02:55 +0800
Message-ID: <4ED03ABF.5070604@gmail.com>
References: <CANN7TQkp4t2rhfS=LM38TSUdrp2pE7d0VX_t36AjiEEqayqNmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55001 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254Ab1KZBDO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2011 20:03:14 -0500
Received: by bke11 with SMTP id 11so5063708bke.19
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2011 17:03:13 -0800 (PST)
In-Reply-To: <CANN7TQkp4t2rhfS=LM38TSUdrp2pE7d0VX_t36AjiEEqayqNmQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?VGhvbWFzIExhbmfDpXM=?= <thomas.langaas@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi

I am not sure if this is the root cause. by revert this commit.[1]
our SDIO ks7010 wifi card work again in linux 3.0.

check out this emails, under mailing list:
   SDIO single IRQ optimization breaks libertas
   http://permalink.gmane.org/gmane.linux.kernel.mmc/8338


[1]
Revert "mmc: sdio: optimized SDIO IRQ handling for single irq"
This reverts commit 06e8935febe687e2a561707d4c7ca4245d261dbe.



On 11/26/2011 06:26 AM, Thomas Lang=C3=A5s wrote:
> I have a slightly weird problem; I have an Samsung Exynos 4210 with a=
n BCM4329
> wifi-chip connected through the MMC-bus using SDIO.
>
> This setup works fine with 2.6.35.7 Android-kernel, but not with
> 3.2-rc1 (non-Android).
>
> CMD52 read/write works correctly, but CMD53 only works with reads. Al=
l CMD53
> writes fails.
>
> Here's an example output of the errorlog:
> [  267.175000] brcmf_sdioh_request_word: rw=3D1, func=3D1, addr=3D0x0=
bf98, nbytes=3D4
> [  267.175000] mmc1: starting CMD53 arg 957f3004 flags 000001b5
> [  267.175000] mmc1:     blksz 4 blocks 1 flags 00000100 tsac 1000 ms=
 nsac 0
> [  267.175000] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x0020800=
3
> [  267.175000] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 =
00000000
> [  267.175000] mmc1:     0 bytes transferred: -84
>
> I've checked the setup registers (pad-controlls to see that all pads
> are set to mmc
> instead of gpio, and mmc registers).  All are identical on Android an=
d
> non-Android,
> so it doesn'tseem like the problem is there at least.
>
> Any ideas on how to proceed with locating the problem?
>


