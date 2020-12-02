Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C85C64E8A
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 12:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340E722203
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 12:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgLBMmg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 07:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgLBMmg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 07:42:36 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EECC0613D4
        for <linux-mmc@vger.kernel.org>; Wed,  2 Dec 2020 04:41:50 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id p7so821435vsf.8
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2020 04:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXMUAU2XPmm9w5lTnyXOI4+QFALzMfNDFQIh0c94WPA=;
        b=okJw6qJdJQQLgwoGkITAZ2RzTakzKviiWbNlSxfhQaCslP04glk6JlxDe01Dn+WUsf
         UNfsOjMSh/6EV0scoKGD1ucdfaZ8r6tv+2emxCtiYWzLzairDs/DyB4gax3DB0R//jkg
         qFCFmFC0otE1FKTXcVmVNVFWghen/i3fv0L4IbjumIHptCgljZrKHIeCtjSINM+xGAfS
         mnMzPJxQmi4N992OZfE6XrjOWPAgkhj2IjnXrF4EwQBF4jlljmDCPGznbJVsM+l40v2s
         SDihjgH1x0GN0MeIT/vJ01edB5XrI0uCggSkyv7teg7Und3usureLXU6BBncOR8f5lP5
         rUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXMUAU2XPmm9w5lTnyXOI4+QFALzMfNDFQIh0c94WPA=;
        b=KPin6fsp18IJP1bHJnYnyKuWr71dHbHCg/ULwLagNyrkSmKruvjpPTo0rBvHr0DRbz
         iWF5P10OqoL4kCBzPmw/xgWwTLDJYvthBtjTXb5M8VQbmax6JXPeFj3iFM00VciKEB8m
         ke78hlgadgzA6YZQUEx76JXBHBwQQbuHB0OzcQxzfQnWx+EYtH6h30mDr4riGCCAWfjc
         y7r95iDzt2knK4YcrikNY+IhWk9nxf7y5xYR3zyXHyILcDQ6S7IoVWymDp+QA5CLznzK
         WnZf+Kvryj20+TISZjypOPr21THvC5sQUwfEoElZhEbfleyQdzroj3a3zTB6ILR8pewK
         sMSA==
X-Gm-Message-State: AOAM533UxX4JQCBRKLFw8fkAXVUJ2QgbOm/Emae+/YaUjf9RiFVL5gJt
        uNjUz/dWUx6l9RxT3Klx/JpQTZxGffE5fttRLdCHjw==
X-Google-Smtp-Source: ABdhPJyjlRZBwaPxY2L6aa5oVJBa8flUGbh3ZROcX5EjBNbuv11Il4IqU0IGC14Qb2rc5oj9JK1g/jLzRg66x8FuDtI=
X-Received: by 2002:a67:ce8e:: with SMTP id c14mr1115811vse.42.1606912909320;
 Wed, 02 Dec 2020 04:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrg5ur3iTp-dAoVqV5fiFgcmt01j9R7z3_i=tqhWW3WNg@mail.gmail.com> <20201202122520.GD4077@smile.fi.intel.com>
In-Reply-To: <20201202122520.GD4077@smile.fi.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Dec 2020 13:41:12 +0100
Message-ID: <CAPDyKFra1+HPGYjG30LkuPxPyN8mQaZan4+AFLKf7_gvd979PA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        mgross@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Dec 2020 at 13:24, Shevchenko, Andriy
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Dec 02, 2020 at 11:53:42AM +0100, Ulf Hansson wrote:
> > On Wed, 2 Dec 2020 at 08:02, <muhammad.husaini.zulkifli@intel.com> wrote:
>
> ...
>
> > > Kindly help to review this patch set.
> >
> > This version looks a lot better to me, but I am still requesting you
> > to model the pinctrl correctly. I don't see a reason not to, but I may
> > have overlooked some things.
>
> I'm wondering why we need to mock up a pin control from something which has no
> pin control interface. It's rather communication with firmware that does pin
> control under the hood, but it also may be different hardware in the other /
> future generations. Would you accept mocking up the same calls over the kernel
> as pin control, as something else?

Well, my point is that modeling this a pinctrl would keep the mmc
driver portable. Additionally, it's very common to manage pinctrls in
mmc drivers, so it's not like this is an entirely new thing that I
propose.

If/when it turns out that there is a new HW having a different pinctrl
interface, it would just mean that we need a new pinctrl driver, but
can leave the mmc driver as is.

>
> > Would you mind to re-submit to include the gpio/pinctlr list and the
> > maintainers, to get their opinion.
>
> And I will send immediately the same comment which I believe Linus W. supports.
> But who knows...
>
> Cc'ed to Linus as I mentioned him.

Thanks, let's see what Linus thinks then.

Kind regards
Uffe
