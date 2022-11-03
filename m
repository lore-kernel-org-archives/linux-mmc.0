Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C74C433FE
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Nov 2022 15:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiKCPHg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiKCPHN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2022 11:07:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3511F1A821
        for <linux-mmc@vger.kernel.org>; Thu,  3 Nov 2022 08:04:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h193so1881953pgc.10
        for <linux-mmc@vger.kernel.org>; Thu, 03 Nov 2022 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5SX8S1GoqbnGutA7INzRoyQfzD7Efc9HM+BPmRWtUQ=;
        b=jJiOqWM0NMptNv3BNBY/lAWtQ+JFPO0Uf71TRdXOIwP4IjjTYrClPkItlaG+o1Dpkc
         oU7/Toemr8NflzwrL5RLcweQqEupjnzTvXnGV/Gre/Zb9Ku7QK8hOt4P9T2JxH5KymWo
         O2ZdAmF6IoZc1ZaD5sIcaPHWn05dVAMXmsTLq+hrJwHSW161GEBn6utiy/DwBJY/g10P
         ETHtG7Ls+eI7r4Ag/d7ugMwBI4eQZllss0CaXjOiUco+LF3itDZAi/u/eF9+AO+/5Av9
         qXjuIXYpoaALQDBKXLD/z31PltwvsrcRv1YxIPK3PtRCi1jPcApLL4oDGALyFHGHkDuu
         7UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5SX8S1GoqbnGutA7INzRoyQfzD7Efc9HM+BPmRWtUQ=;
        b=y2GjRCgtxBDLjoO4/Ju2d1E98ZormX/0zArZyE3BY603fMtq0qY0a6mtJKyz0c4D40
         ZRJzkAdMFjc+m+riVv1agYqgPfBPburGj35DmKz8YxnwnAUkZVvnQvSBnGFjh9n4R1nX
         5S9sMA0PXbDiySU5EV42DyarRdPzHoFi2DsMrFFZOmcotLsPOwNZmXDEMKHs7UayFiVx
         LIMtYw6I9fm/HO9EHFxeV7ZzBzaQtFGshl80g6L9MN+AjvEle0Zc+NNZfc//u1877+Xp
         eLFNLpjzmOsgSCKtg6GuRuabIyKmS/tBTz176pg+Nw74geJ7RsjbLKkbZgc66YVudBBy
         m5yA==
X-Gm-Message-State: ACrzQf2HkCypMac4F1jTClxVKpd6f08P6A3EmUyVAKPajqp2EiG6w5O/
        QW2C9Nljyk+ZoVDBt3G88VsYEMfaKoY4M20RBQtBLw==
X-Google-Smtp-Source: AMsMyM4cbJucyEqLbWDZpIyLnaLE+WJJU1EjZS+YPC+DzcUIWaiTUDs71Ng+lyG577vLJRbeIcvD+n9TMaqO/rQIAbE=
X-Received: by 2002:a63:1345:0:b0:470:30c2:8b0b with SMTP id
 5-20020a631345000000b0047030c28b0bmr973457pgt.434.1667487884662; Thu, 03 Nov
 2022 08:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221006190452.5316-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFqA1RtcaGMCQgDsKKju4izHWJRAD12SqqirNm+TWLt_hA@mail.gmail.com> <Y2LBiOqomYJ2E/Gd@shikoro>
In-Reply-To: <Y2LBiOqomYJ2E/Gd@shikoro>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Nov 2022 16:04:08 +0100
Message-ID: <CAPDyKFr1UR3QX4X45TmShADDpOEuxnadcvyTGaXLhcxKrAxbow@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] mmc: renesas_sdhi: add support for DMA end irqs
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Nov 2022 at 20:14, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Ulf,
>
> > The tmio/sdhi core still relies on using tasklets. I think we should
> > strive to move away from tasklets for all mmc host drivers and to use
> > threaded irqs instead.
>
> Ooookay, noted. I'll put it on my todo-list. But frankly, I can't give
> this priority for a while :/ SDHI is used on a lot of platforms, even on
> different architectures. Regression testing will be a big one here.
>
> > That said, I am worried that it might be harder to move away from
> > tasklets beyond $subject series, for tmio/sdhi, but I might be wrong?
> > So, I am wondering if it perhaps would be better to make that
> > modernization/conversion as the first step instead?
>
> As said above, I can't do this in the foreseeable future. However, this
> series fixes an issue we see. So, my vote goes for applying this now.
> Even if it costs some extra cycles on the tasklet-removal-work.
>
> D'accord?

Sure, I am fine with applying this. I just wanted to point out my long
term thoughts around using the tasklets.

Do you intend to send a new version to drop the RFC? Or can I apply as is?

Kind regards
Uffe
