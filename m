Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16444C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Feb 2022 04:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243593AbiBPEV2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:21:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbiBPEV1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2022 23:21:27 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C2A931BC
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2022 20:21:16 -0800 (PST)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CFBF3407F4
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2022 04:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644985274;
        bh=HsXK+os0Bu/iWLA0AHHw/feI5UAiYSJ6PqC8mSn7924=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=eXFDmBwprg5T7C0bA5bpvqRee9gHfyNdKh5K9TwrDfDoTNq5g943eeNvHsLhRSQn+
         +v5kPOWtpuvJDFd1z2JXnafsc+HB7LvfoWS4dRX4975oOba2JaGylep+cy7SecZROt
         MEq9RwTMvLVoZO5h2twSzkZrTgumVGStWdxw77xGPdTNZhijErn5w/TNzd/GwpdwDY
         NnBbXU3ChFNZtFJAPeqGHRISG7q3zDn0nOKlkEwsIEWZQyLIjyFoPd+UsycLMcDDz0
         5h1Xt0EvXOGpQSo7SYsg81lyFC2TghEEBv4xWZoFyFWEy9MyPDomEdSjZ3gQzrHWbo
         +uYUpSGSuU01w==
Received: by mail-oo1-f69.google.com with SMTP id t12-20020a4ab58c000000b002dcbee240efso665307ooo.10
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2022 20:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsXK+os0Bu/iWLA0AHHw/feI5UAiYSJ6PqC8mSn7924=;
        b=h9f0Z0X9ZXVCCUzopDgeWnKX8e6ZiWRuy0eBi4sOaK4Ja48u2ZsRIMLuuUh2/exL3M
         jo+tn4XpPSr/DdVJhezgFWi9bL8Ui3C0a+y6m3l1dv9Ni3WUguDqDR5Dl4dX51xsDygv
         b1gJcQmDllIW0YUaALhlWrJiX4hJ3Zu7YU5+n29ZZQ7mt+u+IIi3vm7ZxPCESmGBTyXA
         ABwQD6FXZOSnMPowDD5UG+eichBql3VmHL2+k5VeyabX4pBIzVg3yGnqKsRmrQhKe4Uc
         HMT4b8E3NxIkaEGo1MRfgBAG2h6mX8DuH8OQnxs75sWsV78bdkKsJqvvoLKv4m/6ISbt
         5l4w==
X-Gm-Message-State: AOAM531ZZfx3h+ZZds9UqmNnvNjhSpU8vbyH/k6WU39m4+jLYl3djYas
        M77cwsZHULOrB9aGRWHWSEhCYRC26mJBltFSr2dcuS1Wppo1lCYKT0JHXT2Tj4mn8LugoHQzAG4
        bcQK0zNIuxkjI72dnUpSpOq654W/jZVjk8riwzKfF2mSi5C44w1ULKA==
X-Received: by 2002:a05:6870:134e:b0:d3:7659:e8b5 with SMTP id 14-20020a056870134e00b000d37659e8b5mr1240413oac.131.1644985273568;
        Tue, 15 Feb 2022 20:21:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqQr9WioccQW2rNW50BJPxIWDXzh/BNZrc3rusV/8zTVsrc7M7FzsEBHFXcP6ido7ZdOtWXBCXsG/e+zdx8wc=
X-Received: by 2002:a05:6870:134e:b0:d3:7659:e8b5 with SMTP id
 14-20020a056870134e00b000d37659e8b5mr1240404oac.131.1644985273323; Tue, 15
 Feb 2022 20:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
 <20220125055010.1866563-1-kai.heng.feng@canonical.com> <CAPDyKFrtD28NKTyUAR-6Rt4PwYvkOuWcRhxZZWVAq4KcTNG7QQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrtD28NKTyUAR-6Rt4PwYvkOuWcRhxZZWVAq4KcTNG7QQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 16 Feb 2022 12:21:02 +0800
Message-ID: <CAAd53p5LxZh6-jZj274g6+PeDpAPWSiwRWXL93dgOg3xpqvu8g@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mmc: rtsx: Use pm_runtime_{get,put}() to handle
 runtime PM
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Thomas Hebb <tommyhebb@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Feb 4, 2022 at 8:28 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 25 Jan 2022 at 06:50, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> >
> > Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") doesn't
> > use pm_runtime_{get,put}() helpers when it should, so the RPM refcount
> > keeps at zero, hence its parent driver, rtsx_pci, has to do lots of
> > weird tricks to keep it from runtime suspending.
> >
> > So use those helpers at right places to properly manage runtime PM.
> >
> > Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> > Cc: Ricky WU <ricky_wu@realtek.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> The runtime PM reference counting for the mmc host device is managed
> by the mmc core. Have a look at __mmc_claim_host() and
> mmc_release_host().
>
> In other words, the runtime PM reference counting should not be needed
> in the mmc host driver, unless there are some specific cases, like for
> example during ->probe|remove().
>
> So perhaps it's only the changes in the ->probe|remove() functions
> that you need to fix the problems? No?

Yes you are right. Let me send a patch to remove redundant PM helpers
from this patch.

Kai-Heng

>
> [...]
>
> Kind regards
> Uffe
