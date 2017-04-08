From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 05/22] mmc: queue: Share mmc request array between partitions
Date: Sat, 8 Apr 2017 19:41:43 +0200
Message-ID: <CACRpkdYTbD0U8z2ZBgBcq5hLu=Up=J4Tzz2+YT93TYmRsiZiUA@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com> <1489408613-26915-6-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:37813 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbdDHRlp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2017 13:41:45 -0400
Received: by mail-it0-f41.google.com with SMTP id a140so8177291ita.0
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2017 10:41:45 -0700 (PDT)
In-Reply-To: <1489408613-26915-6-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Mon, Mar 13, 2017 at 1:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> eMMC can have multiple internal partitions that are represented as separate
> disks / queues. However switching between partitions is only done when the
> queue is empty. Consequently the array of mmc requests that are queued can
> be shared between partitions saving memory.
>
> Keep a pointer to the mmc request queue on the card, and use that instead
> of allocating a new one for each partition.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This is an especially nice patch, and even just merging this patch set
to this point is already a significant improvement to the core code IMO.

Yours,
Linus Walleij
