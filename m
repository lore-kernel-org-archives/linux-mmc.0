From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: change stop errors to info
Date: Thu, 18 Sep 2014 01:01:24 +0200
Message-ID: <CAPDyKFpONEKDqdcv-ShpSFrJetCNN9Np+_WgCGuwhpiRe14QHQ@mail.gmail.com>
References: <1410940242-2792-1-git-send-email-johanru@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:35614 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198AbaIQXBZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Sep 2014 19:01:25 -0400
Received: by mail-qa0-f41.google.com with SMTP id f12so70915qad.14
        for <linux-mmc@vger.kernel.org>; Wed, 17 Sep 2014 16:01:24 -0700 (PDT)
In-Reply-To: <1410940242-2792-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@axis.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Johan Rudholm <johanru@axis.com>

On 17 September 2014 09:50, Johan Rudholm <johan.rudholm@axis.com> wrote:
> Stop command errors are not fatal to the transfer since we make sure
> that the card returns to the transfer state and check the card status.
> Change an unnecessary error to an info.
>
> Signed-off-by: Johan Rudholm <johanru@axis.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 452782b..fea0376 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -977,7 +977,7 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
>                 return ERR_CONTINUE;
>
>         /* Now for stop errors.  These aren't fatal to the transfer. */
> -       pr_err("%s: error %d sending stop command, original cmd response %#x, card status %#x\n",
> +       pr_info("%s: error %d sending stop command, original cmd response %#x, card status %#x\n",
>                req->rq_disk->disk_name, brq->stop.error,
>                brq->cmd.resp[0], status);
>
> --
> 1.7.2.5
>
