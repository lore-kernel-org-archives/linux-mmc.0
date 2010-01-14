From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 4/8] omap_hsmmc: set DVFS/PM constraints
Date: Thu, 14 Jan 2010 10:28:30 +0200
Message-ID: <4B4ED5AE.1090807@nokia.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com> <20100113114041.7615.830.sendpatchset@ahunter-work.research.nokia.com> <alpine.DEB.2.00.1001131538560.4769@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57410 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab0ANI25 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2010 03:28:57 -0500
In-Reply-To: <alpine.DEB.2.00.1001131538560.4769@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Karpov Denis.2 (EXT-Teleca/Helsinki)" <ext-denis.2.karpov@nokia.com>, Tony Lindgren <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

Paul Walmsley wrote:
> (added Denis and Kevin)
> 
> Hello Denis, Adrian,
> 
> On Wed, 13 Jan 2010, Adrian Hunter wrote:
> 
>> >From afab8b432b37ae1f42b281e58989c8d607ed7183 Mon Sep 17 00:00:00 2001
>> From: Denis Karpov <ext-denis.2.karpov@nokia.com>
>> Date: Wed, 8 Jul 2009 16:15:08 +0200
>> Subject: [PATCH] omap_hsmmc: set DVFS/PM constraints
>>
>> Set constraint for MPU minimal frequency to maintain good
>> I/O performance.
>>
>> The constraint is set in MMC host 'ENABLED' state and dropped
>> when MMC host enters 'DISABLED' state which currently happens
>> upon 100ms of inactivity.
>>
>> Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
>> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
>> ---
>>  arch/arm/mach-omap2/board-rx51-peripherals.c |   18 ++++++++++++++++++
>>  arch/arm/mach-omap2/hsmmc.c                  |    2 ++
>>  arch/arm/mach-omap2/hsmmc.h                  |    2 ++
>>  arch/arm/plat-omap/include/plat/mmc.h        |    3 +++
>>  drivers/mmc/host/omap_hsmmc.c                |   17 +++++++++++++++++
>>  5 files changed, 42 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> index ab07ca2..b6318b1 100644
>> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
>> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> @@ -209,6 +209,22 @@ static struct twl4030_madc_platform_data rx51_madc_data = {
>>  	.irq_line		= 1,
>>  };
>>  
>> +#if defined(CONFIG_BRIDGE_DVFS)
>> +/*
>> + * This handler can be used for setting other DVFS/PM constraints:
>> + * intr latency, wakeup latency, DMA start latency, bus throughput
>> + * according to API in mach/omap-pm.h.  Currently we only set constraints
>> + * for MPU frequency.
>> + */
>> +#define MMC_MIN_MPU_FREQUENCY	500000000	/* S500M at OPP3 */
>> +static void rx51_mmc_set_pm_constraints(struct device *dev, int on)
>> +{
>> +	omap_pm_set_min_mpu_freq(dev, (on ? MMC_MIN_MPU_FREQUENCY : 0));
>> +}
> 
> NAK.  The MMC driver (or any other driver, for that matter) must not set 
> MPU frequency constraints merely to boost performance.  Drivers have no 
> way of knowing what the power vs. performance policy is for a given device 
> or use case.

The driver doesn't but RX-51 does, which is why the code is in the RX-51
board file.  We know exactly the use cases and the effect on performance.

> If the system is not upscaling MPU frequency quickly enough, then the 
> power management policy code -- CPUFreq, in the MPU case -- or the 
> parameters for that code -- need to be adjusted.  (Of course, integrators 
> can always dump hacks like this in their own trees if they get lazy, but 
> these should be kept far, far away from mainline.)

It is unreasonable to override the policy decisions of the board maker
as defined in their board files.

Instead you must remove the omap_pm_set_min_mpu_freq() function entirely
or suffer the consequence that it can be used. i.e. it should not exist
if you don't want anyone to use it.

> 
> N.B.  As a separate matter, the MMC driver should call 
> omap_pm_set_min_bus_tput() with the maximum throughput that the current 
> MMC card can sustain to memory.  A reasonable upper bound should be easy 
> to calculate based on the MMC clock speed and the width of the MMC 
> transfers.  This will allow the kernel to adjust the bus frequency 
> appropriately as the OMAP PM core's bus utilization model improves.

Many different constraints were tried.  min_mpu_freq was the only one that
worked.

In the future, improvements to DMA and changes to PM may be able to get the
same performance without the min_mpu_freq constraint.

> 
> 
> - Paul
> 

