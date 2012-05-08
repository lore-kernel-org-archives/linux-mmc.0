From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCHv2 00/16] [FS, MM, block, MMC]: eMMC High Priority
 Interrupt Feature
Date: Tue, 8 May 2012 22:01:06 +0530
Message-ID: <CANfBPZ-d-0FqY8Gruv+KDNoL3+FoQ68JEnxya5PydhY80x8yhA@mail.gmail.com>
References: <1336054995-22988-1-git-send-email-svenkatr@ti.com> <4FA8CF5E.1070202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:46441 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755762Ab2EHQba convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 May 2012 12:31:30 -0400
Received: by bkcji2 with SMTP id ji2so4796052bkc.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 May 2012 09:31:28 -0700 (PDT)
In-Reply-To: <4FA8CF5E.1070202@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Minchan Kim <minchan@kernel.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, alex.lemberg@sandisk.com, ilan.smith@sandisk.com, lporzio@micron.com, rmk+kernel@arm.linux.org.uk

On Tue, May 8, 2012 at 1:16 PM, Minchan Kim <minchan@kernel.org> wrote:
> On 05/03/2012 11:22 PM, Venkatraman S wrote:
>
>> Standard eMMC (Embedded MultiMedia Card) specification expects to ex=
ecute
>> one request at a time. If some requests are more important than othe=
rs, they
>> can't be aborted while the flash procedure is in progress.
>>
>> New versions of the eMMC standard (4.41 and above) specfies a featur=
e
>> called High Priority Interrupt (HPI). This enables an ongoing transa=
ction
>> to be aborted using a special command (HPI command) so that the card=
 is ready
>> to receive new commands immediately. Then the new request can be sub=
mitted
>> to the card, and optionally the interrupted command can be resumed a=
gain.
>>
>> Some restrictions exist on when and how the command can be used. For=
 example,
>> only write and write-like commands (ERASE) can be preempted, and the=
 urgent
>> request must be a read.
>>
>> In order to support this in software,
>> a) At the top level, some policy decisions have to be made on what i=
s
>> worth preempting for.
>> =A0 =A0 =A0 This implementation uses the demand paging requests and =
swap
>> read requests as potential reads worth preempting an ongoing long wr=
ite.
>> =A0 =A0 =A0 This is expected to provide improved responsiveness for =
smarphones
>> with multitasking capabilities - example would be launch a email app=
lication
>> while a video capture session (which causes long writes) is ongoing.
>
>
> Do you have a number to prove it's really big effective?

What type of benchmarks would be appropriate to post ?
As you know, the response time of a card would vary depending on
whether the flash device
has enough empty blocks to write into and doesn't have to resort to GC =
during
write requests.
Macro benchmarks like iozone etc would be inappropriate here, as they w=
on't show
the latency effects of individual write requests hung up doing page
reclaim, which happens
once in a while.

>
> What I have a concern is when we got low memory situation.
> Then, writing speed for page reclaim is important for response.
> If we allow read preempt write and write is delay, it means read path=
 takes longer time to
> get a empty buffer pages in reclaim. In such case, it couldn't be goo=
d.
>

I agree. But when writes are delayed anyway as it exceeds
hpi_time_threshold (the window
available for invoking HPI), it means that the device is in GC mode
and either read or write
could be equally delayed.  Note that even in case of interrupting a
write, a single block write
(which usually is too short to be interrupted, as designed) is
sufficient for doing a page reclaim,
and further write requests (including multiblock) would not be subject
to HPI, as they will
complete within the average time.
