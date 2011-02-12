From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sat, 12 Feb 2011 11:33:10 -0600
Message-ID: <AANLkTikxMKm-Xy5du2+MzrD2eLuvfO9hXrSzBKmAkdBm@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102091013.56670.arnd@arndb.de>
	<AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
	<201102121805.47311.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:58928 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab1BLRdO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 12:33:14 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1CHXNBd016784
	for <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 12:33:23 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1CHXM2v016778
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 12:33:23 -0500 (EST)
Received: by vws11 with SMTP id 11so2632621vws.15
        for <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 09:33:10 -0800 (PST)
In-Reply-To: <201102121805.47311.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Sat, Feb 12, 2011 at 11:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 11 February 2011 23:33:42 Andrei Warkentin wrote:
>> On Wed, Feb 9, 2011 at 3:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Yes, this is a Toshiba card. I've sent the patch as a reply to Linus=
' email.
>>
>> cid - 02010053454d3332479070cc51451d00
>> csd - d00f00320f5903ffffffffff92404000
>> erase_size - 524288
>> fwrev - 0x0
>> hwrev - 0x0
>> manfid - 0x000002
>> name - SEM32G
>> oemid - 0x0100
>> preferred_erase_size - 2097152
>
> Very interesting. So the manfid is the same as on most Kingston cards=
,
> but the oemid is different. Most cards have a two-letter ASCII code
> in there, 0x544d ("TM") on Kingston cards, and I always assumed that
> this stood for "Toshiba Memory".
>
> What is even stranger is the size value (among other fields) in the C=
SD,
> the card claims a size of exactly 32GB, which I find hard to believe,
> given that there are always some bad and reserved blocks.
>
> Are you sure that the card you have is authentic? I've heard a lot ab=
out
> fake USB sticks advertising a size that is much larger than the actua=
l
> flash inside of them.
>
> Also this is the first card that I see advertise an allocation unit
> size of 2MB (preferred_erase_size), all other cards seem to advertise
> 4 MB these days, even if they actually have 2 or 8 MB.
>
> =A0 =A0 =A0 =A0Arnd
>

This is a Toshiba eMMC part. It is 32GB as far as the OS can see and ac=
cess.
