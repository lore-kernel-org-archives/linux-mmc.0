From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: sdhci: runtime suspend/resume on card insert/removal
Date: Mon, 14 Sep 2015 15:45:43 +0530
Message-ID: <55F69E4F.8010608@linaro.org>
References: <55F12CF8.50003@linaro.org> <20150910153129.07adbe68@xhacker>
 <20150910080233.GH21084@n2100.arm.linux.org.uk>
 <20150910160402.3b78b5c6@xhacker> <55F66874.2000609@linaro.org>
 <20150914142838.07ec6a07@xhacker> <55F681AC.2010605@linaro.org>
 <20150914161804.101dfc55@xhacker> <55F69121.3030700@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33047 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbbINKPt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 06:15:49 -0400
Received: by pacex6 with SMTP id ex6so140805542pac.0
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2015 03:15:48 -0700 (PDT)
In-Reply-To: <55F69121.3030700@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, ulf.hansson@linaro.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, nico@fluxnic.net



On Monday 14 September 2015 02:49 PM, Vaibhav Hiremath wrote:
>
>
> On Monday 14 September 2015 01:48 PM, Jisheng Zhang wrote:
>> On Mon, 14 Sep 2015 13:43:32 +0530
>> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>>
>>>
>>>
>>> On Monday 14 September 2015 11:58 AM, Jisheng Zhang wrote:
>>>> On Mon, 14 Sep 2015 11:55:56 +0530
>>>> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>>>>
>>>>>
>>>>>
>>>>> On Thursday 10 September 2015 01:34 PM, Jisheng Zhang wrote:
>>>>>> Hi Russell,
>>>>>>
>>>>>> On Thu, 10 Sep 2015 09:02:33 +0100
>>>>>> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>>>>>>
>>>>>>> On Thu, Sep 10, 2015 at 03:31:29PM +0800, Jisheng Zhang wrote:
>>>>>>>> Hi Vaibhav,
>>>>>>>>
>>>>>>>> On Thu, 10 Sep 2015 12:40:48 +0530
>>>>>>>> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>

<snip>

>>> I have confirmed that the runtime PM is working perfectly fine,
>>> clock is gated/disabled on card removal.
>>
>> But seems we still didn't know the sdhci host is clock gated or power
>> gated.
>>
>
> Register above is
> SDIO Host 1 Clock/Reset Control Register
>
> And bit 3 & 4 says
>
> BIT 3:
>
> SD Host 1 Peripheral Clock Enable
>    0x1: Peripheral clock enabled
>    0x0: Peripheral clock disabled
>
> BIT4:
>
> SD Host 1 AXI Clock Enable
>    0x1: AXI clock enabled
>    0x0: AXI clock disabled
>
>
>>>
>>>
>>> Clock Gating:
>>> =============
>>> #
>>> # devmem 0xd4282854
>>> 0x0000181B
>>> # [ 1318.948460] mmc1: card 1234 removed
>>>
>>> #
>>> # devmem 0xd4282854
>>> 0x00001800
>>> #
>>
>> Can you plz read the SDHCI host registers after this step? If the host is
>> clock gated, we should get "asynchronous external abort" in theory.
>>
>
> Ok, that's another way. I can cross check on this.
>

Came across below lines in the datasheet,

========= Copy-n-paste from datasheet============

All SDH interfaces share the same clock which is enabled when any of the 
SDH clock enables are
set (from PMUA_SDH1_CLK_RES_CTRL, PMUA_SDH2_CLK_RES_CTRL,
PMUA_SDH3_CLK_RES_CTRL, PMUA_SDH4_CLK_RES_CTRL,
PMUA_SDH5_CLK_RES_CTRL), with clock source select and divider ratio 
controlled by
PMUA_SDH1_CLK_RES_CTRL.

==================================================


And I can confirm that after disabling AXI interface clock for all the
SDH modules (1-5) I see I get an abort.

This clearly explains/justifies/proves that the existing code is
working as expected. I have eMMC mounted on the board, which makes
clock to always stay ON on SDH3.

So there is an OR gate implemented inside which takes input from
SDHx_AXI_EN and feeds back to all SDHx instances. Don't ask me why it
has been designed that way :)

And I did some experiment as well, so what I have observed is,
SDH_AXI_CLOCK is required to generate card detection, without that I do
not see card detection working.

So Jisheng,
The change/patch which I was referring to now is more clear and I
believe now you would realize that it is required for SDH to work on
PXA1928 platform.


If you have access to internal documentation or someone who knows the
design, please try to cross check.

Thanks,
Vaibhav
