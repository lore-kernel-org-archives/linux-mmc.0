Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9FDC4742C
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 15:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE442076E
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 15:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dFrJt5SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgKJPFB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJPFB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2020 10:05:01 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F75C0613D1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 07:05:01 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so3298304wml.5
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 07:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=mnaZygEEW1L0eKNF/s9ZSCOZcbczK0jgd2fEk5wQNyQ=;
        b=dFrJt5SYmJLmd7L4u3fAU9JCBeewE2bpolNKNt6xGHVlTdyJBdODzAIPF3IkGIidJv
         Ps3vPKmpq+99RI48jh9h3oSLMFt08WOe+BHrfmvce/OJ3Fz1jgk7PzKlrzzZ7czqeZjf
         rYfFk2e/04fh5iKdrYJb/wgQPSDxRxHseX8Hn5tdDza5KusU7sHQoN2/aoy4IFsGqM9s
         yljSFjtW/A8PpIz2XFN0OMaoBrrXotbHnwnm+XWT7bP7YNMcyc/jdGV5sd5cJfMT2jG6
         PjEtuZXfIEHNUetIOtJSUTHsg889CrZDqCuqV2NavrW4uYgbE2MUc3J9MqbvL4uwDeXC
         tsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=mnaZygEEW1L0eKNF/s9ZSCOZcbczK0jgd2fEk5wQNyQ=;
        b=Pj2O1lYwWcjNDWAJ8jp7agk0x0G7tBAnKkjJ30jC1k/1umqDH4rcvBGd68d5lME1Ft
         2YGqz5gUjiXkBnqLC/H++wA1M+GOtTVYBEHeYLFTS3Y9EM7M1Q2BynjxpdorHY9jSaTq
         ZXMoGewmyj/b5g0QlA1GpbcRUYmJ/8zcLSe5AKG2w3PMEIO8NZlZ7/8bqyNg0nTUrLfY
         h3qGVW37PYk2yO0x1uQ3j+bWe9PFZxQ1AvQcSWH3VFSHLV+Emn1NVM7gKbztLHxJUJfn
         y0z4rk6eRQXx+TQQRRzDHQ/qt2XUekb8TPMZOmh1+o7Ici1meswAEpKqP1wGGxRRzmHr
         Iy6A==
X-Gm-Message-State: AOAM532h0aJSDBFJH/XR0/1BWKSqMlQiUMfwQUywx/lfBWKVsss3ijrv
        z9wpEylnoqsuZjVkogLdpGSzqw==
X-Google-Smtp-Source: ABdhPJzUBuNa3CBkQzOs1OJPVLefwvgQPpcWsF5MW6vdx8EKZK2HrPJkUvozcAucIrRAmP5DrGcUrQ==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr68858wmo.97.1605020699866;
        Tue, 10 Nov 2020 07:04:59 -0800 (PST)
Received: from localhost (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.gmail.com with ESMTPSA id d3sm18037975wrg.16.2020.11.10.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 07:04:58 -0800 (PST)
References: <e4e6cc45-bc18-40ec-035e-fdb45b9a8f46@gmail.com>
 <87o8lf74j5.fsf@nanos.tec.linutronix.de>
 <CAPDyKFosR2wd=jqADBF_dNd3kCMbM4oDAHyxiYC-5RF=SZ_E5A@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Brad Harper <bjharper@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
In-reply-to: <CAPDyKFosR2wd=jqADBF_dNd3kCMbM4oDAHyxiYC-5RF=SZ_E5A@mail.gmail.com>
Message-ID: <1jzh3p9rs6.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 10 Nov 2020 16:04:57 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Thu 08 Oct 2020 at 11:08, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Thomas, thanks a lot for helping out and looking at this!
>
> It looks like the testing of the patch below went well. Are you
> intending to queue up the patch via your tip tree?
>
> If you need any help, just tell us!
>
> Kind regards
> Uffe
>

Hi everyone,

Do we have a plan for this issue ?
I've had Thomas's change in my tree for a month, so far, so good.

Cheers
Jerome
