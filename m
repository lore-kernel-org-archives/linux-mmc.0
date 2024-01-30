Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEA6A035
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jan 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616434; cv=none; b=eG9kOXAbseJsE7V4j7wihCsaNw2h/ptEfAaFsqeHHT/RetL0XNbNKnUaO18y8lg3iqXrusK9woZKc1qRTpHGwRUGvYKCPjAnCw4u8aIU4ofHvvAR+7fPpN8VTAIju+Ik0Qq87vbhTqbwiFEgfhLxLJoghhfrIe6QXhVukYISoZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616434; c=relaxed/simple;
	bh=lccpQK3PSK7WIyeUVAhCOB6LOdNwTfMMMzzSDXBHnCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8rcFhPymVIDhzBI9EFZaRAhqMervmIIDWgQUXzXVvmYEGVjGDI9k9H+rG76BqrtG/fJRvkzfRf9r+BKimkdwZX6z0/cy0idQybzs43U9WpFyNP6m7tLNJFAimV7KBoelAdHnNpTFV0AU6TzmnEKsRu9aPBuuNzfdZo6p195xKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qft49v2T; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qft49v2T"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5ff821b9acfso37032917b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jan 2024 04:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706616430; x=1707221230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLcG4HSMsok8OgW9kIfoonSsgZVQI6gGRsjiQ9jl1ag=;
        b=qft49v2TQzyCn1UoQ+45+DsRu+ZfiaTHXge3GcnaYN/JeMnFTHe5Y53JB2mkltC1mJ
         IqoUOmkdH7WdBk74vD5RzR22cf91u/WtMxQlOtJR61Z3NroIt3kHvcF4HyZgzh5Ezzp1
         EtW/Cc48CASnnEuOvueYgU5y3KpE+jipAUhxU55RJPf1i/UZs9NFBS2jy3e+7nqFBMD5
         /qJlNWwI2PDq6b4YBmqwRjsgQ791OeCAlGOYVXuSISIKR/eFMoPY1lcM0uUnlq01Dggt
         eQAHyDtz9Z/BB7W8l220qIeWNXVf0f0efxWJnezRxjx5xmUyxGoHz7zN9M1Zm7XoUfFv
         SSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616430; x=1707221230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLcG4HSMsok8OgW9kIfoonSsgZVQI6gGRsjiQ9jl1ag=;
        b=HkZsXQtGH9sCuXiPZuqBwjxfdduhW4GE7fxw03ToiacLMouHa0muyIyr7uUZ+mhPda
         /PE5wQi5LvaKwE9E/mb4Uz7Vd7VkhhK9/IuxWeIPTi14iIZ0Rkdj+tx9lDs6ACLfd8HF
         Yza0ifYKb1Po3MEKr/nkRETbDV5uYdz5gwaDZn8RWxfBJQccN/Um9yBvBVKGE+Rh/ZC0
         xdlkt0HjoD4BaLpfB8gzWyoQnzyoexlBEPpc6+4yy0jPMWz8VrFT12amcWiNw5OT6fbc
         33nXKN1YQzNXuZsai1nhgcBZtAtftvdbUgk8bmoZShGjuEEibFuBQIUT6G0Xfe33MIKO
         aYGA==
X-Gm-Message-State: AOJu0Yz7cmiDhPuX8FcVne0crdq4SHDdFazt5oda7xr5kSvHhPm4bE7y
	pkJ+Q4ZElgtw20KvekMCI6HdD2YPhRbL6yl9ByNeKFVsV8Vz/5tmGmLile1BF67iF2ZPuP67T+f
	OyHg1eGF8m4AHBVkDQtDgub36zy7PmbRRWUubGw==
X-Google-Smtp-Source: AGHT+IFiIk5mLx1BTIPjxiEuu61f8VEJBW3ENgrpjiz3Pw1GeRA3bVO2GLwMIF1c4DdF1DHZmHrw2zz116TNB7Qdfhg=
X-Received: by 2002:a81:eb0d:0:b0:5ff:6028:99f5 with SMTP id
 n13-20020a81eb0d000000b005ff602899f5mr5554333ywm.41.1706616430609; Tue, 30
 Jan 2024 04:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <583c57d0ae09f9d3a1e1a7b80c1e39ada17954b7.1705244502.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <583c57d0ae09f9d3a1e1a7b80c1e39ada17954b7.1705244502.git.christophe.jaillet@wanadoo.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Jan 2024 13:06:34 +0100
Message-ID: <CAPDyKFrghmeDkUfkJ2kvk14bv_GWPKR6iJkCTJUjzNCaB9EFuA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove usage of the deprecated ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jan 2024 at 16:02, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
>
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added when
> needed.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 12 ++++++------
>  drivers/mmc/core/host.c  |  5 +++--
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 32d49100dff5..a9b60b91e32f 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -206,7 +206,7 @@ static void mmc_blk_kref_release(struct kref *ref)
>         int devidx;
>
>         devidx = mmc_get_devidx(md->disk);
> -       ida_simple_remove(&mmc_blk_ida, devidx);
> +       ida_free(&mmc_blk_ida, devidx);
>
>         mutex_lock(&open_lock);
>         md->disk->private_data = NULL;
> @@ -2467,7 +2467,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         bool cache_enabled = false;
>         bool fua_enabled = false;
>
> -       devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
> +       devidx = ida_alloc_max(&mmc_blk_ida, max_devices - 1, GFP_KERNEL);
>         if (devidx < 0) {
>                 /*
>                  * We get -ENOSPC because there are no more any available
> @@ -2577,7 +2577,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>   err_kfree:
>         kfree(md);
>   out:
> -       ida_simple_remove(&mmc_blk_ida, devidx);
> +       ida_free(&mmc_blk_ida, devidx);
>         return ERR_PTR(ret);
>  }
>
> @@ -2703,7 +2703,7 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
>  {
>         struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
>
> -       ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> +       ida_free(&mmc_rpmb_ida, rpmb->id);
>         kfree(rpmb);
>  }
>
> @@ -2719,13 +2719,13 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>         struct mmc_rpmb_data *rpmb;
>
>         /* This creates the minor number for the RPMB char device */
> -       devidx = ida_simple_get(&mmc_rpmb_ida, 0, max_devices, GFP_KERNEL);
> +       devidx = ida_alloc_max(&mmc_rpmb_ida, max_devices - 1, GFP_KERNEL);
>         if (devidx < 0)
>                 return devidx;
>
>         rpmb = kzalloc(sizeof(*rpmb), GFP_KERNEL);
>         if (!rpmb) {
> -               ida_simple_remove(&mmc_rpmb_ida, devidx);
> +               ida_free(&mmc_rpmb_ida, devidx);
>                 return -ENOMEM;
>         }
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index cf396e8f34e9..7cc9a33d28ca 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -76,7 +76,7 @@ static void mmc_host_classdev_release(struct device *dev)
>         struct mmc_host *host = cls_dev_to_mmc_host(dev);
>         wakeup_source_unregister(host->ws);
>         if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
> -               ida_simple_remove(&mmc_host_ida, host->index);
> +               ida_free(&mmc_host_ida, host->index);
>         kfree(host);
>  }
>
> @@ -538,7 +538,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>                 min_idx = mmc_first_nonreserved_index();
>                 max_idx = 0;
>
> -               index = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
> +               index = ida_alloc_range(&mmc_host_ida, min_idx, max_idx - 1,
> +                                       GFP_KERNEL);
>                 if (index < 0) {
>                         kfree(host);
>                         return NULL;
> --
> 2.43.0
>
