From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCHv4 2/4] clk: socfpga: Add a hook for SD/MMC driver to control
 CIU clock settings
Date: Thu, 12 Dec 2013 15:45:40 -0600
Message-ID: <52AA2E84.2000701@gmail.com>
References: <1386263677-7733-1-git-send-email-dinguyen@altera.com> <201312052157.37538.arnd@arndb.de> <52A7206C.4040500@gmail.com> <201312101915.47648.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:41513 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab3LLVpp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Dec 2013 16:45:45 -0500
In-Reply-To: <201312101915.47648.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: dinguyen@altera.com, mturquette@linaro.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 12/10/13 12:15 PM, Arnd Bergmann wrote:
> On Tuesday 10 December 2013, Dinh Nguyen wrote:
>> On 12/5/13 2:57 PM, Arnd Bergmann wrote:
>>> And in now way should the clock provider code look into the DT properties of the
>>> clock consumer. From what I can tell, the dw-mshc code already interprets the
>>> "samsung,dw-mshc-sdr-timing" property and uses the data to pass the correct
>>> clock rate using 'clk_set_rate()'. The clock code should only use the data passed
>>> in the argument to that function to set up the registers and not need to know
>>> at all who is setting it.
>> You're right, the dw-mshc code interprets "samsung,dw-mshc-sdr-timing",
>> but it is
>> currently doing it in the platform specific code(dw_mmc-exynos and
>> dw_mmc-socfpga).
>> I was thinking I can remove the platform specific for SOCFPGA. But
>> perhaps now that
>> patch "mmc: dw_mmc: Make the use of the hold reg generic" is
>> progressing, and
>> that patch reads "samsung,dw-mshc-sdr-timing" in the generic dw_mmc
>> code, I can now
>> pass it through the clk_set_rate call.
> Ok, good.
>
>> My initial thought to read "samsung,dw-mshc-sdr-timing" in the socfpga clock
>> driver's was that the SOCFPGA's sdmmc_clk only role in life is to feed
>> the sdmmc block. So
>> reading the phase shift bits that adjust this clock does seem weird, but
>> a straightforward way
>> of doing it. I stuck it in the function in .prepare function because the
>> setting of the clock's phase
>> shift also requires that CIU clock be turned off while the bits are
>> toggled, so the prepare function
>> seems to work perfectly. So I think you're only concern is that I should
>> figure out a way to pass
>> the values of "samsung,dw-mshc-sdr-timing" from the dw_mmc driver to the
>> clock driver, correct?
>>
>> Yes, I can read the "samsung,dw-mshc-sdr-timing" in the dw_mmc code and
>> pass it to the clock
>> driver using clk_set_rate(), but this method seems more cumbersome, as
>> this clk_set_rate does not
>> have anything to do with setting the rate, but only the phase shift
>> settings of the clock.
> I see, that does indeed sound a bit strange and is probably not the
> best API. I'm not that familiar with what is actually going on at the
> hardware level. Can you explain in a little more detail what the phase
> setting is about? What are the possible values here and what units
> are being used?
The phase shift settings for this clock is a way for the IP block to
meet the delay and hold
timing requirements for the different data modes of the SD. For example
by shifting the input
clock that is feeding the CIU by 90 degrees in SDR25 mode, the minimum
hold/delay time of 2ns
is achieved.

The values can be:
0  -> 0 degrees
0x1 -> 45 degrees
0x2 -> 90 degrees
0x3 -> 135 degrees
0x4 -> 180 degrees
0x5 -> 225 degrees
0x6 -> 270 degrees
0x7 -> 315 degrees
>
>>> I am a little confused though what the SYSMGR_SDMMCGRP_CTRL_OFFSET register actually
>>> does. It looks like this is just a clock divider, which should be represented as
>>> a separate clock node (as you had in v3) and compute the correct factor from the
>>> requested clock rate and the parent clock rate.
>> The SYSMGR_SDMMCGRP_CTRL_OFFSET is just putting the 2 values of
>> "samsung,dw-mshc-sdr-timing"
>> into a a single u32 value to be written to the register.
>> "samsung,dw-mshc-sdr-timing" has 2 values that
>> controls the phase shift of 2 clocks, the drive clock and the sample clock.
> Do other clocks ever have the same requirement? Would it make sense to have
> a generic clk_set_phase interface for this?
I am not aware of any other clocks that need these phase adjustments.
> If not, could the values alternatively (i.e. departing from the samsung
> method) be encoded in the clock specifier? That would come down to setting
> #clock-cells = <2> for this clock and using a complex clock in the mshc
> node to point at it using
>
> 	<&phandle $phase1 $phase2>
Hmm..this could also be done. I just sent out a V6 that uses the
clk_set_rate API. I believe
that there can be other platforms that can use this approach.

Thanks,
Dinh
> 	Arnd
>
> 	Arnd

