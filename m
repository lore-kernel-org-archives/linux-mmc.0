Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E66C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 13:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8962564EE3
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 13:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCONmn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCONmL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Mar 2021 09:42:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D46C06175F
        for <linux-mmc@vger.kernel.org>; Mon, 15 Mar 2021 06:42:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 15so16265780ljj.0
        for <linux-mmc@vger.kernel.org>; Mon, 15 Mar 2021 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5pbXwp0jQ2rf0gS7DhWdzLYC/FdH6bN4erEwcj2Y3w=;
        b=eRplPfivqS4zqfEYdF7516756o43/GB69SM030Lbw5+KTM9ZUInXX/BsqvDJOCTrSJ
         T7E3OChMVSid26+uM2F2wdfKttRfMWparxKTulKyxeUFZoyGmFZzXE3mIeX3HWMZHy8k
         xuvNEXQv6GSE8rTrBlpxyZC8+AWImHRr0wx/Gp5aUttX1MjU15Ysl6yNHPbG9rdQoq7R
         o1lPpIhZ+goNEheJUcJBvq4LczBIX7twM/7vGM791jYQm6tXSVC0Z1/S3hj4ENKIHEU4
         I777yFwNAYg6JAe4kzRaSC50HptYWMybYuAynnqkEnNJUwuTHQpmCmh11JDhDcmlo/OF
         /6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5pbXwp0jQ2rf0gS7DhWdzLYC/FdH6bN4erEwcj2Y3w=;
        b=MgQ2sy4qB/tt7dWOHFkLQg3V59S9e6y0sIxnE9tT+6KDUgs6fdbxG5x9/hfoR1uVBu
         NF9bSe4dGUOnmEMvZnLkGom7gZHuSjf2UMmLJHqXNsSPOy43vV3CFh7fUPWDhEPZgmqD
         oFV7lCPk73mU2y25uEFRD7Gk7eAmfYy/rKJo2WTG5NBVP0uAN1StIeOgiI6hnwq09ZNF
         0FoqZV+Lf5U7YuEcc8Fs4DlIIZkZlcSUSxMlgFo703kPcGmoGMvi4AOyhtXz6yhDIs0I
         XPjWAljXlNrZDJjeznmhIE7ySUpA8+f8fvQ6lUF6SS5uF7U5aOiyRKL5DNZiO6N2fBrl
         PMxw==
X-Gm-Message-State: AOAM530s91r7DW1xeo7ADZOKcGmVgK0TO0CwYfPikOF6YmYrVwJV6ec6
        ZviVHD3xDZIIEzUF4ybaD0V05R6n6rw6990NJC+epw==
X-Google-Smtp-Source: ABdhPJyUx7DcXAXEJVIgv4ihoNgOoMUF8D64squn8PsmV1cihZWhRtLWq6RORu3j6jnE9W9WyqQlmCiNzfnWCPRvJWk=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr10195795ljj.467.1615815729288;
 Mon, 15 Mar 2021 06:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210309015750.6283-1-peng.zhou@mediatek.com> <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
 <YEpqkAq6wOZ+TpR9@gmail.com>
In-Reply-To: <YEpqkAq6wOZ+TpR9@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Mar 2021 14:41:58 +0100
Message-ID: <CACRpkdb7vmFgH0XTG3Z6OzFv0CfPsBguKqVAZt=PZ+ms2-0WjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Peng Zhou <peng.zhou@mediatek.com>,
        linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Eric,

thanks for stepping in and clarifying! I get it better now, I though
this was some other encryption scheme "on the side".

There is one worrying thing in the patch still:

On Thu, Mar 11, 2021 at 8:08 PM Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Mar 11, 2021 at 02:48:23PM +0100, Linus Walleij wrote:
> > On Tue, Mar 9, 2021 at 3:06 AM Peng Zhou <peng.zhou@mediatek.com> wrote:

> > > +       /*
> > > +        * 1: MSDC_AES_CTL_INIT
> > > +        * 4: cap_id, no-meaning now
> > > +        * 1: cfg_id, we choose the second cfg group
> > > +        */
> > > +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> > > +               arm_smccc_smc(MTK_SIP_MMC_CONTROL,
> > > +                             1, 4, 1, 0, 0, 0, 0, &smccc_res);

So MSDC_AES_CTL_INIT. Assumes we are using AES and AES
only I suppose?

> It happens in the same place, cqhci-crypto.c.  Mediatek's eMMC inline encryption
> hardware follows the eMMC standard fairly closely, so Peng's patch series just
> sets MMC_CAP2_CRYPTO to make it use the standard cqhci crypto code, and does a
> couple extra things to actually enable the hardware's crypto support on Mediatek
> platforms since it isn't enabled by default.  (*Why* it requires an SMC call to
> enable instead of just working as expected, I don't know though.)

Now I don't know the limitations of cqhci crypto. Clearly it only supports
AES today.

However would the cqhci crypto grow support for any other crypto
like 2Fish or DES and the user request this, then I suppose there is
no way for the MTK driver to announce "uh no I don't do that"?

Or will this cqhci hardware only ever support AES?

Yours,
Linus Walleij
