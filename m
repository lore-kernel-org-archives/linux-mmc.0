From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 1/2] mmc: API for accessing host supported maximum
 segment count and size
Date: Tue, 19 Dec 2017 09:36:17 +0100
Message-ID: <CAPDyKFp5dufLwv=ingG6PFKtHZGAfco5ii3qgVco3rpcGTMJ-w@mail.gmail.com>
References: <1511336987-21263-1-git-send-email-huxm@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:44232 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758963AbdLSIgS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Dec 2017 03:36:18 -0500
Received: by mail-io0-f196.google.com with SMTP id w127so12735150iow.11
        for <linux-mmc@vger.kernel.org>; Tue, 19 Dec 2017 00:36:18 -0800 (PST)
In-Reply-To: <1511336987-21263-1-git-send-email-huxm@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Xinming Hu <huxm@marvell.com>
Cc: Linux MMC <linux-mmc@vger.kernel.org>, Zhiyuan Yang <yangzy@marvell.com>, Tim Song <songtao@marvell.com>, Cathy Luo <cluo@marvell.com>, James Cao <jcao@marvell.com>, Ganapathi Bhat <gbhat@marvell.com>, Amitkumar Karwar <akarwar@marvell.com>

On 22 November 2017 at 08:49, Xinming Hu <huxm@marvell.com> wrote:
> sdio device drivers need be able to get the host supported max_segs
> and max_seg_size, so that they know the buffer size to allocate while
> utilizing the scatter/gather DMA buffer list.
>
> This patch provides API for this purpose.

Apologize for the delay.

Overall, this makes perfect sense to me. However some minor comment, see below.

>
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> v2: v2 was submitted with minor improvement like replacing BUG_ON() with WARN_ON()
> v3: Addressed below review comments from Ulf Hansson
>     a) In v3, patch has been split into two separate patches.
>     b) Patch 1/2 introduces an API to fetch max_seg_size and max_segs
>     c) Replaced WARN_ON() with proper error code when sg_ptr->length is invalid
>     d) Instead of duplicating the code in mmc_io_rw_extended(), extra bool parameter
>        has been added to this function and used it in new APIs for SG.
> v4: Removed WARN_ON() calls in newly added APIs. It's gets called in probe handler.
>     Caller already takes care of it(Shawn Lin).
> v5: Rebased on latest code base.
> ---
>  drivers/mmc/core/sdio_io.c                          | 21 +++++++++++++++++++++
>  .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |  6 +++---

The changes to the wifi driver, could please make that a separate
patch on top of this one?

There are actually a couple of more wireless drivers that should
convert to use these new API, I would appreciate if you could fold in
patches in the series for each of them as well (don't forget to cc
correct people for them), then I intend to apply all of them via my
tree, if no objections.

Otherwise this change looks good to me!

[...]

Kind regards
Uffe
