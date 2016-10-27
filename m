From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 0/8] Attempt to clean up BUG_ONs for mmc-tree
Date: Thu, 27 Oct 2016 10:19:20 +0200
Message-ID: <CAPDyKFpARgjvxAaYDNTSSGL9gFJT6YBj1cRM9JSHGOF9sFuYbw@mail.gmail.com>
References: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37905 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754953AbcJ0N66 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 09:58:58 -0400
Received: by mail-wm0-f49.google.com with SMTP id n67so44403620wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 06:58:56 -0700 (PDT)
In-Reply-To: <1476792192-6265-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 18 October 2016 at 14:03, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> We have already removed some BUG_ONs recently[0][1], however there
> are still many pointless BUG_ONs for mmc core. So this patchset is
> going on removing these BUG_ONs from drivers/mmc/core/* and drivers/mmc/card/*.
> It is also possible for us to remove it from drivers/mmc/host/* in the future.
>
> No functional changes intented in theory, except for adding some error
> handle, but I held it for a while in order to test it fully and decided
> to send it after the merge window of 4.9.
>
> Please review and comment. :)

I have reviewed patch 1, patch 2 and patch 3. I think you can follow a
pattern for my review comment, which means the similar comments are
applicable the rest of series as well. Please have a look to see what
you think and perhaps re-spin this.

Thanks for working on this clean-up!

Kind regards
Uffe

>
> [0]: https://patchwork.kernel.org/patch/9300739/
> [1]: https://patchwork.kernel.org/patch/9300741/
>
>
>
> Shawn Lin (8):
>   mmc: core: remove BUG_ONs from sdio
>   mmc: debugfs: remove BUG_ON from mmc_ext_csd_open
>   mmc: core: remove BUG_ONs from mmc
>   mmc: core: remove BUG_ONs from sd
>   mmc: core: remove BUG_ONs from core.c
>   mmc: sdio_uart: remove meaningless BUG_ON
>   mmc: queue: remove BUG_ON for bounce_sg
>   mmc: mmc_test: remove BUG_ONs and deploy error handling
>
>  drivers/mmc/card/mmc_test.c  | 12 ++++++++----
>  drivers/mmc/card/queue.c     |  2 --
>  drivers/mmc/card/sdio_uart.c |  2 --
>  drivers/mmc/core/core.c      | 40 ++++++++++++++--------------------------
>  drivers/mmc/core/debugfs.c   |  6 +++++-
>  drivers/mmc/core/mmc.c       | 24 ++++++++++++++----------
>  drivers/mmc/core/mmc_ops.c   | 20 ++++++--------------
>  drivers/mmc/core/sd.c        | 20 +++++++++-----------
>  drivers/mmc/core/sd_ops.c    | 30 ++++++++++--------------------
>  drivers/mmc/core/sdio.c      | 26 ++++++++++++++------------
>  drivers/mmc/core/sdio_cis.c  |  3 ++-
>  drivers/mmc/core/sdio_irq.c  | 12 +++++++-----
>  12 files changed, 89 insertions(+), 108 deletions(-)
>
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
