From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V14 17/24] mmc: block: blk-mq: Add support for direct completion
Date: Tue, 28 Nov 2017 20:02:01 +0100
Message-ID: <CAPDyKFpzTcaE-pg9ZM1MmiN3EhaQYamo2hQM7bU+6oRYVM2ZXA@mail.gmail.com>
References: <1511271770-3444-1-git-send-email-adrian.hunter@intel.com> <1511271770-3444-18-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <1511271770-3444-18-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-mmc@vger.kernel.org

[...]

>
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 1d7d3b0afff8..c4271fa54f1a 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -103,6 +103,7 @@ struct mmc_queue {
>         bool                    waiting;
>         struct work_struct      recovery_work;
>         wait_queue_head_t       wait;
> +       struct request          *recovery_req;
>         struct request          *complete_req;
>         struct mutex            complete_lock;
>         struct work_struct      complete_work;
> @@ -134,4 +135,9 @@ static inline int mmc_cqe_qcnt(struct mmc_queue *mq)
>                mq->in_flight[MMC_ISSUE_ASYNC];
>  }
>
> +static inline bool mmc_queue_direct_complete(struct mmc_host *host)

Nitpick 1) I would like to make it clear that this is a feature, which
depends on the behavior of the mmc host. Thus, I suggest renaming the
function to something along the lines of mmc_host_*()

Nitpick 2) There is system-wide PM core feature already "reserved" the
"direct_complete" terminology. To avoid mixing them up (terminology
wise), may I suggest renaming the mmc cap to MMC_CAP_DONE_COMPLETE,
thus perhaps the function above to mmc_host_done_complete(). Or if you
find a better option. :-)

> +{
> +       return host->caps & MMC_CAP_DIRECT_COMPLETE;
> +}
> +
>  #endif
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ce2075d6f429..4b68a95a8818 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -324,6 +324,7 @@ struct mmc_host {
>  #define MMC_CAP_DRIVER_TYPE_A  (1 << 23)       /* Host supports Driver Type A */
>  #define MMC_CAP_DRIVER_TYPE_C  (1 << 24)       /* Host supports Driver Type C */
>  #define MMC_CAP_DRIVER_TYPE_D  (1 << 25)       /* Host supports Driver Type D */
> +#define MMC_CAP_DIRECT_COMPLETE        (1 << 27)       /* RW reqs can be completed within mmc_request_done() */
>  #define MMC_CAP_CD_WAKE                (1 << 28)       /* Enable card detect wake */
>  #define MMC_CAP_CMD_DURING_TFR (1 << 29)       /* Commands during data transfer */
>  #define MMC_CAP_CMD23          (1 << 30)       /* CMD23 supported. */
> --
> 1.9.1
>

Besides the nitpicks, this looks good to me!

Kind regards
Uffe
