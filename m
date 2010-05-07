From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor 	autoloading
 feature
Date: Fri, 7 May 2010 14:26:07 -0500
Message-ID: <4BE4694F.3060901@ti.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D2@dbde02.ent.ti.com> <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C5387398@dbde02.ent.ti.com> <v2n7f9d1ffb1005060202r91efbe3habb936f75227ffa6@mail.gmail.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C5387482@dbde02.ent.ti.com> <004501caed38$03e7b9f0$544ff780@am.dhcp.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C538792A@dbde02.ent.ti.com> <000601caee06$b2c8a9b0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39984 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758024Ab0EGT0T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 May 2010 15:26:19 -0400
In-Reply-To: <000601caee06$b2c8a9b0$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, 'kishore kadiyala' <kishorek.kadiyala@gmail.com>, "S, Venkatraman" <svenkatr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, 'Adrian Hunter' <adrian.hunter@nokia.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, 'Tony Lindgren' <tony@atomide.com>

Chikkature Rajashekar, Madhusudhan had written, on 05/07/2010 11:59 AM, 
the following:
> 
>>
>>> -----Original Message-----
>>> From: Chikkature Rajashekar, Madhusudhan
>>> Sent: Thursday, May 06, 2010 9:50 PM
>>> To: Shilimkar, Santosh; 'kishore kadiyala'
>>> Cc: S, Venkatraman; linux-omap@vger.kernel.org; linux-
>> mmc@vger.kernel.org; linux-arm-
>>> kernel@lists.arm.linux.org.uk; 'Adrian Hunter'; Kadiyala, Kishore; 'Tony
>> Lindgren'
>>> Subject: RE: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
>> autoloading feature
>>>
>>>
>>>> -----Original Message-----
>>>> From: Shilimkar, Santosh [mailto:santosh.shilimkar@ti.com]
>>>> Sent: Thursday, May 06, 2010 4:39 AM
>>>> To: kishore kadiyala
>>>> Cc: S, Venkatraman; linux-omap@vger.kernel.org; linux-
>> mmc@vger.kernel.org;
>>>> linux-arm-kernel@lists.arm.linux.org.uk; Chikkature Rajashekar,
>>>> Madhusudhan; Adrian Hunter; Kadiyala, Kishore; Tony Lindgren
>>>> Subject: RE: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
>>>> autoloading feature
>>>>
>>>>> -----Original Message-----
>>>>> From: kishore kadiyala [mailto:kishorek.kadiyala@gmail.com]
>>>>> Sent: Thursday, May 06, 2010 2:32 PM
>>>>> To: Shilimkar, Santosh
>>>>> Cc: S, Venkatraman; linux-omap@vger.kernel.org; linux-
>>>> mmc@vger.kernel.org; linux-arm-
>>>>> kernel@lists.arm.linux.org.uk; Chikkature Rajashekar, Madhusudhan;
>>>> Adrian Hunter; Kadiyala, Kishore;
>>>>> Tony Lindgren
>>>>> Subject: Re: [PATCH v8 2/2] omap hsmmc: adaptation of sdma
>> descriptor
>>>> autoloading feature
>>>>> <<snip>>
>>>>>
>>>>>>> I am not clear about the method. The board files export the
>>>>>>> omap_mmc_platform_data.
>>>>>>> Does it imply that all board files have to change and export
>>>>>>> the capability so that it can be queried ?
>>>>>> No. You don't have to modify the board files. This would need
>>>>>> change in devices.c which common for all omap boards.
>>>>>>
>>>>>> I don't have a strong opinion on this point but just put forth an
>>>>>> alternate way to avoid such SOC specific check in drivers.
>>>>>> You can take call on this
>>>>> Agree. How about adding a flag in hsmmc.h & omap_mmc_platform_data,
>>>>> that would take care of SDMA & SDMA_DLAOD in the driver instead
>> going
>>>>> with SOC check .
>>>> Good idea Kishore.
>>>> Venkat,
>>>> Can you do what kishore is suggesting.
>>>>
>>> omap_mmc_platform_data is MMC specific platform data. Why add a SDMA
>>> specific feature capability into it? Even though you add it there, you
>> will
>>> still need to have a cpu check before that can be set in a common code.
>>>
>> CPU checks are allowed to be in the platform files. That is where such
>> machine/SOC specific differentiation should be done and not in the device
>> drivers.
>> That way device drivers remains clean and portable.
>>
>> I want to stop this thread here since neither the patch author nor the
>> file
>> maintainer thinks that cpu checks in the device drivers is bad idea.
>>
>> Please decide within yourself and move on.
>>
> 
> I am not saying that it is wrong. My point here is that adding this
> particular flag into MMC platform data to differentiate a SDMA specific
> feature which got introduced post certain SOC may not be needed. But you can
> always post your comments on the list which will be looked at by a wider
> audience and finally the right patch will go in. 
Please see [1] for SOC specific feature handling. any reasons we can't 
handle it by adding a new feature?

[1] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/cpu.h#l439

-- 
Regards,
Nishanth Menon
