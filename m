From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Use the mmc host device index as the mmcblk
 device index
Date: Mon, 16 May 2016 10:47:33 +0200
Message-ID: <CAPDyKFq=B0PAxCLJgATSzO9zDHR_L7qOVn7PZ0seekbAb0YRPw@mail.gmail.com>
References: <1460015861-14004-1-git-send-email-ulf.hansson@linaro.org>
	<CA+7w51h=A4vVjkJTEvNoRG=GRt-GPSwqN4N4P3k-OqnubPo+kg@mail.gmail.com>
	<CAPDyKFp8pfZ1iY7HsAZL1f2qgTuLcimDL_f1k59RMcUq5f-iRQ@mail.gmail.com>
	<570B9C8D.2000600@intel.com>
	<CA+7w51iP3Th-m8kqdx_iObEs+kYJruNd62f5n2OfD0XaeGw=9w@mail.gmail.com>
	<570E2B2D.1080507@intel.com>
	<CA+7w51gUcPz+z8eD8A3dtB7r_Pvr8yO1AjymXC14eq9RgN6skQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34114 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbcEPIrf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2016 04:47:35 -0400
Received: by mail-wm0-f49.google.com with SMTP id v200so13783746wmv.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2016 01:47:34 -0700 (PDT)
In-Reply-To: <CA+7w51gUcPz+z8eD8A3dtB7r_Pvr8yO1AjymXC14eq9RgN6skQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Laszlo Fiat <laszlo.fiat@gmail.com>, Nick Krause <xerofoify@gmail.com>

+ Nicholas Krause

On 13 April 2016 at 20:19, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
> Adrian, Ulf,
>
> Here are the two v4.6-rc3 kernel dmesg with mmc-debug option, both
> without additional patches, one working case [1], one failing case
> [2], the working case has patch [3] reverted.
>
> I also uploaded the acpidump [4] for Teclast X80h Baytrail-T tablet.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c11
> [2]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c10
> [3]: patch 520bd7a8b4152aacfbd34eb7f7a447354b631039 ("mmc: core:
> Optimize boot time by detecting cards simultaneously")
> [4]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c12
>

Adrian, did you manage to get some time to look into the debug data
from this issue?
I understand if you have been busy and no worries, although I don't
know who else to ping about this.

I don't want to us revert 520bd7a8b4152aacfbd34eb7f7a447354b631039,
because I believe it will just hide the problem in sdhci(-acpi).
Instead, I intend to wait for a proper fix, does that sounds
reasonable to you as well?

Kind regards
Uffe

> On Wed, Apr 13, 2016 at 1:19 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 12/04/16 21:15, Laszlo Fiat wrote:
>>> Adrian, Ulf,
>>>
>>> All the mmc related patches are from [1] above. I have one extra patch
>>> for rfkill-gpio to get bluetooth working, and one to ignore efi-bgrt,
>>> but these are unrelated to mmc. Actually we can survive some time
>>> without the out-of-tree mmc patches, but usually we freeze within 1-2
>>> hours, that is why we need them.
>>>
>>> I have compiled a v4.6-rc3 vanilla, without any additional patches and
>>> with CONFIG_MMC_DEBUG=y, and created dmesg: [3]
>>
>> Looks like every command to the SDIO card fails.
>>
>>>
>>> I will compile the same one with the offending commit 520bd7a8b415
>>> reverted, so that we can compare what happens differently.
>>>
>>> For acpidump, which format do you need?
>>
>> Doesn't matter which format.
>>
>>>
>>> Thank you for looking into this.
>>>
>>> Best regards,
>>>
>>> Laszlo Fiat
>>>
>>> [3]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c10
>>>
>>> On Mon, Apr 11, 2016 at 2:46 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 11/04/16 11:25, Ulf Hansson wrote:
>>>>> + Adrian
>>>>>
>>>>> On 10 April 2016 at 20:04, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
>>>>>> Hello,
>>>>>>
>>>>>
>>>>> Hi Laszlo,
>>>>>
>>>>> Thanks for your report!
>>>>>
>>>>>> I have tested this patch on top of v4.6-rc2 + our usual out-of-tree
>>>>>> patches from [1], and there is still no SDIO wifi showing up on
>>>>>> baytrail-t. dmesg is available at [2].
>>>>>>
>>>>>> [1] https://github.com/hadess/rtl8723bs/tree/master/patches
>>>>>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=112571#c9
>>>>>>
>>>>>
>>>>> I understand this issue isn't for an upstream kernel, as you are
>>>>> carrying out of tree patches to enable sdhci, sdhci-acpi and sdhci-pci
>>>>> to work for your platform.
>>>>>
>>>>> As my bandwidth is limited, normally I can't spend time on
>>>>> non-upstream kernel reported regressions. Anyway, I decided to help
>>>>> study the kernel log in a bit more detail, but unfortunate I am not
>>>>> able to figure out what goes wrong.
>>>>>
>>>>> >From looking at the errors and a stack trace that gets dumped in the
>>>>> kernel log, my guess is that the problem lies within sdhci/sdhci-acpi.
>>>>> The errors seems related to your out of tree patches.
>>>>>
>>>>> Regarding commit 520bd7a8b415 ("mmc: core: Optimize boot time by
>>>>> detecting cards simultaneously"), even if it seems to be triggering
>>>>> the regression for you, I find it highly unlikely that this is the
>>>>> root cause.
>>>>>
>>>>> Someone that knows Baytrail/sdhci-acpi needs to help out with
>>>>> debugging. Perhaps Adrian or some other Intel folkz are available!?
>>>>
>>>> Need to know exactly what patches you have.  Is it only the ones from [1] above?
>>>>
>>>> You could do an acpidump and also try the failing case with CONFIG_MMC_DEBUG=y.
>>>>
>>>
>>
