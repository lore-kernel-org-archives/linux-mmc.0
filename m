From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: correct outdated comment for use_dma
Date: Mon, 2 Oct 2017 10:29:55 +0200
Message-ID: <CAPDyKFrnVStaEL2Os5EKW3fBXoPRVT4He8YVsqfojOLG1=qq2Q@mail.gmail.com>
References: <1504061901-15857-1-git-send-email-ziyuan.biubiu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:44238 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdJBI34 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 04:29:56 -0400
Received: by mail-io0-f174.google.com with SMTP id v36so4128647ioi.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2017 01:29:55 -0700 (PDT)
In-Reply-To: <1504061901-15857-1-git-send-email-ziyuan.biubiu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziyuan <ziyuan.biubiu@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 30 August 2017 at 04:58, Ziyuan <ziyuan.biubiu@gmail.com> wrote:
> Since commit 3fc7eaef44db ("mmc: dw_mmc: Add external dma interface
> support") use_dma no longer means only the data transfer mode, and
> includes dma transmission channel. So make it more clear.
>
> Signed-off-by: Ziyuan <ziyuan.biubiu@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 34474ad..e3124f0 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -74,7 +74,8 @@ struct dw_mci_dma_slave {
>   * @stop_abort: The command currently prepared for stoping transfer.
>   * @prev_blksz: The former transfer blksz record.
>   * @timing: Record of current ios timing.
> - * @use_dma: Whether DMA channel is initialized or not.
> + * @use_dma: Which DMA channel is in use for the current transfer, zero
> + *     denotes PIO mode.
>   * @using_dma: Whether DMA is in use for the current transfer.
>   * @dma_64bit_address: Whether DMA supports 64-bit address mode or not.
>   * @sg_dma: Bus address of DMA buffer.
> --
> 2.7.4
>
>
