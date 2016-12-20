From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: core: Further fix thread wake-up
Date: Tue, 20 Dec 2016 11:56:23 +0100
Message-ID: <CAPDyKFpB+dWJ55E_DncKv5q0TBqXyYRcg0eEHWcVsQ+8x1TPnA@mail.gmail.com>
References: <1482155854-24963-1-git-send-email-adrian.hunter@intel.com> <1482155854-24963-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f176.google.com ([209.85.210.176]:35619 "EHLO
        mail-wj0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbcLTLDM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2016 06:03:12 -0500
Received: by mail-wj0-f176.google.com with SMTP id v7so173425590wjy.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2016 03:03:12 -0800 (PST)
In-Reply-To: <1482155854-24963-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>

On 19 December 2016 at 14:57, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Commit e0097cf5f2f1 ("mmc: queue: Fix queue thread wake-up") did not go far
> enough. mmc_wait_for_data_req_done() still contains some problems and can
> be further simplified.  First it should not touch
> context_info->is_waiting_last_req because that is a wake-up control used by
> the owner of the context. Secondly, it should always return when one of its
> wake-up conditions is met because, again, that is contolled by the owner of
> the context.
>
> While the current block driver does not have an issue, these problems were
> exposed during testing of the Software Command Queue patches.
>
> Fixes: e0097cf5f2f1 ("mmc: queue: Fix queue thread wake-up")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 543eadd230e5..1076b9d89df3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -496,8 +496,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
>   * Returns enum mmc_blk_status after checking errors.
>   */
>  static enum mmc_blk_status mmc_wait_for_data_req_done(struct mmc_host *host,
> -                                     struct mmc_request *mrq,
> -                                     struct mmc_async_req *next_req)
> +                                                     struct mmc_request *mrq)
>  {
>         struct mmc_command *cmd;
>         struct mmc_context_info *context_info = &host->context_info;
> @@ -507,7 +506,7 @@ static enum mmc_blk_status mmc_wait_for_data_req_done(struct mmc_host *host,
>                 wait_event_interruptible(context_info->wait,
>                                 (context_info->is_done_rcv ||
>                                  context_info->is_new_req));
> -               context_info->is_waiting_last_req = false;
> +
>                 if (context_info->is_done_rcv) {
>                         context_info->is_done_rcv = false;
>                         cmd = mrq->cmd;
> @@ -527,10 +526,9 @@ static enum mmc_blk_status mmc_wait_for_data_req_done(struct mmc_host *host,
>                                 __mmc_start_request(host, mrq);
>                                 continue; /* wait for done/new event again */
>                         }
> -               } else if (context_info->is_new_req) {
> -                       if (!next_req)
> -                               return MMC_BLK_NEW_REQUEST;
>                 }
> +
> +               return MMC_BLK_NEW_REQUEST;
>         }
>         mmc_retune_release(host);
>         return status;
> @@ -660,7 +658,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>                 mmc_pre_req(host, areq->mrq);
>
>         if (host->areq) {
> -               status = mmc_wait_for_data_req_done(host, host->areq->mrq, areq);
> +               status = mmc_wait_for_data_req_done(host, host->areq->mrq);
>                 if (status == MMC_BLK_NEW_REQUEST) {
>                         if (ret_stat)
>                                 *ret_stat = status;
> --
> 1.9.1
>
