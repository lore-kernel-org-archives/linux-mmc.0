From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 00/13] mmc: host: Add facility to support re-tuning
Date: Tue, 13 Jan 2015 12:27:44 +0100
Message-ID: <CAPDyKFqFKKWnV9P8bm153CYB7DHwh3fEFSp_nK+vivL6P2NuHQ@mail.gmail.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:51546 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbbAML1p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 06:27:45 -0500
Received: by mail-qa0-f45.google.com with SMTP id n8so1588105qaq.4
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jan 2015 03:27:44 -0800 (PST)
In-Reply-To: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 5 December 2014 at 18:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are some patches to move re-tuning support out of
> sdhci and into the core, and add support for HS400
> re-tuning.
>
> Currently sdhci does re-tuning transparently by
> calling sdhci_execute_tuning() from its ->request()
> function.
>
> The problem with HS400 re-tuning is that it must be
> done in HS200 mode. That means using switch commands
> and making ios changes. That means it potentially
> conflicts with other command sequences. The new
> re-tuning support accomodates that, however it is
> not strictly necessary because HS400 re-tuning
> should only be needed after runtime suspend when
> there would not be a conflict.
>
> Nevertheless, this approach has more structure
> and potentially more flexibility.
>
>
> Adrian Hunter (13):
>       mmc: core: Simplify by adding mmc_execute_tuning()
>       mmc: host: Add facility to support re-tuning
>       mmc: core: Disable re-tuning when card is no longer initialized
>       mmc: core: Move mmc_card_removed() into mmc_start_request()
>       mmc: core: Add support for re-tuning before each request
>       mmc: core: Check re-tuning before retrying
>       mmc: core: Hold re-tuning during switch commands
>       mmc: core: Hold re-tuning during erase commands
>       mmc: core: Hold re-tuning while bkops ongoing
>       mmc: mmc: Comment that callers need to hold re-tuning if the card is put to sleep
>       mmc: core: Add support for HS400 re-tuning
>       mmc: sdhci: Always init buf_ready_int
>       mmc: sdhci: Change to new way of doing re-tuning

I have applied patch1, patch4, and patch12. Let's discuss more about
the re-tuning timer in the other thread for how to proceed with the
rest of the patches.

Kind regards
Uffe

>
>  drivers/mmc/core/core.c    |  93 +++++++++++++++++++++++++++++++-----
>  drivers/mmc/core/core.h    |   5 ++
>  drivers/mmc/core/host.c    |  63 +++++++++++++++++++++++++
>  drivers/mmc/core/mmc.c     |  58 ++++++++++++++++++-----
>  drivers/mmc/core/mmc_ops.c |  31 ++++++++----
>  drivers/mmc/core/sd.c      |  13 ++---
>  drivers/mmc/core/sdio.c    |  14 ++----
>  drivers/mmc/host/sdhci.c   | 115 ++++++---------------------------------------
>  include/linux/mmc/host.h   |  58 +++++++++++++++++++++++
>  include/linux/mmc/sdhci.h  |   3 --
>  10 files changed, 296 insertions(+), 157 deletions(-)
>
>
> Regards
> Adrian
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
