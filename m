Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36DCC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 08:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiKRILg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbiKRILf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 03:11:35 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E158B123
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 00:11:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so3938480pjb.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 00:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4kibJ263P3dhtkMF23jXF7dhiR5WS0nDu5d93wHySQ=;
        b=QMnN6Ck2beKR171FsNArbFBCYkAJlprCEbC+7a/2zfkab1ohDDxgP9XPejDZAfuyoj
         ZKPEP6M1fETHI8F9o4j2PPO0m1e2U6yzuK635F4aI6fk4yYGSxf7zk1jNRR0Umn6qUU/
         M1iXMrQwCP9BbjDiaie4wwb0c2hAi9IPG/L9TOR7Uzy8v1aE5CQhoeB7eZtgZZHTL6LK
         IXgfxMFjGA+/d6+DZDwOmfdldNh5BXCmAwSCLyJ9IcJgNriXNZ+Jov/CaRv2zlGKT8t9
         wwDYk+FNrtOQgjzuzjk8VMw8tJqVtQR9idGwbiXkBNPgOstxhsrQEllEFK5TaGfkqHCs
         FYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4kibJ263P3dhtkMF23jXF7dhiR5WS0nDu5d93wHySQ=;
        b=aQTRoB77DpZuT1eNZA+56T2eHrSveBrwDOOQatzaucmUibGt4SJ2JotkCfs4C31PBT
         RNlwQVwuB80W/JTMY9prXBXB2z38Y23y6KtzUP1A/2UoPF7iXvkJ1YpMB0iCVLiMps8i
         mSndUsmu/HaTzcZDVFP2dAPSC4DiZ8eWbPdiZYJtuBB+jREGf1TW0hfi9LfLjSZyzo9i
         h04mIrO7TyX8IVYep2eJ1I23wOEJoYNQ+nYt89WYxjZ1UtKlEqBz8DyRTMFk1oxEwahO
         nbkHr1TKlPN39sft6wvBwGcnEG314TwNppVSmI1pXlA/dCaJxjImwXJOrqs8f1UA1GDT
         jeyA==
X-Gm-Message-State: ANoB5pleIz/5DW3raFPP5ES1Ex57J2BhPtOmJYrb6HHfcpyMeZMhIzo6
        vcKoqrpu9TvKDSCe2dEz1ENo0wSosPtm1anjGJu58g==
X-Google-Smtp-Source: AA0mqf5z+ngOt/yQcwVsgv9aDVmQheUmmUbKLHJpLPv2rpJ71KeTs5x/5pPQWqf/L4zOqCfgF1xsfI+hXpHhkK5OWoU=
X-Received: by 2002:a17:902:a503:b0:188:cca8:df29 with SMTP id
 s3-20020a170902a50300b00188cca8df29mr6485744plq.148.1668759094745; Fri, 18
 Nov 2022 00:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20221110025530.4106568-1-yangyingliang@huawei.com> <cd06c6cc-fd5a-1fe4-9570-4266f34918cd@huawei.com>
In-Reply-To: <cd06c6cc-fd5a-1fe4-9570-4266f34918cd@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 09:10:57 +0100
Message-ID: <CAPDyKFrYk9Gr3Fa5mJ2KPebCWXxGFJxZtP47EmXge3CRMtEYQg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] mmc: sdio: fixes some leaks
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Nov 2022 at 08:54, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Hi,
>
> On 2022/11/10 10:55, Yang Yingliang wrote:
> > This patchset fix a refcount leak and two memory leaks about
> > SDIO function.
> >
> > v3 -> v4:
> >    Drop patch1, keep calling put_device() to free memory,
> >    set 'func->card' to NULL to avoid redundant put.
> >
> > v2 -> v3:
> >    Change to call of_node_put() in remove() function to
> >    fix node refcount leak.
> >
> > v1 -> v2:
> >    Fix compile error in patch #2.
> >
> > Yang Yingliang (2):
> >    mmc: sdio: fix of node refcount leak in sdio_add_func()
> >    mmc: sdio: fix possible memory leak in some error path
> >
> >   drivers/mmc/core/sdio.c     | 1 +
> >   drivers/mmc/core/sdio_bus.c | 6 +++---
> >   drivers/mmc/core/sdio_cis.c | 3 ++-
> >   3 files changed, 6 insertions(+), 4 deletions(-)
> Is this look good to you, or any suggestions?

I need some more time to review them, so I will get back to this early
next week.

Kind regards
Uffe
