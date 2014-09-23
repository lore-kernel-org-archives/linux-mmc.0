From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/13] mmc: Some Braswell and misc patches
Date: Tue, 23 Sep 2014 09:34:59 +0200
Message-ID: <CAPDyKFp9u1ausSkzo9wEM1YRH5aJb6BXmPmToncpgx5P95Rx-A@mail.gmail.com>
References: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:44759 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaIWHfA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Sep 2014 03:35:00 -0400
Received: by mail-qg0-f45.google.com with SMTP id q108so4025407qgd.32
        for <linux-mmc@vger.kernel.org>; Tue, 23 Sep 2014 00:35:00 -0700 (PDT)
In-Reply-To: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 22 September 2014 12:17, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are some patches to further support for Intel Braswell
> SoC plus some miscellaneous changes.
>
> The patches needed for Braswell are:
>
>       mmc: sdhci: Add quirk for always getting TC with stop cmd
>       mmc: sdhci-acpi: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers
>       mmc: sdhci-acpi: Add a HID and UID for a SD Card host controller
>       mmc: sdhci-pci: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers
>       mmc: sdhci-pci: Add Bay Trail and Braswell SD card detect
>       mmc: sdhci: Let a driver override timeout clock frequency
>       mmc: sdhci-pci: Fix Braswell eMMC timeout clock frequency
>

The above seems like a good argument to at least split this patchset
into two pieces, could you please do that?

Kind regards
Uffe

>
> Adrian Hunter (13):
>       mmc: Fix use of wrong device in mmc_gpiod_free_cd()
>       mmc: Fix incorrect warning when setting 0 Hz via debugfs
>       mmc: It is not an error for the card to be removed while suspended
>       mmc: block: Fix error recovery stop cmd timeout calculation
>       mmc: block: Fix SD card stop cmd response type
>       mmc: sdhci: Add quirk for always getting TC with stop cmd
>       mmc: sdhci-acpi: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers
>       mmc: sdhci-acpi: Add a HID and UID for a SD Card host controller
>       mmc: sdhci-pci: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers
>       mmc: sdhci-pci: Add Bay Trail and Braswell SD card detect
>       mmc: sdhci: Let a driver override timeout clock frequency
>       mmc: sdhci-pci: Fix Braswell eMMC timeout clock frequency
>       mmc: sdhci: Transfer Complete has higher priority than Data Timeout Error
>
>  drivers/mmc/card/block.c      | 30 ++++++++++++++++++++++++------
>  drivers/mmc/core/core.c       |  2 +-
>  drivers/mmc/core/mmc.c        |  2 +-
>  drivers/mmc/core/sd.c         |  2 +-
>  drivers/mmc/core/slot-gpio.c  |  2 +-
>  drivers/mmc/host/sdhci-acpi.c |  6 ++++--
>  drivers/mmc/host/sdhci-pci.c  | 28 +++++++++++++++++++++++++---
>  drivers/mmc/host/sdhci-pci.h  |  4 ++++
>  drivers/mmc/host/sdhci.c      | 27 +++++++++++++++++++--------
>  include/linux/mmc/sdhci.h     |  2 ++
>  10 files changed, 82 insertions(+), 23 deletions(-)
>
>
> Regards
> Adrian
