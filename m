Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13857C49361
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Jun 2021 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A6661410
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Jun 2021 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhFQJ5x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Jun 2021 05:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhFQJ5u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jun 2021 05:57:50 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B4C06175F
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2021 02:55:42 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id z7so2660464vso.3
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2021 02:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TGF2wYERrKpdFRDmug3cW8EmOuReCFMS75jXByEbcSg=;
        b=RniFwgPZ3+AzveGFKOKCa5Pz7LGq+lxF6fNkMASZWilj9ugmn6Xk9eFRKKviSpBMZj
         2LoGvJmxJcT2c/pyB0AkJNWYeiRooIG67XbSCiCG1SdmUJTVoPc1j56dNeNolJvwoCMk
         2j9F/tvbzrnLC2n52qQ/O6yCTl2cVoP3JNTN0hV26HxXximnGysyQZzWA5UVvlfA0q7Q
         xVbECCJNj5mxgu8Mmm90qfAiSj1ZgaLwuJ1KiEfXdIVr+l71rXWcfyz5kJaU+K3TE+ut
         2wE3xZIJ0k6Wu1DXkIaKAUVTtiBPKgHk0RdGriLItwtD3sJorOMy0gq5MqT0uYKScTj+
         w+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGF2wYERrKpdFRDmug3cW8EmOuReCFMS75jXByEbcSg=;
        b=QWTvFhuTjXS/WNFPYIljrLx15PWguNSi6hIHdr27AB/aWlO5zmXBOI2wHhC031tDl7
         ucyqbQnvDs0ry0NXiC3ekdlYtnSe8e6M9bjqzfo67w6MoZMgXrSNDKZ7pFu2LZAD4DoR
         jXBF7aezZHK5+m8kjrDZtuwFDWjo9mUTGuaEtAzEfGzgOjWXEBWK/7eA/fvTJWBpgtys
         b0LvFGeO8nahM/+v6W8iguIrhcYfSGJJEop1DBUUY5abJdU4pso9jx7Ov9FYEDHs5hWy
         SRHlsxmzUqPs0Y9hsy90ft5Qj/Zb7JqWSOlZIw2nSOk4cPJJKhvQqjVWwvcHyASWmKER
         Jfrg==
X-Gm-Message-State: AOAM530DBZkncwE+1m3Rz/RUenVcjSe97m/Q/AhMYnf5S22j6MCJC1JE
        3mJBGkdhHuELw6jgj9vTEvyrcE9Q/ZPnrkMQLbMYO5wV6BYbTQ==
X-Google-Smtp-Source: ABdhPJw+VvM8QTil6PXyie0e7li3RDVzR5PyTH9Db0r0ri9Eftr0UXB/pubv1EBQuuRPig7Bfrauy2oE80wrpmL4Hqw=
X-Received: by 2002:a05:6102:2159:: with SMTP id h25mr3411673vsg.19.1623923741317;
 Thu, 17 Jun 2021 02:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210616053934.880951-1-hch@lst.de> <20210616053934.880951-2-hch@lst.de>
In-Reply-To: <20210616053934.880951-2-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Jun 2021 11:55:04 +0200
Message-ID: <CAPDyKFpkaPXu_Nxm-_p_8r5eh9V3XMhXkci1wurdJmGqvbdD-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: remove an extra blk_{get,put}_queue pair
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Jun 2021 at 07:40, Christoph Hellwig <hch@lst.de> wrote:
>
> The gendisk already acquires a reference to the queue when add_disk
> is called, which dropped on put_disk.  So remove the superflous
> extra refcounting.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice cleanup!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 689eb9afeeed..947624e76c33 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -201,7 +201,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
>         md->usage--;
>         if (md->usage == 0) {
>                 int devidx = mmc_get_devidx(md->disk);
> -               blk_put_queue(md->queue.queue);
> +
>                 ida_simple_remove(&mmc_blk_ida, devidx);
>                 put_disk(md->disk);
>                 kfree(md);
> @@ -2326,18 +2326,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>
>         md->queue.blkdata = md;
>
> -       /*
> -        * Keep an extra reference to the queue so that we can shutdown the
> -        * queue (i.e. call blk_cleanup_queue()) while there are still
> -        * references to the 'md'. The corresponding blk_put_queue() is in
> -        * mmc_blk_put().
> -        */
> -       if (!blk_get_queue(md->queue.queue)) {
> -               mmc_cleanup_queue(&md->queue);
> -               ret = -ENODEV;
> -               goto err_putdisk;
> -       }
> -
>         md->disk->major = MMC_BLOCK_MAJOR;
>         md->disk->first_minor = devidx * perdev_minors;
>         md->disk->fops = &mmc_bdops;
> --
> 2.30.2
>
