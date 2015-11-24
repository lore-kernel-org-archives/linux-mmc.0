From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: dw_mmc: HLE errors
Date: Mon, 23 Nov 2015 20:55:15 -0500
Message-ID: <5653C383.3090802@linaro.org>
References: <56531E3B.6060601@linaro.org>
 <CAD=FV=Xuzgy2FLD4okzM0=fq752Agfu3DsxAGX1AaBhVYfYNYg@mail.gmail.com>
 <56534CFA.7070403@linaro.org> <5653AB49.3090901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35217 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbKXBzS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2015 20:55:18 -0500
Received: by vkha189 with SMTP id a189so2026477vkh.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2015 17:55:17 -0800 (PST)
In-Reply-To: <5653AB49.3090901@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Guodong Xu <guodong.xu@linaro.org>

On 11/23/2015 07:11 PM, Jaehoon Chung wrote:
> Dear, Jorge.
>
> On 11/24/2015 02:29 AM, Jorge Ramirez-Ortiz wrote:
>> On 11/23/2015 11:57 AM, Doug Anderson wrote:
>>> Jorge,
>>>
>>> On Mon, Nov 23, 2015 at 6:10 AM, Jorge Ramirez-Ortiz
>>> <jorge.ramirez-ortiz@linaro.org> wrote:
>>>> Doug/Jaehoon,
>>>>
>>>> Were there any follow ups to this thread [1] from March 30, 2015?
>>>> We are seeing HLE errors on 3.18 and we are trying to determine if a solution
>>>> was ever delivered.
>>>> On inspection, I can't find anything specific in recent kernels that address
>>>> this particular issue (was the actual root cause identified?)
>>>>
>>>> I put together a possible work-around that avoids the HLE storm from occurring
>>>> for this specific SoC [2].
>>>> However we'd rather not merge this -or any other similar fix- if there is a
>>>> generic solution already that we can pick up from mainline.
>>> Nothing landed that I'm aware of.  Are you on SDIO, SD or eMMC?
>>> Trying to do UHS?
>> SD even without UHS (yet, that is coming now)
> If you want to use the upper mode than UHS-DDR50 for SD-card, you need to apply the below patch.

ACK

>
> https://patchwork.kernel.org/patch/7456121/
>
> Actually, this is not relevant to HLE error.
>
> When sd-card is inserted/removed quickly, then sometime dwmmc controller is occurred the HLE error.
> (Now, i can't see HLE error.)
> So i had applied the some reset processing at my official repository.(It's not generic solution.)

Thanks, I'll have a look now.

I believe this to be your official repo:
https://github.com/jh80chung/dw-mmc

Please let me know if it is not.


>
>>> I know that this patch mattered for me for UHS:
>>>
>>>   7c5209c315ea mmc: core: Increase delay for voltage to stabilize from
>>> 3.3V to 1.8V
>>>
>>>
>>> Also important for UHS (for at least some folks) were patches like:
>>>
>>>   9c85f37a2984 mmc: core: Add mmc_regulator_set_vqmmc()
>>>
>>> ...that attempted to get voltages more proper...
>> ack
>>
>>>
>>> In the ChromeOS tree we did just land treating HLE errors as data and
>>> cmd errors <https://patchwork.kernel.org/patch/5978711/>.  It's not
>>> wonderful but it's better than letting an interrupt go off forever...
>> Yes I did try this patch on 3.18 but it didn't seem to be enough for us.
>> Even though it would prevent the interrupt storm from flooding the kernel, once
>> the event triggered and the interrupt was handled no more card
>> insertions/ejections would be detected.
> If HLE error will be reproduce with the generic sequence, I think we can find the generic solution.
> So could you explain to me in more detail? If i can reproduce with v3.18, i will try to test it.
> Your case will be helpful to me for solving the HLE error.


Yes, the issue is relatively easy to reproduce.

On this platform:
https://www.96boards.org/products/ce/hikey/

Using either debian [1] or android [2] releases and the latest UEFI [3]
[1] https://builds.96boards.org/snapshots/hikey/linaro/debian/379/
[2] https://builds.96boards.org/snapshots/hikey/linaro/aosp/197/
[3] https://builds.96boards.org/snapshots/hikey/linaro/uefi/89/

The kernel tree between android and debian is shared [4].
We are using the "hikey" branch (v3.18)
[4] https://github.com/96boards/linux

For my tests and to be able to handed the interrupt storm and monitor the
registers while it happens, I patched the kernel with a Xenomai [5] co-kernel.
This is my kernel tree [6]
[5] http://xenomai.org/
[6] http://git.xenomai.org/ipipe-jro.git/log/?h=hikey

To reproduce the problem all it was required was to insert/remove the SD card
rapidly until it triggers this condition:
[  229.974525] dwmmc_k3 f723e000.dwmmc1: Busy; trying anyway
 
When it triggered, and after patching the interrupt handler with some debug info
to show the distance between interrupts and the content of the MINTSTS register,
I could see the following:
mci_isr: 0x1000,  3333 ns
mci_isr: 0x1000,  3334 ns
mci_isr: 0x1000,  3333 ns
mci_isr: 0x1000,  3334 ns
mci_isr: 0x1000,  3333 ns
mci_isr: 0x1000,  2500 ns
mci_isr: 0x1000,  3334 ns
mci_isr: 0x1000,  2500 ns
mci_isr: 0x1000,  3333 ns
mci_isr: 0x1000,  3334 ns
mci_isr: 0x1000,  3334 ns
mci_isr: 0x1000,  3333 ns
mci_isr: 0x1000,  3334 ns
mci_isr: 0x1000,  2500 ns
mci_isr: 0x1000,  3334 ns
[...]

Notice that since the Xenomai co-kernel runs with a higher priority than the
Linux kernel, I was able to output this information to the console.

I put together a fix based on this commit from Doug;
mmc: dw_mmc: Don't start commands while busy
https://lkml.org/lkml/2015/2/20/508

In Doug's commit, we would delay sending a command until the SDMCC_STATUS_BUSY
cleared.
However if it never cleared, we'd go ahead and submit the command anyway.

I believe this is what was causing the HLE to be raised.
In order to prevent that from happening, I think we should abort the operation
completely.
My "extension" for the Hikey platform looks like this:
https://github.com/96boards/linux/commit/fe8d7f714d420121cec460e69f6529044a2cb6d

It could be made generic or the fix could have some other form of course.
I was only targeting the Hikey platform when I wrote this hoping that it would
have been fixed upstream.

Having said all of this, I am not sure what would cause the host status to
remain busy for so long (which is Ulf's biggest concern)
I also tried increasing some of the timers that wait for the voltages to ramp up
after power on but it didnt make any difference.

I captured most of the information above under this bug for reference.
https://bugs.96boards.org/show_bug.cgi?id=175



