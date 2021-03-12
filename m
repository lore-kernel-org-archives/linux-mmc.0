Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47863C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Mar 2021 09:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5EC64FDC
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Mar 2021 09:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhCLJr4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhCLJrq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Mar 2021 04:47:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0154C061762
        for <linux-mmc@vger.kernel.org>; Fri, 12 Mar 2021 01:47:34 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id e7so44787273lft.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Mar 2021 01:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMk9ZOPG5drs53p+SuNaGTRJ/y2LmEHScXuPR6AdCe8=;
        b=w/JETIl+jQpqvLCzn65MfrNC+8dTeF7KPKuQmMEOIbfX+jVeeA7NaQgQWGUwT2Rxsg
         pTAP60qjPN4LU5FcusSQZTv1JZfc9SlNHr7cl8Q5SbAcp3Mnaprsyck5NHPd85i8uj4I
         aSPTwaD6/RWpoysa3nFv9ZL/ZGFUv4kJkMrIy7xKD2fqtJu5vWfsJeCo1WyoOpH+iy8w
         T520hqje2419f+Hn33AHVMTRrN8mdybSM4zmVUrpRpSUHm0wrq4HJeLNUksNJZ1gd4TJ
         AwyOn+1R/+Uf20b6CwA4QCQqdwpn/uWjRs970tvXuNyO3BQygdJsKzyaj73sTpgV+en3
         O9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMk9ZOPG5drs53p+SuNaGTRJ/y2LmEHScXuPR6AdCe8=;
        b=K2MHDazSmnI9iCEpE3YY/AfGRYA/6jMzruHuYeTRLOwAEH4AXnQTT94aJGp076Wfid
         Yp/bj7c1oUL4ij0OFhAudUEIf45FI9c/EIwI5fcWIefYtRjcXhIPKGR+5PDfFYlmwCwh
         xQZJ98Ze91aM8x4wcMgFBdPlXOfyltj/WzcLtBnsRpWo2QLA0DHqI11cTg787YmlsT0b
         PFdZcR4hk+NPIYYwlzSXVNj2Mqku09A8eWrUaA+PFcoHkZRfSgGfNLxmNT10YvRnFWkw
         fCqS8Ro05WTiq6PMXbIpRNsudXFNEG//4ilYRaRQdqtbzk5ya8WhcP8Apb9PZaLvMhcq
         z8RA==
X-Gm-Message-State: AOAM531QQn23nBZ1H+TmSZpn068HmwlOpTD+rEFNQQkui23uTXnx6Rkb
        temmAndcVZSnmJIn32bTrWun3nG1/yfAP8r3POn/Sw==
X-Google-Smtp-Source: ABdhPJz3WLLA+H74P//j1Ln11RFxEyFm1vpbROXtZ66D7ytPG5df2SySNnXZoEquL+Ke2jaSnccKJ8/ughXkxGzr2Yw=
X-Received: by 2002:a19:6b13:: with SMTP id d19mr4768518lfa.291.1615542453087;
 Fri, 12 Mar 2021 01:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210303135500.24673-2-alex.bennee@linaro.org> <CAK8P3a0W5X8Mvq0tDrz7d67SfQA=PqthpnGDhn8w1Xhwa030-A@mail.gmail.com>
 <20210305075131.GA15940@goby> <CAK8P3a0qtByN4Fnutr1yetdVZkPJn87yK+w+_DAUXOMif-13aA@mail.gmail.com>
 <CACRpkdb4RkQvDBgTMW_+7yYBsHNRyJZiT5bn04uQJgk7tKGDOA@mail.gmail.com>
 <6c542548-cc16-af68-c755-df52bd13b209@marcan.st> <CAFA6WYOYmTgguVDwpyjnt3gLssqW48qzAkRD_nyPYg0nNhxT2A@mail.gmail.com>
 <beca6bc8-8970-bd01-8de0-6ded1fb69be2@marcan.st> <CAFA6WYMSJxK2CjmoLJ6mdNNEfOQOMVXZPbbFRfah7KLeZNfguw@mail.gmail.com>
 <CACRpkdZb5UMyq5qSJE==3ZnH-7fh92q_t4AnE8mPm0oFEJxqpQ@mail.gmail.com>
 <e5d3f4b5-748e-0700-b897-393187b2bb1a@marcan.st> <CACRpkdYxMGN3N-jFt1Uw4AkBR-x=dRj6HEvDp6g+2ku7+qCLwg@mail.gmail.com>
 <02d035ca-697d-1634-a434-a43b9c01f4a9@marcan.st>
In-Reply-To: <02d035ca-697d-1634-a434-a43b9c01f4a9@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Mar 2021 10:47:21 +0100
Message-ID: <CACRpkdZS4qoDOsm+GTpYV1bGB8ewjd0g3xA397XDoNQk4Nk82w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To:     Hector Martin <marcan@marcan.st>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Arnd Bergmann <arnd@linaro.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ruchika Gupta <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>, yang.huang@intel.com,
        bing.zhu@intel.com, Matti.Moell@opensynergy.com,
        hmo@opensynergy.com, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Hector,

I see a misunderstanding here :) explaining below.

On Thu, Mar 11, 2021 at 9:29 PM Hector Martin <marcan@marcan.st> wrote:

> And so we're back to embedded platforms like Android phones and other
> SoC stuff... user-controlled secureboot is already somewhat rare here,
> and even rarer are the cases where the user controls the whole chain
> including the TEE if any (otherwise it'll be using RPMB already); this
> pretty much excludes all production Android phones except for a few
> designed as completely open systems; we're left with those and a subset
> of dev boards (e.g. the Jetson TX1 I did fuse experiments on). In the
> end, those systems will probably end up with fairly bespoke set-ups for
> any given device or SoC family, for using RPMB.

Hehe. I think we have different ideas of "user-controlled" here,
our "users" include OP-TEE, which develop and deploy a TEE
which is open source.
https://www.op-tee.org/
Joakim who works on this project is on CC he's just not saying
anything (yet).

This project is forked and deployed by different Android and
other Arm SoC-using vendors.

Some vendors have written their own TEE from scratch.

So our users include these guys. :) As in: they take an active
interest in what we are designing here. They have access to
devices where they can replace the whole secure world for
development. They work actively with the kernel and created
the drivers/tee subsystem which is the pipe where the kernel
and the TEE communicate.

> But then again, if you have a full secureboot system where you control
> the TEE level, wouldn't you want to put the RPMB shenanigans there and
> get some semblance of secure TPM/keystore/attempt throttling
> functionality that is robust against Linux exploits and has a smaller
> attack surface? Systems without EL3 are rare (Apple M1 :-)) so it makes
> more sense to do this on those that do have it. If you're paranoid
> enough to be getting into building your own secure system with
> anti-rollback for retry counters, you should be heading in that directly
> anyway.
>
> And now Linux's RPMB code is useless because you're running the stack in
> the secure monitor instead :-)

The way OP-TEE makes use of RPMB is to call out to a userspace
daemon called tee-supplicant, which issues ioctl()s down to the
eMMC device to read/write counters. AFAIK other TEE implementations
use a similar scheme. (Judging from feedback I got when rewriting
the RPMB code in the MMC subsystem, it mattered to them.)
Their source code is here:
https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/rpmb.c

So Linux' eMMC RPMB code is already in wide use for this, it is
what I think all Android phones are actually using to read/write RPMB
counters. It's not like they're accessing RPMB "on the side" or
so. (I might be wrong!)

Since reading/writing RPMB on eMMC needs to be serialized
alongside Linux' read/write commands it is absolutely necessary
that the secure world and the Linux storage drivers cooperate
so the solution is to let Linux handle this arbitration.

Now the question for this patch set is: is TEE software the only
user we need to care about?

Yours,
Linus Walleij
