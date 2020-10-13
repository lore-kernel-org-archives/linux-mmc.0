Return-Path: <SRS0=f1/V=DU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5148C433E7
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 12:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F3B2240B
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 12:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBrYp4m+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgJMMdP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 08:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgJMMdN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2020 08:33:13 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF922C0613D0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2020 05:33:12 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id r17so1879258uaf.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2020 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z6dPsJU2L1OPjljCMlXRdeEJAVflRV40QkSXjxTJ0ng=;
        b=FBrYp4m+GAGtZV82aTEC354CqZltbzs/Yf/LUuJjzvabyAtnfiuReGzlf/xtTl2ex/
         tPmyo7XCcHiA8OL1g8FKbhzcjWYvZHm1wKRtgHzOehg6s51jhC8quoWHbMs1ZrB35yLn
         YGVmV/6qL888+IPIGknL9+nXijf76oSPYU8vv3qflh+upcIksoBRIdCQiDjGa7ozJMS9
         B1f+xPJQkjtRKruePjfpEMGcw5vq5m4oyV072HksmlkJ6lV/A5kJTM+LsoFOI+i3wmah
         8g4f17BIc0xYjtpMzjh5azZsTUGZ5jBmJhPJTxiTFV711+KtisbuU0QNMZnt1DRrz69B
         4BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z6dPsJU2L1OPjljCMlXRdeEJAVflRV40QkSXjxTJ0ng=;
        b=og1Y4MZmrmttsQcoeaf0uhh4o1IANYcAwW4TI1Q6UzQbwMSXJ1m6mkFdh81Urb/CVG
         Oj+SJBdAF5aPRWkTIoeODIq1rsKMOPQDdR3MqeADIqdXFLemNk07S589oMTqwvkg5G6k
         ncqeUZCS5FLTb+mNX+lw2FvJS6wKbuL9jJnm0j/JmxU5/jRpdmH2/FAKahRq9rC5I5Qv
         W9vnVXaFnCvStUnQ1ofqcGfTR6Ekl5K1XrBQlLdxXIUPfPoXVXfrmVqadqmToLy8lVok
         7qaoq/KYzFo3yabfUo35W0rfS+rCzhu8OaWdGTS5WDg7FbhTqJDETFMXWAp/XkhpQ7kz
         nUIg==
X-Gm-Message-State: AOAM5331eOCLD9gPCuap8xi77UyEDg9mZ6dugbiFcWKgc7hxub3g2dtX
        pyFf/tzAvqCG7pG0g42SXMU/1IpKO8T1/r0gVhQoZXQ1R+M/jQ==
X-Google-Smtp-Source: ABdhPJxwjDwpPtESi1aKUL1SFHDRry4o+uXj9uu/aahzjvNt+Q1NiAKWVtdY6L53RltDQYVOgw4kWR82NhEI8Iw0euk=
X-Received: by 2002:ab0:4425:: with SMTP id m34mr14458778uam.19.1602592391576;
 Tue, 13 Oct 2020 05:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201013190851.715df9ad@xhacker.debian>
In-Reply-To: <20201013190851.715df9ad@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Oct 2020 14:32:35 +0200
Message-ID: <CAPDyKFo-Q-+wK1RjtTyoC42_M7UL-HteKwzLmWR-ctD6oKc=rA@mail.gmail.com>
Subject: Re: eMMC performance regression caused by 427b6514d0953bf
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian

On Tue, 13 Oct 2020 at 13:09, Jisheng Zhang <Jisheng.Zhang@synaptics.com> w=
rote:
>
> Hi,
>
> I found an emmc performance regression with below simple benchmark cmd:
>
> dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D8192 count=3D100000
>
> This regression has been bisected to commit
> 427b6514d0953bf (=E2=80=9Cmmc: sdhci: Add Auto CMD Auto Select support=E2=
=80=9D)
>
> If I revert this commit, the performance is good now.
>
> I=E2=80=99m not sure whether this is common issue or not.

Can you provide some data, like how much is the regression and how
many tests did you run?

Did you try different block sizes of the dd command?

Kind regards
Uffe
