Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0057FC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Jan 2022 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347829AbiARSNw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Jan 2022 13:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347828AbiARSNv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2022 13:13:51 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F5C06161C
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 10:13:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x7so74166573lfu.8
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZCS5SVZK2L8S9xNfDFnJAY2P9V67pUv9JotfTURPdc=;
        b=VDEyKx9vJ1XeIiO3nLQEc+hXfAz3GPhhAwDgMn8mj+iAkl5w4iplhps+qgKIM+0byC
         Rvhk6ghOcpj5FLgaBVuoTrnqVVkg2Vx1lxldB6Y+hbSIQTFsNwueRz9CxxrE9GkL4RHs
         hzSK+HV4eyGYXqNSq1YWWRS/tHhCMB1OLBKv4/VuVqLmeQBaECQFk8g9IropJIjivd0J
         Y14w+d2NqjE26gwtzcgqLV8H9vjsgsd7voocY9+pITxXdvXc60mog1DU1vx3b9np1mga
         YKfiBl73Ja+umCbfj/pn1C21ZzSa7bIY9aH2lQbR5aUcU3f+TzJDDAeYkhtY9o0/+Mco
         Zjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZCS5SVZK2L8S9xNfDFnJAY2P9V67pUv9JotfTURPdc=;
        b=5qmYb0oZZ6IsUvTcSegn9KVqF1Oxrxz2GrviGHdaO4iQTesDLINYsEyxZe9Vu2EjZf
         JzfLZh5/IowYjwTF67JceYZGfCan8YjwMIc6ewFr6GHHEvr107bco49Imfjl/VjmzuIk
         /TVpDfNNmumeMH1aDieG738d6UFb2U9qm3+MvCbsb/WZAmQ9vVXuZjrXl8fpto0PZIYW
         hWaV/beOP/0hWkZ++qXKN0c9OlHf4Dvk2/Rc/SDj/bfb+f09H417vf66b63JCEGTvr5t
         n+uW4kBa6CkRVGCBWlEMqznZW/RTxT1Eoqj6XH2U52Qizhvbus1Xb9oA/fvqMJIoPFY8
         GR8Q==
X-Gm-Message-State: AOAM533ZJR9eveimaBMS0IPK+xrr/+Bk8Ja1cUrLFHDjmuPhlFgOOkQh
        3DTkMM7gKW9IV4AukyaBYGn4n9K7HKV409g+SnNvXwYl3z4/8Q==
X-Google-Smtp-Source: ABdhPJyEptVcHmTt+O+yUspy+IWTA5CynZ+6eKQbc0Z/FDcr6y+/NvQPHe/czvduqPycuOS0PwZVUGREk0imJsX5Pl0=
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr2528313ljl.367.1642529629711;
 Tue, 18 Jan 2022 10:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20220105094104.2457423-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220105094104.2457423-1-jiasheng@iscas.ac.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Jan 2022 19:13:13 +0100
Message-ID: <CAPDyKFqBCGyZ7M0=b511rC2Jxr2xF5tuOf2BNEmtB1JG7KUnEg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: Check for null res pointer
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 5 Jan 2022 at 10:41, Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> If there is no suitable resource, platform_get_resource() will return
> NULL.
> Therefore in order to avoid the dereference of the NULL pointer, it
> should be better to check the 'res'.
>
> Fixes: 27cbd7e815a8 ("mmc: sh_mmcif: rework dma channel handling")

I think this fixes tag is wrong. The problem seems to have been there
way before this point.

I suggest we instead just tag it for stable - and then let it be
applied to whatever kernel version it can. Does it make sense to you?

Kind regards
Uffe

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/mmc/host/sh_mmcif.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index e5e457037235..45dfa3b0be9c 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -405,6 +405,9 @@ static int sh_mmcif_dma_slave_config(struct sh_mmcif_host *host,
>         struct dma_slave_config cfg = { 0, };
>
>         res = platform_get_resource(host->pd, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;
> +
>         cfg.direction = direction;
>
>         if (direction == DMA_DEV_TO_MEM) {
> --
> 2.25.1
>
