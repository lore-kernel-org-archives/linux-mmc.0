From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: return error on failed mmc_blk_get()
Date: Wed, 10 Feb 2016 09:18:34 +0100
Message-ID: <CAPDyKFoAGD2bsAxRm1nkk9r1SUv8oBPCTpYgoPGSu_vqYj6yMg@mail.gmail.com>
References: <1455039270-30204-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33555 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbcBJISf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2016 03:18:35 -0500
Received: by mail-yw0-f174.google.com with SMTP id u200so8956112ywf.0
        for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2016 00:18:34 -0800 (PST)
In-Reply-To: <1455039270-30204-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@google.com>

On 9 February 2016 at 18:34, Olof Johansson <olof@lixom.net> wrote:
> This used to return -EFAULT, but the function above returns -EINVAL on
> the same condition so let's stick to that.
>
> The removal of error return on this path was introduced with b093410c9aef
> ('mmc: block: copy resp[] data on err for MMC_IOC_MULTI_CMD').
>
> Fixes: b093410c9aef ('mmc: block: copy resp[] data on err for MMC_IOC_MULTI_CMD').
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Grant Grundler <grundler@google.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 57a5b6d..b3ec4fb 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -655,8 +655,10 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>         }
>
>         md = mmc_blk_get(bdev->bd_disk);
> -       if (!md)
> +       if (!md) {
> +               err = -EINVAL;
>                 goto cmd_err;
> +       }
>
>         card = md->queue.card;
>         if (IS_ERR(card)) {
> --
> 2.1.4
>
