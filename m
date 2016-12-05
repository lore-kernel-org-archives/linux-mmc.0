From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/9] mmc: sdhci: Fix recovery from tuning timeout
Date: Mon, 5 Dec 2016 14:19:02 +0100
Message-ID: <CAPDyKFr28AShhBOoFGO9gQp3t7KZnB1XVSgXRY_0TuPwUkbDpQ@mail.gmail.com>
References: <1480684467-26833-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37011 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbcLENTE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2016 08:19:04 -0500
Received: by mail-wm0-f50.google.com with SMTP id t79so92390341wmt.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Dec 2016 05:19:04 -0800 (PST)
In-Reply-To: <1480684467-26833-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 2 December 2016 at 14:14, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are some small SDHCI tuning-related fixes and some clean-ups.
>
> Changes in V2:
>         Added clean-up patches
>
>
> Adrian Hunter (9):
>       Revert "mmc: sdhci: Reset cmd and data circuits after tuning failure"
>       mmc: sdhci: Fix recovery from tuning timeout
>       mmc: sdhci: Fix tuning reset after exhausting the maximum number of loops
>       mmc: sdhci: Always allow tuning to fall back to fixed sampling
>       mmc: mmc: Introduce mmc_abort_tuning()
>       mmc: sdhci: Use mmc_abort_tuning()
>       mmc: sdhci: Factor out tuning helper functions
>       mmc: sdhci: Simplify tuning block size logic
>       mmc: sdhci: Tidy tuning loop
>
>  drivers/mmc/core/mmc_ops.c |  25 ++++
>  drivers/mmc/host/sdhci.c   | 278 ++++++++++++++++++++++++---------------------
>  include/linux/mmc/core.h   |   1 +
>  3 files changed, 173 insertions(+), 131 deletions(-)
>
>
> Regards
> Adrian

Thanks, applied for next. I also picked v3 of patch 7/9.

Kind regards
Uffe
