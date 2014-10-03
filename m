From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/7] mmc: Some Braswell patches
Date: Fri, 03 Oct 2014 15:58:51 +0300
Message-ID: <542E9D8B.4080501@intel.com>
References: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com> <CAPDyKFro_jDAuD1Hgk4hBePRLh0_Y9yKNuEzGVRoJ2ErKsXf3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:19694 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbaJCNAa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Oct 2014 09:00:30 -0400
In-Reply-To: <CAPDyKFro_jDAuD1Hgk4hBePRLh0_Y9yKNuEzGVRoJ2ErKsXf3A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 03/10/14 15:57, Ulf Hansson wrote:
> On 24 September 2014 09:27, Adrian Hunter <adrian.hunter@intel.com> wrote:
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
> 
> Thanks! Applied for next. It required a minor fix for patch 5, since
> the mmc_gpiod_request_cd() now takes one more parameter.

Thank you!

