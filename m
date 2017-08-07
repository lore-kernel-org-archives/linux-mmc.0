From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 05/11] mmc: core: Add support for handling CQE requests
Date: Mon, 7 Aug 2017 16:21:39 +0200
Message-ID: <CAPDyKFqbxcPw27Gs=s6dQwc1mw_Ksd4MJMJNqMNA7s=BuUZWFA@mail.gmail.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com> <1500630584-22852-6-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:38523 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbdHGOVl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 10:21:41 -0400
Received: by mail-qk0-f181.google.com with SMTP id x191so3247999qka.5
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 07:21:41 -0700 (PDT)
In-Reply-To: <1500630584-22852-6-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 21 July 2017 at 11:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Add core support for handling CQE requests, including starting, completing
> and recovering.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c  | 147 +++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/mmc/core.h |   5 ++
>  2 files changed, 147 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index b0af9db18eef..5a9d837599a1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -266,7 +266,8 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>         host->ops->request(host, mrq);
>  }
>
> -static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq)
> +static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq,
> +                            bool cqe)
>  {
>         if (mrq->sbc) {
>                 pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
> @@ -275,9 +276,12 @@ static void mmc_mrq_pr_debug(struct mmc_host *host, struct mmc_request *mrq)
>         }
>
>         if (mrq->cmd) {
> -               pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
> -                        mmc_hostname(host), mrq->cmd->opcode, mrq->cmd->arg,
> -                        mrq->cmd->flags);
> +               pr_debug("%s: starting %sCMD%u arg %08x flags %08x\n",
> +                        mmc_hostname(host), cqe ? "CQE direct " : "",
> +                        mrq->cmd->opcode, mrq->cmd->arg, mrq->cmd->flags);
> +       } else if (cqe) {
> +               pr_debug("%s: starting CQE transfer for tag %d blkaddr %u\n",
> +                        mmc_hostname(host), mrq->tag, mrq->data->blk_addr);
>         }
>
>         if (mrq->data) {
> @@ -345,7 +349,7 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>         if (mmc_card_removed(host->card))
>                 return -ENOMEDIUM;
>
> -       mmc_mrq_pr_debug(host, mrq);
> +       mmc_mrq_pr_debug(host, mrq, false);
>
>         WARN_ON(!host->claimed);
>
> @@ -485,6 +489,139 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>  }
>  EXPORT_SYMBOL(mmc_wait_for_req_done);
>

As this is an exported function, could you please add some function
header information.

> +int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
> +{
> +       int err;
> +
> +       /* Caller must hold retuning while CQE is in use */

Would be nice to get some more clarification on *why* this is needed.
Can you please extend the comment a bit on that?

> +       err = mmc_retune(host);
> +       if (err)
> +               goto out_err;
> +
> +       mrq->host = host;
> +
> +       mmc_mrq_pr_debug(host, mrq, true);
> +
> +       err = mmc_mrq_prep(host, mrq);
> +       if (err)
> +               goto out_err;
> +
> +       err = host->cqe_ops->cqe_request(host, mrq);
> +       if (err)
> +               goto out_err;
> +
> +       trace_mmc_request_start(host, mrq);
> +
> +       return 0;
> +
> +out_err:
> +       if (mrq->cmd) {
> +               pr_debug("%s: failed to start CQE direct CMD%u, error %d\n",
> +                        mmc_hostname(host), mrq->cmd->opcode, err);
> +       } else {
> +               pr_debug("%s: failed to start CQE transfer for tag %d, error %d\n",
> +                        mmc_hostname(host), mrq->tag, err);
> +       }
> +       return err;
> +}
> +EXPORT_SYMBOL(mmc_cqe_start_req);
> +
> +static void __mmc_cqe_request_done(struct mmc_host *host,
> +                                  struct mmc_request *mrq)
> +{
> +       mmc_should_fail_request(host, mrq);
> +
> +       /* Flag re-tuning needed on CRC errors */
> +       if ((mrq->cmd && mrq->cmd->error == -EILSEQ) ||
> +           (mrq->data && mrq->data->error == -EILSEQ))
> +               mmc_retune_needed(host);
> +
> +       trace_mmc_request_done(host, mrq);
> +
> +       if (mrq->cmd) {
> +               pr_debug("%s: CQE req done (direct CMD%u): %d\n",
> +                        mmc_hostname(host), mrq->cmd->opcode, mrq->cmd->error);
> +       } else {
> +               pr_debug("%s: CQE transfer done tag %d\n",
> +                        mmc_hostname(host), mrq->tag);
> +       }
> +
> +       if (mrq->data) {
> +               pr_debug("%s:     %d bytes transferred: %d\n",
> +                        mmc_hostname(host),
> +                        mrq->data->bytes_xfered, mrq->data->error);
> +       }
> +}
> +
> +/**
> + *     mmc_cqe_request_done - CQE has finished processing an MMC request
> + *     @host: MMC host which completed request
> + *     @mrq: MMC request which completed
> + *
> + *     CQE drivers should call this function when they have completed
> + *     their processing of a request.
> + */
> +void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq)
> +{
> +       __mmc_cqe_request_done(host, mrq);
> +
> +       mrq->done(mrq);
> +}
> +EXPORT_SYMBOL(mmc_cqe_request_done);
> +
> +/**
> + *     mmc_cqe_post_req - CQE post process of a completed MMC request
> + *     @host: MMC host
> + *     @mrq: MMC request to be processed
> + */
> +void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq)
> +{
> +       if (host->cqe_ops->cqe_post_req)
> +               host->cqe_ops->cqe_post_req(host, mrq);
> +}
> +EXPORT_SYMBOL(mmc_cqe_post_req);
> +
> +/* Arbitrary 1 second timeout */
> +#define MMC_CQE_RECOVERY_TIMEOUT       1000

Why 1 second?

Nitpick:
I am bit reluctant to use the terminology of "recovery". In then end
it's about a request timeout and then act by doing a graceful abort.

> +

Please add function header.

> +int mmc_cqe_recovery(struct mmc_host *host)
> +{
> +       struct mmc_command cmd;
> +       int err;
> +
> +       mmc_retune_hold_now(host);
> +
> +       /*
> +        * Recovery is expected seldom, if at all, but it reduces performance,
> +        * so make sure it is not completely silent.
> +        */
> +       pr_warn("%s: running CQE recovery\n", mmc_hostname(host));
> +
> +       host->cqe_ops->cqe_recovery_start(host);

What is expected to be done by the host from this callback?

I have been thinking about deploying a common data request timeout
behavior in the mmc core. In principle calling
wait_for_completion_timeout() instead of just wait_for_completion().
To deal with that, one would also need to invent a new host ops
callback to allow the host driver to restore its HW to a know state.
Very similar to what you also seems to need here for CQE.

I was just thinking that part of this code/callbacks could be re-used
for other non-CQE data requests that timeouts. Do you think that could
makes sense?

> +
> +       memset(&cmd, 0, sizeof(cmd));
> +       cmd.opcode       = MMC_STOP_TRANSMISSION,
> +       cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC,
> +       cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
> +       cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
> +       mmc_wait_for_cmd(host, &cmd, 0);
> +
> +       memset(&cmd, 0, sizeof(cmd));
> +       cmd.opcode       = MMC_CMDQ_TASK_MGMT;
> +       cmd.arg          = 1; /* Discard entire queue */
> +       cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
> +       cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
> +       cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
> +       err = mmc_wait_for_cmd(host, &cmd, 0);
> +
> +       host->cqe_ops->cqe_recovery_finish(host);
> +
> +       mmc_retune_release(host);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL(mmc_cqe_recovery);
> +
>  /**
>   *     mmc_is_req_done - Determine if a 'cap_cmd_during_tfr' request is done
>   *     @host: MMC host
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index bf1788a224e6..1974fcfd4284 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -174,6 +174,11 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
>  int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
>                 int retries);
>
> +int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq);
> +void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
> +void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq);
> +int mmc_cqe_recovery(struct mmc_host *host);
> +
>  int mmc_hw_reset(struct mmc_host *host);
>  void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
>
> --
> 1.9.1
>

Kind regards
Uffe
