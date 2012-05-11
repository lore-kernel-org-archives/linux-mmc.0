From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCHv2 00/16] [FS, MM, block, MMC]: eMMC High Priority
 Interrupt Feature
Date: Sat, 12 May 2012 00:48:57 +0530
Message-ID: <CANfBPZ9jHfX6tyrOx=9E+L+Z0JzXMqjMYK++Q53C4TJFSujoGg@mail.gmail.com>
References: <1336054995-22988-1-git-send-email-svenkatr@ti.com>
 <4FA8CF5E.1070202@kernel.org> <CANfBPZ-d-0FqY8Gruv+KDNoL3+FoQ68JEnxya5PydhY80x8yhA@mail.gmail.com>
 <4FA9BE10.1030007@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4FA9BE10.1030007@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Minchan Kim <minchan@kernel.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, arnd.bergmann@linaro.org, alex.lemberg@sandisk.com, ilan.smith@sandisk.com, lporzio@micron.com, rmk+kernel@arm.linux.org.uk
List-Id: linux-mmc@vger.kernel.org

On Wed, May 9, 2012 at 6:15 AM, Minchan Kim <minchan@kernel.org> wrote:
> On 05/09/2012 01:31 AM, S, Venkatraman wrote:
>
>> On Tue, May 8, 2012 at 1:16 PM, Minchan Kim <minchan@kernel.org> wro=
te:
>>> On 05/03/2012 11:22 PM, Venkatraman S wrote:
>>>
>>>> Standard eMMC (Embedded MultiMedia Card) specification expects to =
execute
>>>> one request at a time. If some requests are more important than ot=
hers, they
>>>> can't be aborted while the flash procedure is in progress.
>>>>
>>>> New versions of the eMMC standard (4.41 and above) specfies a feat=
ure
>>>> called High Priority Interrupt (HPI). This enables an ongoing tran=
saction
>>>> to be aborted using a special command (HPI command) so that the ca=
rd is ready
>>>> to receive new commands immediately. Then the new request can be s=
ubmitted
>>>> to the card, and optionally the interrupted command can be resumed=
 again.
>>>>
>>>> Some restrictions exist on when and how the command can be used. F=
or example,
>>>> only write and write-like commands (ERASE) can be preempted, and t=
he urgent
>>>> request must be a read.
>>>>
>>>> In order to support this in software,
>>>> a) At the top level, some policy decisions have to be made on what=
 is
>>>> worth preempting for.
>>>> =A0 =A0 =A0 This implementation uses the demand paging requests an=
d swap
>>>> read requests as potential reads worth preempting an ongoing long =
write.
>>>> =A0 =A0 =A0 This is expected to provide improved responsiveness fo=
r smarphones
>>>> with multitasking capabilities - example would be launch a email a=
pplication
>>>> while a video capture session (which causes long writes) is ongoin=
g.
>>>
>>>
>>> Do you have a number to prove it's really big effective?
>>
>> What type of benchmarks would be appropriate to post ?
>> As you know, the response time of a card would vary depending on
>> whether the flash device
>> has enough empty blocks to write into and doesn't have to resort to =
GC during
>> write requests.
>> Macro benchmarks like iozone etc would be inappropriate here, as the=
y won't show
>> the latency effects of individual write requests hung up doing page
>> reclaim, which happens
>> once in a while.
>
>
> We don't have such special benchmark so you need time to think how to=
 prove it.
> IMHO, you can use run-many-x-apps.sh which checks elapsed time to act=
ivate programs
> by posting by Wu long time ago.
>
> http://www.spinics.net/lists/linux-mm/msg09653.html
>
> Of course, your eMMC is used above 80~90% for triggering GC stress an=
d
> your memory should be used up by dirty pages to happen reclaim.
>
>
>>>
>>> What I have a concern is when we got low memory situation.
>>> Then, writing speed for page reclaim is important for response.
>>> If we allow read preempt write and write is delay, it means read pa=
th takes longer time to
>>> get a empty buffer pages in reclaim. In such case, it couldn't be g=
ood.
>>>
>>
>> I agree. But when writes are delayed anyway as it exceeds
>> hpi_time_threshold (the window
>> available for invoking HPI), it means that the device is in GC mode
>> and either read or write
>> could be equally delayed. =A0Note that even in case of interrupting =
a
>> write, a single block write
>> (which usually is too short to be interrupted, as designed) is
>> sufficient for doing a page reclaim,
>> and further write requests (including multiblock) would not be subje=
ct
>> to HPI, as they will
>> complete within the average time.
>
>
> My point is that it would be better for read to not preempt write-for=
-page_reclaim.
> And we can identify it by PG_reclaim. You can get the idea.
>
> Anyway, HPI is only feature of a device of many storages and you are =
requiring modification
> of generic layers although it's not big. So for getting justification=
 and attracting many
> core guys(MM,FS,BLOCK), you should provide data at least.
>
Hi Kim,
 Apologies for a delayed response. I am studying your suggestions and
will get back with
some changes and also some profiling data.
Regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
