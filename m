From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/2] mmc: sdhci-pci: Enable card detect wake for Intel
 BYT-related SD card host controllers
Date: Tue, 13 Jun 2017 14:22:11 +0200
Message-ID: <CAPDyKFpfptayY6mu839-5viEf6_Mwr0U0BrOFoO3y+ad1OmB_Q@mail.gmail.com>
References: <1497355672-12980-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36109 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdFMMWM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2017 08:22:12 -0400
Received: by mail-qt0-f178.google.com with SMTP id u19so169057800qta.3
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2017 05:22:12 -0700 (PDT)
In-Reply-To: <1497355672-12980-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 13 June 2017 at 14:07, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are 2 small patches to enable card detect wake for Intel BYT-related
> SD card host controllers.
>
>
> Changes in V2:
>         Use a host capability to select card detect wake
>
>
> Adrian Hunter (2):
>       mmc: slot-gpio: Add support to enable irq wake on cd_irq
>       mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD card host controllers
>
>  drivers/mmc/core/core.c           | 5 ++++-
>  drivers/mmc/core/slot-gpio.c      | 2 ++
>  drivers/mmc/host/sdhci-pci-core.c | 2 +-
>  include/linux/mmc/host.h          | 2 ++
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
>
> Regards
> Adrian

Thanks, applied for next!

Kind regards
Uffe
