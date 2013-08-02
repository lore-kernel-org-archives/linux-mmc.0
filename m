From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/9] dma: edma: Find missed events and issue them
Date: Fri, 2 Aug 2013 13:15:37 -0500
Message-ID: <51FBF749.4010303@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
	<1375104595-16018-5-git-send-email-joelf@ti.com>
	<51F7659E.3040302@ti.com> <51F89763.1010102@ti.com>
	<51F8D667.2040406@ti.com> <51F9C793.2000001@ti.com>
	<51F9FC87.3020706@ti.com> <51FAC50A.2020507@ti.com>
	<51FBB371.6030901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51FBB371.6030901-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Santosh Shilimkar <santosh.shilim>
List-Id: linux-mmc@vger.kernel.org

Hi Sekhar,

Thanks for your detailed illustrations.

On 08/02/2013 08:26 AM, Sekhar Nori wrote:
[..]
>>>>>> This can be used only for buffers that are contiguous in memory, not
>>>>>> those that are scattered across memory.
>>>>>
>>>>> I was hinting at using the linking facility of EDMA to achieve this.
>>>>> Each PaRAM set has full 32-bit source and destination pointers so I see
>>>>> no reason why non-contiguous case cannot be handled.
>>>>>
>>>>> Lets say you need to transfer SG[0..6] on channel C. Now, PaRAM sets are
>>>>> typically 4 times the number of channels. In this case we use one DMA
>>>>> PaRAM set and two Link PaRAM sets per channel. P0 is the DMA PaRAM set
>>>>> and P1 and P2 are the Link sets.
>>>>>
>>>>> Initial setup:
>>>>>
>>>>> SG0 -> SG1 -> SG2 -> SG3 -> SG4 -> SG5 -> SG6 -> NULL
>>>>>  ^      ^      ^
>>>>>  |      |      |
>>>>> P0  -> P1  -> P2  -> NULL
>>>>>
>>>>> P[0..2].TCINTEN = 1, so get an interrupt after each SG element
>>>>> completion. On each completion interrupt, hardware automatically copies
>>>>> the linked PaRAM set into the DMA PaRAM set so after SG0 is transferred
>>>>> out, the state of hardware is:
>>>>>
>>>>> SG1  -> SG2 -> SG3 -> SG3 -> SG6 -> NULL
>>>>>  ^       ^
>>>>>  |       |
>>>>> P0,1    P2  -> NULL
>>>>>  |       ^
>>>>>  |       |
>>>>>  ---------
>>>>>
>>>>> SG1 transfer has already started by the time the TC interrupt is
>>>>> handled. As you can see P1 is now redundant and ready to be recycled. So
>>>>> in the interrupt handler, software recycles P1. Thus:
>>>>>
>>>>> SG1 -> SG2 -> SG3 -> SG4 -> SG5 -> SG6 -> NULL
>>>>>  ^      ^      ^
>>>>>  |      |      |
>>>>> P0  -> P2  -> P1  -> NULL
>>>>>
>>>>> Now, on next interrupt, P2 gets copied and thus can get recycled.
>>>>> Hardware state:
>>>>>
>>>>> SG2  -> SG3 -> SG4 -> SG5 -> SG6 -> NULL
>>>>>  ^       ^
>>>>>  |       |
>>>>> P0,2    P1  -> NULL
>>>>>  |       ^
>>>>>  |       |
>>>>>  ---------
>>>>>
>>>>> As part of TC completion interrupt handling:
>>>>>
>>>>> SG2 -> SG3 -> SG4 -> SG5 -> SG6 -> NULL
>>>>>  ^      ^      ^
>>>>>  |      |      |
>>>>> P0  -> P1  -> P2  -> NULL
>>>>>
>>>>> This goes on until the SG list in exhausted. If you use more PaRAM sets,
>>>>> interrupt handler gets more time to recycle the PaRAM set. At no point
>>>>> we touch P0 as it is always under active transfer. Thus the peripheral
>>>>> is always kept busy.
>>>>>
>>>>> Do you see any reason why such a mechanism cannot be implemented?
>>>>
>>>> This is possible and looks like another way to do it, but there are 2
>>>> problems I can see with it.
>>>>
>>>> 1. Its inefficient because of too many interrupts:
>>>>
>>>> Imagine case where we have an SG list of size 30 and MAX_NR_SG size is
>>>> 10. This method will trigger 30 interrupts always, where as with my
>>>> patch series, you'd get only 3 interrupts. If you increase MAX_SG_NR ,
>>>> you'd get even fewer interrupts.
>>>
>>> Yes, but you are seeing only one side of inefficiency. In your design
>>> DMA *always* stalls waiting for CPU to intervene. The whole point to DMA
>>> is to keep it going while CPU does bookeeping in background. This is
>>> simply not going to scale with fast peripherals.
>>
>> Agreed. So far though, I've no way to reproduce a fast peripheral that
>> scatters data across physical memory and suffers from any stall.
>>
>>> Besides, missed events are error conditions as far as EDMA and the
>>> peripheral is considered. You are handling error interrupt to support a
>>> successful transaction. Think about why EDMA considers missed events as
>>> error condition.
>>
>> I agree with this, its not the best way to do it. I have been working on
>> a different approach.
>>
>> However, in support of the series:
>> 1. It doesn't break any existing code
>> 2. It works for all current DMA users (performance and correctness)
>> 3. It removes the SG limitations on DMA users.
> 
> Right, all of this should be true even with the approach I am suggesting.
> 
>> So what you suggested, would be more of a feature addition than a
>> limitation of this series. It is atleast better than what's being done
>> now - forcing the limit to the total number of SGs, so it is a step in
>> the right direction.
> 
> No, I do not see my approach is an feature addition to what you are
> doing. They are both very contrasting ways. For example, you would not
> need the manual (re)trigger in CC error condition in what I am proposing.
> 
>>
>>>> 2. If the interrupt handler for some reason doesn't complete or get
>>>> service in time, we will end up DMA'ing incorrect data as events
>>>> wouldn't stop coming in even if interrupt is not yet handled (in your
>>>> example linked sets P1 or P2 would be old ones being repeated). Where as
>>>> with my method, we are not doing any DMA once we finish the current
>>>> MAX_NR_SG set even if events continue to come.
>>>
>>> Where is repetition and possibility of wrong data being transferred? We
>>> have a linear list of PaRAM sets - not a loop. You would link the end to
>>> PaRAM set chain to dummy PaRAM set which BTW will not cause missed
>>> events. The more number of PaRAM sets you add to the chain, the more
>>
>> There would have to be a loop, how else would you ensure continuity and
>> uninterrupted DMA?
> 
> Uninterrupted DMA comes because of PaRAM set recycling. In my diagrams
> above, hardware is *always* using P0 for transfer while software always
> updates the tail of PaRAM linked list.
> 
>>
>> Consider if you have 2 sets of linked sets:
>> L1 is the first set of Linked sets and L2 is the second.
> 
> I think this is where there is confusion. I am using only one linked set
> of PaRAM entries (P0->P1->P2->DUMMY). If you need more time to service
> the interrupt before the DMA hits the dummy PaRAM you allocate more link
> PaRAM sets for the channel (P0->P1->...Pn->DUMMY). At no point was I
> suggesting having two sets of linked PaRAM sets. Why would you need
> something like that?
> 

I think we are talking about the same thing. Let's for now discuss
having just 1 linked set to avoid confusion, that's fine.

I think where we are differing in our understanding, is the dummy link
comes into picture only when we are transferring the *last* SG.
For all others there is a cyclic link between P1 and P2. Would you agree?

Even in your diagrams you are actually showing such a cyclic link


>>>>>
>>>>> SG1 -> SG2 -> SG3 -> SG4 -> SG5 -> SG6 -> NULL
>>>>>  ^      ^      ^
>>>>>  |      |      |
>>>>> P0  -> P2  -> P1  -> NULL

Comparing this..

>>>>>
>>>>> Now, on next interrupt, P2 gets copied and thus can get recycled.
>>>>> Hardware state:
>>>>>
>>>>> SG2  -> SG3 -> SG4 -> SG5 -> SG6 -> NULL
>>>>>  ^       ^
>>>>>  |       |
>>>>> P0,2    P1  -> NULL
>>>>>  |       ^
>>>>>  |       |
>>>>>  ---------
>>>>>
>>>>> As part of TC completion interrupt handling:
>>>>>
>>>>> SG2 -> SG3 -> SG4 -> SG5 -> SG6 -> NULL
>>>>>  ^      ^      ^
>>>>>  |      |      |
>>>>> P0  -> P1  -> P2  -> NULL

.. with this. Notice that P2 -> P1 became P1 -> P2

The next thing logical diagram would look like:

>>>>>
>>>>> Now, on next interrupt, P1 gets copied and thus can get recycled.
>>>>> Hardware state:
>>>>>
>>>>> SG3  -> SG4 -> SG5 -> SG6 -> NULL
>>>>>  ^       ^
>>>>>  |       |
>>>>> P0,1    P2  -> NULL
>>>>>  |       ^
>>>>>  |       |
>>>>>  ---------
>>>>>
>>>>> As part of TC completion interrupt handling:
>>>>>
>>>>> SG3 -> SG5 -> SG6 -> SG6 -> NULL
>>>>>  ^      ^      ^
>>>>>  |      |      |
>>>>> P0  -> P2  -> P1  -> NULL


"P1 gets copied" happens only because of the cyclic link from P2 to P1,
it wouldn't have happened if P2 was linked to Dummy as you described.

Now coming to 2 linked sets vs 1, I meant the same thing that to give
interrupt handler more time, we could have something like:

>>>>> As part of TC completion interrupt handling:
>>>>>
>>>>> SG1 -> SG2 -> SG3 -> SG4 -> SG5 -> NULL
>>>>>  ^      ^             ^
>>>>>  |      |             |
>>>>> P0  -> P1  -> P2  -> P3  -> P4  ->  Null

So what I was describing as 2 sets of linked sets is P1 and P2 being 1
set, and P3 and P4 being another set. We would then recycle a complete
set at the same time. That way interrupt handler could do more at once
and get more time to recycle. So we would setup TC interrupts only for
P2 and P4 in the above diagrams.

Thanks,

-Joel
