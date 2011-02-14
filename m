From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Mon, 14 Feb 2011 16:25:48 -0600
Message-ID: <AANLkTinPtiwXmtRy9qS2zZXwuhQDOyO-H8-wmF=fSNnJ@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102131839.08517.arnd@arndb.de>
	<AANLkTin=bkzvdQXoWUKRfX8Xs=4bXnxWf88TUG+VvjPD@mail.gmail.com>
	<201102142122.54766.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og101.obsmtp.com ([64.18.0.141]:60302 "EHLO
	exprod5og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1BNW2o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 17:28:44 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p1EMRh53017966
	for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2011 17:27:43 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p1EMM0s7015619
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2011 17:27:43 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 11so4203977vws.15
        for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2011 14:28:43 -0800 (PST)
In-Reply-To: <201102142122.54766.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Mon, Feb 14, 2011 at 2:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> As I mentioned, I am checking with T right now on whether we can use
>> suggestion (1) or
>> suggestion (2) or if they need to be combined. The documentation we
>> got was open to interpretation and the patch created from that did
>> both.
>> You mentioned that writing in reverse is not a good idea. Could you
>> elaborate why? I would guess because you're always causing a write
>> into a different AU (on these Toshiba cards), causing extra GC on
>> every write?
>
> Probably both the reliable write and writing small blocks in reverse
> order will cause any card to do something that is different from
> what it does on normal 64kb (or larger) aligned accesses.
>
> There are multiple ways how this could be implemented:
>
> 1. Have one exception cache for all "special" blocks. This would norm=
ally
> =A0 be for FAT32 subdirectory updates, which always write to the same
> =A0 few blocks. This means you can do small writes efficiently anywhe=
re
> =A0 on the card, but only up to a (small) fixed number of block addre=
sses.
> =A0 If you overflow the table, the card still needs to go through an
> =A0 extra PE for each new entry you write, in order to free up an ent=
ry.
>
> 2. Have a small number of AUs that can be in a special mode with effi=
cient
> =A0 small writes but inefficient large writes. This means that when y=
ou
> =A0 alternate between small and large writes in the same AU, it has t=
o go
> =A0 through a PE on every switch. Similarly, if you do small writes t=
o
> =A0 more than the maximum number of AUs that can be held in this mode=
, you
> =A0 get the same effect. This number can be as small as one, because =
that
> =A0 is what FAT32 requires.
>
> In both cases, you don't actually have a solution for the problem, yo=
u just
> make it less likely for specific workloads.

Aha, ok. By the way, I did find out that either suggestion works. So
I'll pull out the reversing portion of the patch. No need to
overcomplicate :).
