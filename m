From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH v2 0/6] Try to get rid of CONFIG_MMC_DEBUG
Date: Thu, 27 Jul 2017 16:48:23 +0200
Message-ID: <CAPDyKForAcA7UF29QEwGP7vzxYWZj0qEPHFdMb9nN75b7RUi2g@mail.gmail.com>
References: <1500450661-158463-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33886 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdG0OsZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2017 10:48:25 -0400
Received: by mail-qk0-f182.google.com with SMTP id u139so42266752qka.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2017 07:48:25 -0700 (PDT)
In-Reply-To: <1500450661-158463-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 19 July 2017 at 09:50, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> CONFIG_MMC_DEBUG was introduced long time ago and mostly
> it's a all-or-none proposition for compile-time. By looking
> at how the mmc core use it, it's obviously pointless to still
> carry on this option.
>
> But referring to the host drivers, it's hard to say should we
> remove it now. The following drivers[1] will print some extra log
> on irq context for debugging. Probably folks still need to debug
> it sometimes but making it default behaviour seems to introduce some
> unnecessary burden for their drivers I guess. Anyway, we downgrade this
> option for hosts only and ask the following added host drivers to use
> this for debugging instead of adding their private macro to activate
> their debug functions.
>
> This patchset also cleanup wbsd and improve sdhci a bit.
>
> [1]:
> drivers/mmc/host/s3cmci.c
> drivers/mmc/host/omap.c
> drivers/mmc/host/omap_hsmmc.c
> drivers/mmc/host/tmio_mmc_core.c
>
>
> Changes in v2:
> - rework the changes for sdhci suggested by Adrian
>
> Shawn Lin (6):
>   mmc: core: remove check of host->removed for rescan routine
>   mmc: core: always check the length of sglist with total data size
>   mmc: core: turn the pr_info under CONFIG_MMC_DEBUG into pr_debug
>   mmc: Kconfig: downgrade CONFIG_MMC_DEBUG for host drivers only
>   mmc: wbsd: remove CONFIG_MMC_DEBUG from the driver
>   mmc: sdhci: remove CONFIG_MMC_DEBUG from the driver
>
>  drivers/mmc/Kconfig      |  7 -------
>  drivers/mmc/Makefile     |  2 --
>  drivers/mmc/core/core.c  | 35 +++++++----------------------------
>  drivers/mmc/host/Kconfig |  9 +++++++++
>  drivers/mmc/host/sdhci.c | 15 +++++++--------
>  drivers/mmc/host/wbsd.c  |  2 --
>  include/linux/mmc/host.h |  3 ---
>  7 files changed, 23 insertions(+), 50 deletions(-)
>
> --

Thanks, applied for next!

Kind regards
Uffe
