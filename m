From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/7] mmc: Some Braswell patches
Date: Thu, 02 Oct 2014 08:04:33 +0300
Message-ID: <542CDCE1.4070900@intel.com>
References: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com> <542A9C20.8060902@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:50577 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaJBFF6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 2 Oct 2014 01:05:58 -0400
In-Reply-To: <542A9C20.8060902@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Ping?

On 30/09/14 15:03, Adrian Hunter wrote:
> Hi
> 
> Any comments on these?
> 
> 
> On 24/09/14 10:27, Adrian Hunter wrote:
>> Hi
>>
>> Here are some patches to further support for Intel Braswell
>> SoC.
>>
>>
>> Adrian Hunter (7):
>>       mmc: sdhci: Add quirk for always getting TC with stop cmd
>>       mmc: sdhci-acpi: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers
>>       mmc: sdhci-acpi: Add a HID and UID for a SD Card host controller
>>       mmc: sdhci-pci: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers
>>       mmc: sdhci-pci: Add Bay Trail and Braswell SD card detect
>>       mmc: sdhci: Let a driver override timeout clock frequency
>>       mmc: sdhci-pci: Fix Braswell eMMC timeout clock frequency
>>
>>  drivers/mmc/host/sdhci-acpi.c |  6 ++++--
>>  drivers/mmc/host/sdhci-pci.c  | 28 +++++++++++++++++++++++++---
>>  drivers/mmc/host/sdhci-pci.h  |  4 ++++
>>  drivers/mmc/host/sdhci.c      | 14 ++++++++++++--
>>  include/linux/mmc/sdhci.h     |  2 ++
>>  5 files changed, 47 insertions(+), 7 deletions(-)
>>
>>
>> Regards
>> Adrian
> 
> 
> 

