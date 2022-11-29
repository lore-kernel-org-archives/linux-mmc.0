Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7D6C4321E
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 12:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbiK2Mzj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiK2MzU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 07:55:20 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F5861779
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:55:12 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v3so12928991pgh.4
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftiXgz+B+vOpBcYXy4A3YnZ9vOuM4Xrk8do1SJNwvNw=;
        b=S5fONXt/GZUX+VPNjQ8wjwvgj1L5o3FEQEHgHst+0zUCcE6FDhY9qA+zTRXofJWDW+
         c1oAAENRW4wu99+WAh4Vgan0DVieGb0G6LKgnn02xsYsYbMRyY3yLSKgwC2bkcWKRmBc
         bDrqshM+GcRK37/bOVIsjF6lyTdj5wKLTGcm4VCfF62BOI32ewCviQll4UrgRSE+EDuz
         /KABiRD982+xl3jCI0U/eSW2IVTUNnwtk/DEmuMjN03fbb/IpniiTCXHrxJzRH8eNa0b
         twd+x0dflgEk2FVaQ4LlbfaHNgCE5dodml94qdwNYMYbgXLNU0muZ/UOfp/iKmHP+LbU
         mD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftiXgz+B+vOpBcYXy4A3YnZ9vOuM4Xrk8do1SJNwvNw=;
        b=CBwT+awIn64RiSyvANl0Sz42DMmX1fT9fFwIgj9BFRKwqr1ZzcG6ceedCAtB7UVkCe
         3S8uWchpa+9laY5HDhJODPfgfDORDKqEiYV/+LCEczlXUl9G+9P9xYcSgsZb9sVWjvYC
         DVvCak0/gRnQ43qIEVZmgMjP/KA4LXuloulg+zaqHTFEt6pH7fYmN8opcZ+BBQTAnBaZ
         io5Cppj6eLu6zjq9hqm++4CT97mjh3MQxyWF9szNqEjEWTQUZ/RIpONbvhRwwqjtWl7R
         mxiC0zDqh+f0pm60m4T4O0fhuGVhwI9R0mhxPwbeDoHHKE7w7l2Eguv+Q5NoR5aZP3hk
         0mrA==
X-Gm-Message-State: ANoB5pkhH5B7cygZaojntfr+eIEkJH+rJJLMbqTo/jJvLmcCmk3aXItx
        vx1g+RzYIEYb+0pbH4TxBTTIAfNc+MHnUmeHtYe9Z9vU63o=
X-Google-Smtp-Source: AA0mqf4tRavSghmd641vpAo8y9apdqARGkKzA4fKbaIkdh0gUAGATXJxxpWIxwsXpsKsxP6JAgnBU3+euq7f+fKIv6s=
X-Received: by 2002:a63:501c:0:b0:477:650a:c29a with SMTP id
 e28-20020a63501c000000b00477650ac29amr31160049pgb.541.1669726512135; Tue, 29
 Nov 2022 04:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20221126012558.34374-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20221126012558.34374-1-jiasheng@iscas.ac.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:35 +0100
Message-ID: <CAPDyKFo6jyL+A82w+ixBgHdAjTry4LiqOU6i0yFzoS-0nntMtg@mail.gmail.com>
Subject: Re: [PATCH v2] memstick/ms_block: Add check for alloc_ordered_workqueue
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     error27@gmail.com, maximlevitsky@gmail.com, oakad@yahoo.com,
        christophe.jaillet@wanadoo.fr, axboe@kernel.dk, hare@suse.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 26 Nov 2022 at 02:26, Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the alloc_ordered_workqueue may return NULL pointer,
> it should be better to add check for the return
> value.
> Moreover, the msb->io_queue should be freed if error occurs later.
>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Applied for next (replaced the earlier applied v1 with v2), thanks!

Kind regards
Uffe


> ---
> Changelog:
>
> v1 -> v2:
>
> 1. Assign error number to rc if alloc_ordered_workqueue fails.
> 2. Free msb->io_queue if error occurs later.
> ---
>  drivers/memstick/core/ms_block.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index ba8414519515..04115cd92433 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2116,6 +2116,11 @@ static int msb_init_disk(struct memstick_dev *card)
>         dbg("Set total disk size to %lu sectors", capacity);
>
>         msb->io_queue = alloc_ordered_workqueue("ms_block", WQ_MEM_RECLAIM);
> +       if (!msb->io_queue) {
> +               rc = -ENOMEM;
> +               goto out_cleanup_disk;
> +       }
> +
>         INIT_WORK(&msb->io_work, msb_io_work);
>         sg_init_table(msb->prealloc_sg, MS_BLOCK_MAX_SEGS+1);
>
> @@ -2125,10 +2130,12 @@ static int msb_init_disk(struct memstick_dev *card)
>         msb_start(card);
>         rc = device_add_disk(&card->dev, msb->disk, NULL);
>         if (rc)
> -               goto out_cleanup_disk;
> +               goto out_destroy_workqueue;
>         dbg("Disk added");
>         return 0;
>
> +out_destroy_workqueue:
> +       destroy_workqueue(msb->io_queue);
>  out_cleanup_disk:
>         put_disk(msb->disk);
>  out_free_tag_set:
> --
> 2.25.1
>
