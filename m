From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: subtract boot sectors from disk size for eMMC 4.3+ devices
Date: Thu, 28 Apr 2011 12:33:46 +0200
Message-ID: <BANLkTinzAzg6ot5bLLjey04Do4ZFT6_5FA@mail.gmail.com>
References: <1299327344-12462-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33751 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758198Ab1D1Kdr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 06:33:47 -0400
Received: by iwn34 with SMTP id 34so2091828iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 03:33:46 -0700 (PDT)
In-Reply-To: <1299327344-12462-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Gary King <gking@nvidia.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Colin Cross <ccross@google.com>, Sebastian Rasmussen <Sebastian.Rasmussen@stericsson.com>

2011/3/5 Linus Walleij <linus.walleij@stericsson.com>:

> This patch is a squash of patches from Gary King and Ulf
> Hansson done in Android trees, hopefully fixing the issue properly.
>
> The csd sector count reported by eMMC 4.3+ cards includes the boot
> partition size; subtract this from the size reported to the disk
> since the boot partition is inaccessible.

I'm trying to get somewhere with this.

AFAICT reading the spec it does not say anything about the
boot sectors being subtracted from the pool of available sectors,
i.e. either you set these sectors aside permanently or you do not
support the feature.

So the behaviour fixed in this patch should be a per-card quirk,
not generic.

Then this:

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* size is in 256K chun=
ks, i.e. 512 sectors each */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 boot_sectors =3D ext_cs=
d[EXT_CSD_BOOT_SIZE_MULTI] * 512;

This is not what the spec says. It states that the size is
in 128KB chunks, so the correct code shoul be:

boot_sectors =3D ext_csd[EXT_CSD_BOOT_SIZE_MULTI] * 256;

Any comments on this? I guess it's been working, the
patch prent in the Android kernels simply remove twice as
many sectors as required from the card sector pool :-/

Yours,
Linus Walleij
