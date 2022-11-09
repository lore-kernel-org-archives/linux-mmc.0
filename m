Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A0BC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 12:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiKIM14 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 07:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiKIM1z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 07:27:55 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412932CDEA
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 04:27:54 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z26so16560840pff.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 04:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ps+a93mKbAaLVBbIi5Bdy0J3m7nZCm55KVv0qQ+05U=;
        b=OfS9gskCi/hB8NFHwiFqtERxVbZO61IcypBofyrY3SpiOCBzexvbKvvhIO6ZEtx4/t
         iPOyvCcFLkuo7c8JKJKCpkdgt2JQq3B9syH2NJOLnbSZywJ+5wdnXom4hy4z20zYx6VN
         4yTAfqmp+zwmCF2o78gS9hOG3P9OWnTD4wML4kgrp8zojffI8wJ3XjVt+v6fgFcwQIUF
         VQgztNaBQMcdNFJZTZzWKmDyJ9cWwStHlV0XfjZVSEMjUYdzX6wyMX5jrqXsWXE4agir
         q42HXPhycmwrx6dzrdUnx4WB5duIDM2kFmEuxH7DeTMx87fWPhTuZVyLlfx8JjW6Ipix
         Qaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ps+a93mKbAaLVBbIi5Bdy0J3m7nZCm55KVv0qQ+05U=;
        b=H+8bycDcRPG5vVlVFmICpB6wpiIitISnZ1Cl7sp/K1MPyMh3yaj9jClKnnH4DcCUul
         oFf+HqHnLOJyg3FuDyWfxvq+BniZikPyCDRSfqq8T1bdKX5KKVLP6x0pXioZNmpdoJhM
         6Dyk5bf0VAMkZG98xfdqVg2iKqPj0aYXPkKD5DCQSOVATALQioMDUhGDISo2xp5mt1g6
         HujeOBEHqOG/ofKRVgSt03v/2rRJImBFNB0yivisJd9BFh+tNXTVwlGC5vuFljZoAAC2
         kO0X745EP1KB8sr628gp+fO8lwfSk08Y6DXNHl/KQUsdyPeuJ7fhB9m2Z9K7eO9US+ce
         Hk1Q==
X-Gm-Message-State: ACrzQf2uA12H7INbKZN68Ef7HFmebaakFmzp9btwrrlYARcnPQ1MRXQc
        OwPmkNDH4Xzt5oUbxOmmGuCCXpW6YXeDdoNN1uKLgz5dR/m7NA==
X-Google-Smtp-Source: AMsMyM5BGO8mLz6guqf/n0aWE9L9h9UNtAcicC9y80KDFIvqRO98H1j04Co0Lrxvi9SqPA1cLfbHFIvdUIpGFMXyew0=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr53503392pgk.595.1667996873748; Wed, 09
 Nov 2022 04:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20221109025142.1565445-1-yangyingliang@huawei.com> <20221109025142.1565445-3-yangyingliang@huawei.com>
In-Reply-To: <20221109025142.1565445-3-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:27:17 +0100
Message-ID: <CAPDyKFrcguZWaFd51Bk-xkkVHEWG5gTVKfVHLpc2KuF06hfFug@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: sdio: fix of node refcount leak in sdio_add_func()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Nov 2022 at 03:53, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> If device_add() returns error in sdio_add_func(), sdio function is not
> presented, so the node refcount that hold in sdio_set_of_node() can not
> be put in sdio_remove_func() which is called from error path. Fix this
> by moving of_node_put() before present check in remove() function.
>
> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/mmc/core/sdio_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index babf21a0adeb..266639504a94 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -377,11 +377,11 @@ int sdio_add_func(struct sdio_func *func)
>   */
>  void sdio_remove_func(struct sdio_func *func)
>  {
> +       of_node_put(func->dev.of_node);
>         if (!sdio_func_present(func))
>                 return;
>
>         device_del(&func->dev);
> -       of_node_put(func->dev.of_node);
>         put_device(&func->dev);

Seems like we should call put_device() even if sdio_func_present()
returns false, don't you think?

In this way, the corresponding sdio_release_func() will help to manage
the cleanup for us, so patch1 can be dropped. Or is there a problem
with that?

Kind regards
Uffe
