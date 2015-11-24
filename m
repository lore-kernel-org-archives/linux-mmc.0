From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: dw_mmc: HLE errors
Date: Tue, 24 Nov 2015 09:11:53 +0900
Message-ID: <5653AB49.3090901@samsung.com>
References: <56531E3B.6060601@linaro.org>
 <CAD=FV=Xuzgy2FLD4okzM0=fq752Agfu3DsxAGX1AaBhVYfYNYg@mail.gmail.com>
 <56534CFA.7070403@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:41427 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbKXALz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2015 19:11:55 -0500
In-reply-to: <56534CFA.7070403@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Dear, Jorge.

On 11/24/2015 02:29 AM, Jorge Ramirez-Ortiz wrote:
> On 11/23/2015 11:57 AM, Doug Anderson wrote:
>> Jorge,
>>
>> On Mon, Nov 23, 2015 at 6:10 AM, Jorge Ramirez-Ortiz
>> <jorge.ramirez-ortiz@linaro.org> wrote:
>>> Doug/Jaehoon,
>>>
>>> Were there any follow ups to this thread [1] from March 30, 2015?
>>> We are seeing HLE errors on 3.18 and we are trying to determine if a solution
>>> was ever delivered.
>>> On inspection, I can't find anything specific in recent kernels that address
>>> this particular issue (was the actual root cause identified?)
>>>
>>> I put together a possible work-around that avoids the HLE storm from occurring
>>> for this specific SoC [2].
>>> However we'd rather not merge this -or any other similar fix- if there is a
>>> generic solution already that we can pick up from mainline.
>> Nothing landed that I'm aware of.  Are you on SDIO, SD or eMMC?
>> Trying to do UHS?
> 
> SD even without UHS (yet, that is coming now)

If you want to use the upper mode than UHS-DDR50 for SD-card, you need to apply the below patch.

https://patchwork.kernel.org/patch/7456121/

Actually, this is not relevant to HLE error.

When sd-card is inserted/removed quickly, then sometime dwmmc controller is occurred the HLE error.
(Now, i can't see HLE error.)
So i had applied the some reset processing at my official repository.(It's not generic solution.)

> 
>>
>> I know that this patch mattered for me for UHS:
>>
>>   7c5209c315ea mmc: core: Increase delay for voltage to stabilize from
>> 3.3V to 1.8V
>>
>>
>> Also important for UHS (for at least some folks) were patches like:
>>
>>   9c85f37a2984 mmc: core: Add mmc_regulator_set_vqmmc()
>>
>> ...that attempted to get voltages more proper...
> 
> ack
> 
>>
>>
>> In the ChromeOS tree we did just land treating HLE errors as data and
>> cmd errors <https://patchwork.kernel.org/patch/5978711/>.  It's not
>> wonderful but it's better than letting an interrupt go off forever...
> 
> Yes I did try this patch on 3.18 but it didn't seem to be enough for us.
> Even though it would prevent the interrupt storm from flooding the kernel, once
> the event triggered and the interrupt was handled no more card
> insertions/ejections would be detected.

If HLE error will be reproduce with the generic sequence, I think we can find the generic solution.
So could you explain to me in more detail? If i can reproduce with v3.18, i will try to test it.
Your case will be helpful to me for solving the HLE error.

Best Regards,
Jaehoon Chung

> 
> ok, thanks for the info!
> 
> 
> 
> 
> 

