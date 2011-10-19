From: Praveen G K <praveen.gk@gmail.com>
Subject: Re: slow eMMC write speed
Date: Wed, 19 Oct 2011 16:27:02 -0700
Message-ID: <CAHzg1A9swGoYy8fE6ULw8WprJQvURQNWHhOZ9vywgrONT9RDpw@mail.gmail.com>
References: <1680748273.3852.1317673156420.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<4E8A2275.3050009@linux.intel.com>
	<CANz0V+5HGJpNkoHMmsAupCcCK3tG74Jza=rmZQxjv3pwMWKSuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53999 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897Ab1JSX1E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2011 19:27:04 -0400
Received: by bkbzt19 with SMTP id zt19so2759687bkb.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2011 16:27:03 -0700 (PDT)
In-Reply-To: <CANz0V+5HGJpNkoHMmsAupCcCK3tG74Jza=rmZQxjv3pwMWKSuA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Cc: J Freyensee <james_p_freyensee@linux.intel.com>, Andrei Warkentin <awarkentin@vmware.com>, =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>

Also, can somebody please tell me the significance of blk_end_request? =
Thanks.
Why do we call this after every block read or write?

2011/10/4 Andrei E. Warkentin <andrey.warkentin@gmail.com>
>
> Hi James,
>
> 2011/10/3 J Freyensee <james_p_freyensee@linux.intel.com>:
> >
> > The idea is the page cache is too generic for hand-held (i.e. Andro=
id)
> > workloads. =A0Page cache handles regular files, directories, user-s=
wappable
> > processes, etc, and all of that has to contend with the resource av=
ailable
> > for the page cache. =A0This is specific to eMMC workloads. =A0Namel=
y, for games
> > and even .pdf files on an Android system (ARM or Intel), there are =
a lot of
> > 1-2 sector writes and almost 0 reads.
> >
> > But by no means am I an expert on the page cache area either.
> >
>
> I misspoke, sorry, I really meant the buffer cache, which caches bloc=
k
> access. It may contend
> with other resources, but it is practically boundless and responds
> well to memory pressure (which
> otherwise is something you need to consider).
>
> As to Android workloads, what you're really trying to say, is that
> you're dealing with a tumult of SQLite accesses,
> and coupled with ext4 these don't look so good when it comes down to
> MMC performance and reliability, right? When
> I investigated this problem in my previous life, it came down to
> figuring out if it was worth putting vendor hacks in the MMC driver
> to purportedly reduce a drastic reduction in reliability/life-span,
> while also improving performance for accesses smaller than flash page
> size.
>
> The problem being, of course that you have many small random accesses=
, which -
> a) Chew through a fixed amount of erase-block (AU, allocation unit)
> slots in the internal (non-volatile) cache on the MMC.
> b) As a consequence of (a) result in much thrashing, as erase-block
> slot evictions result in (small) writes, which result in extra erases=
=2E
> c) The accesses could also end up spanning erase-blocks which further
> multiplies the performance and life-span damage.
>
> The hacks I was investigating actually made things worse performance
> wise, and there was no way to measure reliability. I did realize that
> you could, under some circumstances, and with some idea behind the GC
> behavior of MMCs and it's flash parameters, devise an I/O scheduler
> that would optimize accesses by grouping AUs and trying to defer
> writing AUs which are being actively written to. Of course this would
> be in no way generic, and would involve fine tuning on a per-card
> basis, making it useful for eMMC/eSD.
>
> Caching by itself =A0might save you some trouble from many writes to
> similar places, but you can already tune the buffer cache to delay
> writes
> (/proc/sys/vm/dirty_writeback_centisec), and it's not going to help
> with the fixed amount of AUs and preferences to a particular size of
> writes (i.e. the garbage collection mechanism inside the MMC and the
> flash technology in it). On the other hand, caching brings another se=
t
> of problems - data loss, and the occasional need to flush all data to
> disk, with a larger delay.
>
> Speaking of reducing flash traffic...you might be interested with
> bumping the commit time (ext3/ext4), but that also has data-loss
> implications.
>
> Anyway, the point I want to make, is that you should ask yourself the
> question of what you're trying to achieve, and what the real problem
> is - and why existing solutions don't work. If you think caching is
> your problem, then you should probably answer the question of why the
> buffer cache isn't sufficient - and if it isn't, how should it adapt
> to fit the scenario. I would want to say that the real fix should be
> the I/O happy SQLite usage on Android... But there may be some value
> in trying to alleviate in by grouping writes by AUs and deferring
> "hot" AUs.
>
> A
