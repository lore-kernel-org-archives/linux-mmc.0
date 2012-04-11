From: Minchan Kim <minchan@kernel.org>
Subject: Re: swap on eMMC and other flash
Date: Wed, 11 Apr 2012 18:54:18 +0900
Message-ID: <20120411095418.GA2228@barrios>
References: <201203301744.16762.arnd@arndb.de>
 <201204091235.48750.arnd@arndb.de>
 <4F838584.1020002@kernel.org>
 <201204100832.52093.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:44889 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2DKJy2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Apr 2012 05:54:28 -0400
Content-Disposition: inline
In-Reply-To: <201204100832.52093.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Minchan Kim <minchan@kernel.org>, linaro-kernel@lists.linaro.org, android-kernel@googlegroups.com, linux-mm@kvack.org, "Luca Porzio (lporzio)" <lporzio@micron.com>, Alex Lemberg <alex.lemberg@sandisk.com>, linux-kernel@vger.kernel.org, Saugata Das <saugata.das@linaro.org>, Venkatraman S <venkat@linaro.org>, Yejin Moon <yejin.moon@samsung.com>, Hyojin Jeong <syr.jeong@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Apr 10, 2012 at 08:32:51AM +0000, Arnd Bergmann wrote:
> On Tuesday 10 April 2012, Minchan Kim wrote:
> > 2012-04-09 =EC=98=A4=ED=9B=84 9:35, Arnd Bergmann =EC=93=B4 =EA=B8=80=
:
>=20
> > >>
> > >> I understand it's best for writing 64K in your statement.
> > >> What the 8K, 16K? Could you elaborate relation between 8K, 16K a=
nd 64K?
> > >=20
> > > From my measurements, there are three sizes that are relevant her=
e:
> > >=20
> > > 1. The underlying page size of the flash: This used to be less th=
an 4kb,
> > > which is fine when paging out 4kb mmu pages, as long as the parti=
tion is
> > > aligned. Today, most devices use 8kb pages and the number is incr=
easing
> > > over time, meaning we will see more 16kb page devices in the futu=
re and
> > > presumably larger sizes after that. Writes that are not naturally=
 aligned
> > > multiples of the page size tend to be a significant problem for t=
he
> > > controller to deal with: in order to guarantee that a 4kb write m=
akes it
> > > into permanent storage, the device has to write 8kb and the next =
4kb
> > > write has to go into another 8kb page because each page can only =
be
> > > written once before the block is erased. At a later point, all th=
e partial
> > > pages get rewritten into a new erase block, a process that can ta=
ke
> > > hundreds of miliseconds and that we absolutely want to prevent fr=
om
> > > happening, as it can block all other I/O to the device. Writing a=
ll
> > > (flash) pages in an erase block sequentially usually avoids this,=
 as
> > > long as you don't write to many different erase blocks at the sam=
e time.
> > > Note that the page size depends on how the controller combines di=
fferent
> > > planes and channels.
> > >=20
> > > 2. The super-page size of the flash: When you have multiple chann=
els
> > > between the controller and the individual flash chips, you can wr=
ite
> > > multiple pages simultaneously, which means that e.g. sending 32kb=
 of
> > > data to the device takes roughly the same amount of time as writi=
ng a
> > > single 8kb page. Writing less than the super-page size when there=
 is
> > > more data waiting to get written out is a waste of time, although=
 the
> > > effects are much less drastic as writing data that is not aligned=
 to
> > > pages because it does not require garbage collection.
> > >=20
> > > 3. optimum write size: While writing larger amounts of data in a =
single
> > > request is usually faster than writing less, almost all devices
> > > I've seen have a sharp cut-off where increasing the size of the w=
rite
> > > does not actually help any more because of a bottleneck somewhere
> > > in the stack. Writing more than 64kb almost never improves perfor=
mance
> > > and sometimes reduces performance.
> >=20
> >=20
> > For our understanding, you mean we have to do aligned-write as foll=
ows
> > if possible?
> >=20
> > "Nand internal page size write(8K, 16K)" < "Super-page size write(3=
2K)
> > which considers parallel working with number of channel and plane" =
<
> > some sequential big write (64K)
>=20
> In the definition I gave above, page size (8k, 16k) would be the only
> one that requires alignment. Writing 64k at an arbitrary 16k alignmen=
t
> should still give us the best performance in almost all cases and
> introduce no extra write amplification, while writing with less than
> page alignment causes significant write amplification and long latenc=
ies.
>=20
> >=20
> > >=20
> > > Note that eMMC-4.5 provides a high-priority interrupt mechamism t=
hat
> > > lets us interrupt the a write that has hit the garbage collection
> > > path, so we can send a more important read request to the device.
> > > This will not work on other devices though and the patches for th=
is
> > > are still under discussion.
> >=20
> >=20
> > Nice feature but I think swap system doesn't need to consider such
> > feature. I should be handled by I/O subsystem like I/O scheduler.
>=20
> Right, this is completely independent of swap. The current implementa=
tion
> of the patch set favours only reads that are done for page-in operati=
ons
> by interrupting any long-running writes when a more important read co=
mes
> in. IMHO we should do the same for any synchronous read, but that dis=
cussion
> is completely orthogonal to having the swap device on emmc.
>=20
> > >>>>> 2) Make variable sized swap clusters. Right now, the swap spa=
ce is
> > >>>>> organized in clusters of 256 pages (1MB), which is less than =
the typical
> > >>>>> erase block size of 4 or 8 MB. We should try to make the swap=
 cluster
> > >>>>> aligned to erase blocks and have the size match to avoid garb=
age collection
> > >>>>> in the drive. The cluster size would typically be set by mksw=
ap as a new
> > >>>>> option and interpreted at swapon time.
> > >>>>>
> > >>>>
> > >>>> If we can find such big contiguous swap slots easily, it would=
 be good.
> > >>>> But I am not sure how often we can get such big slots. And may=
be we have to
> > >>>> improve search method for getting such big empty cluster.
> > >>>
> > >>> As long as there are clusters available, we should try to find =
them. When
> > >>> free space is too fragmented to find any unused cluster, we can=
 pick one
> > >>> that has very little data in it, so that we reduce the time it =
takes to
> > >>> GC that erase block in the drive. While we could theoretically =
do active
> > >>> garbage collection of swap data in the kernel, it won't get mor=
e efficient
> > >>> than the GC inside of the drive. If we do this, it unfortunatel=
y means that
> > >>> we can't just send a discard for the entire erase block.
> > >>
> > >>
> > >> Might need some compaction during idle time but WAP concern rais=
es again. :(
> > >=20
> > > Sorry for my ignorance, but what does WAP stand for?
> >=20
> >=20
> > I should have written more general term. I means write amplication =
but
> > WAF(Write Amplication Factor) is more popular. :(
>=20
> D'oh. Thanks for the clarification. Note that the entire idea of incr=
easing the
> swap cluster size to the erase block size is to *reduce* write amplif=
ication:
>=20
> If we pick arbitrary swap clusters that are part of an erase block (o=
r worse,
> span two partial erase blocks), sending a discard for one cluster doe=
s not
> allow the device to actually discard an entire erase block. Consider =
the best
> possible scenario where we have a 1MB cluster and 2MB erase blocks, a=
ll
> naturally aligned. After we have written the entire swap device once,=
 all
> blocks are marked as used in the device, but some are available for r=
euse
> in the kernel. The swap code picks a cluster that is currently unused=
 and=20
> sends a discard to the device, then fills the cluster with new pages.
> After that, we pick another swap cluster elsewhere. The erase block n=
ow
> contains 50% new and 50% old data and has to be garbage collected, so=
 the
> device writes 2MB of data  to anther erase block. So, in order to wri=
te 1MB,
> the device has written 3MB and the write amplification factor is 3. U=
sing
> 8MB erase blocks, it would be 9.
>=20
> If we do the active compaction and increase the cluster size to the e=
rase
> block size, there is no write amplification inside of the device (and=
 no
> stalls from the garbage collection, which are the other concern), and
> we only need to write a few blocks again that are still valid in a cl=
uster
> at the time we want to reuse it. On an ideal device, the write amplif=
ication
> for active compaction should be exactly the same as what we get when =
we
> write a cluster while some of the data in it is still valid and we sk=
ip
> those pages, while some devices might now like having to gc themselve=
s.
> Doing the compaction in software means we have to spend CPU cycles on=
 it,
> but we get to choose when it happens and don't have to block on the d=
evice
> during GC.

Thanks for detail explanation.
At least, we need active compaction to avoid GC completely when we can'=
t find
empty cluster and there are lots of hole.
Indirection layer we discussed last LSF/MM could help slot change by
compaction easily.
I think way to find empty cluster should be changed because current lin=
ear scan
is not proper for bigger cluster size.

I am looking forward to your works!

P.S) I'm afraid this work might raise endless war, again which host can=
 do well VS
device can do well. If we can work out, we don't need costly eMMC FTL, =
just need
dumb bare nand, controller and simple firmware.

>=20
> 	Arnd
