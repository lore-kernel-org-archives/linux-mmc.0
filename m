Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB1C433E2
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B90C61983
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 13:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhCWNi2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhCWNiN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2021 09:38:13 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9183EC061574
        for <linux-mmc@vger.kernel.org>; Tue, 23 Mar 2021 06:38:13 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id k76so4619076vkk.10
        for <linux-mmc@vger.kernel.org>; Tue, 23 Mar 2021 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oh8GJQVSl1PJxaKgrZv7bYmOGictbqv/x3tJgCJgmNY=;
        b=hXeRdtOg6s6oCUh964ZpAQTncTbLLJXrp/kU0meqsqiV9FkKkuyt1xzKm5e1OkRKMk
         NyuRM5Ah6fUdbC9IncKfYuDUY34v0kGDvZgEh66BykgceGA/7P7V21k/slrNFQJlOzNI
         xwP93/HiMS7DK+7fxU4SBf1rFgs6FOMR/pxPVAkxATZi35imXsLrTVQxqxlvPiS0aSp8
         6MOyQLghm+S1uE97UnEr3vPmMtszLGLNzmBNrvQKnkXC1st1mQAHijvS9JHDHoWTnD1O
         KBHyxHMKcT2kLYCqfCyDkrrtbCBgG4SJhrK1sry5qrfSq93yb2uZ7f/ihzRzKKH89uAr
         ASGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oh8GJQVSl1PJxaKgrZv7bYmOGictbqv/x3tJgCJgmNY=;
        b=aRoV9nFKyLqMBDzWRA4KPrvPkqu6l8eijMpOzTjVhU2BZWcsDk/18p/Em3Mp2Jxa2r
         YGqzz8pWbW1sxf6XZp0R8nDGgRA0XylmHlxN/ygSEvKb554KQlS9Ka5aIPa/tbPyGF+O
         mb5JDj7BmuaCb4IAPMg5z8PskL4LGqMQjk82JPTRYte3DyksG52nyzGXtdN2sDwhrYfw
         SNjC4VSnkNG2CVEt+q9LwNyBAt6/OUS8P6/ebzpN9qLDaQyWf8GA1FN03SNcqzIqzcIN
         yC7C5kBRYsgCX6KjXQmGSqVemrE1ql9MSE+D/x+ncLTIT4ImrqlpPCcMWiSyOgx1Jmak
         9DxA==
X-Gm-Message-State: AOAM530D0FwABuELSFdAWkGqCzePJs5iCBAZ/nURzB4VCpPmMvA8j7ih
        1qqulfx2IBfEWlpnk2+NX3P1vuKknSIl5MIU831llA==
X-Google-Smtp-Source: ABdhPJzHVz6S/kvCdH7mWuoFkpqTLaGBI2y1Hi+RhDqPCnK9CqSxiUwvz72xiMlX2kMOYZEhRIQX4DXsvqOcSbETtB4=
X-Received: by 2002:a1f:2c58:: with SMTP id s85mr3271635vks.15.1616506692244;
 Tue, 23 Mar 2021 06:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210309015750.6283-1-peng.zhou@mediatek.com> <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
 <YEpqkAq6wOZ+TpR9@gmail.com> <CAPDyKFoWg7HYHAbxYJRbOad5kqm+rzVLVQ0O3g76ROO5Z+MF3Q@mail.gmail.com>
 <1615884533.21508.118.camel@mbjsdccf07> <CAPDyKFqtjYVAAe_wUKQC3n3ok5bUpGtpu=TUiOgFmbb6+Qkg=A@mail.gmail.com>
 <1615893329.21508.128.camel@mbjsdccf07> <CAPDyKFqaFbviwxQ8U_X8U64F7OwNaxXde6XdUcGPeGg8k9MWWg@mail.gmail.com>
 <CACRpkdapAOq7NtZDOgnugvTmO0+Yh+EoCVod-s_akPfs2=Sj9Q@mail.gmail.com>
In-Reply-To: <CACRpkdapAOq7NtZDOgnugvTmO0+Yh+EoCVod-s_akPfs2=Sj9Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Mar 2021 14:37:35 +0100
Message-ID: <CAPDyKFoCjv7S_2yyVZOAgwbEEZV5H_dmQxQGFVTt7awSE3Ss8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Peng.Zhou" <peng.zhou@mediatek.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Mar 2021 at 14:45, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Mar 16, 2021 at 2:56 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > It looks like we have a couple of options to support this. I suggest
> > we consider the two below, but perhaps others (Arnd/Linus?) have
> > better ideas?
>
> Admittedly it's a bit hard to shoehorn this in as it is not a standard
> resource (clk, regulator, genpd, reset, gpio...)

In my opinion, I wouldn't object if we would model this as phy, simply
because I think it would be the easiest way. Although, I agree, it's
not a perfect fit.

>
> There is drivers/soc and then you end up with the same custom
> abstraction that qcom is using. The upside to using that
> is that we can #ifdef it to static stubs in the .h file if this SoC
> is not used, so I would go for that.
>
> See for example qcom_scm_ice_invalidate_key() used from
> drivers/firmware/qcom_scm.c, header is at
> include/linux/qcom_scm.h and here you find:
> #if IS_ENABLED(CONFIG_QCOM_SCM)
> and if not, there are some stubs.

Please, no. As discussed and also pointed out by Arnd in another
thread, generic drivers must remain portable and must not get
sprinkled with SoC specific code. If not, we would be moving backwards
and increasing the fragmentation of the kernel.

The qcom case is about programming a crypto key, which seems rather
specific to me. I can't figure out another generic way to support
this, but using the SoC specific calls.

The Mediatek case is about turning on/off a resource to activate the
device. If the phy framework doesn't work for us (or another), then at
least we should fall back to use runtime PM + PM domain provider
(genpd), because this would solve the problem. SoC specific code, like
the SMC call can then be called from the genpd provider driver and
abstracted from generic drivers.

Additionally, in this case the mmc driver has already runtime PM
support deployed, which means some of the work has already been
completed.

>
> Yours,
> Linus Walleij

Kind regards
Uffe
