From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/7] mmc: Some fixes
Date: Fri, 27 Nov 2015 14:27:22 +0100
Message-ID: <CAPDyKFrvUBNXx4QO06_Yfih4SP1pGzMdqd3Q_tMMWGC330A_-g@mail.gmail.com>
References: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34724 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbbK0N1X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Nov 2015 08:27:23 -0500
Received: by ykfs79 with SMTP id s79so119009533ykf.1
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2015 05:27:23 -0800 (PST)
In-Reply-To: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wenkai Du <wenkai.du@intel.com>

On 26 November 2015 at 13:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are some fixes.  The important ones have cc: stable.
> It doesn't matter to me whether you queue them as fixes
> or for v4.5.
>
>
> Adrian Hunter (6):
>       mmc: sdhci-pci: Do not default to 33 Ohm driver strength for Intel SPT
>       mmc: sdhci: Do not BUG on invalid vdd
>       mmc: sdio: Fix invalid vdd in voltage switch power cycle
>       mmc: sdhc: Fix DMA descriptor with zero data length
>       mmc: sdhci: 64-bit DMA actually has 4-byte alignment
>       mmc: sdhci: Fix sdhci_runtime_pm_bus_on/off()
>
> Wenkai Du (1):
>       mmc: mmc: Fix incorrect use of driver strength switching HS200 and HS400
>
>  drivers/mmc/core/mmc.c            |  6 ++---
>  drivers/mmc/core/sdio.c           |  2 +-
>  drivers/mmc/host/sdhci-pci-core.c |  2 +-
>  drivers/mmc/host/sdhci.c          | 49 +++++++++++++++++++--------------------
>  drivers/mmc/host/sdhci.h          | 21 ++++++++++-------
>  5 files changed, 40 insertions(+), 40 deletions(-)
>
>
> Regards
> Adrian


Thanks, applied for next!

Kind regards
Uffe
