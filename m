From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: sdhci: Fixes
Date: Mon, 7 Nov 2016 13:43:28 +0100
Message-ID: <CAPDyKFpLXD0ft6zEYHe0ekAzp24t=SBQB2-Mv602xV+K_UBw3g@mail.gmail.com>
References: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37626 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbcKGMna (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 07:43:30 -0500
Received: by mail-wm0-f50.google.com with SMTP id t79so174754273wmt.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 04:43:30 -0800 (PST)
In-Reply-To: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Harjani Ritesh <riteshh@codeaurora.org>

On 2 November 2016 at 14:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are 4 small sdhci fixes.  Some of the fixes improve sdhci ability to
> deal with errors (e.g. CRC errors ) when software command queuing is active.
>
>
> Adrian Hunter (4):
>       mmc: sdhci: Fix CMD line reset interfering with ongoing data transfer
>       mmc: sdhci: Fix unexpected data interrupt handling
>       mmc: sdhci: Reset cmd and data circuits after tuning failure
>       mmc: sdhci: Fix missing enhanced strobe setting during runtime resume
>
>  drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
>
> Regards
> Adrian

Thanks, applied for fixes!

Kind regards
Uffe
