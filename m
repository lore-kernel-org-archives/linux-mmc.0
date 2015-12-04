From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: usdhi6rol0: handle NULL data in timeout
Date: Fri, 4 Dec 2015 15:56:20 +0100
Message-ID: <CAPDyKFpqn1iL1F5nE_FMGUkmXj4OrTQ8VdD_8_9eU5sdV9bt9w@mail.gmail.com>
References: <1448625551-32328-1-git-send-email-rabin.vincent@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35184 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbbLDO4V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2015 09:56:21 -0500
Received: by ykba77 with SMTP id a77so126123905ykb.2
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2015 06:56:20 -0800 (PST)
In-Reply-To: <1448625551-32328-1-git-send-email-rabin.vincent@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin.vincent@axis.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Rabin Vincent <rabinv@axis.com>

On 27 November 2015 at 12:59, Rabin Vincent <rabin.vincent@axis.com> wrote:
> bb08a7d489bd22 ("mmc: usdhi6rol0: fix NULL pointer deref in debug
> print") fixed one NULL pointer dereference but unfortunately introduced
> another.  "data" may be NULL if this is a command timeout for a command
> without any data, so we should only use it if we're actually waiting for
> data.
>
> Fixes: bb08a7d("mmc: usdhi6rol0: fix NULL pointer deref in debug print")
> Cc: stable@vger.kernel.org # v4.3
> Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>

Thanks, applied for next! (The patch has a checkpatch error, I fixed
it up this time).

Kind regards
Uffe


> ---
>  drivers/mmc/host/usdhi6rol0.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 4498e92..b47122d 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1634,7 +1634,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
>         struct usdhi6_host *host = container_of(d, struct usdhi6_host, timeout_work);
>         struct mmc_request *mrq = host->mrq;
>         struct mmc_data *data = mrq ? mrq->data : NULL;
> -       struct scatterlist *sg = host->sg ?: data->sg;
> +       struct scatterlist *sg;
>
>         dev_warn(mmc_dev(host->mmc),
>                  "%s timeout wait %u CMD%d: IRQ 0x%08x:0x%08x, last IRQ 0x%08x\n",
> @@ -1666,6 +1666,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
>         case USDHI6_WAIT_FOR_MWRITE:
>         case USDHI6_WAIT_FOR_READ:
>         case USDHI6_WAIT_FOR_WRITE:
> +               sg = host->sg ?: data->sg;
>                 dev_dbg(mmc_dev(host->mmc),
>                         "%c: page #%u @ +0x%zx %ux%u in SG%u. Current SG %u bytes @ %u\n",
>                         data->flags & MMC_DATA_READ ? 'R' : 'W', host->page_idx,
> --
> 1.7.10.4
>
