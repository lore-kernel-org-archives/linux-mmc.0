From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Use the mmc host device index as the mmcblk
 device index
Date: Mon, 16 May 2016 12:12:42 +0300
Message-ID: <57398F0A.7070600@intel.com>
References: <1460015861-14004-1-git-send-email-ulf.hansson@linaro.org>
 <CA+7w51h=A4vVjkJTEvNoRG=GRt-GPSwqN4N4P3k-OqnubPo+kg@mail.gmail.com>
 <CAPDyKFp8pfZ1iY7HsAZL1f2qgTuLcimDL_f1k59RMcUq5f-iRQ@mail.gmail.com>
 <570B9C8D.2000600@intel.com>
 <CA+7w51iP3Th-m8kqdx_iObEs+kYJruNd62f5n2OfD0XaeGw=9w@mail.gmail.com>
 <570E2B2D.1080507@intel.com>
 <CA+7w51gUcPz+z8eD8A3dtB7r_Pvr8yO1AjymXC14eq9RgN6skQ@mail.gmail.com>
 <CAPDyKFq=B0PAxCLJgATSzO9zDHR_L7qOVn7PZ0seekbAb0YRPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2904 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432AbcEPJRl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 May 2016 05:17:41 -0400
In-Reply-To: <CAPDyKFq=B0PAxCLJgATSzO9zDHR_L7qOVn7PZ0seekbAb0YRPw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Laszlo Fiat <laszlo.fiat@gmail.com>, Nick Krause <xerofoify@gmail.com>

On 16/05/16 11:47, Ulf Hansson wrote:
> + Nicholas Krause
> 
> On 13 April 2016 at 20:19, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
>> Adrian, Ulf,
>>
>> Here are the two v4.6-rc3 kernel dmesg with mmc-debug option, both
>> without additional patches, one working case [1], one failing case
>> [2], the working case has patch [3] reverted.
>>
>> I also uploaded the acpidump [4] for Teclast X80h Baytrail-T tablet.
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c11
>> [2]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c10
>> [3]: patch 520bd7a8b4152aacfbd34eb7f7a447354b631039 ("mmc: core:
>> Optimize boot time by detecting cards simultaneously")
>> [4]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c12
>>
> 
> Adrian, did you manage to get some time to look into the debug data
> from this issue?

Not yet.

> I understand if you have been busy and no worries, although I don't
> know who else to ping about this.

I will have a look today.

> 
> I don't want to us revert 520bd7a8b4152aacfbd34eb7f7a447354b631039,
> because I believe it will just hide the problem in sdhci(-acpi).
> Instead, I intend to wait for a proper fix, does that sounds
> reasonable to you as well?

Sure


