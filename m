From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: simplify ida handling
Date: Mon, 30 Jan 2017 11:04:37 +0100
Message-ID: <CAPDyKFq5a4xJCoEb7gQQqL7ysUZ5JorNM4WrkvYX84s0TaWEew@mail.gmail.com>
References: <4dae93b9-78f6-25c5-4836-4a70a5a00ab6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38697 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbdA3KjV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 05:39:21 -0500
Received: by mail-wm0-f45.google.com with SMTP id r141so26860166wmg.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2017 02:37:26 -0800 (PST)
In-Reply-To: <4dae93b9-78f6-25c5-4836-4a70a5a00ab6@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 28 January 2017 at 09:32, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> ida handling can be simplified by switching to the ida_simple_
> functions.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 98f25ffb..0a26c8b6 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -34,14 +34,11 @@
>  #define cls_dev_to_mmc_host(d) container_of(d, struct mmc_host, class_dev)
>
>  static DEFINE_IDA(mmc_host_ida);
> -static DEFINE_SPINLOCK(mmc_host_lock);
>
>  static void mmc_host_classdev_release(struct device *dev)
>  {
>         struct mmc_host *host = cls_dev_to_mmc_host(dev);
> -       spin_lock(&mmc_host_lock);
> -       ida_remove(&mmc_host_ida, host->index);
> -       spin_unlock(&mmc_host_lock);
> +       ida_simple_remove(&mmc_host_ida, host->index);
>         kfree(host);
>  }
>
> @@ -354,22 +351,13 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         /* scanning will be enabled when we're ready */
>         host->rescan_disable = 1;
>
> -again:
> -       if (!ida_pre_get(&mmc_host_ida, GFP_KERNEL)) {
> +       err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
> +       if (err < 0) {
>                 kfree(host);
>                 return NULL;
>         }
>
> -       spin_lock(&mmc_host_lock);
> -       err = ida_get_new(&mmc_host_ida, &host->index);
> -       spin_unlock(&mmc_host_lock);
> -
> -       if (err == -EAGAIN) {
> -               goto again;
> -       } else if (err) {
> -               kfree(host);
> -               return NULL;
> -       }
> +       host->index = err;
>
>         dev_set_name(&host->class_dev, "mmc%d", host->index);
>
> --
> 2.11.0
>
