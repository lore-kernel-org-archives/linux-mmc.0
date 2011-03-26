From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [comments] MMC: Reliable write support.
Date: Sat, 26 Mar 2011 02:22:40 -0500
Message-ID: <AANLkTiksZE_bE2nUXf+OtLpBA7giF-0KGWahbsEBar6O@mail.gmail.com>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com>
	<1301001751-30785-2-git-send-email-andreiw@motorola.com>
	<201103251614.29893.arnd@arndb.de>
	<AANLkTik4tXB1eix+Ej10yQudo8zBUxJdgXdPUaS9HJQb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:33840 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab1CZHWo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Mar 2011 03:22:44 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2Q7N1vN029258
	for <linux-mmc@vger.kernel.org>; Sat, 26 Mar 2011 03:23:01 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2Q7MxlY029238
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 26 Mar 2011 03:23:00 -0400 (EDT)
Received: by wwb28 with SMTP id 28so2035110wwb.3
        for <linux-mmc@vger.kernel.org>; Sat, 26 Mar 2011 00:22:40 -0700 (PDT)
In-Reply-To: <AANLkTik4tXB1eix+Ej10yQudo8zBUxJdgXdPUaS9HJQb@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Sat, Mar 26, 2011 at 2:17 AM, Andrei Warkentin <andreiw@motorola.com=
> wrote:
> Hi Arnd,
>
> On Fri, Mar 25, 2011 at 10:14 AM, Arnd Bergmann <arnd@arndb.de> wrote=
:
>> On Thursday 24 March 2011, Andrei Warkentin wrote:
>>>
>>> Beyond REQ_FUA/REQ_META, this was meant to be used by a following p=
atch that aimed
>>> to reduce write amplification issues in cards employing a small (us=
ually flash page-sized)
>>> buffer and a large (usually erase-block sized) buffer, at the expen=
se of performance.
>>
>> Looks good to me, but I don't really understand some of the block la=
yer
>> specifics here. One question:
>> How does this work when you have a flush that does not directly foll=
ow
>> a REQ_FUA or REQ_META request? I would assume that we still need to
>> flush in some way, which you don't seem to do here.
>
> In much the same way as before - REQ_FLUSH does nothing as it did
> nothing before. The only reason I'm handing REQ_FLUSH, is because you
> can't register for REQ_FUA without registering for REQ_FLUSH, which
> does make sense - after all, if REQ_FUA is used to ensure data is
> committed immediately, then by default it isn't, and you need a flush
> operation if you want to commit the data at a particular checkpoint
> You are correct in stating that it is a likely issue, but it is an
> issue even without this patch. =A0Unfortunately, there is nothing (th=
at
> I saw) in the latest JEDEC MMC specification that says how a card's
> internal buffers might be forced to be flushed to non-volatile
> storage. Clearly, any recent card which tries to play optimization
> games in order to reduce write amplification and flash wearing is
> going to have an internal buffer, so the inability to handle REQ_FLUS=
H
> is already a potential issue for these cards.
>
> Looking at the 4.41 JEDEC spec, CMD0, CMD15 and hardware reset are al=
l
> non-ways to ensure flush. In fact they will terminate the programming
> operation resulting in an unknown state.
>
> I'm working with a flash vendor to see if I missed something or if
> there is some way to flush internal buffers, and if that way is
> generic enough to apply to all cards.
>
> A
>

Sorry, I totally forgot to add. REQ_FLUSH means - flush all write back
caches internal to the disk hardware.

A
