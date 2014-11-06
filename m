From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 0/4] mmc: sdhci: Add HS400 support to SDHCI driver
Date: Thu, 6 Nov 2014 14:33:56 +0100
Message-ID: <CAPDyKFpx7N2m123s-H03Y1v3QWFgrgDRDE633qKZE=OV0_jj3A@mail.gmail.com>
References: <1415279946-5054-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:53289 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbaKFNd6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Nov 2014 08:33:58 -0500
Received: by mail-qc0-f180.google.com with SMTP id o8so736929qcw.11
        for <linux-mmc@vger.kernel.org>; Thu, 06 Nov 2014 05:33:56 -0800 (PST)
In-Reply-To: <1415279946-5054-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 6 November 2014 14:19, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here is version 3 of some patches for SDHCI to support HS400 mode.
>
> Changes in V3:
>
>         mmc: sdhci: Clear also HS400 1.2V capability if 1.2V is not supported
>                 Rename MMC_CAPS2_HSX00_1_2V to MMC_CAP2_HSX00_1_2V
>
> Changes in V2:
>
>         mmc: sdhci: Clear also HS400 1.2V capability if 1.2V is not supported
>                 Rename MMC_CAPS2_1_2V to MMC_CAPS2_HSX00_1_2V
>
>         mmc: sdhci: Add HS400 support to SDHCI driver
>                 Re-base on Ulf's current tree which required moving
>                 SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 to the next free
>                 quirk2 bit
>
>
> Adrian Hunter (4):
>       mmc: sdhci: Remove unused SDHCI_CTRL_HS_SDR200
>       mmc: sdhci: Fix vqmmc error setting
>       mmc: sdhci: Clear also HS400 1.2V capability if 1.2V is not supported
>       mmc: sdhci: Add HS400 support to SDHCI driver
>
>  drivers/mmc/host/sdhci.c  | 28 ++++++++++++++++++++--------
>  drivers/mmc/host/sdhci.h  |  4 +++-
>  include/linux/mmc/host.h  |  1 +
>  include/linux/mmc/sdhci.h |  2 ++
>  4 files changed, 26 insertions(+), 9 deletions(-)
>

Thanks! Applied for next.

Kind regards
Uffe
