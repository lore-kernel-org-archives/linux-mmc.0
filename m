From: Stefan Roese <sr@denx.de>
Subject: Re: SDIO "SD2" vs. SD-card "SD3" interface on BayTrail
Date: Thu, 31 Aug 2017 17:24:35 +0200
Message-ID: <63d5c5f0-619f-b55b-88b3-8afe6e81227b@denx.de>
References: <d7249bf2-b057-0535-334e-71cdc957e9b5@denx.de>
 <1499176431.22624.255.camel@linux.intel.com>
 <8a909116-5fec-e7d0-5d30-de8de42612df@denx.de>
 <dc49d8be-dd15-167b-2ab4-d09d1b6ea83d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:40643 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbdHaPZC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 31 Aug 2017 11:25:02 -0400
In-Reply-To: <dc49d8be-dd15-167b-2ab4-d09d1b6ea83d@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org

Hi Adrian,

On 31.08.2017 14:41, Adrian Hunter wrote:
> On 31/08/17 12:38, Stefan Roese wrote:
>> Hi Andy, Hi Adrian,
>>
>> On 04.07.2017 15:53, Andy Shevchenko wrote:
>>> On Tue, 2017-07-04 at 14:53 +0200, Stefan Roese wrote:
>>>> Hi,
>>>>
>>>> we are currently investigating, if its possible to connect a SDIO
>>>> device (WLAN module) to the SD-card interface "SD3" of the BayTrail
>>>> SoC instead of the SDIO interface "SD2". The BayTrail manual states,
>>>> that the SDIO interface is capable of connecting SDIO devices. Is
>>>> this also possible for the SD-card interface "SD3", even if its not
>>>> explicitly mentioned in the manual? If not, why is this not possible?
>>>>
>>>> Any insight on this would be really helpful.
>>>
>>> Hmm... I have no documentation for SD/SDIO/eMMC for BayTrail except the
>>> public one. Internally I found some charts that shows similarities
>>> between two. So, taking that into consideration I would suggest to try
>>> it out on real hardware (MinnowBoard MAX, for example), only impediment
>>> I can see is the absence of support in the drivers in Linux OS. If you
>>> need it only in U-Boot, you perhaps may fix it easily.
>>>
>>> P.S. Adrian on vacation.
>>
>> I hope your vacation was great!
>>
>> Sorry for getting back to this, but I would really like to get some
>> more feedback on this. Perhaps Adrian has some additional comments
>> about the SDIO usage of the SD interface (SD3 - PCI Device ID 0x0f16)
>> on BayTrail.
>>
>> I'm now running latest mainline Linux on this board and am trying to
>> get the Linux MMC / SDIO subsystem to just detect a device on this
>> SD PCI interface. For this I have added quite a bit of debug code to
>> the MMC / SDIO code to see, if any device is detected on the SDIO
>> port. But all command queries return timeout as far as I can tell.
> 
> I would usually interpret that to mean the SDIO card is not turned on.

Yes, this is of course possible - or some signal issues while
level-shifting etc. I've also thought of this possibility. One of the
next things to do, will be to measure some of the signals.

>> Adrian, do you have some additional information, if this mode of
>> operation is possible at all on this SD-card interface, even if
>> its not explicitly mentioned in the BayTrail datasheet?
> 
> I have used removable SDIO cards in SD slots before.  It should work.

Sorry, but I need to double-check on this. You have successfully used
some SDIO cards in this "SD-card-only controller" (as stated in the
datasheet) on BayTrail?

Do you b y any chance remember, which SDIO card you have tested with?

>>                                                          Or do you
>> have some suggestions, how I could test such a basic SDIO connection
>> (without integrating of the WLAN driver first) in the simplest way?
> 
> Only to try a removable SDIO card.

Thats not possible on this board, as this WLAN module is soldered.
But I might find some other / alternative board, to test this. Let
me check on this...

Thanks,
Stefan
