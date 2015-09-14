From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: sdhci: runtime suspend/resume on card insert/removal
Date: Mon, 14 Sep 2015 18:35:08 +0530
Message-ID: <55F6C604.6020007@linaro.org>
References: <20150910080233.GH21084@n2100.arm.linux.org.uk>
 <20150910160402.3b78b5c6@xhacker> <55F66874.2000609@linaro.org>
 <20150914142838.07ec6a07@xhacker> <55F681AC.2010605@linaro.org>
 <20150914161804.101dfc55@xhacker> <55F69121.3030700@linaro.org>
 <55F69E4F.8010608@linaro.org> <20150914105014.GJ21084@n2100.arm.linux.org.uk>
 <55F6BEA4.1070803@linaro.org> <20150914124949.GM21084@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35153 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304AbbINNFP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 09:05:15 -0400
Received: by pacfv12 with SMTP id fv12so146968701pac.2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2015 06:05:15 -0700 (PDT)
In-Reply-To: <20150914124949.GM21084@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jisheng Zhang <jszhang@marvell.com>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, nico@fluxnic.net, ulf.hansson@linaro.org



On Monday 14 September 2015 06:19 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 14, 2015 at 06:03:40PM +0530, Vaibhav Hiremath wrote:
>> On Monday 14 September 2015 04:20 PM, Russell King - ARM Linux wrote:
>>> On Mon, Sep 14, 2015 at 03:45:43PM +0530, Vaibhav Hiremath wrote:
>>>> Came across below lines in the datasheet,
>>>>
>>>> ========= Copy-n-paste from datasheet============
>>>>
>>>> All SDH interfaces share the same clock which is enabled when any of the SDH
>>>> clock enables are
>>>> set (from PMUA_SDH1_CLK_RES_CTRL, PMUA_SDH2_CLK_RES_CTRL,
>>>> PMUA_SDH3_CLK_RES_CTRL, PMUA_SDH4_CLK_RES_CTRL,
>>>> PMUA_SDH5_CLK_RES_CTRL), with clock source select and divider ratio
>>>> controlled by
>>>> PMUA_SDH1_CLK_RES_CTRL.
>>>>
>>>> ==================================================
>>>>
>>>>
>>>> And I can confirm that after disabling AXI interface clock for all the
>>>> SDH modules (1-5) I see I get an abort.
>>>>
>>>> This clearly explains/justifies/proves that the existing code is
>>>> working as expected. I have eMMC mounted on the board, which makes
>>>> clock to always stay ON on SDH3.
>>>>
>>>> So there is an OR gate implemented inside which takes input from
>>>> SDHx_AXI_EN and feeds back to all SDHx instances. Don't ask me why it
>>>> has been designed that way :)
>>>>
>>>> And I did some experiment as well, so what I have observed is,
>>>> SDH_AXI_CLOCK is required to generate card detection, without that I do
>>>> not see card detection working.
>>>
>>> What that means is that if DT configures the interface to use its
>>> internal card detection, the AXI clock must never shut off when entering
>>> runtime-PM.
>>>
>>
>> Yes, exactly.
>> Its clock driver which is doing this.
>>
>> static struct mmp_param_gate_clk apmu_gate_clks[] = {
>>          /* The gate clocks has mux parent. */
>>          {PXA1928_CLK_SDH0, "sdh0_clk", "sdh_div", CLK_SET_RATE_PARENT,
>> PXA1928_CLK_SDH0 * 4, 0x1b, 0x1b, 0x0, 0, &sdh0_lock},
>> };
>>
>> Here the mask and enable_val both are set to 0x1b, which means it
>> shuts off both peripheral and AXI clock both.
>
> *Sigh*.
>
> So, rather than represent the hardware in DT by telling the SDHCI code
> that you have two independent clocks, you've chosen to do the brain
> dead thing, and combine the two clocks *which are logically different*
> to suit the Linux implementation, thereby leaking implementation details
> into DT, and creating a compatibility headache through doing so.
>
> Stop doing this.  Just stop it.  It's broken, it's wrong, and it's down
> right idiotic.
>
> DT should _always_ describe the bloody hardware, not the implementation.
>
> I suggest that you have only one way to solve this on this platform.
>
> 1. Declare new clocks from your PXA clock driver which expose the AXI
>     and peripheral clock separately.
> 2. Add code (if not already there) to the SDHCI crap-pile to claim and
>     appropriately manage these two clocks, falling back to the existing
>     but broken method with existing DT.
> 3. Change DT to provide the new clocks to SDHCI.
>
> That's about the only way I can see to ensure that an old DT file would
> continue to work with a new kernel, given this fsckup.
>

sdhci-pxav3 driver already handles both, in terms of 'core' and 'io'
clock. And it does disable both the clocks in runtime_pm_suspend()

So I have to find a way not to disable AXI clock here.

And yes, both clocks should be defined separately.

Looping Rob here as well.
Rob please add if I am missing anything here.

