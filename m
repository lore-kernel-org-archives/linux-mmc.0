From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 15/23] Alternative mmc structure to support pxa168,
 pxa910, mmp2 family SD
Date: Fri, 7 Jan 2011 08:48:36 -0800
Message-ID: <ABCC071A-5598-48AA-9545-2712FA0BB624@marvell.com>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
 <AANLkTikmZ=c8LnOwxLqx9w6cXV07eVL7AZ0qQmXKojs9@mail.gmail.com>
 <7E0D4C72-717F-495B-98FE-35F40C7CDCAE@marvell.com>
 <201101062029.45604.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48820 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754447Ab1AGQw1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Jan 2011 11:52:27 -0500
In-Reply-To: <201101062029.45604.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <markb@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On Jan 6, 2011, at 11:29 AM, Arnd Bergmann wrote:

> On Friday 31 December 2010, Philip Rakity wrote:
>> The patch selects ARCH-MMP (as now) but adds the ability
>> to also know which specific SoC was chosen.  (This is sort of done by choosing the development board today).
> 
> On a larger scale, we try to go in the opposite direction: make it possible to
> have kernels run on as many boards as possible by decreasing the code differences
> between SoCs and even SoC families.
> 
>>> Your patches will make them mess.
>> 
>> suggest a solution.  
>> 
>> The current mechanism of having the development board select the CPU does not seem right.
>> One can select a development board for MMP2 and PXA168 and yet the arch files to support each CPU
>> are different and not compatible.  (for example cache handling).  
> 
> The optimal solution would be to make sure that working support for both CPUs can be built into
> a single kernel. There is a lot of infrastructure in arch/arm/mm/* that tries to do this, but
> I don't know of that actually works for the combination of CPU_MOHAWK and CPU_V6. It does
> work for some other combinations of CPU cores though, so it's certainly possible.
> For instance, arch/arm/include/asm/cacheflush.h has abstractions to select the cache handling
> at boot time.
> 
> To go even further, it might make sense to combine the PXA and MMP platforms, since they already
> share some code through the plat-pxa directory.
> 
> Getting it running for MMP with mohawk and v6 cores could be a significant amount of work if
> nobody has tries this in that platform, so for now, I would recommend you just keep ARCH_MMP as
> a global option in arch/arm/Kconfig for now and add another 'choice' statement in
> arch/arm/mach-mmp/Kconfig to select the CPU core, with the board selection depending on that.
> 


Thanks for the suggestion.  Let me see if I can implement this.  

A couple of points first

a) current implementation once PXA168/910 is selected will no longer show MMP2 boards so it is also broken.  Play around and you will see the issues

My proposed patch did the following
a) ARCH_MMP is set when PXA168, PXA910 or MMP2 are selected (from arch/arm)
b) Board selection uses the PXA168/PXA910/MMP2 to show correct board.

If I understand what you are suggesting is the following
a) leave ARCH_MMP is system selection alone -- 
b) move speciific CPU selection to where board selection is now (cpu/arch/mach-mmp)
c) what do with development boards ?  select all of them for the CPU Type ?  

Point me to a Kconfig that does what you are suggesting as an example and I can try out the suggestion.


> 	Arnd
> 

