From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/15] mmc: sdhci: Add 64-bit ADMA support
Date: Mon, 3 Nov 2014 15:40:10 +0100
Message-ID: <CAPDyKFr5PvQeXRsD5wCuriDmqbtun7U4a75zfro0vYNALeNnrg@mail.gmail.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
	<5451E802.1010704@intel.com>
	<54573CB1.9030907@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:42768 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbaKCOkL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Nov 2014 09:40:11 -0500
Received: by mail-qa0-f42.google.com with SMTP id k15so6657809qaq.15
        for <linux-mmc@vger.kernel.org>; Mon, 03 Nov 2014 06:40:10 -0800 (PST)
In-Reply-To: <54573CB1.9030907@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "arnd@arndb.de >> Arnd Bergmann" <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 3 November 2014 09:28, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 30/10/14 09:25, Adrian Hunter wrote:
>> On 21/10/14 12:26, Adrian Hunter wrote:
>>> Hi
>>>
>>> Here are patches to add 64-bit ADMA support to the SDHCI driver.
>>>
>>> The patchset starts with 3 minor fixes related to SDHCI ADMA,
>>> then there are 8 preparatory patches, then 3 main patches, then
>>> the mmc_test "Badly aligned" tests are extended slightly.
>>
>> Hi Ulf
>>
>> Can you take these?  Note that there was a V2 of
>> "mmc: sdhci-acpi: Add 64-bit DMA support".  Also
>> that patch is dependent (for functionality not
>> compilation) on a patch in v3.18-rc2 so it is slightly
>> preferable if you pull v3.18-rc2 first.
>
> Can you take these now?

Thanks, applied for next!

If Arnd have some more thoughts or would like to provide his reviewed
by I may update/drop them.

Kind regards
Uffe
