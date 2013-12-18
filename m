From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: don't decrement qty when calculating max_discard
Date: Wed, 18 Dec 2013 11:32:46 +0100
Message-ID: <CAPDyKFqn1ZHzB47UY-Cq+A_Tgb2vx0qxaAWc9VHZWC-YUp1Snw@mail.gmail.com>
References: <1387303344-11802-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:49959 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab3LRKcr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 05:32:47 -0500
Received: by mail-qc0-f172.google.com with SMTP id e16so6024453qcx.31
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2013 02:32:47 -0800 (PST)
In-Reply-To: <1387303344-11802-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <dongas86@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>

On 17 December 2013 19:02, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> In mmc_do_calc_max_discard(), if any value has been assigned to qty,
> that value must have passed the timeout checks in the loop. Hence,
> qty is the maximum number of erase blocks that fit within the timeout,
> not the first value that does not fit into the timeout. In turn, this
> means we don't need any special case for (qty == 1); any value of qty
> needs to be multiplied by the card's erase shift, and we don't need to
> decrement qty before doing so.
>
> Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
> in qty == 1, which is immediately returned. This causes discard to
> operate a single sector at a time, which is chronically slow. With this
> patch in place, discard operates a single erase block at a time, which
> is reasonably fast.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Dong Aisheng <dongas86@gmail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Fixes: e056a1b5b67b "(mmc: queue: let host controllers specify maximum discard timeout")
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> If this makes sense, I wonder if it should be Cc: stable?
> ---
>  drivers/mmc/core/core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 57a2b403bf8e..dd793cf4ef46 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2150,16 +2150,13 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>         if (!qty)
>                 return 0;
>
> -       if (qty == 1)
> -               return 1;
> -
>         /* Convert qty to sectors */
>         if (card->erase_shift)
> -               max_discard = --qty << card->erase_shift;
> +               max_discard = qty << card->erase_shift;
>         else if (mmc_card_sd(card))
>                 max_discard = qty;
>         else
> -               max_discard = --qty * card->erase_size;
> +               max_discard = qty * card->erase_size;
>
>         return max_discard;
>  }
> --
> 1.8.1.5
>

I guess this patch on it's own seems reasonable, so we should maybe
apply it as a short term solution!?

To solve the real problem, I think we shall not consider the
"max_discard_to" while calculating the max_discard value. Instead I
think we shall be able to make an estimation of a fixed number of
erase blocks (maybe considering the size of the card of something).

Then we instead calculates what busy detection timeout, this fixed
number of erase blocks, gives us.

For hosts not supporting MMC_CAP_WAIT_WHILE_BUSY, the calculated busy
detection timeout will be of less importance, since I think we should
rely on polling with CMD13 to find out when the erase operation is
completed.

For hosts supporting MMC_CAP_WAIT_WHILE_BUSY, the calculated busy
detection timeout can turn out to be bigger than what the host
supports. In this case we need to decide whether we still should
expect the host to handle busy detection but with an indefinite
timeout, or if should prevent the host from using busy detection and
do polling with CMD13 instead.

Does this make sense?

Kind regards
Ulf Hansson
