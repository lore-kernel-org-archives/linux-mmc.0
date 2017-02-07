From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] Some small cleanup for quirks
Date: Tue, 7 Feb 2017 10:23:55 +0100
Message-ID: <CAPDyKFrYCwPiB=ffrvfocEJKstfOi3jTSMhAqyWbBmrNhx2Apg@mail.gmail.com>
References: <1486456043-105954-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35790 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdBGJX5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 04:23:57 -0500
Received: by mail-wm0-f47.google.com with SMTP id v186so2343549wmd.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Feb 2017 01:23:56 -0800 (PST)
In-Reply-To: <1486456043-105954-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 7 February 2017 at 09:27, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> I just see the we put them everywhere, so the legacy code
> should be improved a bit for maintainability, especially for
> the sdio quirks case. Just split them into small patches to be
> better reviewed but I don't mind to squash them up. :)
>
>
>
> Shawn Lin (5):
>   mmc: core: change quirks.c to be a header file
>   mmc: core: move some sdio IDs out of quirks file
>   mmc: core: improve the quirks for sdio devices
>   mmc: core: move all quirks together into quirks.h
>   mmc: core: add mmc prefix for blk_fixups
>
>  drivers/mmc/core/Makefile    |   2 +-
>  drivers/mmc/core/block.c     |  77 +----------------------
>  drivers/mmc/core/card.h      |   2 -
>  drivers/mmc/core/mmc.c       |  12 +---
>  drivers/mmc/core/quirks.c    |  85 -------------------------
>  drivers/mmc/core/quirks.h    | 145 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/sdio.c      |   3 +-
>  include/linux/mmc/sdio_ids.h |   7 +++
>  8 files changed, 158 insertions(+), 175 deletions(-)
>  delete mode 100644 drivers/mmc/core/quirks.c
>  create mode 100644 drivers/mmc/core/quirks.h
>
> --
> 1.9.1

Besides the comment for patch 1, this looks good to me.

Kind regards
Uffe
