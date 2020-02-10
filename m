Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA2EC352A1
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 04:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44633206ED
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 04:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n3Ht9nwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJEYk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 9 Feb 2020 23:24:40 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44172 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJEYi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Feb 2020 23:24:38 -0500
Received: by mail-io1-f68.google.com with SMTP id z16so6029650iod.11
        for <linux-mmc@vger.kernel.org>; Sun, 09 Feb 2020 20:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f9/SpRmu7ZftQfQrFKpqn3FiKFBhLldZW4LlC+d7FEA=;
        b=n3Ht9nwt3oFNzZVouxN0h0x/ECuQGwRj6N97mqr+Sl429uxJEHSrkHS48aRexIh3fw
         nxvTLNDb3J/oVL1q0Ehb403siYgBTFrUfX1rH95Qcc6Uu/Fc/DLJcbPL+n3f9QvqIAZk
         P3442KH4s6p4cw3q4HQ4kudxH0tWMvlIJXEmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9/SpRmu7ZftQfQrFKpqn3FiKFBhLldZW4LlC+d7FEA=;
        b=cNKmiGEo04eqQRJjfddOyO7Urt5BM98NB+tRJQ0RorhIuuYLJD4JmVBj6tkWyAtkxK
         SLz3wsBeyIW4DwS214OGXrbneecEX6nVRh+oTHd0uP3ucxmODuwo1SFhx+7jxtyaF01+
         dTVwLNDlT4wJjbLL9DikUHmzYYQZPq/QtNL0drh0ccK4df9aI43OG8HRnA67tEnzpxaH
         zA64QTTa54XBeJHxVfSEZryyA4yK60KsXLd39ht1yMq348266QFU1fUXQ8VJIaxUeKgT
         PbPPG4a9IjSdrKBJqp56EE1RkfJ0bf4TYfa0Inc4etRExsJPEfhuTcXh7HB2xtuczq01
         3/vw==
X-Gm-Message-State: APjAAAUU0fsz8axp74SARzvT4tueBdeNcMPuNPsBYsO2nDjzl0s2uwl1
        vCXlAOsEPLq9/A2bWq1r+iEEmI6scpBFuZD8N/cO3w==
X-Google-Smtp-Source: APXvYqyKXFQWOfUcJughVD7+IczCYrEmXa8+KVPkwR23+DH7h9JTtgAmwF5wDycGjx9kxCMYaIKV2ieQTzAYHPcKEJU=
X-Received: by 2002:a02:b385:: with SMTP id p5mr8392462jan.43.1581308676642;
 Sun, 09 Feb 2020 20:24:36 -0800 (PST)
MIME-Version: 1.0
References: <1579591258-30940-1-git-send-email-yong.mao@mediatek.com>
 <1579591258-30940-2-git-send-email-yong.mao@mediatek.com> <CAJMQK-gZcvpQTSqM4kNsnNOXpcOfJw9u-X9uedQDM6W2soF_4w@mail.gmail.com>
In-Reply-To: <CAJMQK-gZcvpQTSqM4kNsnNOXpcOfJw9u-X9uedQDM6W2soF_4w@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 10 Feb 2020 12:24:10 +0800
Message-ID: <CAJMQK-g57BLA0auzFbZsv-__rEQBb38-P5Sv4JNhyQz0M08ZBg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix SDIO irq issue
To:     Yong Mao <yong.mao@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 21, 2020 at 3:38 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Tue, Jan 21, 2020 at 7:20 AM Yong Mao <yong.mao@mediatek.com> wrote:
> >
> > From: yong mao <yong.mao@mediatek.com>
> >
> > Host controller may lost interrupt in some specail case.
> > Add SDIO irq recheck mechanism to make sure all interrupts
> > can be processed immediately.
> >
> > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > ---
>
> Thanks, mt8173 need this patch for cap-sdio-irq to work.
>
> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
>

Gentle ping

Thanks.
