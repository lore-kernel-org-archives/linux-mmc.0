From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 03/13] mmc: host: Add CQE interface
Date: Tue, 22 Aug 2017 13:13:14 +0200
Message-ID: <CAPDyKFpemPy7ioB3=B3VrOBhDED3HoDq0CVBV=bq7gyEOQ7PkA@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33657 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbdHVLNQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:13:16 -0400
Received: by mail-qt0-f179.google.com with SMTP id d15so24679108qta.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:13:15 -0700 (PDT)
In-Reply-To: <1502366898-23691-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 10 August 2017 at 14:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Add CQE host operations, capabilities, and host members.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next! However with some minor comments, explained below.

[...]

>
> +       /* Command Queue Engine (CQE) support */
> +       const struct mmc_cqe_ops *cqe_ops;
> +       void                    *cqe_private;
> +       /*
> +        * Notify uppers layers (e.g. mmc block driver) that CQE needs recovery
> +        * due to an error associated with the mmc_request.
> +        */

Thanks for adding the explanation.

> +       void                    (*cqe_recovery_notifier)(struct mmc_host *,
> +                                                        struct mmc_request *);

Normally we don't put callbacks in the struct mmc_host that someone
else than the host driver should assign - so this feels a bit upside
down.

Is there any reason to why you didn't want to add a new API? Something
like mmc_cqe_recover(), which the host driver could call.

> +       int                     cqe_qdepth;
> +       bool                    cqe_enabled;
> +       bool                    cqe_on;
> +
>         unsigned long           private[0] ____cacheline_aligned;
>  };
>
> --
> 1.9.1
>

Kind regards
Uffe
