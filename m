From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: usdhi6rol0: fix NULL pointer deref in debug print
Date: Tue, 25 Aug 2015 14:07:28 +0200
Message-ID: <CAPDyKFphocAgw5v3zCSV-ystjGsxugrOusMBOrw8ARTY_A-2Jw@mail.gmail.com>
References: <1439991696-28488-1-git-send-email-rabin.vincent@axis.com>
	<1439991696-28488-2-git-send-email-rabin.vincent@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33131 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932534AbbHYMH3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:07:29 -0400
Received: by igfj19 with SMTP id j19so9490964igf.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:07:28 -0700 (PDT)
In-Reply-To: <1439991696-28488-2-git-send-email-rabin.vincent@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin.vincent@axis.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc <linux-mmc@vger.kernel.org>, Rabin Vincent <rabinv@axis.com>

On 19 August 2015 at 15:41, Rabin Vincent <rabin.vincent@axis.com> wrote:
> host->sg is only set when we're transferring multiple blocks.  Check for
> its availibility before dereferencing it in the timeout work debug
> print.
>
> Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/usdhi6rol0.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 63d5d72..4188e84e 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1634,6 +1634,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
>         struct usdhi6_host *host = container_of(d, struct usdhi6_host, timeout_work);
>         struct mmc_request *mrq = host->mrq;
>         struct mmc_data *data = mrq ? mrq->data : NULL;
> +       struct scatterlist *sg = host->sg ?: data->sg;
>
>         dev_warn(mmc_dev(host->mmc),
>                  "%s timeout wait %u CMD%d: IRQ 0x%08x:0x%08x, last IRQ 0x%08x\n",
> @@ -1669,7 +1670,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
>                         "%c: page #%u @ +0x%zx %ux%u in SG%u. Current SG %u bytes @ %u\n",
>                         data->flags & MMC_DATA_READ ? 'R' : 'W', host->page_idx,
>                         host->offset, data->blocks, data->blksz, data->sg_len,
> -                       sg_dma_len(host->sg), host->sg->offset);
> +                       sg_dma_len(sg), sg->offset);
>                 usdhi6_sg_unmap(host, true);
>                 /*
>                  * If USDHI6_WAIT_FOR_DATA_END times out, we have already unmapped
> --
> 1.7.10.4
>
