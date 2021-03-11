Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F5CC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 01:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EDF64FDD
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 01:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCKBCi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Mar 2021 20:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhCKBCK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2021 20:02:10 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCF9C061760
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2021 17:02:10 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id p15so160532ljc.13
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2021 17:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8MWUEPcWRqlNN6HV0ALExHUT0G/wuf/0Gpk6qlo1WE=;
        b=UhMP6tzOupn8Kgm9qYDbMvA5SCQImG9o3THb5a8Ek4/IxA6Ws6YGQoiQaHOUEBSRcc
         /ZpjF/pAJubmqTu9r/jwd7HBBwpIAp/E+cSIIircb7aU6kwwbRJuxr7BN5dvmMGw01io
         5pVLAWKHtIxUn/RKgjkjffI+X8LpF5V88y1/uaJ9Ku/hMV1zyg+KDMDkBrczbFUCzhGs
         S4hOB6Km+eAAvrBcseYvd3NlDzvkQTg6zzCq3AqRuJ06/FT5I8IqtJbek2KTykNN+zRz
         s3z1LKVDczv1nd/6qnTe63ho1j/gNgmQLCSc3V4M1KuFMY7f99od7XGzD+aT+hY2pOVY
         96xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8MWUEPcWRqlNN6HV0ALExHUT0G/wuf/0Gpk6qlo1WE=;
        b=Lja86ckN/BVkqkSQdjS8qzpgwfc0MsFkn/iRCj8QTdUmvy9TU1JCwNSsSSp9LB2Vlo
         HJdZAOB4KGaWaHV/SePfUzIJ8lt40JgNiUzvs/8RbEJxEYhUaffqqWnejBJ1iO9VVN0h
         dbXdNRhT7thsPXJ2qxqGTiqL0d2H3Fyzd11ZXLmBuCANUU/OZJCGO+y0eu/6KG0kh6zg
         UOKJ2V0r+a8KHsLXd0spWCDP/+9sJbYFT/ZX3VqoCF1feffgWOjXD5UV17czkD5S764d
         Q9dcgGBYEHCju0tMGs7GCuBJaRx4cR6HDAJIjoZnUB0P5/kdMILcUjU8Gd/8zx2fCtPE
         TkMA==
X-Gm-Message-State: AOAM532XQEyGBNI40t9zxqn+DZuwtUrdDWzVHmer/2jMBOqXBMCK8Yy/
        j4yDajprITvTQlKFmjpXcutA41dOyK+cW16BB9mLTw==
X-Google-Smtp-Source: ABdhPJzkcZbjChLiKr2QTj6cupQ7Gt4EKlXJ9kqPzoWN9882YNqqEJKPD3YGlEuuS/DQkce8boJ9ojboDa+oHD5ilFI=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr3492915ljw.74.1615424528892;
 Wed, 10 Mar 2021 17:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20210310152900.149380-1-ulf.hansson@linaro.org>
In-Reply-To: <20210310152900.149380-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 02:01:57 +0100
Message-ID: <CACRpkdayGkuJE9z+QT41ZVoJJN4sBx4e28c5OLzC9obvE94gBw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix hanging on I/O during system suspend for
 removable cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Mar 10, 2021 at 4:29 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The mmc core uses a PM notifier to temporarily during system suspend, turn
> off the card detection mechanism for removal/insertion of (e)MMC/SD/SDIO
> cards. Additionally, the notifier may be used to remove an SDIO card
> entirely, if a corresponding SDIO functional driver don't have the system
> suspend/resume callbacks assigned. This behaviour has been around for a
> very long time.
>
> However, a recent bug report tells us there are problems with this
> approach. More precisely, when receiving the PM_SUSPEND_PREPARE
> notification, we may end up hanging on I/O to be completed, thus also
> preventing the system from getting suspended.
>
> In the end what happens, is that the cancel_delayed_work_sync() in
> mmc_pm_notify() ends up waiting for mmc_rescan() to complete - and since
> mmc_rescan() wants to claim the host, it needs to wait for the I/O to be
> completed first.
>
> Typically, this problem is triggered in Android, if there is ongoing I/O
> while the user decides to suspend, resume and then suspend the system
> again. This due to that after the resume, an mmc_rescan() work gets punted
> to the workqueue, which job is to verify that the card remains inserted
> after the system has resumed.
>
> To fix this problem, userspace needs to become frozen to suspend the I/O,
> prior to turning off the card detection mechanism. Therefore, let's drop
> the PM notifiers for mmc subsystem altogether and rely on the card
> detection to be turned off/on as a part of the system_freezable_wq, that we
> are already using.
>
> Moreover, to allow and SDIO card to be removed during system suspend, let's
> manage this from a ->prepare() callback, assigned at the mmc_host_class
> level. In this way, we can use the parent device (the mmc_host_class
> device), to remove the card device that is the child, in the
> device_prepare() phase.
>
> Reported-by: Kiwoong Kim <kwmad.kim@samsung.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This makes sense to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
