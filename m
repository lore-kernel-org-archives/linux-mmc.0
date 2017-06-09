From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/2] mmc: sdio: Keep card runtime resumed while adding
 function devices
Date: Fri, 9 Jun 2017 15:29:34 +0200
Message-ID: <CAPDyKFrKN6ZCacVje-ODcjpMm8crv209BhV2adSz8Ja4B6-apQ@mail.gmail.com>
References: <1497011238-9573-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34716 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdFIN3k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 09:29:40 -0400
Received: by mail-qt0-f178.google.com with SMTP id c10so75560148qtd.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 06:29:40 -0700 (PDT)
In-Reply-To: <1497011238-9573-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 9 June 2017 at 14:27, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here is V2 of the patch to keep an SDIO card runtime resumed while adding
> function devices.
>
>
> Changes in V2:
>
>         mmc: sdio: Tidy error path in mmc_attach_sdio()
>                 New patch
>
>         mmc: sdio: Keep card runtime resumed while adding function devices
>                 Move call to pm_runtime_get_noresume() before
>                 pm_runtime_set_active().
>                 Do not use pm_runtime_put() incorrectly (or at all) in the
>                 error path.
>
>
> Adrian Hunter (2):
>       mmc: sdio: Tidy error path in mmc_attach_sdio()
>       mmc: sdio: Keep card runtime resumed while adding function devices
>
>  drivers/mmc/core/sdio.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
>
> Regards
> Adrian

Thanks, applied for next!

Kind regards
Uffe
