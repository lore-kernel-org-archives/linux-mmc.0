Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA34C433E9
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Mar 2021 09:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8444A64FD5
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Mar 2021 09:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhCLJGh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhCLJG3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Mar 2021 04:06:29 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C04FC061761
        for <linux-mmc@vger.kernel.org>; Fri, 12 Mar 2021 01:06:29 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id j12so9886402vsm.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Mar 2021 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKUgWAnyYxdaXxA4WcJUs92ZAvj1xyLLHDtMDJLSkd0=;
        b=dSIdoTd+DHa3b3s48bp7fWShXcqwUQyj8Si1t00CGfGaSzaSMROEDdIubHnYI158gD
         i2BxrzOy8RBKKsC5aBuoA9cXJJV6ZJEOUEaDq+s5uMd/eXgp3A8TYfiw+Gm7sXUx+loY
         mk327FO4u+eTnbNJTCvbnmJRWl+KiepfjPmv3fgh+ghY93pJUzEwBoemHPkEFxhpBj6s
         ksk4NMJ0pCF7Fs7tsm8IcUVWoyI+EamxsmT5Yd1HFCqk7qvfsFg2135ZU+h1Lv6AHb2q
         KH8RZp6E8wEmSBAMR3XTZtRD9L6qgxNaXng1t40dsPYMr4Unp+d4l2WWlT82O62ovF5t
         WJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKUgWAnyYxdaXxA4WcJUs92ZAvj1xyLLHDtMDJLSkd0=;
        b=uTF7tGYO4kykqshjoeoCk6thfp+l03yFBdIdEXJwVyetf1FM0oL9YHRAOkd8+KQ6RZ
         07kRk3a0CWApJs64Zlnd8i2H6n/2eFPWBkeXr4JeabETYwJwS6MTM3015Cbp28SKR5+d
         yJRtlmqyLrrqaGbG/A0J0wlpOgS8wqnEUKdzKuHbw4Q2axyh9dPQjv+s8uMO5TRFk5mv
         +usgHsPI4URKJu5HCH1XZpBT7UMRqOodQWDdp38/0+HICbiDAZPVujF4yd6sytLjlE5e
         HggdnFLWkfpeG2fHzbCDlKp5/u003fmiVq4aU1q4GruERQwXtW1cIf+9dv39sWaS8EGr
         cSqg==
X-Gm-Message-State: AOAM5328AoGdAxT7mBGYLDPUIZF6aY8jAZZYesHkQshxeXdiXvS0moKp
        l/TcpaOo/I+Vot5sNmKr2xp0x08bhZcSI0Zb7SWcDQ==
X-Google-Smtp-Source: ABdhPJywyg+TZqWkv+eOIIeDvlTZhsk1W2Rf0tP+aSqF6848Pp5TOH0dcsimKnhzzavXvrnzQsoNF1mgevMYfZ9lPxA=
X-Received: by 2002:a67:6942:: with SMTP id e63mr8074907vsc.48.1615539988056;
 Fri, 12 Mar 2021 01:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20210309015750.6283-1-peng.zhou@mediatek.com> <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
 <YEpqkAq6wOZ+TpR9@gmail.com>
In-Reply-To: <YEpqkAq6wOZ+TpR9@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Mar 2021 10:05:51 +0100
Message-ID: <CAPDyKFoWg7HYHAbxYJRbOad5kqm+rzVLVQ0O3g76ROO5Z+MF3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
To:     Eric Biggers <ebiggers@kernel.org>,
        Peng Zhou <peng.zhou@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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

+ Arnd, Sudeep

On Thu, 11 Mar 2021 at 20:08, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Mar 11, 2021 at 02:48:23PM +0100, Linus Walleij wrote:
> > Hi Peng,
> >
> > thanks for your patch!
> >
> > On Tue, Mar 9, 2021 at 3:06 AM Peng Zhou <peng.zhou@mediatek.com> wrote:
> >
> > > Use SMC call enable hardware crypto engine
> > > due to it only be changed in ATF(EL3).
> > >
> > > Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
> >
> > Unfortunately this commit message is way to short to
> > understand what is going on, and has a lot of assumed
> > previous knowledge.
> >
> > Can you expand the commit message so that anyone
> > who just know MMC and some SoC basics can understand
> > what an SMC call and and what ATF(EL3) means?
> >
> > I assume this some kind of inline encryption?
> >
> > I think maybe linux-block mailing list need to be involved
> > because there is certain a Linux standard way of setting
> > up inline encryption for the block layer.
> >
> > For example: how is the key to be used derived?
> > How is the device unlocked in the first place?
> >
> > If I insert a LUKS encrypted harddrive in a Linux machine
> > the whole system is pretty much aware of how this should
> > be handled and everything "just works", I enter a pass
> > phrase and off it goes. I can use symmetric keys as well.
> > How is this stuff done for this hardware?
> >
> > > +       /*
> > > +        * 1: MSDC_AES_CTL_INIT
> > > +        * 4: cap_id, no-meaning now
> > > +        * 1: cfg_id, we choose the second cfg group
> > > +        */
> > > +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> > > +               arm_smccc_smc(MTK_SIP_MMC_CONTROL,
> > > +                             1, 4, 1, 0, 0, 0, 0, &smccc_res);
> >
> > The same as above: these comments assume that everyone
> > already knows what is going on.
> >
> > AES encryption requires a key and I don't see the driver
> > setting up any key. How is the code in this file:
> > drivers/mmc/core/crypto.c
> > interacting with your driver?
> > drivers/mmc/host/cqhci-crypto.c
> > is used by SDHCI and is quite readable and I see what is going on.
> > For example it contains functions like:
> > cqhci_crypto_program_key()
> > cqhci_crypto_keyslot_program()
> > cqhci_crypto_clear_keyslot()
> > cqhci_crypto_keyslot_evict()
> > cqhci_find_blk_crypto_mode()
> >
> > MMC_CAP2_CRYPTO is used as a sign that the driver
> > can do inline encryption, then devm_blk_ksm_init() is called
> > to initialize a block encryption abstraction with the block layer.
> > Ops are registered using
> > struct blk_ksm_ll_ops cqhci_ksm_ops.
> >
> > This is very straight forward.
> >
> > But where does all the above happen for this driver?
> >
>
> It happens in the same place, cqhci-crypto.c.  Mediatek's eMMC inline encryption
> hardware follows the eMMC standard fairly closely, so Peng's patch series just
> sets MMC_CAP2_CRYPTO to make it use the standard cqhci crypto code, and does a
> couple extra things to actually enable the hardware's crypto support on Mediatek
> platforms since it isn't enabled by default.  (*Why* it requires an SMC call to
> enable instead of just working as expected, I don't know though.)

As I have probably indicated earlier, I am starting to become more and
more annoyed with these arm_smccc_smc() calls in generic drivers.

As a matter of fact, I think the situation is about to explode. Just
do a "git grep arm_smccc_smc" and you will find that it's not only SoC
specific drivers that call them. In general we want to keep drivers
portable and this is clearly moving in the wrong direction. Or maybe
it's just me being grumpy and having a bad day. :-)

In the Qcom mmc case (drivers/mmc/host/sdhci-msm.c) for eMMC inline
encryption, the arm_smccc_smc() call is slightly better handled as
it's abstracted behind a Qcom specific firmware API. So, sdhci-msm.c
calls qcom_scm_ice_set_key() (implemented in
drivers/firmware/qcom_scm.c) to program a key. I guess we don't have
an abstraction layer that would fit for this case, right?

My point is, when there is no proper abstraction layer to use for the
relevant arm_smccc_smc() call, the Qcom way is fine to me.

In this Mediatek case, it looks slightly different. To me it looks
more like a resource that needs to be turned on/off to enable/disable
the "inline encryption engine". Could it be modeled as phy,
power-rail, clock, pinctrl or perhaps behind a PM domain (where SoC
specific calls makes perfect sense).

Peng can you please elaborate on what goes on behind the
arm_smccc_smc() call, as that would help us to understand what
abstraction layer to pick?

[...]

Kind regards
Uffe
