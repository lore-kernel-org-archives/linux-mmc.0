Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60EEC04A94
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Aug 2023 11:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjHILer (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Aug 2023 07:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbjHILer (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2023 07:34:47 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8658B1BFF
        for <linux-mmc@vger.kernel.org>; Wed,  9 Aug 2023 04:34:46 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso5810293276.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Aug 2023 04:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691580885; x=1692185685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aD56ssm9QC9I0rzJqBDeVLbg0IeaWawXKYztBhRW81Q=;
        b=CuVvO32bFJmtcXNM/Ac/ZcRHY9bx+5ZKfEv+DgKCDzVRAzvY7tJ/uW5cVqHAfeXSSy
         IyfswDeU5vuksuGXvs/JFngTKVZP0sENgrm2Io8DwwgIrQghS82AHvsblFgcjYQlSnI5
         KESlgSbpGBMruAV7VjyjK42KqF+CEwlLjGZpxUvY+OsPlZHcFxIVNeEbKVjSKQPkLWXK
         n7GbfQPft4O75MRzz1nUPirhkyIuSfiuJHcdOrhgq0faT4IfenI2c7qJyVzyq2ZrRvQk
         I6pyrtWoxAc/0uVUpoVsJpsEj8kPiXxEB+jerZNjedubyq8z8/YBcXeTKiNHtMflgbn7
         PISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691580885; x=1692185685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aD56ssm9QC9I0rzJqBDeVLbg0IeaWawXKYztBhRW81Q=;
        b=h3NDHZznnmN2BVHb+B5D317Hz0nz2H1lMev65CphbvUWZ+LHOnN0Ajqbnyq3GqtrQ0
         sgNabKY6rtpP1oEFkwylcAcvc/ifE4ZPhBkVedovoA7RRoWfJXgRo8L0i/blCWnETe0j
         vqKJrdjkhW6KmLs5yu3RP3yykNU/HukY0ew4eVHxMA/hCgFl+jjChwIlAJ6i4gHIt4fp
         okTO+dQ5ADN+0PuYwMFkkMfmOR9arMXQ9KrvRJ8bSYdkl4WW01POahyYYGtX5xrOqkUP
         i0wJLxlX6xJR+Fx8yqNcryM3dx2ScIi8jtrhINwN1KaMiXx0/cITuzZGm6LaRnyuPWBo
         Y4Jg==
X-Gm-Message-State: AOJu0YxojsME+ehh/Ssjn5UY2tjlOmHzmUEWYgu9IFAtOTHOro0oIRfs
        0HZO7/JRxuuPX1wQpM9dCF/Vq8HF1lyqzHzYbQZwCg==
X-Google-Smtp-Source: AGHT+IFWTtT7Au7OcxGJYudyxTmX0HDSlvkTygksag1saC0TK5AE/Org3FlDFAVjAS3k5Yn+HiTFsD4ysSp1D5ox0GE=
X-Received: by 2002:a25:b09e:0:b0:d35:9a48:51b0 with SMTP id
 f30-20020a25b09e000000b00d359a4851b0mr2468087ybj.7.1691580885637; Wed, 09 Aug
 2023 04:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230807124443.3431366-1-yangyingliang@huawei.com>
In-Reply-To: <20230807124443.3431366-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Aug 2023 13:34:09 +0200
Message-ID: <CAPDyKFqm8Uc8St8+kFqpLiJrcF+Y8M=oPS2VwX+Ohx8TXQXGvg@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] mmc: wbsd: fix double mmc_free_host() in wbsd_init()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org, pierre@ossman.eu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Aug 2023 at 14:48, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> mmc_free_host() has already be called in wbsd_free_mmc(),
> remove the mmc_free_host() in error path in wbsd_init().
>
> Fixes: dc5b9b50fc9d ("mmc: wbsd: fix return value check of mmc_add_host()")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/wbsd.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index 521af9251f33..bf2a92fba0ed 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -1705,8 +1705,6 @@ static int wbsd_init(struct device *dev, int base, int irq, int dma,
>
>                 wbsd_release_resources(host);
>                 wbsd_free_mmc(dev);
> -
> -               mmc_free_host(mmc);
>                 return ret;
>         }
>
> --
> 2.25.1
>
