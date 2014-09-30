From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/7] mmc: Some Braswell patches
Date: Tue, 30 Sep 2014 15:03:44 +0300
Message-ID: <542A9C20.8060902@intel.com>
References: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4029 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbaI3MFb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Sep 2014 08:05:31 -0400
In-Reply-To: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Any comments on these?


On 24/09/14 10:27, Adrian Hunter wrote:
> Hi
> 
> Here are some patches to further support for Intel Braswell
> SoC.
> 
> 
> Adrian Hunter (7):
>       mmc: sdhci: Add quirk for always getting TC with stop cmd
>       mmc: sdhci-acpi: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers
>       mmc: sdhci-acpi: Add a HID and UID for a SD Card host controller
>       mmc: sdhci-pci: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers
>       mmc: sdhci-pci: Add Bay Trail and Braswell SD card detect
>       mmc: sdhci: Let a driver override timeout clock frequency
>       mmc: sdhci-pci: Fix Braswell eMMC timeout clock frequency
> 
>  drivers/mmc/host/sdhci-acpi.c |  6 ++++--
>  drivers/mmc/host/sdhci-pci.c  | 28 +++++++++++++++++++++++++---
>  drivers/mmc/host/sdhci-pci.h  |  4 ++++
>  drivers/mmc/host/sdhci.c      | 14 ++++++++++++--
>  include/linux/mmc/sdhci.h     |  2 ++
>  5 files changed, 47 insertions(+), 7 deletions(-)
> 
> 
> Regards
> Adrian

