From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] More MMC block core cleanup
Date: Fri, 18 Nov 2016 15:30:09 +0100
Message-ID: <CAPDyKFo6LVv_hUXYO-A2pTds71g6nacVrzamGT2ujrz09t+J2w@mail.gmail.com>
References: <1479472576-2687-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35416 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753338AbcKROaM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 09:30:12 -0500
Received: by mail-wm0-f43.google.com with SMTP id a197so41852926wmd.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2016 06:30:11 -0800 (PST)
In-Reply-To: <1479472576-2687-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

On 18 November 2016 at 13:36, Linus Walleij <linus.walleij@linaro.org> wrote:
> The more I dig the more I find. These are pretty straight-forward
> and should be possible to merge right off.
>
> Linus Walleij (3):
>   mmc: block: use mmc_req_is_special()
>   mmc: block: rename data to blkdata
>   mmc: block: move packed command struct init
>
>  drivers/mmc/card/block.c | 67 ++++++++++++++++++++++++++++++++++++++----------
>  drivers/mmc/card/queue.c | 43 -------------------------------
>  drivers/mmc/card/queue.h |  6 ++---
>  3 files changed, 56 insertions(+), 60 deletions(-)
>
> --
> 2.7.4
>

Thanks, applied for next!

Kind regards
Uffe
