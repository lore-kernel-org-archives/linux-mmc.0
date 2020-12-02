Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09312C64E7C
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 14:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28D821D42
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 14:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgLBOeh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 09:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgLBOeg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 09:34:36 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6069C0613CF;
        Wed,  2 Dec 2020 06:33:56 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id s2so1211975plr.9;
        Wed, 02 Dec 2020 06:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhLHY8QyPomX7+8QgezYScCBuMVKGE89dP75ZvcTbfc=;
        b=F9kyCqSTHzWUx3lx1szktgRdzLO+BcxE6M6k4y0VpLoM7XYhauT0UljblhVwgoZb30
         cdk2QtA92ZQHfrnAgHUkfb9mryKbPBSsDiLX8KJGgLNrFlmu+Oo+VorC7a1Ur/EXW9Lu
         h2CUUfrmV5DZ0+x60HsowW6GqEPi1rd6mrJ7sVIKytUnYDr6O2BMwVylEvl9lau4aupE
         TkPsjkPY6HTOUQ9zsy6HNWFCtCkQuitYL3kGRU4gbDx9O1tNJBoxrVwTe8QCoSa7YYpk
         /1T/+CTtto9jx7OZRBBaKXYYh7DX4s7Pwyg0BAmB5ze5N6ersPBpNNY5DBPHW6avJaXF
         TG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhLHY8QyPomX7+8QgezYScCBuMVKGE89dP75ZvcTbfc=;
        b=U87d+l/YpBo4MTIUrAd1yYbpqgSYwZQRBpB6dStPOt4BcFzgwhQ4cmHjjGKaLo7oJh
         UOROy1nfm8ncycJAz16w1yZHZyA/LxKo81BYwYDHsORpa1U24lY5CfSPDwlz6xHNo9ZC
         VgDn4fZecRuZG0TOXb5/oRryHwO/rtAz1DcRwCubF4nSZ92aVqc72nrGHXXK21k64CA3
         AsSkgxBV0ScRUpSnfluFuNEpRu2L3Q0aWqljX2bghq0O+rqHk3Gg+zI/zb99x8s4X99J
         +uzBqyyOC7WdwGuurfTPmKNQe2y8O8ular4V6KgtUT3EPgJ5rBVZ+ZyKLRvydLtbm2lQ
         DCfA==
X-Gm-Message-State: AOAM532AV0nHQ34BlxqO6FZ/Sn2p4289qVqs/PfS+8mNk2dYIzSt+Vpp
        WfALid3bmUBKv4FJcn1KXgcD5WLwK0hYsg4sVEE=
X-Google-Smtp-Source: ABdhPJxr6QfkVhUs2mGtVIPIaJI9K8ykKYv5YXpKR2u2KXqwXr1SyRSCcN4uXm8kfnu0qKCboU8lwMl8FTALOvHpYtA=
X-Received: by 2002:a17:902:b7c3:b029:da:76bc:2aa9 with SMTP id
 v3-20020a170902b7c3b02900da76bc2aa9mr2889382plz.21.1606919635935; Wed, 02 Dec
 2020 06:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrg5ur3iTp-dAoVqV5fiFgcmt01j9R7z3_i=tqhWW3WNg@mail.gmail.com>
 <20201202122520.GD4077@smile.fi.intel.com> <CAPDyKFra1+HPGYjG30LkuPxPyN8mQaZan4+AFLKf7_gvd979PA@mail.gmail.com>
 <CAHp75VeXxPoNqJVQojDC1G3gzJUJEiJs2UOm6kob71Aqa_7v2w@mail.gmail.com> <CAPDyKFpfadG2-JPA1PC5Sx1_eM39AQUQTVj=m26Gu_=GQmjicA@mail.gmail.com>
In-Reply-To: <CAPDyKFpfadG2-JPA1PC5Sx1_eM39AQUQTVj=m26Gu_=GQmjicA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Dec 2020 16:34:44 +0200
Message-ID: <CAHp75Vf66eWnJFom66oZZnZ4Rcw0VF0QkGWgM5Mm40mTVt6i4A@mail.gmail.com>
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

On Wed, Dec 2, 2020 at 4:10 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 2 Dec 2020 at 14:09, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Wed, Dec 2, 2020 at 2:44 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

...

> > My point is that it may be *not* a pin control at all.
>
> Sorry, but I don't quite follow, what is *not* a pinctrl?
>
> According to the information I have received from the previous
> discussions [1], it's clear to me that the ARM SMC call ends up
> changing settings for the I/O-pads. Or did I get that wrong?

I'm discussing the possible implication of the solution (faking pin
control) you are proposing.
In this case we know that it's a pin control *under the hood of IPC*
(!) but in another hardware generation it may be, for example,custom
voltage regulator.

What you are proposing seems to me suboptimal and actually lying about
hardware. Because we do not have direct access to control this pad.
What we have is an IPC to firmware. And it's not our business what is
under the hood.

It seems it was a mistake to talk about these details in the first
place because it brings more confusion about hardware. So, consider
that it's not a pin control from OS perspective, but a firmware magic.

-- 
With Best Regards,
Andy Shevchenko
