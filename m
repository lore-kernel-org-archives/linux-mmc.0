Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52614C433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 09:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C1A2068F
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 09:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaSXdba5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgHYJUg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgHYJUg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 05:20:36 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756E6C061755
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2020 02:20:35 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y8so5960384vsq.8
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2020 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RE4Ki0KsQ1ZCjBgLwwwcSn3VtnY3dVfuiwED9hvbSeQ=;
        b=jaSXdba5X+bBzry1TQOZDk+5dtAHbETHyvKYqbEPs1bmgJzW8DPYoewuuztM9m6TQ3
         nOaLZQnUlsJGhLn8aR3vkrzi7JnWBdwqQRoN5SJ7UQJGcB1cEXtbvTmpmtBco7bQ67TN
         AdgGj3TUhrfzF/0rmrfCKiiimSOH6a30o9+SHy2juX4w0FFddoDHy/eT2y1PAWNTT8Nr
         krCjL2BpZdknCArUnYpYLvbn4zlJC8F4TZQQqI1x5ansp8VW4l6C3/eVPWSIZnM+a3IU
         HK4RZrA5xb91vgGcVRh5VIILEEG1iOYfD+cn+O2GtLgVhYaSXjkFwsT4dIwC7ZXahKcq
         Ln6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RE4Ki0KsQ1ZCjBgLwwwcSn3VtnY3dVfuiwED9hvbSeQ=;
        b=rOsZzdLLH7Mtr6koerllgFAtxkdDFTPjViQW6xc1cgdeslujInOitxYanvZDXLy8Tv
         bS5N24MG8Mlovl6So8WklBtOo+6j2HxosQVxzf5p7F3ke9YiAR9lpDRm5IEHWTbeSop8
         pqPkjuVUXp17Xludvxv8HaUJ4jwavmIHpTtzwR6R85ZRkwS28syp9TlwP+nE+PhGA4jp
         HDUSOCkCEMjPqjkBKcfm0x0vgGVOoBnEEVG5DBLgFniEUhk5QFbINHQBF39Rj0hPp83h
         cex0QQUqLIDD9ztgXVIx5IcfxpqEhk0AeirY2ACP0zXKrHv2kFTKHDVD3feGH5nFcEEO
         oOmQ==
X-Gm-Message-State: AOAM5312z7Mg5CE3FUcSdJ6/vZx9ozy6wg3kEhwkbKK5HGwd6CRrFQ9f
        2u7MRHp9V4fyqAdPXlPl5OUm5s3LmxI7NDVI9Gwclw==
X-Google-Smtp-Source: ABdhPJwkkicekTC3pU8dLL4Fs6NujFaf6Q6aRPdusTHFwELiwk8Tp8c+YfE+JVOT1IwgNu431PAptkDFAdGSjW/c0c0=
X-Received: by 2002:a67:8c06:: with SMTP id o6mr5206839vsd.200.1598347234392;
 Tue, 25 Aug 2020 02:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200820075949.19133-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20200820075949.19133-1-matthias.schiffer@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Aug 2020 11:19:58 +0200
Message-ID: <CAPDyKFq8RL8=1bF2Tc3eQPpTBDv-z4K5jEhu5J1TOF=X-GJPqA@mail.gmail.com>
Subject: Re: [PATCH mmc-next v2] mmc: allow setting slot index via device tree alias
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 Aug 2020 at 09:59, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> As with GPIO, UART and others, allow specifying the device index via the
> aliases node in the device tree.
>
> On embedded devices, there is often a combination of removable (e.g.
> SD card) and non-removable MMC devices (e.g. eMMC).
> Therefore the index might change depending on
>
> * host of removable device
> * removable card present or not
>
> This makes it difficult to hardcode the root device, if it is on the
> non-removable device. E.g. if SD card is present eMMC will be mmcblk1,
> if SD card is not present at boot, eMMC will be mmcblk0.
>
> All indices defined in the aliases node will be reserved for use by the
> respective MMC device, moving the indices of devices that don't have an
> alias up into the non-reserved range. If the aliases node is not found,
> the driver will act as before.
>
> This is a rebased and slightly cleaned up version of
> https://www.spinics.net/lists/linux-mmc/msg26588.html .
>
> Based-on-patch-by: Sascha Hauer <s.hauer@pengutronix.de>
> Link: https://lkml.org/lkml/2020/8/5/194
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

One more thing, can you please also update the DT doc example in
mmc-controller.yaml, to show that mmc supports aliases. In a separate
patch, of course.

Kind regards
Uffe

> ---
>
> v2: fix missing symbols for modular mmcblock
>
>  drivers/mmc/core/block.c | 13 +++++++++++--
>  drivers/mmc/core/core.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/core.h  |  3 +++
>  drivers/mmc/core/host.c  | 15 +++++++++++++--
>  4 files changed, 67 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 7896952de1ac..4620afaf0e50 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -38,6 +38,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/idr.h>
>  #include <linux/debugfs.h>
> +#include <linux/of.h>
>
>  #include <linux/mmc/ioctl.h>
>  #include <linux/mmc/card.h>
> @@ -2260,9 +2261,17 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>                                               int area_type)
>  {
>         struct mmc_blk_data *md;
> -       int devidx, ret;
> +       int rsvidx, devidx = -1, ret;
> +
> +       rsvidx = mmc_get_reserved_index(card->host);
> +       if (rsvidx >= 0)
> +               devidx = ida_simple_get(&mmc_blk_ida, rsvidx, rsvidx + 1,
> +                                       GFP_KERNEL);
> +       if (devidx < 0)
> +               devidx = ida_simple_get(&mmc_blk_ida,
> +                                       mmc_first_nonreserved_index(),
> +                                       max_devices, GFP_KERNEL);
>
> -       devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
>         if (devidx < 0) {
>                 /*
>                  * We get -ENOSPC because there are no more any available
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8ccae6452b9c..5bce281a5faa 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2419,10 +2419,50 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
>  }
>  #endif
>
> +static int mmc_max_reserved_idx = -1;
> +
> +/**
> + * mmc_first_nonreserved_index() - get the first index that is not reserved
> + */
> +int mmc_first_nonreserved_index(void)
> +{
> +       return mmc_max_reserved_idx + 1;
> +}
> +EXPORT_SYMBOL(mmc_first_nonreserved_index);
> +
> +/**
> + * mmc_get_reserved_index() - get the index reserved for this MMC host
> + *
> + * Returns:
> + *   The index reserved for this host on success,
> + *   negative error if no index is reserved for this host
> + */
> +int mmc_get_reserved_index(struct mmc_host *host)
> +{
> +       return of_alias_get_id(host->parent->of_node, "mmc");
> +}
> +EXPORT_SYMBOL(mmc_get_reserved_index);
> +
> +static void __init mmc_of_reserve_idx(void)
> +{
> +       int max;
> +
> +       max = of_alias_get_highest_id("mmc");
> +       if (max < 0)
> +               return;
> +
> +       mmc_max_reserved_idx = max;
> +
> +       pr_debug("MMC: reserving %d slots for OF aliases\n",
> +                mmc_max_reserved_idx + 1);
> +}
> +
>  static int __init mmc_init(void)
>  {
>         int ret;
>
> +       mmc_of_reserve_idx();
> +
>         ret = mmc_register_bus();
>         if (ret)
>                 return ret;
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 575ac0257af2..6aef6cf4e90f 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -79,6 +79,9 @@ int mmc_attach_mmc(struct mmc_host *host);
>  int mmc_attach_sd(struct mmc_host *host);
>  int mmc_attach_sdio(struct mmc_host *host);
>
> +int mmc_first_nonreserved_index(void);
> +int mmc_get_reserved_index(struct mmc_host *host);
> +
>  /* Module parameters */
>  extern bool use_spi_crc;
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index ce43f7573d80..386e15afde83 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -387,6 +387,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>  {
>         int err;
>         struct mmc_host *host;
> +       int alias_id, min_idx, max_idx;
>
>         host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
>         if (!host)
> @@ -395,7 +396,18 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         /* scanning will be enabled when we're ready */
>         host->rescan_disable = 1;
>
> -       err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
> +       host->parent = dev;
> +
> +       alias_id = mmc_get_reserved_index(host);
> +       if (alias_id >= 0) {
> +               min_idx = alias_id;
> +               max_idx = alias_id + 1;
> +       } else {
> +               min_idx = mmc_first_nonreserved_index();
> +               max_idx = 0;
> +       }
> +
> +       err = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
>         if (err < 0) {
>                 kfree(host);
>                 return NULL;
> @@ -406,7 +418,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         dev_set_name(&host->class_dev, "mmc%d", host->index);
>         host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));
>
> -       host->parent = dev;
>         host->class_dev.parent = dev;
>         host->class_dev.class = &mmc_host_class;
>         device_initialize(&host->class_dev);
> --
> 2.17.1
>
