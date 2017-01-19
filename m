From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: wbsd: safer check if dma_addr is valid DMA address
Date: Thu, 19 Jan 2017 12:23:19 +0100
Message-ID: <CAPDyKFow-fa_tePQ7VO9SsapgMj_TQqc-v7XNOnGNtPXr7TRtg@mail.gmail.com>
References: <1484347971-30829-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34864 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbdASLuf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 06:50:35 -0500
Received: by mail-wm0-f46.google.com with SMTP id r126so286086202wmr.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 03:50:32 -0800 (PST)
In-Reply-To: <1484347971-30829-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Pierre Ossman <pierre@ossman.eu>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org

On 13 January 2017 at 23:52, Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:
> host->dma_addr can store a value that is not returned by the DMA API,
> so it is safer to check if is a valid DMA address indirectly.
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/wbsd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index 80a3b11f3217..bd04e8bae010 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -1437,11 +1437,14 @@ static void wbsd_request_dma(struct wbsd_host *host, int dma)
>
>  static void wbsd_release_dma(struct wbsd_host *host)
>  {
> -       if (!dma_mapping_error(mmc_dev(host->mmc), host->dma_addr)) {
> +       /*
> +        * host->dma_addr is valid here iff host->dma_buffer is not NULL.
> +        */
> +       if (host->dma_buffer) {
>                 dma_unmap_single(mmc_dev(host->mmc), host->dma_addr,
>                         WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
> +               kfree(host->dma_buffer);
>         }
> -       kfree(host->dma_buffer);
>         if (host->dma >= 0)
>                 free_dma(host->dma);
>
> --
> 2.7.4
>
