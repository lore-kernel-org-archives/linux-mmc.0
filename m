From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/8] mmc: debugfs: remove BUG_ON from mmc_ext_csd_open
Date: Tue, 29 Nov 2016 13:41:00 +0100
Message-ID: <CAPDyKFph5UdQMX5djbY85yrGyK9LBc4DfS5aCnA77yAwnrbzLQ@mail.gmail.com>
References: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com> <1478071479-12730-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38753 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755684AbcK2MlC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 07:41:02 -0500
Received: by mail-wm0-f42.google.com with SMTP id f82so186847527wmf.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2016 04:41:02 -0800 (PST)
In-Reply-To: <1478071479-12730-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2 November 2016 at 08:24, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Return error value for file_operations callback instead
> of triggering BUG_ON which is meaningless. Personally I
> don't believe n != EXT_CSD_STR_LEN could happen. Anyway,
> propagate the error to the caller.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/debugfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index c8451ce..30623b8 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -321,7 +321,11 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
>         for (i = 0; i < 512; i++)
>                 n += sprintf(buf + n, "%02x", ext_csd[i]);
>         n += sprintf(buf + n, "\n");
> -       BUG_ON(n != EXT_CSD_STR_LEN);
> +
> +       if (n != EXT_CSD_STR_LEN) {
> +               err = -EINVAL;
> +               goto out_free;
> +       }
>
>         filp->private_data = buf;
>         kfree(ext_csd);
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
