From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: use memdup_user
Date: Fri, 19 May 2017 09:43:55 +0200
Message-ID: <CAPDyKFqiKsB-hUg0MEo-EqqSjndZUXMg5MMbyF5d4WhBh9A7yQ@mail.gmail.com>
References: <908fa521decaf3703e172c3734c0d498741f3ddb.1494580404.git.geliangtang@gmail.com>
 <b379dcae31767ca644693366c6131304523dcf23.1494578464.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35295 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdESHn4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2017 03:43:56 -0400
Received: by mail-qk0-f176.google.com with SMTP id a72so54731819qkj.2
        for <linux-mmc@vger.kernel.org>; Fri, 19 May 2017 00:43:56 -0700 (PDT)
In-Reply-To: <b379dcae31767ca644693366c6131304523dcf23.1494578464.git.geliangtang@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jens Axboe <axboe@fb.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 13 May 2017 at 05:15, Geliang Tang <geliangtang@gmail.com> wrote:
> Use memdup_user() helper instead of open-coding to simplify the code.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  drivers/mmc/core/block.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8273b07..47ccb2a 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -342,21 +342,15 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>                 return idata;
>         }
>
> -       idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
> -       if (!idata->buf) {
> -               err = -ENOMEM;
> +       idata->buf = memdup_user((void __user *)(unsigned long)
> +                                idata->ic.data_ptr, idata->buf_bytes);
> +       if (IS_ERR(idata->buf)) {
> +               err = PTR_ERR(idata->buf);
>                 goto idata_err;
>         }
>
> -       if (copy_from_user(idata->buf, (void __user *)(unsigned long)
> -                                       idata->ic.data_ptr, idata->buf_bytes)) {
> -               err = -EFAULT;
> -               goto copy_err;
> -       }
> -
>         return idata;
>
> -copy_err:
>         kfree(idata->buf);

As we aren't using the copy_err label no more, you can also remove the
above line.

>  idata_err:
>         kfree(idata);
> --
> 2.9.3
>

Kind regards
Uffe
