From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v5] mmc: documentation of mmc non-blocking request usage
 and design.
Date: Sat, 9 Jul 2011 21:20:24 +0200
Message-ID: <CAJ0pr1--8VtOaFwB7Lh6SnRVOHpeT-28Ykrv17mCdQjrFz1zzQ@mail.gmail.com>
References: <1309933806-2346-1-git-send-email-per.forlin@linaro.org>
	<4E178AA0.1060603@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35556 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab1GITUZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Jul 2011 15:20:25 -0400
Received: by qwk3 with SMTP id 3so1374458qwk.19
        for <linux-mmc@vger.kernel.org>; Sat, 09 Jul 2011 12:20:24 -0700 (PDT)
In-Reply-To: <4E178AA0.1060603@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, Randy Dunlap <rdunlap@xenotime.net>

Chris, is the non-blocking patchset planned to be merged for 3.1?

James,

On 9 July 2011 00:54, J Freyensee <james_p_freyensee@linux.intel.com> w=
rote:
> On 07/05/2011 11:30 PM, Per Forlin wrote:
>>
>> Documentation about the background and the design of mmc non-blockin=
g.
>> Host driver guidelines to minimize request preparation overhead.
>
> Resending this out on the linux-mmc list since that is what I am subs=
cribed
> to (and I had html format on so original got blocked).
>
> I'd like to make a couple suggestions on the documentation when docum=
enting
> actual function names. =A0In general, really state the name of the fu=
nction.
> =A0See below for issues.
>
point taken.

>> Signed-off-by: Per Forlin<per.forlin@linaro.org>
>> Acked-by: Randy Dunlap<rdunlap@xenotime.net>
>> ---
>> ChangeLog:
>> =A0v2: - Minor updates after proofreading comments from Chris
>> =A0v3: - Minor updates after more comments from Chris
>> =A0v4: - Minor updates after comments from Randy
>> =A0v5: - Fixed one more comment and Acked-by from Randy
>>
>> =A0Documentation/mmc/00-INDEX =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
>> =A0Documentation/mmc/mmc-async-req.txt | =A0 86
>> +++++++++++++++++++++++++++++++++++
>> =A02 files changed, 88 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/mmc/mmc-async-req.txt
>>
>> diff --git a/Documentation/mmc/00-INDEX b/Documentation/mmc/00-INDEX
>> index 93dd7a7..a9ba672 100644
>> --- a/Documentation/mmc/00-INDEX
>> +++ b/Documentation/mmc/00-INDEX
>> @@ -4,3 +4,5 @@ mmc-dev-attrs.txt
>> =A0 =A0 =A0 =A0 =A0- info on SD and MMC device attributes
>> =A0mmc-dev-parts.txt
>> =A0 =A0 =A0 =A0 =A0- info on SD and MMC device partitions
>> +mmc-async-req.txt
>> + =A0 =A0 =A0 =A0- info on mmc asynchronous requests
>> diff --git a/Documentation/mmc/mmc-async-req.txt
>> b/Documentation/mmc/mmc-async-req.txt
>> new file mode 100644
>> index 0000000..b7a52ea
>> --- /dev/null
>> +++ b/Documentation/mmc/mmc-async-req.txt
>> @@ -0,0 +1,86 @@
>> +Rationale
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +How significant is the cache maintenance overhead?
>> +It depends. Fast eMMC and multiple cache levels with speculative ca=
che
>> +pre-fetch makes the cache overhead relatively significant. If the D=
MA
>> +preparations for the next request are done in parallel with the cur=
rent
>> +transfer, the DMA preparation overhead would not affect the MMC
>> performance.
>> +The intention of non-blocking (asynchronous) MMC requests is to min=
imize
>> the
>> +time between when an MMC request ends and another MMC request begin=
s.
>> +Using mmc_wait_for_req(), the MMC controller is idle while dma_map_=
sg and
>> +dma_unmap_sg
>
> if dma_unmap_sg/dma_map_sg are complete functions, please
I'll make it "dma_map_sg() and dma_unmap_sg()"

>>
>> are processing. Using non-blocking MMC requests makes it
>> +possible to prepare the caches for next job in parallel with an act=
ive
>> +MMC request.
>> +
>> +MMC block driver
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The issue_rw_rq() in the MMC block driver is made non-blocking.
>
> Could this be made *_issue_rw_rq() please? =A0When I see 'issue_rw_rq=
()', I
> assume it is referring to an entire function with that name. =A0But I=
 am
> really thinking this is for functions ending with '_issue_rw_rq()', r=
ight?
> =A0Like in mmc_blk_issue_rw_rq()?
>
> Actually, if mmc_blk_issue_rw_rq() is the only function, please just =
use
> this.
I agree.

>>
>> +The increase in throughput is proportional to the time it takes to
>> +prepare (major part of preparations are dma_map_sg and dma_unmap_sg=
)
>> +a request and how fast the memory is. The faster the MMC/SD is
>> +the more significant the prepare request time becomes. Roughly the
>> expected
>> +performance gain is 5% for large writes and 10% on large reads on a=
 L2
>> cache
>> +platform. In power save mode, when clocks run on a lower frequency,=
 the
>> DMA
>> +preparation may cost even more. As long as these slower preparation=
s are
>> run
>> +in parallel with the transfer performance won't be affected.
>> +
>> +Details on measurements from IOZone and mmc_test
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> +
>>
>> +https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfMMC-a=
sync-req
>> +
>> +MMC core API extension
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +There is one new public function mmc_start_req().
>
> Is it really meant mmc_start_req*uest*()? =A0That is what I see in co=
re.c.
>
> Also, is this the actual async API being introduced in this work that=
 is to
> be used by client drivers? =A0I don't see it being exported with
> EXPORT_SYMBOL()/EXPORT_SYMBOL_GPL() like mmc_request_done() is in the
> linux-next tree (and I just recently pulled it because I had to fix m=
y own
> driver bug :-/).
The patches are not merged yet, to be merged for 3.1 (I hope). This
patch https://patchwork.kernel.org/patch/936842 adds the mmc core
stuff.

>>
>> +It starts a new MMC command request for a host. The function isn't
>> +truly non-blocking. If there is on ongoing async request it waits
>> +for completion of that request and starts the new one and returns. =
It
>> +doesn't wait for the new request to complete. If there is no ongoin=
g
>> +request it starts the new request and returns immediately.
>> +
>> +MMC host extensions
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +There are two optional hooks -- pre_req() and post_req() -- that th=
e host
>
> Same here...pre_req()/post_req()...are these functions meant to have
> 'pre_req()' in the name? =A0Please use *_pre_req(). =A0Otherwise, jus=
t state the
> exact function name.
These are members of the mmc_host_ops, added by the same patch.
I can clarify this by writing
+There are two optional members in the mmc_host_ops -- pre_req() and
post_req() -- that the host

>>
>> +driver may implement in order to move work to before and after the =
actual
>> +mmc_request function is called.
>
> If there is only a couple of mmc request functions being referred to =
here,
> please just type it out.
mmc_request is referring to the request member of mmc_host_ops.
I can change it to "mmc_host_ops.request()"

>>
>> In the DMA case pre_req() may do
>> +dma_map_sg() and prepare the DMA descriptor, and post_req runs
>> +the dma_unmap_sg.
>> +
>> +Optimize for the first request
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The first request in a series of requests can't be prepared in para=
llel
>> with
>> +the previous transfer, since there is no previous request.
>> +The argument is_first_req in pre_req() indicates that there is no
>> previous
>
> Minor thing...if 'is_first_req' a function or macro, please add the '=
()' to
> it.
It's the second argument in mmc_host_ops.pre_req()

>
> And please use *_pre_req()/type-out-exact-pre_req() function please.
>>
>> +request. The host driver may optimize for this scenario to minimize
>> +the performance loss. A way to optimize for this is to split the cu=
rrent
>> +request in two chunks, prepare the first chunk and start the reques=
t,
>> +and finally prepare the second chunk and start the transfer.
>> +
>> +Pseudocode to handle is_first_req scenario with minimal prepare ove=
rhead:
>
> Please add a blank line here after the 'Pseduocode' statement. =A0I'm=
 only
> suggesting it because there are blank lines in the pseudo-code itself=
 to
> help improve readability.
I agree.

>>
>> +if (is_first_req&& =A0req->size> =A0threshold)
>> + =A0 /* start MMC transfer for the complete transfer size */
>> + =A0 mmc_start_command(MMC_CMD_TRANSFER_FULL_SIZE);
>> +
>> + =A0 /*
>> + =A0 =A0* Begin to prepare DMA while cmd is being processed by MMC.
>> + =A0 =A0* The first chunk of the request should take the same time
>> + =A0 =A0* to prepare as the "MMC process command time".
>> + =A0 =A0* If prepare time exceeds MMC cmd time
>> + =A0 =A0* the transfer is delayed, guesstimate max 4k as first chun=
k size.
>> + =A0 =A0*/
>> + =A0 =A0prepare_1st_chunk_for_dma(req);
>> + =A0 =A0/* flush pending desc to the DMAC (dmaengine.h) */
>> + =A0 =A0dma_issue_pending(req->dma_desc);
>> +
>> + =A0 =A0prepare_2nd_chunk_for_dma(req);
>> + =A0 =A0/*
>> + =A0 =A0 * The second issue_pending should be called before MMC run=
s out
>> + =A0 =A0 * of the first chunk. If the MMC runs out of the first dat=
a chunk
>> + =A0 =A0 * before this call, the transfer is delayed.
>> + =A0 =A0 */
>> + =A0 =A0dma_issue_pending(req->dma_desc);
>
>
