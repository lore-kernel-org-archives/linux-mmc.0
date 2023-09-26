Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA81E7E644
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 15:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjIZPEE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZPEE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 11:04:04 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040311D
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 08:03:57 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7e904674aeso10417617276.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695740636; x=1696345436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1SkY6iwaLZdSNUuJZyThmR7YbUEz80TbBrJlu3z4uyc=;
        b=lxTu02hxfmVyqX+La5WHMgVkf/Xkpt9k8XgP/TJuOrdESK2j0uARJqGlWhUn/SOhlI
         hKcRob7heXpwunTnetNYs5hDeY+0Elf2CtdfVrKs9SY7u5G7QlRo+c5j+Rdj3q4wg9M6
         N0LrFaK99l30PvBNGK9G+u0CNV4KXVN/sX+0Hu08wECozk6uqG5Tha8DyjZ4fg5yJN9m
         7Dkt5dPqrbE2SttJvWEJELVK+ZDZUhDI+dSw+fixS+WxCKDDosh1UpMy+rcRd/ZyavJ1
         jvcDxAD51/3WL1dtFvj5XQyR7z35PuG+Kiai3GRJzsVc6t5VMTEHoDXR0qu24QeXzJTs
         oIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740636; x=1696345436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SkY6iwaLZdSNUuJZyThmR7YbUEz80TbBrJlu3z4uyc=;
        b=qq9+WYQ80l1vqSHDB4S9TCs8ea25aMpJSJHNClvlvCpp3rISNNlc5izgzu/5hIcnJQ
         khM42WOKko4NjxnreSvLH3I+0ViiCz4aiuQx5D2Cqzr0FwRF08O6LKotyoZR/hzgiKw8
         eHZBvaO/63nXJAyONFPjESx5Np539N2P1qBezCF5gAXWFFtFoCHFRxLaMw338p6fWtyJ
         ZqtzqXlO5yrwVVhqTKUofXJZS+ZXowh/rBnjX1B5DfSU9SizxMRcGRxLdJG90id9fc3Z
         HeL0/uEvPrBp3lXWYstWbrh6Y1tWqoyAWz+xeeOK3UrlZIErfatq+gvy3XtB/0kCsf3j
         TsJg==
X-Gm-Message-State: AOJu0YxOPJkism/IMaOrOa8x3JY+YwkcXYZpLYxCWaaKb66+ybrEktbx
        Jrz6g6g6iqf1GsCYAtT98RdeGD8rZ0QTZj5TvUpLsQ==
X-Google-Smtp-Source: AGHT+IF7KyVFVO+2QHZ2q6plBAK5asvhbL+daWClJRb4pwMEPfq54YbUtWsdRaDk+zh8YGamOafnUyzxW6UvKeIy2yk=
X-Received: by 2002:a05:6902:510:b0:d89:4e0f:114b with SMTP id
 x16-20020a056902051000b00d894e0f114bmr3291629ybs.65.1695740636452; Tue, 26
 Sep 2023 08:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <2ce258f371234b1f8a1a470d5488d00e@realtek.com> <CAPDyKFoCHtN9jK3A9YkoQC+e_3XNKJNp7-w1WkNMFBp6n-PH=g@mail.gmail.com>
In-Reply-To: <CAPDyKFoCHtN9jK3A9YkoQC+e_3XNKJNp7-w1WkNMFBp6n-PH=g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Sep 2023 17:03:20 +0200
Message-ID: <CAPDyKFp6cFnpWRA=iGZFr94UdjFbjtMbcTJORfFKQ-izdtX8bQ@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Fix an error access Page fault
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Sept 2023 at 16:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 6 Sept 2023 at 10:03, Ricky WU <ricky_wu@realtek.com> wrote:
> >
> > an error occurs on insert SD7.0 card.
> > The pci slot of rtsx_pci will Link Down when the SD7.0 card inserted,
> > but the rtsx_pci not exit from runtime_idle at that time,
> > then do the power_saving function to access the wrong resource
> >
> > Fixes: 597568e8df04 ("misc: rtsx: Rework runtime power management flow")
> > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
>
> Applied for fixes, thanks!

This was not ready to be applied, my bad! Fortunately, I haven't
submitted a pull-request with this yet, so I am simply dropping the
patch for now, to make sure we find the proper solution.

[...]

Kind regards
Uffe
