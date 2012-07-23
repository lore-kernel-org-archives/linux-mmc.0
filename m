From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2 1/1] mmc: block: Add write packing control
Date: Mon, 23 Jul 2012 17:52:14 +0530
Message-ID: <CANfBPZ9HF3bHymNOYH1Y-u3RsyZqJfCD0oEGgVN1ikmdjMULzQ@mail.gmail.com>
References: <b09d01655db4d4aa535b9a9d310bc8f9.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <b09d01655db4d4aa535b9a9d310bc8f9.squirrel@www.codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: merez@codeaurora.org
Cc: Chris Ball <cjb@laptop.org>, Muthu Kumar <muthu.lkml@gmail.com>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 23, 2012 at 5:13 PM,  <merez@codeaurora.org> wrote:
> On Wed, July 18, 2012 12:26 am, Chris Ball wrote:
>> Hi,  [removing Jens and the documentation list, since now we're
>> talking about the MMC side only]
>>
>> On Wed, Jul 18 2012, merez@codeaurora.org wrote:
>>> Is there anything else that holds this patch from being pushed to
> mmc-next?
>>
>> Yes, I'm still uncomfortable with the write packing patchsets for a
> couple of reasons, and I suspect that the sum of those reasons means =
that
> we should probably plan on holding off merging it until after 3.6.
>>
>> Here are the open issues; please correct any misunderstandings:
>>
>> With Seungwon's patchset ("Support packed write command"):
>>
>> * I still don't have a good set of representative benchmarks showing
>>   what kind of performance changes come with this patchset.  It seem=
s
> like we've had a small amount of testing on one controller/eMMC part =
combo
> from Seungwon, and an entirely different test from Maya, and the resu=
lts
> aren't documented fully anywhere to the level of describing what the
> hardware was, what the test was, and what the results were before and
> after the patchset.
>
> Currently, there is only one card vendor that supports packed command=
s.
> Following are our sequential write (LMDD) test results on 2 of our ta=
rgets
> (in MB/s):
>                        No packing        packing
> Target 1 (SDR 50MHz)     15               25
> Target 2 (DDR 50MHz)     20               30
>
>>
>> With the reads-during-writes regression:
>>
>> * Venkat still has open questions about the nature of the read
>>   regression, and thinks we should understand it with blktrace befor=
e
> trying to fix it.  Maya has a theory about writes overwhelming reads,=
 but
> Venkat doesn't understand why this would explain the observed
> bandwidth drop.
>
> The degradation of read due to writes is not a new behavior and exist=
s
> also without the write packing feature (which only increases the
> degradation). Our investigation of this phenomenon led us to the
> Conclusion that a new scheduling policy should be used for mobile dev=
ices,
> but this is not related to the current discussion of the write packin=
g
> feature.
>
> The write packing feature increases the degradation of read due to wr=
ite
> since it allows the MMC to fetch many write requests in a row, instea=
d of
> fetching only one at a time.  Therefore some of the read requests wil=
l
> have to wait for the completion of more write requests before they ca=
n be
> issued.

I am a bit puzzled by this claim. One thing I checked carefully when
reviewing write packing patches from SJeon was that the code didn't
plough through a mixed list of reads and writes and selected only
writes.
This section of the code in "mmc_blk_prep_packed_list()", from v8 patch=
set..
<Quote>
+               if (rq_data_dir(cur) !=3D rq_data_dir(next)) {
+                       put_back =3D 1;
+                       break;
+               }
</Quote>

means that once a read is encountered in the middle of write packing,
the packing is stopped at that point and it is executed. Then the next
blk_fetch_request should get the next read and continue as before.

IOW, the ordering of reads and writes is _not_ altered when using
packed commands.
=46or example if there were 5 write requests, followed by 1 read,
followed by 5 more write requests in the request_queue, the first 5
writes will be executed as one "packed command", then the read will be
executed, and then the remaining 5 writes will be executed as one
"packed command". So the read does not have to wait any more than it
waited before (packing feature)

And I requested blktrace to confirm that this is indeed the behaviour.

Your rest of the arguments anyway depend on this assertion, so can you
please clarify this.

>
> To overcome this behavior, the solution would be to stop the write pa=
cking
> when a read request is fetched, and this is the algorithm suggested b=
y the
> write packing control.
>
> Let's also keep in mind that lmdd benchmarking doesn't fully reflect =
the
> real life in which there are not many scenarios that cause massive re=
ad
> and write operations. In our user-common-scenarios tests we saw that =
in
> many cases the write packing decreases the read latency. It can happe=
n in
> cases where the same amount of write requests is fetched with and wit=
hout
> packing. In such a case the write packing decreases the transfer time=
 of
> the write requests and causes the read request to wait for a shorter =
time.
>
>>
>> With Maya's patchset ("write packing control"):
>>
>> * Venkat thinks that HPI should be used, and the number-of-requests
>>   metric is too coarse, and it doesn't let you disable packing at th=
e
> right time, and you're essentially implementing a new I/O scheduler i=
nside
> the MMC subsystem without understanding the root cause for why that's
> necessary.
>
> According to our measurements the stop transmission (CMD12) + HPI is =
a
> heavy operation that may take up to several milliseconds. Therefore, =
a
> massive usage of HPI can cause a degradation of performance.
> In addition, it doesn=92t provide a complete solution for read during=
 write
> since it doesn=92t solve the problem of =93what to do with the interr=
upted
> write request remainder?=94.  That is, a common interrupting read req=
uest
> will usually be followed by another one. If we just continue to write=
 the
> interrupted write request remainder we will probably get another HPI =
due
> to the second read request, so eventually we may end up with lots of =
HPIs
> and write retries. A complete solution will be: stop the current writ=
e,
> change packing mode to non-packing, serve the read request, push back=
 the
> write remainders to the block I/O scheduler and let him schedule them
> again probably after the read burst ends (this requires block layer
> support of course).
>
> Regarding the packing control, there seem to be a confusion since the
> number-of-requests is the trigger for *enabling* the packing (after i=
t was
> disabled), while a single read request disable packing. Therefore, th=
e
> packing is stopped at the right time.
>
> The packing control doesn't add any scheduling policy to the MMC laye=
r.
> The write packing feature is the one changing the scheduling policy b=
y
> fetching many write requests in a row without a delay that allows rea=
d
> requests to come in the middle.
> By disabling the write packing, the write packing control returns the=
 old
> scheduling policy. It causes the MMC to fetch the requests one by one=
,
> thus read requests are served as before.
>
> It is correct that the trigger for enabling the write packing control
> should be adjusted per platform and doesn't give a complete solution.=
 As I
> mentioned above, the complete solution will include the usage of writ=
e
> packing control, a re-insert of the write packed to the scheduler whe=
n a
> read request is fetched and usage of HPI to stop the packing that is
> already transferred.
>
> To summarize -
> We recommend including the write packing in 3.6 due to the following =
reasons:
> 1. It significantly improves the write throughput
> 2. In some of the cases it even decreases the read latency
> 3. The read degradation in simultaneous read-write flows already exis=
t,
> even without this feature
>
> As for the write packing control, it can be included in 3.6 to supply=
 a
> partial solution for the read degradation or we can postpone it to 3.=
7 and
> integrate it as part of the complete solution.
>
> Thanks,
> Maya
>
>>
>> My sense is that there's no way we can solve all of these to
>> satisfaction in the next week (which is when the merge window will
> open), but that by waiting a cycle we might come up with some good an=
swers.
>>
>> What do other people think?  If you're excited about these patchsets=
,
> now would be a fine time to come forward with your benchmarking resul=
ts
> and to help understand the reads-during-writes regression.
>>
