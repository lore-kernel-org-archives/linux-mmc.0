From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] omap3/omap4 hsmmc: Register offset handling
Date: Fri, 03 Sep 2010 17:50:56 +0200
Message-ID: <4C811960.9060801@ti.com>
References: <23570.10.24.255.18.1283190527.squirrel@dbdmail.itg.ti.com>	<4C80A76F.3060108@ti.com>	<AANLkTi=OW_sykGsf8u8Gi94ApLCYjiR+xS4aEu1Tf3pC@mail.gmail.com> <87eida4ysh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48609 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925Ab0ICPvO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Sep 2010 11:51:14 -0400
In-Reply-To: <87eida4ysh.fsf@deeprootsystems.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: kishore kadiyala <kishorek.kadiyala@gmail.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>

On 9/3/2010 5:44 PM, Kevin Hilman wrote:
> kishore kadiyala<kishorek.kadiyala@gmail.com>  writes:
>
>> Hi Benoit
>>
>> <snip>
>>
>>>> +               while (!(omap_readl(base + reg_off)&
>>>>                           MMCHS_SYSSTATUS_RESETDONE))
>>>>                          cpu_relax();
>>>
>>> Why does that series not seems to be based on your hwmod migration? The
>>> reset is fully handle by the hwmod framework now.
>>
>> Agree. But Kevin has  suggested to post this patch  independent of hwmod.
>> Does this patch has to go in hwmod series ?
>
> I suggested that this register conversion patch could be merged before
> the hwmod conversion as it is independent of that.

OK, I missed that part. I was surprised because the hwmod series was 
sent before that one.

Benoit
