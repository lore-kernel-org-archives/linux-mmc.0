From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [comments] MMC: Reliable write support.
Date: Sat, 26 Mar 2011 02:17:54 -0500
Message-ID: <AANLkTik4tXB1eix+Ej10yQudo8zBUxJdgXdPUaS9HJQb@mail.gmail.com>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com>
	<1301001751-30785-2-git-send-email-andreiw@motorola.com>
	<201103251614.29893.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:59185 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab1CZHR7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Mar 2011 03:17:59 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2Q7IFfc028983
	for <linux-mmc@vger.kernel.org>; Sat, 26 Mar 2011 03:18:15 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2Q7IEl2028980
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 26 Mar 2011 03:18:15 -0400 (EDT)
Received: by wyb34 with SMTP id 34so2007486wyb.15
        for <linux-mmc@vger.kernel.org>; Sat, 26 Mar 2011 00:17:55 -0700 (PDT)
In-Reply-To: <201103251614.29893.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

Hi Arnd,

On Fri, Mar 25, 2011 at 10:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 24 March 2011, Andrei Warkentin wrote:
>>
>> Beyond REQ_FUA/REQ_META, this was meant to be used by a following patch that aimed
>> to reduce write amplification issues in cards employing a small (usually flash page-sized)
>> buffer and a large (usually erase-block sized) buffer, at the expense of performance.
>
> Looks good to me, but I don't really understand some of the block layer
> specifics here. One question:
> How does this work when you have a flush that does not directly follow
> a REQ_FUA or REQ_META request? I would assume that we still need to
> flush in some way, which you don't seem to do here.

In much the same way as before - REQ_FLUSH does nothing as it did
nothing before. The only reason I'm handing REQ_FLUSH, is because you
can't register for REQ_FUA without registering for REQ_FLUSH, which
does make sense - after all, if REQ_FUA is used to ensure data is
committed immediately, then by default it isn't, and you need a flush
operation if you want to commit the data at a particular checkpoint
You are correct in stating that it is a likely issue, but it is an
issue even without this patch.  Unfortunately, there is nothing (that
I saw) in the latest JEDEC MMC specification that says how a card's
internal buffers might be forced to be flushed to non-volatile
storage. Clearly, any recent card which tries to play optimization
games in order to reduce write amplification and flash wearing is
going to have an internal buffer, so the inability to handle REQ_FLUSH
is already a potential issue for these cards.

Looking at the 4.41 JEDEC spec, CMD0, CMD15 and hardware reset are all
non-ways to ensure flush. In fact they will terminate the programming
operation resulting in an unknown state.

I'm working with a flash vendor to see if I missed something or if
there is some way to flush internal buffers, and if that way is
generic enough to apply to all cards.

A
