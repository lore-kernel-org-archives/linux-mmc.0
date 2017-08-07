From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 03/11] mmc: host: Add CQE interface
Date: Mon, 7 Aug 2017 15:55:06 +0200
Message-ID: <CAPDyKFoyyZYY=0z06PCk6VC4onRArK9vC5=xgKSALo5_iW4=1A@mail.gmail.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com> <1500630584-22852-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:38128 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdHGNzH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 09:55:07 -0400
Received: by mail-qt0-f178.google.com with SMTP id t37so2758755qtg.5
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 06:55:07 -0700 (PDT)
In-Reply-To: <1500630584-22852-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 21 July 2017 at 11:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Add CQE host operations, capabilities, and host members.

I think adding these new interfaces deserves a bit more descriptive changelog.

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  include/linux/mmc/host.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ebd1cebbef0c..4dd7ada9b4b9 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -162,6 +162,19 @@ struct mmc_host_ops {
>                                   unsigned int direction, int blk_size);
>  };
>
> +struct mmc_cqe_ops {

Could you please add a small comment to each new callback. Even if the
names gives a good hint on they are used, some additional information
would be nice.

> +       int     (*cqe_enable)(struct mmc_host *host, struct mmc_card *card);
> +       void    (*cqe_disable)(struct mmc_host *host);
> +       int     (*cqe_request)(struct mmc_host *host, struct mmc_request *mrq);
> +       void    (*cqe_post_req)(struct mmc_host *host, struct mmc_request *mrq);
> +       void    (*cqe_off)(struct mmc_host *host);

What differs between ->cqe_off() and ->cqe_disable()? Do we need both?

> +       int     (*cqe_wait_for_idle)(struct mmc_host *host);

The name sounds like you will poll the host to understand when the
card becomes idle.

Is that so? Then when is this needed?

> +       bool    (*cqe_timeout)(struct mmc_host *host, struct mmc_request *mrq,
> +                              bool *recovery_needed);
> +       void    (*cqe_recovery_start)(struct mmc_host *host);
> +       void    (*cqe_recovery_finish)(struct mmc_host *host);
> +};
> +
>  struct mmc_async_req {
>         /* active mmc request */
>         struct mmc_request      *mrq;
> @@ -307,6 +320,8 @@ struct mmc_host {
>  #define MMC_CAP2_HS400_ES      (1 << 20)       /* Host supports enhanced strobe */
>  #define MMC_CAP2_NO_SD         (1 << 21)       /* Do not send SD commands during initialization */
>  #define MMC_CAP2_NO_MMC                (1 << 22)       /* Do not send (e)MMC commands during initialization */
> +#define MMC_CAP2_CQE           (1 << 23)       /* Has eMMC command queue engine */
> +#define MMC_CAP2_CQE_DCMD      (1 << 24)       /* CQE can issue a direct command */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>
> @@ -393,6 +408,15 @@ struct mmc_host {
>         int                     dsr_req;        /* DSR value is valid */
>         u32                     dsr;    /* optional driver stage (DSR) value */
>
> +       /* Command Queue Engine (CQE) support */
> +       const struct mmc_cqe_ops *cqe_ops;
> +       void                    *cqe_private;
> +       void                    (*cqe_recovery_notifier)(struct mmc_host *,
> +                                                        struct mmc_request *);

Please add a comment here to understand how this callback is going to be used.

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
