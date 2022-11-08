Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067DAC4332F
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 16:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiKHQF2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 11:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHQF1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 11:05:27 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8B517A86
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 08:05:26 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id l2so14547039pld.13
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2022 08:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/7DBpcXjoEuxYm96UMO1WQWUSv8DVRGWg2hVuVzg6y8=;
        b=cKxMbBYM+zL79UzdBN8w8egsbaj1hWslWpM61BzkkmRxDRKOy6L7ptIIA27jx7U3qz
         N0uRHFW/yjrQPPaTu09a+qqgpbaQlP3OsFCQSXx74G9ed4SBiIO8ZxprSv218HKtp14e
         apJGsw5fxkK9c9PWPv6XbuJlKbs6V+YAp43ZEODFBef7XdOBsgiX65AlW4m/FtRsZRsx
         drWX5QE+7usXF0ypJ5Dz56SB0wQHj4S3dXOy29ghieWoEcliYNQscYKTnqZh04iaxC5N
         ndZSCeB9dameOsO7IgUm3pZN3t/GOuvNRc5cOwGumpPDS7esfFiEPj+GZf1OUUv1zuAU
         gUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7DBpcXjoEuxYm96UMO1WQWUSv8DVRGWg2hVuVzg6y8=;
        b=ATkz8Ge4bbwqU2Q/kmxOdUT6c6491b6/ruHoxiot79hnZV7j5NA8K+QjHF1m1iauO6
         PFX7vdq0IVQKdXnwscJW87Aq5VCQT//GlbkwukHetlRoYNgZwVFlamKqpUAVALRpm0A+
         lsFBIZdTDMUq1XKMpbhJuzPi5xFzv8fGmzBTfbKP8pEW0/y/Wa6BKy9+j8cN3fSudYKk
         0lbd0b8pWyoN7Bm8EkpB4PBnpFa6zDTLXfP2MH65lkdOKliIpdInIR/veCTNpjPct1NC
         EeMnF3z1L/06vSRrzucYgufSsSw8l1PJi/j0Cm476YmmhV/p/crNThuUlmZY9mUgJHRD
         pPxw==
X-Gm-Message-State: ACrzQf2vCF0XGQxOmUEQHOJUaykYlxnSmEeuG0VMuZj13Zg0GhyMHqqM
        GZk+QZmioGWH/KOU5qY+juj9zyBZvHdWznx09Po+N7OEWPqCAA==
X-Google-Smtp-Source: AMsMyM5xCK55KF9NYcRvKsBhPwhw+sVllZfqaqibZ4WP8MMduJ0POvucVze11iBIe1SftKPG8M45+YSJ9LbSx1cUHro=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr57860803plb.148.1667923525987; Tue, 08
 Nov 2022 08:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20221102012533.1270876-1-yangyingliang@huawei.com> <20221102012533.1270876-2-yangyingliang@huawei.com>
In-Reply-To: <20221102012533.1270876-2-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Nov 2022 17:04:49 +0100
Message-ID: <CAPDyKFopPes26gxBwLw=61ZkZCA-dRbaXCMMbL+JvxymuziB-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: sdio: fix of node refcount leak in sdio_add_func()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Nov 2022 at 02:27, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> If device_add() returns error in sdio_add_func(), sdio function is not
> presented, so the node refcount that hold in sdio_set_of_node() can not
> be put in sdio_remove_func() which is called from error path. Fix this
> by calling of_node_put() if device_add() fails.
>
> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/mmc/core/sdio_bus.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index babf21a0adeb..b9308813a226 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -365,6 +365,8 @@ int sdio_add_func(struct sdio_func *func)
>         ret = device_add(&func->dev);
>         if (ret == 0)
>                 sdio_func_set_present(func);
> +       else
> +               of_node_put(func->dev.of_node);

I think it would be better to change the sdio_remove_func() to manage
this. In principle sdio_func_present() should not make
sdio_remove_func() to return immediately, but rather just control
whether device_del() needs to be called or not.

>
>         return ret;
>  }


Kind regards
Uffe
