From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [RESEND LIST PATCHv7 1/4] clk: socfpga: Add a clk-phase property
 to the "altr, socfpga-gate-clk"
Date: Wed, 18 Dec 2013 22:04:10 -0600
Message-ID: <52B2703A.8090001@gmail.com>
References: <1387213476-22122-1-git-send-email-dinguyen@altera.com> <1387213476-22122-2-git-send-email-dinguyen@altera.com> <20131218205636.23538.50735@quantum> <201312182221.46506.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:36529 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab3LSEER (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 23:04:17 -0500
In-Reply-To: <201312182221.46506.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>
Cc: dinguyen@altera.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org


On 12/18/13 3:21 PM, Arnd Bergmann wrote:
> On Wednesday 18 December 2013, Mike Turquette wrote:
>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>> index f936476..616d9ee 100644
>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>> @@ -413,6 +413,7 @@
>>>                                                 compatible = "altr,socfpga-gate-clk";
>>>                                                 clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
>>>                                                 clk-gate = <0xa0 8>;
>>> +                                               clk-phase = <0 3>;
>> Looking at this again, I have a hard time understanding the values in
>> the clk-phase property. You reference some functions in the property
>> definition above, but they are not obvious to me.
>>
>> Additionally I wonder if the binding would better if the clock-phase
>> property was simply the value in degrees. E.g:
>>
>>         clk-phase = <315>;    // 315 degrees
> I would definitely prefer using degrees over an arbitrary enumeration that
> might work on some platforms but not on others.
>
> I'm also a bit skeptical about the idea of putting the phase into the clock
> provider rather than the consumer, given the comments about the
> clk_set_phase() interface earlier. Generally we try to avoid having
> consumer-specific settings in a provider node (for any DT binding,
> not just clocks). Can't you have the same numbers in the dw-mshc
> node instead and let the mmc driver call clk_set_phase instead?
> If every clock has a fixed phase for a given piece of hardware, it
> could even be set automatically by making the common clk code read
> the clk-phase attribute at the time a driver calls clk_get.

So I think this is what you're suggesting:
clocks = <&sdmmc_clk 0 135>, this would specify 0 and 135 degrees phase.

The clock-bindings document is stating that the integer in the clocks
property is
specifying the output number of the clock. Would this approach cause a
conflict and would
need an update to that document/approach?

Dinh

>
> 	Arnd

