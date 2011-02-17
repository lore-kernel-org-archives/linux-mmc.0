From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Wed, 16 Feb 2011 20:08:56 -0600
Message-ID: <AANLkTimoqCtWMmBJ40v+1UjR0U2Sdh9pp+2fwYpi3fUx@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102142122.54766.arnd@arndb.de>
	<AANLkTinPtiwXmtRy9qS2zZXwuhQDOyO-H8-wmF=fSNnJ@mail.gmail.com>
	<201102151816.57104.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:50530 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497Ab1BQCI6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 21:08:58 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p1H27sIv015421
	for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 21:07:54 -0500 (EST)
Received: from mail-qy0-f170.google.com (mail-qy0-f170.google.com [209.85.216.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p1H27RFc015265
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 21:07:54 -0500 (EST)
Received: by mail-qy0-f170.google.com with SMTP id 10so4567903qyk.15
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 18:08:56 -0800 (PST)
In-Reply-To: <201102151816.57104.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Tue, Feb 15, 2011 at 11:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 14 February 2011, Andrei Warkentin wrote:
>> > There are multiple ways how this could be implemented:
>> >
>> > 1. Have one exception cache for all "special" blocks. This would n=
ormally
>> > =A0 be for FAT32 subdirectory updates, which always write to the s=
ame
>> > =A0 few blocks. This means you can do small writes efficiently any=
where
>> > =A0 on the card, but only up to a (small) fixed number of block ad=
dresses.
>> > =A0 If you overflow the table, the card still needs to go through =
an
>> > =A0 extra PE for each new entry you write, in order to free up an =
entry.
>> >
>> > 2. Have a small number of AUs that can be in a special mode with e=
fficient
>> > =A0 small writes but inefficient large writes. This means that whe=
n you
>> > =A0 alternate between small and large writes in the same AU, it ha=
s to go
>> > =A0 through a PE on every switch. Similarly, if you do small write=
s to
>> > =A0 more than the maximum number of AUs that can be held in this m=
ode, you
>> > =A0 get the same effect. This number can be as small as one, becau=
se that
>> > =A0 is what FAT32 requires.
>> >
>> > In both cases, you don't actually have a solution for the problem,=
 you just
>> > make it less likely for specific workloads.
>>
>> Aha, ok. By the way, I did find out that either suggestion works. So
>> I'll pull out the reversing portion of the patch. No need to
>> overcomplicate :).
>
> BTW, what file system are you using? I could imagine that each of ext=
4, btrfs
> and nilfs2 give you very different results here. It could be that if =
your
> patch is optimizing for one file system, it is actually pessimising f=
or
> another one.
>

Ext4. I've actually been rewriting the patch a lot and it's taking
time because there are a lot of things that are wrong in it (so I feel
kinda bad for forwarding it to this list in the first place...). I've
already mentioned that there is no need to reorder, so that's going
away and it simplifies everything greatly.

I agree, which is why all of this is controlled now through sysfs, and
there are no more hard-coded checks for manfid, mmc versus sd or any
other magic. There is a page_size_secs attribute, through which you
can notify of the page size for the device. The workaround for small
writes crossing the page boundary (and winding up in Buffer B, instead
of A) is turned on by setting split_tlow and split_thigh, which
provided a threshold range in sectors over which the the writes will
be split/aligned. The second workaround for splitting larger requests
and writing them with reliable write (to avoid getting coalesced and
winding up in Buffer B again) is controlled through split_relw_tlow
and split_relw_thigh. Do you think there is a better way? Or is this
good enough?

So, as I mentioned before, T had done some tests given data provided
by M, and then T verified that this fix was good. I need to do my own
tests on the patch after I rewrite it. Is iozone the best tool I can
use? So far I have a MMC logging facility through connector that I use
to collect stats (useful for seeing how fs traffic translates to
actual mmc commands...once I clean it up I'll push here for RFC). What
about the tool you're writing? Any way I can use it?
