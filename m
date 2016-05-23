From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: Fixes relating to Bus Width Testing on Intel platforms
Date: Mon, 23 May 2016 11:56:03 +0200
Message-ID: <CAPDyKFq3ZF-7UE2=vLgBqeeQGPTEZwSoPBhRAukj7bWZVB1Uaw@mail.gmail.com>
References: <1463729628-3517-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38051 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbcEWJ4G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2016 05:56:06 -0400
Received: by mail-wm0-f51.google.com with SMTP id n129so64870133wmn.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2016 02:56:04 -0700 (PDT)
In-Reply-To: <1463729628-3517-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 20 May 2016 at 09:33, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are a couple of fixes relating to Bus Width Testing and reading the
> Extended CSD register on Intel platforms.
>
>
> Adrian Hunter (2):
>       mmc: sdhci-pci: Remove MMC_CAP_BUS_WIDTH_TEST for Intel controllers
>       mmc: sdhci-acpi: Remove MMC_CAP_BUS_WIDTH_TEST for Intel controllers
>
> Matt Gumbel (1):
>       mmc: longer timeout for long read time quirk
>
>  drivers/mmc/card/block.c          | 5 +++--
>  drivers/mmc/core/core.c           | 4 ++--
>  drivers/mmc/host/sdhci-acpi.c     | 6 +++---
>  drivers/mmc/host/sdhci-pci-core.c | 5 +----
>  4 files changed, 9 insertions(+), 11 deletions(-)
>
>
> Regards
> Adrian

Thanks, applied all for fixes!

Kind regards
Uffe
