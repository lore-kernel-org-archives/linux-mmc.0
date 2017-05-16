From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 5/5] mmc: cavium: Fix probing race with regulator
Date: Tue, 16 May 2017 09:50:26 -0700
Message-ID: <b10a88af-638a-820b-40d1-92c19bebae06@caviumnetworks.com>
References: <20170516093655.17746-1-jglauber@cavium.com>
 <20170516093655.17746-6-jglauber@cavium.com>
 <CAL_Jsq+wMnNH0oOy7qpycm+4tTu=zYCVzDSuSTSpkfQY85kDEQ@mail.gmail.com>
 <20170516133838.GA20659@hc>
 <CAL_Jsq+p8c-9Sypr6_fAsU2y=uakVhNENJ8XPS0j06Zo=a3caw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:51840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750795AbdEPQud (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 May 2017 12:50:33 -0400
In-Reply-To: <CAL_Jsq+p8c-9Sypr6_fAsU2y=uakVhNENJ8XPS0j06Zo=a3caw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Jan Glauber <jan.glauber@caviumnetworks.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/16/2017 07:37 AM, Rob Herring wrote:
> On Tue, May 16, 2017 at 8:38 AM, Jan Glauber
> <jan.glauber@caviumnetworks.com> wrote:
>> On Tue, May 16, 2017 at 08:07:50AM -0500, Rob Herring wrote:
>>> On Tue, May 16, 2017 at 4:36 AM, Jan Glauber <jglauber@cavium.com> wrote:
>>>> If the regulator probing is not yet finished this driver
>>>> might catch a -EPROBE_DEFER. Returning after this condition
>>>> did not remove the created platform device. On a repeated
>>>> call to the probe function the of_platform_device_create
>>>> fails.
>>>>
>>>> Calling of_platform_device_destroy after EPROBE_DEFER resolves
>>>> this bug.
>>>>
>>>> Signed-off-by: Jan Glauber <jglauber@cavium.com>
>>>> ---
>>>>   drivers/mmc/host/cavium-thunderx.c | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
>>>> index fe3d772..257535e 100644
>>>> --- a/drivers/mmc/host/cavium-thunderx.c
>>>> +++ b/drivers/mmc/host/cavium-thunderx.c
>>>> @@ -137,8 +137,10 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>>>>                                  continue;
>>>>
>>>>                          ret = cvm_mmc_of_slot_probe(&host->slot_pdev[i]->dev, host);
>>>> -                       if (ret)
>>>> +                       if (ret) {
>>>> +                               of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
>>>
>>> What if this fails after the 1st iteration of the loop. It's only
>>> cleaning up the current device.
>>
>> The platform device is just a dummy device created directly before
>> cvm_mmc_of_slot_probe(). So there is no need to cleanup anything else.
> 
> So if you have 2 slots, the first slot probes successfully and the 2nd
> slot defers, then you only need to clean-up the 2nd device/slot? Looks
> to me like you are leaking the 1st device you alloc.
> 
>>
>> As far as I've seen it the platform code 'tags' the nodes it already
>> used, but I need the same node to be parsed again on -EPROBE_DEFER.
>>
>>> Use devm_of_platform_populate or
>>> of_platform_populate/of_platform_depopulate instead.
>>
>> I'm not sure one of these will work here.
> 
> Those functions loop over child nodes and create devices. You are
> doing the same thing. You'd just need to create all the devices first
> and then probe them all.
> 
> The whole structure here with the dummy devices and how you are
> initializing things is screwy. IMO, you should be creating actual
> drivers for the dummy devices.
> 

The "dummy devices" (AKA slots) share many resources with a need for 
locking between the slots to make sure these shared resources don't get 
stomped on by the other slots.  We did have discussions about the 
architecture of the driver around this very point in the review process 
before the current driver was merged.  The conclusion we reached was 
that we wouldn't fragment the code across multiple drivers.

I would suggest the following:

1) Patches 1-3 are independent of this discussion, and could probably be 
merged separately from 4 and 5.

2) Without creating invasive infrastructure changes in the MMC core, the 
current driver architecture is good enough, and we should patch it so 
there are no resource leaks in the cleanest manner possible.

Thanks,
David Daney
