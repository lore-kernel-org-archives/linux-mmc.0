From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V5 09/13] mmc: block: Use local variables in mmc_blk_data_prep()
Date: Sun, 20 Aug 2017 13:43:33 +0200
Message-ID: <CACRpkda2SCGcN2ivVQJPLoeGxrudPqy883EpmRWcvNdGRe7GKQ@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-10-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33022 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbdHTLne (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Aug 2017 07:43:34 -0400
Received: by mail-oi0-f45.google.com with SMTP id f11so132121514oic.0
        for <linux-mmc@vger.kernel.org>; Sun, 20 Aug 2017 04:43:34 -0700 (PDT)
In-Reply-To: <1502366898-23691-10-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Use local variables in mmc_blk_data_prep() in preparation for adding CQE
> support which doesn't use the output variables.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
on the patch as such but:

>  static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
> -                             int disable_multi, bool *do_rel_wr,
> -                             bool *do_data_tag)
> +                             int disable_multi, bool *do_rel_wr_p,
> +                             bool *do_data_tag_p)

We need to figure out what we mean by "tag" in eMMC.

Yours,
Linus Walleij
