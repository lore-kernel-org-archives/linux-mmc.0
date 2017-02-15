From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 22/39] mmc: block: Prepare CQE data
Date: Wed, 15 Feb 2017 14:49:23 +0100
Message-ID: <CACRpkdZkTgNEUFiG5JorBM+MiXVfp6iSnNH0-k27jYb+zjgiLw@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-23-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35623 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdBONt0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 08:49:26 -0500
Received: by mail-io0-f171.google.com with SMTP id j18so88598476ioe.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 05:49:25 -0800 (PST)
In-Reply-To: <1486731352-8018-23-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Enhance mmc_blk_data_prep() to support CQE requests.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Hey:

> +#include <linux/ioprio.h>
(...)
> +       if (IOPRIO_PRIO_CLASS(req_get_ioprio(req)) == IOPRIO_CLASS_RT)
> +               brq->data.flags |= MMC_DATA_PRIO;

What is this?

Why are we not already doing this and why is it not a separate patch?

>         /*
>          * Data tag is used only during writing meta data to speed
>          * up write and any subsequent read of this meta data
>          */

Is this comment still true?

> -       *do_data_tag = card->ext_csd.data_tag_unit_size &&
> -                      (req->cmd_flags & REQ_META) &&
> -                      (rq_data_dir(req) == WRITE) &&
> -                      ((brq->data.blocks * brq->data.blksz) >=
> -                       card->ext_csd.data_tag_unit_size);
> +       do_data_tag = card->ext_csd.data_tag_unit_size &&
> +                     (req->cmd_flags & REQ_META) &&
> +                     (rq_data_dir(req) == WRITE) &&
> +                     ((brq->data.blocks * brq->data.blksz) >=
> +                      card->ext_csd.data_tag_unit_size);
> +
> +       if (do_data_tag)
> +               brq->data.flags |= MMC_DATA_DAT_TAG;

Because it seems to be more unconditionally used now.

Yours,
Linus Walleij
