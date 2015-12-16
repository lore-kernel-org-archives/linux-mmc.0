From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: set non-removable in ACPI table
Date: Wed, 16 Dec 2015 02:17:28 +0100
Message-ID: <5670BBA8.5040900@intel.com>
References: <1449150480-1173-1-git-send-email-pelcan@codeaurora.org>
 <5669E72C.4090701@codeaurora.org> <566A868E.8080808@intel.com>
 <2610121.hCKXuUzvHo@vostro.rjw.lan> <567087F3.7030308@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <567087F3.7030308@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Philip Elcan <pelcan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.org>, Mark Langsdorf <mlangsdo@redhat.com>, harba@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 12/15/2015 10:36 PM, Philip Elcan wrote:
> On 12/11/2015 05:53 PM, Rafael J. Wysocki wrote:
>> On Friday, December 11, 2015 10:17:18 AM Adrian Hunter wrote:
>>> On 10/12/15 22:57, Philip Elcan wrote:
>>>> On 12/07/2015 03:30 AM, Adrian Hunter wrote:
>>>>> On 04/12/15 17:40, Philip Elcan wrote:
>>>>>> On 12/03/2015 09:14 AM, Adrian Hunter wrote:
>>>>>>> On 03/12/15 15:48, Philip Elcan wrote:
>>>>>>>> This allows setting an SDHC controller as non-removable
>>>>>>>> by using the _RMV method in the ACPI table. It doesn't
>>>>>>> Is that _RMV on the host controller?  Shouldn't it be on the card i.e. child
>>>>>>> device node?
>>>>>> Yes, this is on the host controller. The ACPI table only describes the
>>>>>> host controller, not the child nodes.
>>>>>>
>>>>> If you look at Intel devices, the _RMV is on the child e.g.
>>>>>
>>>>>          Device (SDHA)
>>>>>          {
>>>>>              Name (_HID, "80860F14")  // _HID: Hardware ID
>>>>>              Name (_CID, "PNP0D40")  // _CID: Compatible ID
>>>>>              Name (_DDN, "Intel(R) eMMC Controller - 80860F14")  // _DDN: DOS Device Name
>>>>> 	    ...
>>>>>              Device (EMMD)
>>>>>              {
>>>>> 		...
>>>>>                  Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
>>>>>                  {
>>>>>                      Return (Zero)
>>>>>                  }
>>>>>              }
>>>>>          }
>>>>>
>>>>> I am not an ACPI expert but that seems like the correct place for it.
>>>> My understanding is that in ACPI you don't generally create child devices on buses that are discoverable.
>>> I've cc'ed Rafael and the linux-acpi mailing list.  Maybe someone there can
>>> comment.
>> The context here is a bit unclear to me.
>>
>> Quite frankly, I don't see now _RMV above is useful for anything.  As per the
>> spec, _RMV is only necessary for devices that *can* be removed from the system
>> and where there's no eject mechanism controlled by software.  For those
>> devices _RMV is intended to indicate that it is safe to remove the device
>> at the time _RMV is evaluated.  Devices that can never be removed don't
>> need _RMV at all.
>>
>> Thanks,
>> Rafael
>>
> Maybe I'm misinterpreting something, but the spec says that "_RMV object indicates
> to OSPM whether the device can be removed while the system is in the working state
> and does not require any ACPI system firmware actions to be performed for the device
> to be safely removed from the system." That sounds exactly like what I'm trying to
> do. And from Adrian's example, it sounds like others are using this to indicate if
> a devices is removeable.

It also says "Any such removable device that does not have _LCK or _EJx 
control methods must have and _RMV object."

Which clearly implies that _RMV is not required for devices that cannot 
be removed at all.  Indeed, it is redundant in those cases as stated above.

> However, if I follow your paradigm, I can just test if the _RMV object exists, and if
> it doesn't, I can assume the device is not removable?

That's correct as far as I can say.

> I'm concerned not all firmware will have this object implemented.

That's correct too.

It only is intended for devices that may be removed in a 
surprise-removal fashion and it is rarely used in general.

> Is there something else you suggest I use in the ACPI table to designate an SD/MMC
> device is removable?

If you want to say "this device is removable", then there should be 
either _LCK/_EJx or _RMV object present for it.  The latter indicates 
that the device can be removed at any time in principle, but it is only 
safe to remove it if/when 1 is returned by _RMV. That is, the OS can't 
prevent the user from removing the device, but it can indicate to the 
user (this way or another) when it is safe to remove it.  The decision 
whether or not to do that is still up to the user.

Thanks,
Rafael

