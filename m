From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 2/23]  Alternative mmc structure to support pxa168,
 pxa910, mmp2 family SD
Date: Fri, 24 Dec 2010 08:29:37 -0800
Message-ID: <9815DC2D-86F7-4B4F-8CE3-46395E72B77B@marvell.com>
References: <593647B8-BECF-492E-B196-FFCEDB9DE6B2@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46075 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752161Ab0LXQ36 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Dec 2010 11:29:58 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>


> 
> Enrico,
> 
> Good catch.  
> 
> The definitions are correct for mmp2 but not pxa168 and pxa910.

Aspenite and pxa910 do not support SD/MMC at this time.
check the files in arch/arm/mach-mmp.

> 
> We will fix.
> 
> Thank you.
> 
> On Dec 23, 2010, at 4:26 AM, Enrico Scholz wrote:
> 
>> The following message is a courtesy copy of an article
>> that has been posted to gmane.linux.kernel.mmc,gmane.linux.ports.arm.kernel as well.
>> 
>> Philip Rakity <prakity@marvell.com> writes:
>> 
>>> --- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
>>> +++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
>>> +#define APMU_SDH2	APMU_REG(0x0e8)
>>> +#define APMU_SDH3	APMU_REG(0x0ec)
>> 
>> is this really correct?  "ARMADA 16x Application Processor Family"
>> (October 2010) manual says that these registers are at 0xe0 + 0xe4.
>> 
>> 
>> Enrico
> 

