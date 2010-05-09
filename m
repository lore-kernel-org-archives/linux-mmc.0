From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
	autoloading feature
Date: Sun, 9 May 2010 16:21:40 +0530
Message-ID: <x2r618f0c911005090351meff49918t941a904edb8027c3@mail.gmail.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D2@dbde02.ent.ti.com>
	 <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C5387398@dbde02.ent.ti.com>
	 <v2n7f9d1ffb1005060202r91efbe3habb936f75227ffa6@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C5387482@dbde02.ent.ti.com>
	 <004501caed38$03e7b9f0$544ff780@am.dhcp.ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C538792A@dbde02.ent.ti.com>
	 <000601caee06$b2c8a9b0$544ff780@am.dhcp.ti.com>
	 <4BE4694F.3060901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4BE4694F.3060901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, kishore kadiyala <kishorek.kadiyala@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Adrian Hunter <adrian.hunter@nokia.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Nishanth Menon <nm@ti.com> wrote:
> Chikkature Rajashekar, Madhusudhan had written, on 05/07/2010 11:59 AM, the
> following:
>>
>>>
>>>> -----Original Message-----
>>>> From: Chikkature Rajashekar, Madhusudhan
>>>> Sent: Thursday, May 06, 2010 9:50 PM
>>>> To: Shilimkar, Santosh; 'kishore kadiyala'
>>>> Cc: S, Venkatraman; linux-omap@vger.kernel.org; linux-
>>>
>>> mmc@vger.kernel.org; linux-arm-
>>>>
>>>> kernel@lists.arm.linux.org.uk; 'Adrian Hunter'; Kadiyala, Kishore; 'Tony
>>>
>>> Lindgren'
>>>>
>>>> Subject: RE: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
>>>
>>> autoloading feature
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Shilimkar, Santosh [mailto:santosh.shilimkar@ti.com]
>>>>> Sent: Thursday, May 06, 2010 4:39 AM
>>>>> To: kishore kadiyala
>>>>> Cc: S, Venkatraman; linux-omap@vger.kernel.org; linux-
>>>
>>> mmc@vger.kernel.org;
>>>>>
>>>>> linux-arm-kernel@lists.arm.linux.org.uk; Chikkature Rajashekar,
>>>>> Madhusudhan; Adrian Hunter; Kadiyala, Kishore; Tony Lindgren
>>>>> Subject: RE: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
>>>>> autoloading feature
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: kishore kadiyala [mailto:kishorek.kadiyala@gmail.com]
>>>>>> Sent: Thursday, May 06, 2010 2:32 PM
>>>>>> To: Shilimkar, Santosh
>>>>>> Cc: S, Venkatraman; linux-omap@vger.kernel.org; linux-
>>>>>
>>>>> mmc@vger.kernel.org; linux-arm-
>>>>>>
>>>>>> kernel@lists.arm.linux.org.uk; Chikkature Rajashekar, Madhusudhan;
>>>>>
>>>>> Adrian Hunter; Kadiyala, Kishore;
>>>>>>
>>>>>> Tony Lindgren
>>>>>> Subject: Re: [PATCH v8 2/2] omap hsmmc: adaptation of sdma
>>>
>>> descriptor
>>>>>
>>>>> autoloading feature
>>>>>>
>>>>>> <<snip>>
>>>>>>
>>>>>>>> I am not clear about the method. The board files export the
>>>>>>>> omap_mmc_platform_data.
>>>>>>>> Does it imply that all board files have to change and export
>>>>>>>> the capability so that it can be queried ?
>>>>>>>
>>>>>>> No. You don't have to modify the board files. This would need
>>>>>>> change in devices.c which common for all omap boards.
>>>>>>>
>>>>>>> I don't have a strong opinion on this point but just put forth an
>>>>>>> alternate way to avoid such SOC specific check in drivers.
>>>>>>> You can take call on this
>>>>>>
>>>>>> Agree. How about adding a flag in hsmmc.h & omap_mmc_platform_data,
>>>>>> that would take care of SDMA & SDMA_DLAOD in the driver instead
>>>
>>> going
>>>>>>
>>>>>> with SOC check .
>>>>>
>>>>> Good idea Kishore.
>>>>> Venkat,
>>>>> Can you do what kishore is suggesting.
>>>>>
>>>> omap_mmc_platform_data is MMC specific platform data. Why add a SDMA
>>>> specific feature capability into it? Even though you add it there, you
>>>
>>> will
>>>>
>>>> still need to have a cpu check before that can be set in a common code.
>>>>
>>> CPU checks are allowed to be in the platform files. That is where such
>>> machine/SOC specific differentiation should be done and not in the device
>>> drivers.
>>> That way device drivers remains clean and portable.
>>>
>>> I want to stop this thread here since neither the patch author nor the
>>> file
>>> maintainer thinks that cpu checks in the device drivers is bad idea.
>>>
>>> Please decide within yourself and move on.
>>>
>>
>> I am not saying that it is wrong. My point here is that adding this
>> particular flag into MMC platform data to differentiate a SDMA specific
>> feature which got introduced post certain SOC may not be needed. But you
>> can
>> always post your comments on the list which will be looked at by a wider
>> audience and finally the right patch will go in.
>
> Please see [1] for SOC specific feature handling. any reasons we can't
> handle it by adding a new feature?
>
> [1]
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/cpu.h#l439
>

Thanks. I can add a new feature here, but I see that the API is tied
to OMAP3, whereas the DMA feature is common
to 3630, OMAP4 and mostly everything after that. I can work on an
upgrade, but do you see that
as a dependency and done on the context of this patch ?
Regards,
Venkat.
