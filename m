Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E4C4361A
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A838E22571
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgLDO4D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgLDO4C (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Dec 2020 09:56:02 -0500
X-Gm-Message-State: AOAM530fRn+jG/7r2aRwor6yNl0aC7xpKh32Lk+SxC1yClFqyW4T9d5Y
        QXB84mYxxHZNm9tCj1VuO8vk8i8SHgKJ3SQohPk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607093722;
        bh=qGUZ+1dL4G4WyrQWUkYKJEc8DutOEdYhYFuupUNzlyk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A1dP7j+7Iu93950O3626NFqdsC0LKQdwiXFyBli4wzqASDhZy9+IXMpZKsGuDoDY6
         mdzabAv0QxoMk3lQd/Kwn15V3G6aUqUQ+a+nlhaaoEzJktP5+fAT/niQkLYKj9mvqF
         y7QCZohJuHfZGZAPXwTpFp+D35yCRj5VljQR3TqjvqguAswaxNTHoz1EKBl6CqGe60
         JjUi4oH8kYsK9kdntbO0cceE1FjdR3eKtkyF8AE3YvARoSANS6brW6ignZ9LPHNhtb
         fcVAm05ZwauaDLTXgD0vn2kXvF5KzlSqE6QPtvt5aC2DcH3NfFnSokytxYGRGL0zeg
         x3GricqBEeyug==
X-Google-Smtp-Source: ABdhPJxosiEcP3n8aXD6Ztpyp2agBQbOVGOw9SFaLMj/+6lrSftY4Ms6n1Z/TqYNWm3jQWaDwMiFp86WazgYRXqrNXQ=
X-Received: by 2002:a05:6808:9a9:: with SMTP id e9mr3493815oig.4.1607093721297;
 Fri, 04 Dec 2020 06:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20201203222922.1067522-1-arnd@kernel.org> <CAPDyKFqtFYqc8i_fVzOUnuZGJjtwjVLqE-vebtOKuYJ-4PrDBg@mail.gmail.com>
 <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com> <CAPDyKFqS5touMvORyovCS-QQrHZg+0LGob9DtS1m61quvXYezw@mail.gmail.com>
In-Reply-To: <CAPDyKFqS5touMvORyovCS-QQrHZg+0LGob9DtS1m61quvXYezw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 4 Dec 2020 15:55:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0PvxT3B+4WYmbarLPY_uHbKL_z5Jd7WU=PZ79QXjtwOw@mail.gmail.com>
Message-ID: <CAK8P3a0PvxT3B+4WYmbarLPY_uHbKL_z5Jd7WU=PZ79QXjtwOw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: mark PM functions as __maybe_unused
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        yong mao <yong.mao@mediatek.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Marek Vasut <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 4, 2020 at 3:38 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
.
> >
> > I don't see a lot of other instances of that yet, and it's fairly new.
> > Maybe we should fix it before it gets propagated further.
> >
> > I would suggest we redefine pm_ptr like
> >
> > #define pm_ptr(_ptr) (IS_ENABLED(CONFIG_PM) ? (_ptr) : NULL)
>
> Why is this better than the original definition?

It tells the compiler that the _ptr is referenced from here, so it does
not warn about an unused symbol, but at the same time it still
knows that it can discard it along with the functions referenced by
it and should not emit any of that output.

> > and remove the __maybe_unused annotations on those that we
> > already have. This also has the effect of dropping the unused
> > data from the object, but without having to an an #ifdef or
> > __maybe_unused.
>
> I didn't quite get this (sorry it's Friday afternoon... getting
> tired), can you perhaps give a concrete example?

These work:

a)
static const struct dev_pm_ops __maybe_unused ops = { ... };
...
      .ops = &ops,
...

b)
static const struct dev_pm_ops ops = { ... };
...
      .ops = &ops,
...

c)
#ifdef CONFIG_PM
static const struct dev_pm_ops ops = { ... };
#endif
...
#ifdef CONFIG_PM
     .ops = ops,
#endif
...

d)
static const struct dev_pm_ops __maybe_unused ops = { ... };
...
#ifdef CONFIG_PM
     .ops = ops,
#endif
...

e)
static const struct dev_pm_ops ops = { ... };
...
     .ops = IS_ENABLED(CONFIG_PM) ? ops : NULL,
...

But these do not work:

f)
#ifdef CONFIG_PM
static const struct dev_pm_ops ops = { ... };
#endif
...
/* error: missing declaration for ops */
     .ops = IS_ENABLED(CONFIG_PM) ? ops : NULL,
...

g)
static struct dev_pm_ops ops = { ... };
...
/* warning: unused variable */
#ifndef CONFIG_PM
     .ops = NULL,
#else
    .ops = ops,
#endif
...

       Arnd
