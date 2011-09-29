From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: slow eMMC write speed
Date: Thu, 29 Sep 2011 13:16:10 -0700
Message-ID: <4E84D20A.4040707@linux.intel.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com> <CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com> <CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com> <4E837C89.9020109@linux.intel.com> <CAHzg1A8Cgz8DNje_We9MKJ90E4=9BDw9XzvEQU5h2et8HPHBjw@mail.gmail.com> <4E838B43.5090605@linux.intel.com> <CAHzg1A-wa0Gm2jXrU6q3L7-NBzQQJmZszraDsfs-Dgb8F6gT6w@mail.gmail.com> <4E839302.5020001@linux.intel.com> <CACRpkdYdrfhFSfLh=Zgjox60KbYCqN+n_WdOaP2sv_mhai+iig@mail.gmail.com> <4E84297C.3060408@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58958 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755709Ab1I2UIn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Sep 2011 16:08:43 -0400
In-Reply-To: <4E84297C.3060408@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Praveen G K <praveen.gk@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>

On 09/29/2011 01:17 AM, Per F=F6rlin wrote:
> On 09/29/2011 09:24 AM, Linus Walleij wrote:
>> On Wed, Sep 28, 2011 at 11:34 PM, J Freyensee
>> <james_p_freyensee@linux.intel.com>  wrote:
>>
>>> Now in the 3.0 kernel I know mmc_wait_for_req() has changed and the=
 goal was
>>> to try and make that function a bit more non-blocking,
>>
>> What has been done by Per F=F6rlin is to add pre_req/post_req hooks
>> for the datapath. This will improve data transfers in general if and
>> only if the driver can do some meaningful work in these hooks, so
>> your driver needs to be patched to use these.
>>
>> Per patched a few select drivers to prepare the DMA buffers
>> at this time. In our case (mmci.c) dma_map_sg() can be done in
>> parallel with an ongoing transfer.
>>
>> In our case (ux500, mmci, dma40) we don't have bounce buffers
>> so the only thing that will happen in parallel with ongoing transfer=
s
>> is L2 and L1 cache flush. *still* we see a noticeable improvement in
>> throughput, most in L2, but even on the U300 which only does L1
>> cache I see some small improvements.
>>
>> I *guess* if you're using bounce buffers, the gain will be even
>> more pronounced.
>>
>> (Per, correct me if I'm wrong on any of this...)
>>
> Summary:
> * The mmc block driver runs mmc_blk_rw_rq_prep(), mmc_queue_bounce_po=
st() and __blk_end_request() in parallel with an ongoing mmc transfer.
> * The driver may use the hooks to schedule low level work such as pre=
paring dma and caches in parallel with ongoing mmc transfer.
> * The big benefit of this is when using DMA and running the CPU at a =
lower speed. Here's an example of that: https://wiki.linaro.org/Working=
Groups/Kernel/Specs/StoragePerfMMC-async-req#Block_device_tests_with_go=
vernor
>
>
>>> with it too much because my current focus is on existing products a=
nd no
>>> handheld product uses a 3.0 kernel yet (that I am aware of at least=
).
>>>   However, I still see the fundamental problem is that the MMC stac=
k, which
>>> was probably written with the intended purpose to be independent of=
 the OS
>>> block subsystem (struct request and other stuff), really isn't inde=
pendent
>>> of the OS block subsystem and will cause holdups between one anothe=
r,
>>> thereby dragging down read/write performance of the MMC.
>>
>> There are two issues IIRC:
>>
>> - The block layer does not provide enough buffers at a time for
>>    the out-of-order buffer pre/post preps to make effect, I think th=
is
>>    was during writes only (Per, can you elaborate?)

As I've been playing around with with buffering/caching, it seems to me=
=20
an opportunity to simplify things in the MMC space is to eliminate the=20
need for a mmc_blk_request struct or mmc_request struct.  With looking=20
through the mmc_blk_issue_rw_rq(), there is a lot of work to initialize=
=20
struct mmc_blk_request brq, only to pass a struct mmc_queue variable th=
e=20
actual mmc_wait_for_req() instead.  In fact, some of the parameters in=20
the struct mmc_blk_request member brq.mrq (of type mmc_request) wind up=
=20
just pointing to members in struct mmc_blk_request brq.  Granted, I=20
totally don't understand everything going on here and I haven't studied=
=20
this code nearly as long as others, but when I see something like this,=
=20
the first thing that comes up in my mind is 'elimination/simplification=
=20
opportunity'.

>>
> Writes are buffered and pushed down many in one go. This mean they ca=
n easily be scheduled to be prepared while another is being transferred=
=2E
> Large continues reads are pushed down to MMC synchronously one reques=
t per read ahead size. The next large continues read will wait in the b=
lock layer and not start until the current one is complete. Read more a=
bout the details here: https://wiki.linaro.org/WorkingGroups/Kernel/Spe=
cs/StoragePerfMMC-async-req#Analysis_of_how_block_layer_adds_read_reque=
st_to_the_mmc_block_queue
>
>> - Anything related to card geometries and special sectors and
>>    sector sizes etc, i.e. the stuff that Arnd has analyzed in detail=
,
>>    also Tixy looked into that for some cards IIRC.
>>
>> Each needs to be adressed and is currently "to be done".
>>
>>> The other fundamental problem is the writes themselves.  Way, WAY m=
ore
>>> writes occur on a handheld system in an end-user's hands than reads=
=2E
>>> Fundamental computer principle states "you make the common case fas=
t". So
>>> focus should be on how to complete a write operation the fastest wa=
y
>>> possible.
>>
>> First case above I think, yep it needs looking into...
>>
> The mmc non-blocking patches only tries to move any overhead in paral=
lel with transfer. The actual transfer speed of MMC reads and writes ar=
e unaffected. I am hoping that the eMMC v4.5 packed commands support (t=
he ability to group a series of commands in a single data transaction) =
will help to boost the performance in the future.
>
> Regards,
> Per


--=20
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
