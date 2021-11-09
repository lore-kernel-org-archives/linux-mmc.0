Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021E5C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF20361178
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 11:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbhKILSQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245617AbhKILSG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 06:18:06 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70326C061764
        for <linux-mmc@vger.kernel.org>; Tue,  9 Nov 2021 03:15:20 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bl27so30183600oib.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2021 03:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4hVT10Becr18q5c+7WtU6LwFlNBSvo80lS6A2/bda08=;
        b=ZhXfE8fkb4kM7D/n3iQS5fnoQZmaFTutNdUzpKyGPv436hMukJ9vK1uP8tSpO+PXRc
         M0gVdu0NzRyblMeiuI5wcMuznoCarl71nL8IqX393wppVulXPC/2CW2lP35vMZ5CE+lH
         2B+KjwBr8x+ccQ0A6uNiH86Qp6Yg47a32b0fNz682Z0o0fZEGTXFvbECg4WDTQHhzSgH
         7HcoeYeS+AulErQ4lYSbEqPEhJ/etfjjZDt9rXYyNi1awNAcRgfc0UwYDt+Da7NdwPz4
         5My5tOefwW3IZn2ct0ets51BOzleP69gT4Wz0swbJIRpPG6eQoA30u3F1oDWrDBuEZP/
         NyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4hVT10Becr18q5c+7WtU6LwFlNBSvo80lS6A2/bda08=;
        b=lk72xodEBXrdZHFoS+g8YTmOVxXxJApfowDvCPuqEmZj5yxU3QAlCUyVLBZYyEUN/0
         /sXc5i7cjghx5XAr/ObdCzhtVn7kqVonXJNQCUWqYCvWHiI3imIHtqCs4P0sufCM5nIT
         FCDSwCxauvG0ahdjRO680OZw73+2Ca3/u84DFIvMn6/XHpAmF6754nNQ3vkct9QdaivY
         +7Y4U6cmI+cyXvPkinAlojic2Css9WuDUrmIFFl26XaBybqzNq2Ov+8YnOvPUr+oqrEF
         PBShZsW/OtREL0910KEFDippE3dkNLOUT0PvawjbBOIGzWow0TsTo9ds6N45M1TG9QA1
         gvXQ==
X-Gm-Message-State: AOAM531DtgJH4knRD6u6JamBUSUB6NFMADfpx9z2FvE1C9c3shEM9+yX
        KMXEOfk3tTMlbHxgT8Pteq4LekIBvM6JBxp0qKcSoA==
X-Google-Smtp-Source: ABdhPJwk/P0SmvmDLHXhXAK1zJywnnYAVMs+ay9ZSTJjMZGRMEHispXDZQ/dpNO4SGj4/9plBxGXloJ/zEgEPWm0dyA=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr5037966oih.162.1636456519895;
 Tue, 09 Nov 2021 03:15:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635944413.git.hns@goldelico.com> <10f243eccdca10ee34b09fb626500f4a56da914a.1635944413.git.hns@goldelico.com>
In-Reply-To: <10f243eccdca10ee34b09fb626500f4a56da914a.1635944413.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:15:08 +0100
Message-ID: <CACRpkdZgrjfJ5mbstnwPELs_AWqZSBUZ6LXAR031Mm45Aivg_Q@mail.gmail.com>
Subject: Re: [RFC v3 1/6] mmc: core: rewrite mmc_fixup_device()
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 3, 2021 at 2:01 PM H. Nikolaus Schaller <hns@goldelico.com> wro=
te:

> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> Currently, mmc_fixup_device() is a bit difficult to read because of
> particularly long condition.
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

That's more readable!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
