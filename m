Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D40C64E7C
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 13:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BCE2222F
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 13:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgLBNJ5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 08:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbgLBNJ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 08:09:57 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D5CC0613CF;
        Wed,  2 Dec 2020 05:09:17 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x24so1215504pfn.6;
        Wed, 02 Dec 2020 05:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1z5RghUm6yb3JSWWMIkAtmUbvFsrsgFkS/6j5bM5Nz0=;
        b=cQc1Nna3s2K66qgZ0MEK53kPZT2w5huQsS3t5h1U1UW0Y+xL4rYxDIqVHOoqene60z
         uUpwdu4quEdrmBE8pCdyNyHkQ2bo8ka9TPYZk7Wfzc5eI0VEgVcol9owDkUu3WISbQKv
         EAfTy1l2FiD7myllfEG8r3zCFfBlQbtFAu+F/VTj0rxSaNHc5ukw71qmbe7GjUwm1e/W
         cpWNNOoGQ4HbT/tHMJojeQrR5VkXAAHpbXV5EZAljduJa0gPvSPJy9NOE8ZN3Gr0I8Zc
         uWkJEPI4rBNM2oEkXiFisfn1Re44dThXrA6F/IqGcej3dfrOAjYTYPV1Plu636suXADn
         ksTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1z5RghUm6yb3JSWWMIkAtmUbvFsrsgFkS/6j5bM5Nz0=;
        b=oGyIQaoUdQ7Kzh9mhNTcJ6s1PrbgfEqT/lLnocESasjrivAwowgbkgRNxKqLmu2qrT
         geNGnaytv3ceNG2aA6TSBSBDatif8Gj8HMZZLwH8ay9qBetlNMKA0Qszdg7Bx0rBpT8V
         iD3AmIsER24IRgcil7D2Knq7pjw7Rde84ZS53z0s4CciTiM5xITNRpzSYIWbSCSLZp/C
         hmH87PqvI0fAqXexq4iQ2Cv3XAP6nC7nZO0tQiFy7WLQKXByBiPlvBR6dfZ+j6DG+8H7
         BHVSZXPhH3W5yUBhUkXszVp28Ks6RE7ZhNMQEqSqYJ0Wx5eIXchraYDwvf9SD/fvihkL
         Qywg==
X-Gm-Message-State: AOAM533FH1zOMsSOUL9kd80aEJLzkUPcfvvywAWHp/IqCE0nTMXkmatA
        ftPTIzOG1nLdGan895GD5YAHHELnt5XJqYYmrNPSbcAgwI4=
X-Google-Smtp-Source: ABdhPJx1w9uaqNh+tnBMkkXkuAfuVJPg0wYvh4NwfQg9ye3H+qABWR4bjKvRYKRJwe7+OwYdEebWsNm/vIq7sbGK52I=
X-Received: by 2002:a62:ae0e:0:b029:198:11b4:6b6b with SMTP id
 q14-20020a62ae0e0000b029019811b46b6bmr2508125pff.73.1606914556601; Wed, 02
 Dec 2020 05:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrg5ur3iTp-dAoVqV5fiFgcmt01j9R7z3_i=tqhWW3WNg@mail.gmail.com>
 <20201202122520.GD4077@smile.fi.intel.com> <CAPDyKFra1+HPGYjG30LkuPxPyN8mQaZan4+AFLKf7_gvd979PA@mail.gmail.com>
In-Reply-To: <CAPDyKFra1+HPGYjG30LkuPxPyN8mQaZan4+AFLKf7_gvd979PA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Dec 2020 15:10:05 +0200
Message-ID: <CAHp75VeXxPoNqJVQojDC1G3gzJUJEiJs2UOm6kob71Aqa_7v2w@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Mark Gross <mgross@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 2, 2020 at 2:44 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 2 Dec 2020 at 13:24, Shevchenko, Andriy
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Dec 02, 2020 at 11:53:42AM +0100, Ulf Hansson wrote:
> > > On Wed, 2 Dec 2020 at 08:02, <muhammad.husaini.zulkifli@intel.com> wrote:
> >
> > ...
> >
> > > > Kindly help to review this patch set.
> > >
> > > This version looks a lot better to me, but I am still requesting you
> > > to model the pinctrl correctly. I don't see a reason not to, but I may
> > > have overlooked some things.
> >
> > I'm wondering why we need to mock up a pin control from something which has no
> > pin control interface. It's rather communication with firmware that does pin
> > control under the hood, but it also may be different hardware in the other /
> > future generations. Would you accept mocking up the same calls over the kernel
> > as pin control, as something else?
>
> Well, my point is that modeling this a pinctrl would keep the mmc
> driver portable. Additionally, it's very common to manage pinctrls in
> mmc drivers, so it's not like this is an entirely new thing that I
> propose.
>
> If/when it turns out that there is a new HW having a different pinctrl
> interface, it would just mean that we need a new pinctrl driver, but
> can leave the mmc driver as is.

My point is that it may be *not* a pin control at all.
And in that case you will need to mock up (what exactly?) and update
the MMC driver.

-- 
With Best Regards,
Andy Shevchenko
