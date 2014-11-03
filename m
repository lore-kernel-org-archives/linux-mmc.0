From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 00/15] mmc: sdhci: Add 64-bit ADMA support
Date: Mon, 03 Nov 2014 10:28:33 +0200
Message-ID: <54573CB1.9030907@intel.com>
References: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com> <5451E802.1010704@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62839 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbaKCIaF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Nov 2014 03:30:05 -0500
In-Reply-To: <5451E802.1010704@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "arnd@arndb.de >> Arnd Bergmann" <arnd@arndb.de>

On 30/10/14 09:25, Adrian Hunter wrote:
> On 21/10/14 12:26, Adrian Hunter wrote:
>> Hi
>>
>> Here are patches to add 64-bit ADMA support to the SDHCI driver.
>>
>> The patchset starts with 3 minor fixes related to SDHCI ADMA,
>> then there are 8 preparatory patches, then 3 main patches, then
>> the mmc_test "Badly aligned" tests are extended slightly.
> 
> Hi Ulf
> 
> Can you take these?  Note that there was a V2 of
> "mmc: sdhci-acpi: Add 64-bit DMA support".  Also
> that patch is dependent (for functionality not
> compilation) on a patch in v3.18-rc2 so it is slightly
> preferable if you pull v3.18-rc2 first.

Can you take these now?

> 
> Regards
> Adrian
> 
>>
>>
>> Adrian Hunter (15):
>>       mmc: sdhci: Fix incorrect ADMA2 descriptor table size
>>       mmc: sdhci: Fix ADMA page boundary warnings
>>       mmc: sdhci: Fix ADMA table size warning
>>       mmc: sdhci: Rename two ADMA-related functions for consistency
>>       mmc: sdhci: Rename adma_desc to adma_table
>>       mmc: sdhci: Add sdhci_adma_mark_end()
>>       mmc: sdhci: Use 'void *' for not 'u8 *' for ADMA data
>>       mmc: sdhci: Parameterize ADMA sizes and alignment
>>       mmc: sdhci: Define maximum segments
>>       mmc: sdhci: Define ADMA constants
>>       mmc: sdhci: Define ADMA descriptor structure
>>       mmc: sdhci: Add 64-bit ADMA support
>>       mmc: sdhci-acpi: Add 64-bit DMA support
>>       mmc: sdhci-pci: Add 64-bit DMA support
>>       mmc: mmc_test: Extend "Badly aligned" tests for 8-byte alignment
>>
>>  drivers/mmc/card/mmc_test.c   |  10 +-
>>  drivers/mmc/host/sdhci-acpi.c |  41 +++++---
>>  drivers/mmc/host/sdhci-pci.c  |  14 ++-
>>  drivers/mmc/host/sdhci.c      | 226 +++++++++++++++++++++++++++---------------
>>  drivers/mmc/host/sdhci.h      |  41 ++++++++
>>  include/linux/mmc/sdhci.h     |  14 ++-
>>  6 files changed, 241 insertions(+), 105 deletions(-)
>>
>>
>> Regards
>> Adrian
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
> 
> 
> 

