Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98168C433E6
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 08:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709596501B
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 08:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCEIpR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEIoq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2021 03:44:46 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA4BC061574
        for <linux-mmc@vger.kernel.org>; Fri,  5 Mar 2021 00:44:46 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q203so1699156oih.5
        for <linux-mmc@vger.kernel.org>; Fri, 05 Mar 2021 00:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KB08yorhtcB6bwnYQdEUiilQWgj+qvMuWqAWFcX/SDg=;
        b=ZxLlJnE23vDFkH/RI149rtpJ6Rb1DuzsbCYGBoepoSLkhoigkzcZQUrThOEJZMZwXg
         g1v7bO3IE1yzgG9XgDolnIsjLiFud25gSY/WXkSrUQ33M9yrvaC+DmEwk9uROs2DEDYZ
         UeOvLWSeWGxxNp8UchPjXELvxDG+jSq+E/C9Z8SMTDaDbNjhI98yvEQ5EqBlK3Ac87vk
         NSlDPFWK49JH8UMthr1MOgrwDRFUjDlDss3egSdIyPYv1PPdvhoq7JyduB4XShz7Lwso
         6/33LAwukxq1jS0D82bC9rlW937dDemOUMjOVCjpBBHS2XaVb4B7qqTdOJU7Kbe3tA6L
         fTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KB08yorhtcB6bwnYQdEUiilQWgj+qvMuWqAWFcX/SDg=;
        b=hBmHN7n88dw/IH6jS/E+B56KomRkGpDVJauySFvVBpiDY19oodV6PNeBFwDb9PH0q/
         JFNuIhu2eZXDfs53UtL7XWhBANDovSkPwfSxNX35J4zHv8AaZQnCE1jliQTVHn56BvpN
         0v/esCuGqIjLBipNCN2YJLx9JFtEsQGu0i4nmEn8mvQ8A+COspb6aXCz03IDmQdvkh9v
         ndRXl2uZUBksR4UErrz+ewPfUOYmrlmpMcuF58qpx3XW2H2y9w+j4Lf3VlJmVLYQaB2r
         GnzuXYQ1jEStN5suRisjhBuOEA0Jtkb11U2KI40N2tQzAUF9MRmr3j65LlPzUbS3Zzfb
         FboQ==
X-Gm-Message-State: AOAM533FngXBhoNDNg7UU4jTRXx6yseD4GhAaorVOFFW3hB3mLLLv0xZ
        bZkcgvj2Mkhyjx0WPEaO7CdLoQ==
X-Google-Smtp-Source: ABdhPJxR8UD4zmwPWma3pzbK8QCYZjGc7PejnTVLeCvE+CW5nhVqP0j0e5s2Np4XhDKntGZwQKsI0w==
X-Received: by 2002:aca:4d8f:: with SMTP id a137mr1610818oib.132.1614933885443;
        Fri, 05 Mar 2021 00:44:45 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id g6sm432421ooh.29.2021.03.05.00.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 00:44:44 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id d9so1044401ote.12;
        Fri, 05 Mar 2021 00:44:44 -0800 (PST)
X-Received: by 2002:a9d:12e1:: with SMTP id g88mr3706815otg.305.1614933884478;
 Fri, 05 Mar 2021 00:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210303135500.24673-2-alex.bennee@linaro.org> <CAK8P3a0W5X8Mvq0tDrz7d67SfQA=PqthpnGDhn8w1Xhwa030-A@mail.gmail.com>
 <20210305075131.GA15940@goby>
In-Reply-To: <20210305075131.GA15940@goby>
From:   Arnd Bergmann <arnd@linaro.org>
Date:   Fri, 5 Mar 2021 09:44:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0qtByN4Fnutr1yetdVZkPJn87yK+w+_DAUXOMif-13aA@mail.gmail.com>
Message-ID: <CAK8P3a0qtByN4Fnutr1yetdVZkPJn87yK+w+_DAUXOMif-13aA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To:     Joakim Bech <joakim.bech@linaro.org>
Cc:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        ruchika.gupta@linaro.org,
        "Winkler, Tomas" <tomas.winkler@intel.com>, yang.huang@intel.com,
        bing.zhu@intel.com, Matti.Moell@opensynergy.com,
        hmo@opensynergy.com, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Mar 5, 2021 at 8:52 AM Joakim Bech <joakim.bech@linaro.org> wrote:
> On Thu, Mar 04, 2021 at 09:56:24PM +0100, Arnd Bergmann wrote:
> > On Wed, Mar 3, 2021 at 2:54 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
> > That said, I can also imagine use cases where we do want to
> > store the key in the kernel's keyring, so maybe we end up needing
> > both.
> >
> The concern I have in those cases is that you need to share the RPMB key
> in some way if you need to access the RPMB device from secure side as
> well as from the non-secure side. Technically doable I guess, but in
> practice and in terms of security it doesn't seem like a good approach.
>
> In a shared environment like that you also have the problem that you
> need to agree on how to actually store files on the RPMB device. OP-TEE
> has it's own "FAT-look-a-like" implementation when using RPMB. But if
> you need mutual access, then you need to get into agreement on where to
> actually store the files in the RPMB.
>
> However, if secure side for some reason doesn't use RPMB at all, then
> kernel could of course take control of it and use it.
>
> I would probably not spend too much time on taking that use case into
> account until we actually see a real need for it.

I think the scenario for the 'nvme-rpmb' tool that does the signing in user
space does not involve any TEE at the moment, because PCs usually
don't have one.

I agree that sharing the RPMB is not a great idea, so if you have a TEE
in the system that requires an RPMB for storage, it won't be usable by
anything else. However, you can have multiple RPMB partitions with separate
keys on an NVMe drive, and you can easily have multiple emulated
virtio-rpmb devices  in a guest and use them for purposes other than the
TEE.

      Arnd
