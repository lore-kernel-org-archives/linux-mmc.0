From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] use setup_timer() helper function.
Date: Wed, 27 Sep 2017 00:24:37 +0200
Message-ID: <CAPDyKFrL_SNu9Pgo_HuTSWqvmiiO8n3nkZaecZDHB9=hxaX30w@mail.gmail.com>
References: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:53401 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030416AbdIZWYi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2017 18:24:38 -0400
Received: by mail-it0-f49.google.com with SMTP id 85so4568144ith.2
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2017 15:24:38 -0700 (PDT)
In-Reply-To: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Allen Pais <allen.lkml@gmail.com>
Cc: brucechang@via.com.tw, Tony Olech <tony.olech@elandigitalsystems.com>, Pierre Ossman <pierre@ossman.eu>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 22 September 2017 at 14:07, Allen Pais <allen.lkml@gmail.com> wrote:
> This series uses setup_timer() helper function. The series
> addresses the files under drivers/mmc/host/*.
>
>
> Allen Pais (4):
>   mmc-host: wbsd: use setup_timer() helper.
>   mmc-host: via: use setup_timer() helper.
>   mmc-host: vub300: use setup_timer() helper.
>   mmc-host: mxcmmc: use setup_timer() helper.
>
>  drivers/mmc/host/mxcmmc.c    |  4 +---
>  drivers/mmc/host/via-sdmmc.c |  4 +---
>  drivers/mmc/host/vub300.c    | 10 ++++------
>  drivers/mmc/host/wbsd.c      |  5 ++---
>  4 files changed, 8 insertions(+), 15 deletions(-)
>
> --
> 2.7.4
>

Thanks, applied for next!

Kind regards
Uffe
