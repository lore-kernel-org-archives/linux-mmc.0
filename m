From: Minchan Kim <minchan@kernel.org>
Subject: Re: swap on eMMC and other flash
Date: Tue, 10 Apr 2012 09:57:40 +0900
Message-ID: <4F838584.1020002@kernel.org>
References: <201203301744.16762.arnd@arndb.de> <201204061616.11716.arnd@arndb.de> <4F82443F.9000804@kernel.org> <201204091235.48750.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <201204091235.48750.arnd@arndb.de>
Sender: owner-linux-mm@kvack.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, android-kernel@googlegroups.com, linux-mm@kvack.org, "Luca Porzio (lporzio)" <lporzio@micron.com>, Alex Lemberg <alex.lemberg@sandisk.com>, linux-kernel@vger.kernel.org, Saugata Das <saugata.das@linaro.org>, Venkatraman S <venkat@linaro.org>, Yejin Moon <yejin.moon@samsung.com>, Hyojin Jeong <syr.jeong@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

2012-04-09 =EC=98=A4=ED=9B=84 9:35, Arnd Bergmann =EC=93=B4 =EA=B8=80:

> On Monday 09 April 2012, Minchan Kim wrote:
>> 2012-04-07 =EC=98=A4=EC=A0=84 1:16, Arnd Bergmann =EC=93=B4 =EA=B8=80:
>>
>>> larger chunks would generally be helpful, in order to guarantee that =
we
>>> the drive doesn't do any garbage collection, we would have to do all =
writes
>>
>>
>> And we should guarantee for avoiding unnecessary swapout, even OOM kil=
ling.
>>
>>> in aligned chunks. It would probably be enough to do this in 8kb or
>>> 16kb units for most devices over the next few years, but implementing=
 it
>>> for 64kb should be the same amount of work and will get us a little b=
it
>>> further.
>>
>>
>> I understand it's best for writing 64K in your statement.
>> What the 8K, 16K? Could you elaborate relation between 8K, 16K and 64K=
?
>=20
> From my measurements, there are three sizes that are relevant here:
>=20
> 1. The underlying page size of the flash: This used to be less than 4kb=
,
> which is fine when paging out 4kb mmu pages, as long as the partition i=
s
> aligned. Today, most devices use 8kb pages and the number is increasing
> over time, meaning we will see more 16kb page devices in the future and
> presumably larger sizes after that. Writes that are not naturally align=
ed
> multiples of the page size tend to be a significant problem for the
> controller to deal with: in order to guarantee that a 4kb write makes i=
t
> into permanent storage, the device has to write 8kb and the next 4kb
> write has to go into another 8kb page because each page can only be
> written once before the block is erased. At a later point, all the part=
ial
> pages get rewritten into a new erase block, a process that can take
> hundreds of miliseconds and that we absolutely want to prevent from
> happening, as it can block all other I/O to the device. Writing all
> (flash) pages in an erase block sequentially usually avoids this, as
> long as you don't write to many different erase blocks at the same time=
.
> Note that the page size depends on how the controller combines differen=
t
> planes and channels.
>=20
> 2. The super-page size of the flash: When you have multiple channels
> between the controller and the individual flash chips, you can write
> multiple pages simultaneously, which means that e.g. sending 32kb of
> data to the device takes roughly the same amount of time as writing a
> single 8kb page. Writing less than the super-page size when there is
> more data waiting to get written out is a waste of time, although the
> effects are much less drastic as writing data that is not aligned to
> pages because it does not require garbage collection.
>=20
> 3. optimum write size: While writing larger amounts of data in a single
> request is usually faster than writing less, almost all devices
> I've seen have a sharp cut-off where increasing the size of the write
> does not actually help any more because of a bottleneck somewhere
> in the stack. Writing more than 64kb almost never improves performance
> and sometimes reduces performance.


For our understanding, you mean we have to do aligned-write as follows
if possible?

"Nand internal page size write(8K, 16K)" < "Super-page size write(32K)
which considers parallel working with number of channel and plane" <
some sequential big write (64K)

>=20
> From the I've done, a typical profile could look like
>=20
> Size	Throughput
> 1KB	200KB/s
> 2KB	450KB/s
> 4KB	1MB/s
> 8KB	4MB/s		<=3D=3D page size
> 16KB	8MB/s
> 32KB	16MB/s		<=3D=3D superpage size
> 64KB	18MB/s		<=3D=3D optimum size
> 128KB	17MB/s
> ...
> 8MB	18MB/s		<=3D=3D erase block size
>=20
>>> I'm not sure what we would do when there are less than 64kb available
>>> for pageout on the inactive list. The two choices I can think of are
>>> either not writing anything, or wasting the swap slots and filling
>>
>>
>> No wrtite will cause unnecessary many pages to swap out by next prioir=
ty
>> of scanning and we can't gaurantee how long we wait to queue up to 64K=
B
>> in anon pages. It might take longer than GC time so we need some deadl=
ine.
>>
>>
>>> up the data with zeroes.
>>
>>
>> Zero padding would be a good solution but I have a concern on WAP so w=
e
>> need smart policy.
>>
>> To be honest, I think swapout is normally asynchonous operation so tha=
t
>> it should not affect system latency rather than swap read which is
>> synchronous operation. So if system is low memory pressure, we can que=
ue
>> swap out pages up to 64KB and then batch write-out in empty cluster. I=
f
>> we don't have any empty cluster in low memory pressure, we should writ=
e
>> out it in partial cluster. Maybe it doesn't affect system latency
>> severely in low memory pressure.
>=20
> The main thing that can affect system latency is garbage collection
> that blocks any other reads or writes for an extended amount of time.
> If we can avoid that, we've got the 95% solution.


I see.

>=20
> Note that eMMC-4.5 provides a high-priority interrupt mechamism that
> lets us interrupt the a write that has hit the garbage collection
> path, so we can send a more important read request to the device.
> This will not work on other devices though and the patches for this
> are still under discussion.


Nice feature but I think swap system doesn't need to consider such
feature. I should be handled by I/O subsystem like I/O scheduler.

>=20
>> If system memory pressure is high(and It shoud be not frequent),
>> swap-out B/W would be more important. So we can reserve some clusters
>> for it and I think we can use page padding you mentioned in this case
>> for reducing latency if we can queue it up to 64KB within threshold ti=
me.
>>
>> Swap-read is also important. We have to investigate fragmentation of
>> swap slots because we disable swap readahead in non-rotation device. I=
t
>> can make lots of hole in swap cluster and it makes to find empty
>> cluster. So for it, it might be better than enable swap-read in
>> non-rotation devices, too.
>=20
> Yes, reading in up to 64kb or at least a superpage would also help here=
,
> although there is no problem reading in a single cpu page, it will stil=
l
> take no more time than reading in a superpage.
>=20
>>>>> 2) Make variable sized swap clusters. Right now, the swap space is
>>>>> organized in clusters of 256 pages (1MB), which is less than the ty=
pical
>>>>> erase block size of 4 or 8 MB. We should try to make the swap clust=
er
>>>>> aligned to erase blocks and have the size match to avoid garbage co=
llection
>>>>> in the drive. The cluster size would typically be set by mkswap as =
a new
>>>>> option and interpreted at swapon time.
>>>>>
>>>>
>>>> If we can find such big contiguous swap slots easily, it would be go=
od.
>>>> But I am not sure how often we can get such big slots. And maybe we =
have to
>>>> improve search method for getting such big empty cluster.
>>>
>>> As long as there are clusters available, we should try to find them. =
When
>>> free space is too fragmented to find any unused cluster, we can pick =
one
>>> that has very little data in it, so that we reduce the time it takes =
to
>>> GC that erase block in the drive. While we could theoretically do act=
ive
>>> garbage collection of swap data in the kernel, it won't get more effi=
cient
>>> than the GC inside of the drive. If we do this, it unfortunately mean=
s that
>>> we can't just send a discard for the entire erase block.
>>
>>
>> Might need some compaction during idle time but WAP concern raises aga=
in. :(
>=20
> Sorry for my ignorance, but what does WAP stand for?


I should have written more general term. I means write amplication but
WAF(Write Amplication Factor) is more popular. :(

>=20
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--=20
Kind regards,
Minchan Kim

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter=
.ca/
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
