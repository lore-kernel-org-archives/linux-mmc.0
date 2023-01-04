Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72221C46467
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Jan 2023 10:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjADKTt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Jan 2023 05:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjADKTr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2023 05:19:47 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DDC193FA
        for <linux-mmc@vger.kernel.org>; Wed,  4 Jan 2023 02:19:46 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s67so12597468pgs.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jan 2023 02:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aBay3x5ix+eeS0Ab1w112q7r/bDoorzo0l299Ov2Q+0=;
        b=MRVAoQUpPfvGcfuJhT9ozrOtZYt3+xLerA/WQ2SOAnro5MSNs96KEdRrqfl0TKAPht
         tqmml6wwgIxVxaMTlEx1twESIr0ITs3T28qrOyLrLpMioiY+6qf9yty1jaLqzXxUkKIP
         c5+dKpDF+k6SNrs4Kr8vsv/PAY14Jzq3HOflF/vu1jdN0jMFEgL6SvjW47MW/C3pW7lF
         X+qhxRGLOPCvBCY/ZKuvfWzkMOs9Zoh5TqNAcnSmYIx5KTpxhi01fg3LtbCfEoNEYI2M
         h4dEuiDQ0UL9O/zHRi98RQ3KtD7BflakhiofxiBvipKGd5tLuHz3o33e0nnsWjccHSgL
         oCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBay3x5ix+eeS0Ab1w112q7r/bDoorzo0l299Ov2Q+0=;
        b=AQC6FTc2MYHBvk2gH1YKEGYe4E9Bdf/Vj8yzBBshBSTu1cX8U3uOqB3C2HdwM0yQl3
         W5lQrE5vmVTG0yzu/XBt68e31ikJhsQufkVyyWoVzrpaSj3htBrjgm5htU1dDGKkcy2v
         CAbFj2Piwydzzz+MJT5lEiIf9Ps7VGLneVuQjQFzJk4L5yLI3kS4gtf7Zh+ddYZGSlCt
         IHHfhOt2pkZTp4m4y/leazaSs5Y7clviIGFLZ+rhdmJg+9sXrXgtBaQc4ITlQqRZXk+9
         AazDat8xf/LFHgpvIzkAJGyh6hC9SejosRfdKGXNjlUO4H7y1sqZSvabcvi4EAKypAWo
         raWQ==
X-Gm-Message-State: AFqh2kpn2pwJu6kW9Sp756FPKac25f3XMKOphkFSrLledOuEgCWpCAf7
        umxCMmctuYiSghBcZjo5igCvKmllNZwb9mVdbdVu8E5TddDtPA==
X-Google-Smtp-Source: AMrXdXvwaCEbgZysYP7/DZ0pwn3zCNWade05Mj8AyMdITn2FqHQxu7YJLCxxh6eyyldu/wWNORF+QfXS8cL5ro3cc10=
X-Received: by 2002:a62:ed04:0:b0:577:3e5e:7a4 with SMTP id
 u4-20020a62ed04000000b005773e5e07a4mr3263806pfh.57.1672827585941; Wed, 04 Jan
 2023 02:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20221213141403.1734718-1-yangyingliang@huawei.com>
 <CAPDyKFqhTdk1n5Gj4aO3vQj7uZ3r+9H0tuBCNgwqvxyg=BNJRQ@mail.gmail.com> <cb59db8e-e479-8181-4f2c-e1340106e6cf@huawei.com>
In-Reply-To: <cb59db8e-e479-8181-4f2c-e1340106e6cf@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jan 2023 11:19:09 +0100
Message-ID: <CAPDyKFoH3o_+vC4RdhFG18-6wJqL4TZnyhvpjLXvWczN+ySKfA@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: sdio: fix possible resource leaks in some error paths
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Jan 2023 at 05:51, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
>
> On 2023/1/3 23:35, Ulf Hansson wrote:
> > On Tue, 13 Dec 2022 at 15:17, Yang Yingliang <yangyingliang@huawei.com> wrote:
> >> If sdio_add_func() or sdio_init_func() fails, sdio_remove_func() can
> >> not release the resources, because the sdio function is not presented
> >> in these two cases, it won't call of_node_put() or put_device().
> >>
> >> To fix these leaks, make sdio_func_present() only control whether
> >> device_del() needs to be called or not, then always call of_node_put()
> >> and put_device().
> >>
> >> In error case in sdio_init_func(), the reference of 'card->dev' is
> >> not get, to avoid redundant put in sdio_free_func_cis(), move the
> >> get_device() to sdio_alloc_func() and put_device() to sdio_release_func(),
> >> it can keep the get/put function balanced.
> >>
> >> Without this patch, while doing fault inject test, it can get the
> >> following leak reports, after this fix, the leak is gone.
> >>
> >> unreferenced object 0xffff888112514000 (size 2048):
> >>    comm "kworker/3:2", pid 65, jiffies 4294741614 (age 124.774s)
> >>    hex dump (first 32 bytes):
> >>      00 e0 6f 12 81 88 ff ff 60 58 8d 06 81 88 ff ff  ..o.....`X......
> >>      10 40 51 12 81 88 ff ff 10 40 51 12 81 88 ff ff  .@Q......@Q.....
> >>    backtrace:
> >>      [<000000009e5931da>] kmalloc_trace+0x21/0x110
> >>      [<000000002f839ccb>] mmc_alloc_card+0x38/0xb0 [mmc_core]
> >>      [<0000000004adcbf6>] mmc_sdio_init_card+0xde/0x170 [mmc_core]
> >>      [<000000007538fea0>] mmc_attach_sdio+0xcb/0x1b0 [mmc_core]
> >>      [<00000000d4fdeba7>] mmc_rescan+0x54a/0x640 [mmc_core]
> >>
> >> unreferenced object 0xffff888112511000 (size 2048):
> >>    comm "kworker/3:2", pid 65, jiffies 4294741623 (age 124.766s)
> >>    hex dump (first 32 bytes):
> >>      00 40 51 12 81 88 ff ff e0 58 8d 06 81 88 ff ff  .@Q......X......
> >>      10 10 51 12 81 88 ff ff 10 10 51 12 81 88 ff ff  ..Q.......Q.....
> >>    backtrace:
> >>      [<000000009e5931da>] kmalloc_trace+0x21/0x110
> >>      [<00000000fcbe706c>] sdio_alloc_func+0x35/0x100 [mmc_core]
> >>      [<00000000c68f4b50>] mmc_attach_sdio.cold.18+0xb1/0x395 [mmc_core]
> >>      [<00000000d4fdeba7>] mmc_rescan+0x54a/0x640 [mmc_core]
> >>
> > Thanks for the detailed description, nice!
> >
> >> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
> > This looks wrong, it's not really that commit that introduces the
> > problem. It existed way before this.
> This patch is trying to fix of node and device refcount leaks, this commit
> introduced of node refcount leak.

Yes, the above commit certainly made the problem worse. However, the
main issue about not properly decrementing the reference count for the
device was there way before.

To avoid confusion for stable kernel maintainers, I think it's better
to drop the above fixes tag.

> >
> >> Fixes: 3d10a1ba0d37 ("sdio: fix reference counting in sdio_remove_func()")
> > Even if the problem is really old, I am worried that we may introduce
> > other problems if $subject patch gets applied as is, to older stable
> > kernels that carry the above commit. Did you have a look at this too?
> The patch can be applied to the oldest stable kernel (linux-4.9.y)
> cleanly, and
> I look at the code in linux-4.9.y, the logic of alloc/remove/release sdio
> is same as mainline, so I think it's ok with linux-4.9.y.

That sounds promising, then let's add a stable tag too.

>
> Thanks,
> Yang

[...]

Kind regards
Uffe
