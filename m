From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/5] mmc: queue: initialization of command-queue support
Date: Thu, 15 Jan 2015 11:37:22 +0100
Message-ID: <CAPDyKFpDDBwWf=DBJxgcb5aFoR6=jXC_h4jqnUWXgNpJuUJcDg@mail.gmail.com>
References: <20141202115728.GA27647@asutoshd-ics.in.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141202115728.GA27647@asutoshd-ics.in.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Asutosh Das <asutoshd@codeaurora.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2 December 2014 at 12:57, Asutosh Das <asutoshd@codeaurora.org> wrote:
> Add command queue initialization support. This is
> applicable for emmc devices supporting cmd-queueing.
>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> ---
>  drivers/mmc/card/queue.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/card/queue.h |  6 ++++
>  include/linux/mmc/card.h |  2 ++
>  include/linux/mmc/host.h |  1 +
>  4 files changed, 83 insertions(+)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 3e049c1..c99e385 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -403,6 +403,80 @@ void mmc_packed_clean(struct mmc_queue *mq)
>         mqrq_prev->packed = NULL;
>  }
>
> +static void mmc_cmdq_softirq_done(struct request *rq)
> +{
> +       struct mmc_queue *mq = rq->q->queuedata;
> +
> +       mq->cmdq_complete_fn(rq);
> +}
> +
> +int mmc_cmdq_init(struct mmc_queue *mq, struct mmc_card *card)
> +{
> +       int i, ret = 0;
> +       /* one slot is reserved for dcmd requests */
> +       int q_depth = card->ext_csd.cmdq_depth - 1;
> +
> +       card->cmdq_init = false;
> +       if (!(card->host->caps2 & MMC_CAP2_CMD_QUEUE)) {
> +               ret = -ENOTSUPP;
> +               goto out;
> +       }

I think it's preferable to do above check outside of this function.

> +
> +       mq->mqrq_cmdq = kzalloc(
> +                       sizeof(struct mmc_queue_req) * q_depth, GFP_KERNEL);
> +       if (!mq->mqrq_cmdq) {
> +               pr_warn("%s: unable to allocate mqrq's for q_depth %d\n",
> +                       mmc_card_name(card), q_depth);

No need to print this, done from kzalloc();

> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       for (i = 0; i < q_depth; i++) {
> +               /* TODO: reduce the sg allocation by delaying them */

As I stated in my earlier reply in the $subject patchset, I will only
accept good quality code.
Have TODO comments will be out of the question.

> +               mq->mqrq_cmdq[i].sg = mmc_alloc_sg(card->host->max_segs, &ret);
> +               if (ret) {
> +                       pr_warn("%s: unable to allocate cmdq sg of size %d\n",
> +                               mmc_card_name(card),
> +                               card->host->max_segs);

No need to print this, done from kzalloc();

> +                       goto free_mqrq_sg;
> +               }

Hmm, it seems like a lot of pre-allocating is done here, so I
certainly think your TODO comment is valid. You just need to fix it.
:-)

> +       }
> +
> +       ret = blk_queue_init_tags(mq->queue, q_depth, NULL);
> +       if (ret) {
> +               pr_warn("%s: unable to allocate cmdq tags %d\n",
> +                               mmc_card_name(card), q_depth);

I don't think this print is needed. Likely it's already handled by
blk_queue_init_tags().

> +               goto free_mqrq_sg;
> +       }
> +
> +       blk_queue_softirq_done(mq->queue, mmc_cmdq_softirq_done);
> +       card->cmdq_init = true;
> +       goto out;
> +
> +free_mqrq_sg:
> +       for (i = 0; i < q_depth; i++)
> +               kfree(mq->mqrq_cmdq[i].sg);
> +       kfree(mq->mqrq_cmdq);
> +       mq->mqrq_cmdq = NULL;
> +out:
> +       return ret;
> +}
> +
> +void mmc_cmdq_clean(struct mmc_queue *mq, struct mmc_card *card)
> +{
> +       int i;
> +       int q_depth = card->ext_csd.cmdq_depth - 1;
> +
> +       blk_free_tags(mq->queue->queue_tags);
> +       mq->queue->queue_tags = NULL;
> +       blk_queue_free_tags(mq->queue);
> +
> +       for (i = 0; i < q_depth; i++)
> +               kfree(mq->mqrq_cmdq[i].sg);
> +       kfree(mq->mqrq_cmdq);
> +       mq->mqrq_cmdq = NULL;
> +}
> +
>  /**
>   * mmc_queue_suspend - suspend a MMC request queue
>   * @mq: MMC queue to suspend
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index 5752d50..36a8d64 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -52,11 +52,14 @@ struct mmc_queue {
>  #define MMC_QUEUE_NEW_REQUEST  (1 << 1)
>
>         int                     (*issue_fn)(struct mmc_queue *, struct request *);
> +       int (*cmdq_issue_fn)(struct mmc_queue *, struct request *);

I don't find this callback being used in this patch.

> +       void (*cmdq_complete_fn)(struct request *);
>         void                    *data;
>         struct request_queue    *queue;
>         struct mmc_queue_req    mqrq[2];
>         struct mmc_queue_req    *mqrq_cur;
>         struct mmc_queue_req    *mqrq_prev;
> +       struct mmc_queue_req    *mqrq_cmdq;
>  };
>
>  extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
> @@ -73,4 +76,7 @@ extern void mmc_queue_bounce_post(struct mmc_queue_req *);
>  extern int mmc_packed_init(struct mmc_queue *, struct mmc_card *);
>  extern void mmc_packed_clean(struct mmc_queue *);
>
> +extern int mmc_cmdq_init(struct mmc_queue *mq, struct mmc_card *card);
> +extern void mmc_cmdq_clean(struct mmc_queue *mq, struct mmc_card *card);
> +
>  #endif
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index b87a27c..41f368d 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -309,6 +309,7 @@ struct mmc_card {
>         struct dentry           *debugfs_root;
>         struct mmc_part part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
>         unsigned int    nr_parts;
> +       bool                    cmdq_init; /* cmdq init done */
>  };
>
>  /*
> @@ -545,4 +546,5 @@ extern void mmc_unregister_driver(struct mmc_driver *);
>  extern void mmc_fixup_device(struct mmc_card *card,
>                              const struct mmc_fixup *table);
>
> +extern void mmc_blk_cmdq_req_done(struct mmc_request *mrq);
>  #endif /* LINUX_MMC_CARD_H */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index cb61ea4..f0edb36 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -278,6 +278,7 @@ struct mmc_host {
>  #define MMC_CAP2_PACKED_CMD    (MMC_CAP2_PACKED_RD | \
>                                  MMC_CAP2_PACKED_WR)
>  #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)  /* Don't power up before scan */
> +#define MMC_CAP2_CMD_QUEUE     (1 << 15)       /* support eMMC command queue */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>
> --
> 1.8.2.1
>

Please run checkpatch on all your patches. This one had warnings you
shall resolve and the rest in the series has so as well.

Moreover, I can't apply this patch on my next branch so it needs a
rebase. Can you please do that so I am able to test it.

Kind regards
Uffe
