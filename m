From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Hang on Suspend to RAM with 2.6.36-rc4
Date: Wed, 29 Sep 2010 18:24:51 -0700
Message-ID: <871v8cm3a4.fsf@deeprootsystems.com>
References: <AANLkTikaTRJpZ=twcCxPvqQLOHBWsS5zyzgDwEWVbe-6@mail.gmail.com>
	<87r5gwhqsm.fsf@deeprootsystems.com>
	<AANLkTimenb8mB6sD+b1DKasoKk64-RBsBF6t5yrnndrP@mail.gmail.com>
	<AANLkTinsbOD2Yy84dk+WyMrvAnozzoY_PjeHoxnfNLXb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42456 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab0I3BYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2010 21:24:54 -0400
In-Reply-To: <AANLkTinsbOD2Yy84dk+WyMrvAnozzoY_PjeHoxnfNLXb@mail.gmail.com>
	(Laine Walker-Avina's message of "Wed, 29 Sep 2010 17:01:30 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laine Walker-Avina <lwalkera@pasco.com>
Cc: linux-omap@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, linux-mmc@vger.kernel.org

Laine Walker-Avina <lwalkera@pasco.com> writes:

> On Wed, Sep 22, 2010 at 3:21 PM, Laine Walker-Avina <lwalkera@pasco.c=
om> wrote:
>> On Tue, Sep 14, 2010 at 4:02 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Laine Walker-Avina <lwalkera@pasco.com> writes:
>>>
>>>> I just pulled the latest changes today from the linux-omap git tre=
e,
>>>> and something appears to have broken suspend to RAM on my OMAP3503
>>>> board.
>>>
>>> Is this on the master branch? =A0What defconfig? =A0When was this l=
ast
>>> working for you? =A0-rc3?
>> Yes, on the master branch. I'm using my own config. It was working o=
n
>> 2.6.35 or so. I tried backporting my board patches to 2.6.36 and it
>> fails there too now for some reason. It might be the SD card, I'll
>> have to find another one and try it out.
>>>
>>> Looks like you may have your rootfs on MMC. =A0Do you have
>>> CONFIG_MMC_UNSAFE_RESUME=3Dy in your .config?
>> No

[...]

>
> This appears to be caused by commit 4c2ef25f (mmc: fix all hangs
> related to mmc/sd card insert/removal during suspend/resume). Enablin=
g
> CONFIG_MMC_UNSAFE_RESUME seems to fix it.=20

Good.

> Ideally, it would be nice to have the root file-system on a mmc
> regardless of whether or not it's removable or not.

You'll have to take that one up with the MMC core.

I'm sure they would welcome patches to fix it. ;)

Kevin

