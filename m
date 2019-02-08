From: "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Subject: Re: [PATCH 1/2] mmc: cqhci: replace NUM_SLOTS with cq_host->num_slots
Date: Fri, 8 Feb 2019 16:04:34 +0530
Message-ID: <dcf57693-3daf-8277-53e9-1c4b094f2449@codeaurora.org>
References: <20190114191724.29960-1-alamy.liu@gmail.com>
 <ee3dc963-53f0-e362-caa5-069ce0e6eae7@intel.com>
 <CAJ3kudsgJsZ1KFXdD9Vnfx0GypnEf+ba-D8t+Wy1e8GdLF=U0w@mail.gmail.com>
 <362c073b-d795-4431-f1dd-c203cc606a6f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <362c073b-d795-4431-f1dd-c203cc606a6f@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Alamy Liu <alamy.liu@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2/8/2019 8:07 AM, Ritesh Harjani wrote:
> Hi Alamy,
> 
> On 2/8/2019 1:00 AM, Alamy Liu wrote:
>> It says in B.2.1 in the JESD84-B51.pdf (I don't have JESD84-B51A.pdf):
>>
>>     /The TDL is located in a memory location known to the CQE, and is
>>     comprised of up to 32 fixed-size slots. Each slot is comprised of
>>     one Task Descriptor and one Transfer Descriptor./
>>
>>
>> So if the IP has 16 slots, it should still meet the specification. 
>> Then the configuration could be moved to DTS, maybe:
>>
>>     cqhci-slotnum = <16>;
>>
>>     cqhci-dcmd-slotno = <15>;
>>
> Does your IP defines this as 16 slots & DCMD slot to be 15?
> Because if there is a deviation then IP may also define num_slots by 
> using some reserved registers.
> Also in JESD84-B51.pdf, specific slot no. is used extensively for 
> defining policies(like in case of DCMD & CQCFG), so in that case 
> defining via DT may not be that helpful.
> Unless there is no other way in your IP to determine the num_slots 
> except going via DT?
> 
> Let others also provide an opinion here.
> 
> Regards
> Ritesh
> 
> 
>>
>> Please comment.
>>
>> Regards,
>> Alamy
>>
>>
>>
>> On Thu, Jan 31, 2019 at 1:34 AM Adrian Hunter <adrian.hunter@intel.com 
>> <mailto:adrian.hunter@intel.com>> wrote:
>>
>>     On 14/01/19 9:17 PM, Alamy Liu wrote:
>>     > Prevent to use fixed value (NUM_SLOTS) after it had been determined
>>     > and saved in a variable (cq_host->num_slots).
>>
>>     num_slots is always 32 (i.e. NUM_SLOTS) so why not go the other
>>     way and get
>>     rid of num_slots and just use NUM_SLOTS?
>>
>>     >
>>     > Signed-off-by: Alamy Liu <alamy.liu@gmail.com
>>     <mailto:alamy.liu@gmail.com>>
>>     > ---
>>     >  drivers/mmc/host/cqhci.c | 2 +-
>>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>>     >
>>     > diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
>>     > index 159270e947..26d63594b7 100644
>>     > --- a/drivers/mmc/host/cqhci.c
>>     > +++ b/drivers/mmc/host/cqhci.c
>>     > @@ -699,7 +699,7 @@ static void cqhci_error_irq(struct mmc_host
>>     *mmc, u32 status, int cmd_error,
>>     >                * The only way to guarantee forward progress is
>>     to mark at
>>     >                * least one task in error, so if none is
>>     indicated, pick one.
>>     >                */
>>     > -             for (tag = 0; tag < NUM_SLOTS; tag++) {
>>     > +             for (tag = 0; tag < cq_host->num_slots; tag++) {
>>     >                       slot = &cq_host->slot[tag];
>>     >                       if (!slot->mrq)
>>     >                               continue;
>>     >
>>
Is it worth exploring to tie up the TDL memory allocations with the 
queue-depth? Because the queue-depth may vary with vendor; in most host 
controllers the slot size is 32. And since memory allocations are done 
on the basis of host slot size there's unused slots in the case of card 
advertising less than 32 queue-depth.
The tricky part would be the DCMD handling though.

In the IP in question, what slot is assigned to DCMD?


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
