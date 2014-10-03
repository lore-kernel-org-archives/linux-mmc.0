From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/7] mmc: Some Braswell patches
Date: Fri, 3 Oct 2014 14:57:17 +0200
Message-ID: <CAPDyKFro_jDAuD1Hgk4hBePRLh0_Y9yKNuEzGVRoJ2ErKsXf3A@mail.gmail.com>
References: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:49274 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbaJCM5S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Oct 2014 08:57:18 -0400
Received: by mail-qa0-f47.google.com with SMTP id cm18so791783qab.6
        for <linux-mmc@vger.kernel.org>; Fri, 03 Oct 2014 05:57:18 -0700 (PDT)
In-Reply-To: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 24 September 2014 09:27, Adrian Hunter <adrian.hunter@intel.com> wrote:
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

Thanks! Applied for next. It required a minor fix for patch 5, since
the mmc_gpiod_request_cd() now takes one more parameter.

Kind regards
Uffe
