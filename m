From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Use the mmc host device index as the mmcblk
 device index
Date: Wed, 13 Apr 2016 14:19:09 +0300
Message-ID: <570E2B2D.1080507@intel.com>
References: <1460015861-14004-1-git-send-email-ulf.hansson@linaro.org>
 <CA+7w51h=A4vVjkJTEvNoRG=GRt-GPSwqN4N4P3k-OqnubPo+kg@mail.gmail.com>
 <CAPDyKFp8pfZ1iY7HsAZL1f2qgTuLcimDL_f1k59RMcUq5f-iRQ@mail.gmail.com>
 <570B9C8D.2000600@intel.com>
 <CA+7w51iP3Th-m8kqdx_iObEs+kYJruNd62f5n2OfD0XaeGw=9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19498 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757690AbcDMLWz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Apr 2016 07:22:55 -0400
In-Reply-To: <CA+7w51iP3Th-m8kqdx_iObEs+kYJruNd62f5n2OfD0XaeGw=9w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laszlo Fiat <laszlo.fiat@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 12/04/16 21:15, Laszlo Fiat wrote:
> Adrian, Ulf,
> 
> All the mmc related patches are from [1] above. I have one extra patch
> for rfkill-gpio to get bluetooth working, and one to ignore efi-bgrt,
> but these are unrelated to mmc. Actually we can survive some time
> without the out-of-tree mmc patches, but usually we freeze within 1-2
> hours, that is why we need them.
> 
> I have compiled a v4.6-rc3 vanilla, without any additional patches and
> with CONFIG_MMC_DEBUG=y, and created dmesg: [3]

Looks like every command to the SDIO card fails.

> 
> I will compile the same one with the offending commit 520bd7a8b415
> reverted, so that we can compare what happens differently.
> 
> For acpidump, which format do you need?

Doesn't matter which format.

> 
> Thank you for looking into this.
> 
> Best regards,
> 
> Laszlo Fiat
> 
> [3]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c10
> 
> On Mon, Apr 11, 2016 at 2:46 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 11/04/16 11:25, Ulf Hansson wrote:
>>> + Adrian
>>>
>>> On 10 April 2016 at 20:04, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
>>>> Hello,
>>>>
>>>
>>> Hi Laszlo,
>>>
>>> Thanks for your report!
>>>
>>>> I have tested this patch on top of v4.6-rc2 + our usual out-of-tree
>>>> patches from [1], and there is still no SDIO wifi showing up on
>>>> baytrail-t. dmesg is available at [2].
>>>>
>>>> [1] https://github.com/hadess/rtl8723bs/tree/master/patches
>>>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=112571#c9
>>>>
>>>
>>> I understand this issue isn't for an upstream kernel, as you are
>>> carrying out of tree patches to enable sdhci, sdhci-acpi and sdhci-pci
>>> to work for your platform.
>>>
>>> As my bandwidth is limited, normally I can't spend time on
>>> non-upstream kernel reported regressions. Anyway, I decided to help
>>> study the kernel log in a bit more detail, but unfortunate I am not
>>> able to figure out what goes wrong.
>>>
>>> >From looking at the errors and a stack trace that gets dumped in the
>>> kernel log, my guess is that the problem lies within sdhci/sdhci-acpi.
>>> The errors seems related to your out of tree patches.
>>>
>>> Regarding commit 520bd7a8b415 ("mmc: core: Optimize boot time by
>>> detecting cards simultaneously"), even if it seems to be triggering
>>> the regression for you, I find it highly unlikely that this is the
>>> root cause.
>>>
>>> Someone that knows Baytrail/sdhci-acpi needs to help out with
>>> debugging. Perhaps Adrian or some other Intel folkz are available!?
>>
>> Need to know exactly what patches you have.  Is it only the ones from [1] above?
>>
>> You could do an acpidump and also try the failing case with CONFIG_MMC_DEBUG=y.
>>
> 

