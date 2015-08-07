From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 00/11] omap_hsmmc: voltage switching and tuning
Date: Fri, 7 Aug 2015 20:15:02 +0530
Message-ID: <55C4C46E.9080200@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com> <20150805104355.GE16878@atomide.com> <55C22524.5050304@ti.com> <20150806064821.GO16878@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35406 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323AbbHGOpk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Aug 2015 10:45:40 -0400
In-Reply-To: <20150806064821.GO16878@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, mugunthanvnm@ti.com

Hi,

On Thursday 06 August 2015 12:18 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [150805 08:03]:
>> Hi,
>>
>> On Wednesday 05 August 2015 04:13 PM, Tony Lindgren wrote:
>>> * Kishon Vijay Abraham I <kishon@ti.com> [150730 00:49]:
>>>> Patch series implements voltage switching and tuning for omap_hsmmc
>>>> driver.
>>>>
>>>> Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
>>>> Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.
>>>
>>> Your tests are missing omap3?
>>
>> I don't have one at my disposal :-( I'll try to find one and add omap3 tests.
> 
> Great :) Beagle xm is a good one to test the USB PHY stuff on
> and also MMC. Having USB cable connected or EHCI loaded blocks the PM
> though, so NFSroot is not very usable for testing on it.

I found a beagle xm. So I should be able to get back to this early next week.

Thanks
Kishon
> 
> If you want to test PM over NFSroot, boards with the smsc911x known
> to work with PM  are at least omap3-evm-37xx.dts and
> logicpd-torpedo-37xx-devkit.dts.  Since you tinker with the USB PHYs,
> torpedo has MUSB working the same way as the beagle boards, EVM I
> think can be modified that way but by default has diffent PHY.
> 
> Also overo tobi boards work with PM but only for retntion idle and
> not off idle, and map3-sbc-t3517.dts probably can be made to work
> with PM but I have mine as a gateway and have not been able to test
> with it.
> 
> Probably also zoom3 boards with later processor boards can be made
> to work, the LDP has early omap34xx variants and can't be made to
> work reliably.
> 
> I don't have omap3-lilly, but I'd assume that can also be made
> to work with PM if not already working.
> 
>>> I suggest you add some omap3 tests in general as otherwise you are
>>> only testing a subset of the driver features and completely missing
>>> things like rutnime PM and save and restore for the deeper idle
>>> states.
>>
>> yeah, I'll do those tests and re-post the series.
> 
> Thanks!
> 
> Tony
> 
