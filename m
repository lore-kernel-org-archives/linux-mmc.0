From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Thu, 1 Apr 2010 16:59:28 -0500
Message-ID: <4BB51740.2060802@ti.com>
References: <37310.192.168.10.89.1270081542.squirrel@dbdmail.itg.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030D32CEE8@dbde02.ent.ti.com> <008601cad1bd$6d0022b0$544ff780@am.dhcp.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030D32D372@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59823 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756767Ab0DAV7e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Apr 2010 17:59:34 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030D32D372@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Ghorai, Sukumar had written, on 04/01/2010 01:34 PM, the following:

>>>> -----Original Message-----
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>> owner@vger.kernel.org] On Behalf Of Chikkature Rajashekar, Madhusudhan
>>>> Sent: 2010-04-01 05:56
>>>> To: tony@atomide.com
>>>> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org
>>>> Subject: [PATCH] Disable the non working eMMC on Zoom2/3
>>>>
>>>> From: Madhusudhan Chikkature <madhu.cr@ti.com>
>>>> Date: Wed, 31 Mar 2010 12:29:19 -0400
>>>> Subject: [PATCH] Zoom2/3: Disable MMC
>>>>
>>>> The eMMC on Zoom2/3 seems to have a lower EXT_CSD Rev.This causes the
>>>> writes to fail since the card size is not detected correctly by the
>> MMC
>>>> core. Disable the MMC2 support for Zoom2/3.
>>>
>>> [Ghorai] Please let us know the EXT_CSD Rev you see in zoom3 and the
>> exact
>>> problem. Because we never face any issue for eMMC in ZOOM3. Because we
>>> have the same eMMC device in 3630-SDP and could have the same problem.
>>>
>> On Zoom3 the EXT_CSD Rev reported by eMMC is zero. See the log attached.
>>
>> Hence the failures which are reported by people on the list. I had already
>> bought this problem up on the list previously and was discussed, right?
>> From the log you can also see that a 16GB device is detected as a 1GB.
> 
> [Ghorai] I feel it's an issue with eMMC in pilot-board. And production-board is working fine. And I feel outside TI people having production board only. And 16GB eMMC device is a very good size to work with different things. Otherwise we are talking about MMC#2 boot, eMMC boot, 16GB eMMC device in zoom,.. all these information in different page/ link looks very misleading information, if really having such problem.
> I the mean time I will check this in Pilot board too and think you checked in pilot board only.
>  
Ref [1] I believe tony has the brand new zoom board - I think your 
assumption here might be flawed..

-- 
Regards,
Nishanth Menon
Ref:
[1] http://marc.info/?l=linux-omap&m=126938456103707&w=2
