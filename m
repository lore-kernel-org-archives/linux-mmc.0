From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 00/15] mmc: sdhci: Add 64-bit ADMA support
Date: Thu, 30 Oct 2014 10:40:12 +0200
Message-ID: <5451F96C.6070606@intel.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com> <5451E802.1010704@intel.com> <2905300.MGH0Qn3mUo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:25714 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758523AbaJ3InG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Oct 2014 04:43:06 -0400
In-Reply-To: <2905300.MGH0Qn3mUo@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 30/10/14 10:05, Arnd Bergmann wrote:
> On Thursday 30 October 2014 09:25:54 Adrian Hunter wrote:
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
> You still haven't addressed my comments about clearing
> the SDHCI_USE_64_BIT_DMA flag if the platform finds that
> hardware has set this bit incorrectly.

Yes I did.  I said there was no need:

	http://marc.info/?l=linux-mmc&m=141449082331402&w=2

I would also note that the SDHCI spec does not say explicitly
that a 64-bit device supports 32-bit DMA descriptors.

If the hardware really is broken, the SDHCI_QUIRK2_BROKEN_64_BIT_DMA
should be used.

