From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: sdhci: Minor fixes
Date: Mon, 10 Oct 2016 14:38:33 +0200
Message-ID: <CAPDyKFoVECA96-8rEJe9fqaGaLCC9Jy_obtHuTRP1XKDpGba7w@mail.gmail.com>
References: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32823 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbcJJMqF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Oct 2016 08:46:05 -0400
Received: by mail-qk0-f171.google.com with SMTP id n189so108591694qke.0
        for <linux-mmc@vger.kernel.org>; Mon, 10 Oct 2016 05:46:04 -0700 (PDT)
In-Reply-To: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 5 October 2016 at 11:11, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are a couple of minor fixes.  While it would be good to have them in
> 4.9 or a 4.9-rc, they are not urgent.
>
>
> Adrian Hunter (4):
>       mmc: sdhci: Fix SDHCI_QUIRK2_STOP_WITH_TC
>       mmc: sdhci: Rename sdhci_set_power() to sdhci_set_power_noreg()
>       mmc: sdhci-pci: Let devices define their own sdhci_ops
>       mmc: sdhci-pci: Fix bus power failing to enable for some Intel controllers
>
>  drivers/mmc/host/sdhci-pci-core.c | 54 ++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-pci.h      |  2 ++
>  drivers/mmc/host/sdhci-pxav3.c    |  2 +-
>  drivers/mmc/host/sdhci.c          | 40 ++++++++++++++---------------
>  drivers/mmc/host/sdhci.h          |  2 ++
>  5 files changed, 77 insertions(+), 23 deletions(-)
>
>
> Regards
> Adrian


Thanks, applied for fixes!

Kind regards
Uffe
