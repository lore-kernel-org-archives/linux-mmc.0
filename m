From: Mike Christie <mchristi@redhat.com>
Subject: Re: 4.8-rc1 REGRESSION mmc-blk triggers WARN_ON(!host->claimed),
 related to: "drivers: use req op accessor" ?
Date: Mon, 22 Aug 2016 11:09:52 -0500
Message-ID: <57BB23D0.3050606@redhat.com>
References: <6e68ae5a-4b79-a636-2c46-5726cf2cc44b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754609AbcHVQSM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Aug 2016 12:18:12 -0400
In-Reply-To: <6e68ae5a-4b79-a636-2c46-5726cf2cc44b@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@fb.com>, regressions@leemhuis.info
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 08/21/2016 10:15 AM, Hans de Goede wrote:
> Hi All,
> 
> With 4.8-rc1 I'm seeing WARN_ON(!host->claimed) triggering in both
> mmc_start_request() as well as in mmc_release_host(). The first
> indicating that we're executing mmc commands without doing
> mmc_claim_host() and the second one indicating that we're
> releasing the host without having claimed it first.
> 
> The backtraces all point to mmc_blk_issue_rq(). I've done
> a very naive hack / workaround:
> 
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2151,9 +2151,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
> struct request *req)
>      struct mmc_host *host = card->host;
>      unsigned long flags;
> 
> -    if (req && !mq->mqrq_prev->req)
> -        /* claim host only for the first request */
> -        mmc_get_card(card);
> +    mmc_get_card(card);
> 
>      ret = mmc_blk_part_switch(card, md);
>      if (ret) {
> @@ -2190,15 +2188,8 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
> struct request *req)
>      }
> 
>  out:
> -    if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
> -        mmc_req_is_special(req))
> -        /*
> -         * Release host when there are no more requests
> -         * and after special request(discard, flush) is done.
> -         * In case sepecial request, there is no reentry to
> -         * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
> -         */
> -        mmc_put_card(card);
> +    mmc_put_card(card);
> +
>      return ret;
>  }
> 
> 
> Which fixes this, further pointing to the somewhat magical claim / release
> code in mmc_blk_issue_rq() being the culprit.
> 
> Looking at recent commits these 2 stand out as possible causes of this:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c2df40dfb8c015211ec55f4b1dd0587f875c7b34
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3a5e02ced11e22ecd9da3d6710afe15bcfee1d10
> 
> 
> I've the feeling that one of these is making mmc_blk_issue_rq() not
> claiming
> the host while it should do so ...
> 

There is a bug with those patches and the secure discard ones where when
REQ_OP_SECURE_ERASE is sent, mmc_put_card above will not be called, and
they will be treated as normal requests instead of special one so the
drivers lists are not executed properly.

The patch in Jens's tree
https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git/commit/?h=for-linus&id=7afafc8a44bf0ab841b17d450b02aedb3a138985
fixes the issue.

