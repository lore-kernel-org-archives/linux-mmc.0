Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C487C433E9
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155BF64F6D
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbhCDAAT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242365AbhCCLqR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 06:46:17 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA726C0617AA
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 03:43:05 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id c44so7847471uad.12
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2021 03:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1RbCtGzk8rWPo09qOXUMitD4w0hoz+Ktus8PWbiZQo=;
        b=uDP1yq34dLCzUQ2mMijJAzry+R7H+/RPTtjIcPKY8t4b2Yb49kr8vsgIq49mbgrF5f
         vTkze0+4HU0Qmiwku7724qHn5ISShwVbJpnuU+SzyyZoI0o2YVPw7xO9qlkaPhdh39OT
         t29h945oBFT6vbrBFPynTlAkFd0+C0BrslplW3cMEn2QhoQ2X8zLUdRDm/Ofwcdzxg+u
         B+HSeMLU3CpZ1Ts6cGkCpt0bWv8IOJ9HLmtoaEdoVQrqdYXtOBXFu1z7aWWhvG5FP5rE
         inrbg4C9sMKFeTx91ACVQRrFmQtQpN995d0mLeWzfI14c2HNm0BDBAQoD1ThoSPt/lX4
         94OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1RbCtGzk8rWPo09qOXUMitD4w0hoz+Ktus8PWbiZQo=;
        b=VWT8Am5UyI2ZlppTnR/aDdr7gweOIzsexmAMU2JLAYLyEMqhlMjyTIdwrHzq4Ya7sL
         l0zjhVw327ZpWuTsqhBrEDBKSUfbLcGSa7waTXpf/2PO25B/tsQaRMrD+hQIgY7DudiA
         lxSWVHr7JoiHX/Q8+U1MUpZGMDH1diCT/4DQc7IheLWmulExLVixg6K1yft64B0CojqC
         1ADRmMxC9e322K2J5xGsSgAHFOF9YKwyJucuQIF/04sm1SC1/qfSh1syY80RQRKBDUJL
         VukXXHW2dvykralzUzmB2s8dy2DAXeo03UhGXa+QknzUae9MP/yCs0YK6qof1HH66rx5
         lqaQ==
X-Gm-Message-State: AOAM531HMWF/vAmfp5gph358WBbMW3bMLe9g68X7jM0YBbG+xixX9CUq
        V6mxLvnkDnXBLg0oGWCSgiVKS4ymwNER5zBO/dYBttehbEui+A==
X-Google-Smtp-Source: ABdhPJy/isSezCUZGU1RfXrIp4d0SBBjpYuLIHnMRbqrOtQlvM0/9zVgYhMnt+Sfi7ZpIc4lGFh+JitCk+EXuKiqGCE=
X-Received: by 2002:ab0:c16:: with SMTP id a22mr7056040uak.19.1614771784889;
 Wed, 03 Mar 2021 03:43:04 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210303092222epcas2p11fbb2697a53b54dbc138d741893c9f07@epcas2p1.samsung.com>
 <000001d7100e$b7380f50$25a82df0$@samsung.com>
In-Reply-To: <000001d7100e$b7380f50$25a82df0$@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 3 Mar 2021 12:42:28 +0100
Message-ID: <CAPDyKFr0x7vinYpy=AHcYfqxO-Q_S+SuU_SUb+kRTxRkNm4G6A@mail.gmail.com>
Subject: Re: About SD initialization at resume time
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 3 Mar 2021 at 10:22, Kiwoong Kim <kwmad.kim@samsung.com> wrote:
>
> Dear all
>
> I hope opinions from you guys.
>
> For many users of mobile device, there is a possibility that issuing no IO request to
> a SD card is rare during much of the device's lifetime.

If you want to put the card into a low power state after a period of
idle, you can set MMC_CAP_AGGRESSIVE_PM for the corresponding mmc
host.

Be careful though, as you will prevent the card from doing internal
garbage collection if you power it off. It may be a good idea to
extend the idle period for this, which can be done from userspace via
sysfs.

> Obviously the symptom would happen frequently among system suspend times, too.
> In this situation, doing SD initialization at every system resume leads to long latency
> and can make the users feel it, even when there is no IO request during the period,
> when a hardware architecture requires re-initialization at resume time.

No matter if you have MMC_CAP_AGGRESSIVE_PM or not, system resume time
should not be affected. Re-initialization of the SD/eMMC cards are
deferred to be managed through runtime PM, which means that the card
will be resumed the next time there is a command/request to be sent to
the card.

Assuming there is no I/O request after the system has resumed, then a
non-removable card (host has MMC_CAP_NONREMOVABLE set), typically an
eMMC, will thus remain in low power state even after the system has
resumed.

For a removable card (typically SD cards), there is a limitation that
we need to check if the card remains inserted after the system has
resumed. Although, note that this is done in a workqueue, thus not
affecting the overall system resume time. Still, we do end up
re-initializing of removable cards, just to check that they are still
inserted, which certainly is not always a good thing to do.

> This is what had actually happened and was fixed with some code in commercial products.

The above code in the mmc core was introduced around kernel v3.11,
even if it has been fine tuned since then.

Maybe you have been using even older kernels?

>
> Is there any way to avoid that symptom w/o any code change?
> With no way, I hope to make soemthing to improve it.

Improvements can certainly be done and would be greatly appreciated.

If you want to look at optimizing the behaviour, I suggest trying to
avoid the re-initialization of removable cards during system resume.
It's not possible for all cases, but certainly for some.

If you care about system resume time of SDIO cards, there are even
more improvements that can be made.

>
> Thanks.
> Kiwoong Kim
>

Kind regards
Uffe
