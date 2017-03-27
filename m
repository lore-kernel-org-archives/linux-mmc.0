From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: bcm2835: Fix possible NULL ptr dereference in bcm2835_request
Date: Mon, 27 Mar 2017 10:22:38 +0200
Message-ID: <CAPDyKFq3F9ze289U1BzTiD4-B2Y5A2yGWzMmahP8HLnzP0RgAA@mail.gmail.com>
References: <1490447820-751-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33258 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdC0IWk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Mar 2017 04:22:40 -0400
Received: by mail-vk0-f50.google.com with SMTP id d188so42976040vka.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Mar 2017 01:22:39 -0700 (PDT)
In-Reply-To: <1490447820-751-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-rpi-kernel@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 25 March 2017 at 14:17, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This fixes a NULL pointer dereference in case of a MMC request with a
> set block count command and no data.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/bcm2835.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 7d1b0db..1f343a4 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1200,7 +1200,8 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 return;
>         }
>
> -       host->use_sbc = !!mrq->sbc && (host->mrq->data->flags & MMC_DATA_READ);
> +       host->use_sbc = !!mrq->sbc && host->mrq->data &&
> +                       (host->mrq->data->flags & MMC_DATA_READ);
>         if (host->use_sbc) {
>                 if (bcm2835_send_command(host, mrq->sbc)) {
>                         if (!host->use_busy)
> --
> 1.7.9.5
>
