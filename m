Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92783C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 12:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DE622B48
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 12:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjVyZzwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfLJMnX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:43:23 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44198 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfLJMnW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 07:43:22 -0500
Received: by mail-vk1-f196.google.com with SMTP id y184so1956971vkc.11
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 04:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmEiSSp96CqMy1Ppsk8W6nnDKAAqnPQ9Fp0EYBdV+7E=;
        b=SjVyZzwl1gFe4ZV18t5rV4aLho7lO9k6u7FJV6ZAqeuFB7bj2OpZ7m0NdHHPB5P/9J
         F1GRcZF8vBqkPBqBMbXJp1yuJ+IAcubDftWI51y+mNDpGrT6YxHSHu3zzeoVuKOXTUL6
         ofai+5OMyCUrw7aMsKCreGKjupSo3Hr8MQseWJ2xCsncPzWOMFL/Zih9GO6A6c/ZjqzK
         JyQZpoeWVRpPl0H1oX5XjRDyHL02eQQ9+RL/TZcZdazLKImnbYsdmtz0DQPBGEJMtLj3
         8uxieE2T+RpsIhE9/Ytd6ACKGxx+oh90ka0loPrxuxNct8VjQ+3Ll7M3kAKlYy5U84kC
         DmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmEiSSp96CqMy1Ppsk8W6nnDKAAqnPQ9Fp0EYBdV+7E=;
        b=dmUQwOrrfxjTsBUG1/zKEORGH3PEeoyVbHqIb0feYquHC19YjNz6wlkEzaRzSGG+qZ
         Y2ycqMaaiNjwiDA/o/HNPqD71Hw6nTSu1gY1dVgLFbZdkpbkPzrfQfPhNmeu8J9c4DxY
         8o2q2Gl0m6KQD1zhoeXygJXC+xKPIwOe4bNAlZpRy1FnclSfGyEzzf2fTdpbdxMVz2Ud
         rW6O4rZ0/xIaSBx77LMMrzMpsXvhZX3np5QVS0GC4ovIg/xHUa89Ll320A8fRTN33N01
         8HgnBLboEtnwdm/TNnF2Zt/vNAbWXZVwA6YFpYvretQYWtPADTxEK9WpynsPutj8uZIq
         wG1Q==
X-Gm-Message-State: APjAAAUcIqRuoQynbh4jXrE0/zd/XzOmpCqRf0RQvEXwgLFx1xXX8ihn
        rFLxhPzuDYh8W9EGurDJTf93GhfUAEeMp87TGPWNpA==
X-Google-Smtp-Source: APXvYqwYeuWm53/m5Bq2qBEuOXIjm6v1jerpImsqqYFfOVtKgHeSeKsZzlwtHErJOzdB13a85RtG6b5LG2BU3bpzpc4=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr8918335vka.59.1575981801902;
 Tue, 10 Dec 2019 04:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20191204071958.18553-1-chaotian.jing@mediatek.com>
 <CAPDyKFo9Z2yj7zC5VOS-iX_LyavPp1A4n73eAp7VD-Q+dpoqpw@mail.gmail.com> <1575979419.7714.1.camel@mhfsdcap03>
In-Reply-To: <1575979419.7714.1.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 13:42:45 +0100
Message-ID: <CAPDyKFpCjzpxOLi+bfawgHJNXve16tkJmg-Z0Jqjf3zJ5UxV_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix CMD_TA to 2 for MT8173 HS200/HS400 mode
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@google.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Dec 2019 at 13:03, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> On Tue, 2019-12-10 at 10:51 +0100, Ulf Hansson wrote:
> > On Wed, 4 Dec 2019 at 08:20, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > >
> > > there is a chance that always get response CRC error after HS200 tuning,
> > > the reason is that need set CMD_TA to 2. this modification is only for
> > > MT8173.
> > >
> > > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> >
> > I have applied this for fixes, however it seems like this should also
> > be tagged for stable, right?
> > Yes! should be tagged for stable.
> > Is there a specific commit this fixes or should we just find the
> > version it applies to?
> >
>  this patch should be a fix to commit:
> 1ede5cb88a29bba1aad1b68965c5fc8e00b20ed9

Perfect, I add that!

[...]

Kind regards
Uffe
