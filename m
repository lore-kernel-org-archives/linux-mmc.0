Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAE2C00A89
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 15:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3244B22258
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M5MSnBQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgKBPix (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 10:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKBPix (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 10:38:53 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECBAC0617A6
        for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2020 07:38:53 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id y1so4032242uac.13
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2020 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqxNzB9bebjKacS6hCKnWOzs/I4JbN6NsAjF2jZxB5A=;
        b=M5MSnBQw4VuA4GM+wUMVpYnnF898Zci+8IDRgzspk8rVnDVQoYnYpMXs75GmuijejU
         pUykKDtOIARTSfi/0tW08tOHkRLNXJWGVFUIUt1KMxYAfdF/Mh4mAv4N/crX0QzNJOS0
         F3rl3orFZTBb5OMwT6rOXpp5C5sjltk41c5aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqxNzB9bebjKacS6hCKnWOzs/I4JbN6NsAjF2jZxB5A=;
        b=GoiMj+oXI5tkgMG0kI+f6T4xKOixITcztKbjoy7Dh5b1YhB67rCt2bEaSDV2o+ULQx
         VwCQ8/U4pGV3myvVSNYz0Oh9kZcYgPSFsXcTe8cs1FTWChNXebHAWKSLfQpe7rQ3Qvb0
         RkbXWlTM8y2Seju0m6ImCKZ6BZo3WJdytAZrFIT4jcyU62/MzJazJmRJX2ehMzbRqWwr
         0gE2OXVyMFs8s1Eo3EimYC3Fz7gPRCRb7Me7TJKXlxulb19uhb7fqCcmlaHFqLgPd3lj
         y32dG6VC0a3lPjIXQkxPUh2xzqnpUfzWT+Bmo50VtI0KNnoWb7zCWU5wjNdFSDVOXKCU
         +t0A==
X-Gm-Message-State: AOAM530vcb/6IEjfea7FKG74eBW+HhCEK2cHkskQ/AhkBBKB2BCTFBGe
        tOX/EJCuJI1NXz8jxpaPl6AxvDNHlChUvA==
X-Google-Smtp-Source: ABdhPJwI6ZROqKHcuno7GkD4ndzaa67ihH5+Bz4Vqml+ANFIbr/EjCtXKN2EVULnka0BbS2zWxLPuA==
X-Received: by 2002:ab0:6c52:: with SMTP id q18mr8252119uas.63.1604331532420;
        Mon, 02 Nov 2020 07:38:52 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id o12sm1892550vke.22.2020.11.02.07.38.50
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 07:38:51 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id b3so7677576vsc.5
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2020 07:38:50 -0800 (PST)
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr14954133vsp.34.1604331530584;
 Mon, 02 Nov 2020 07:38:50 -0800 (PST)
MIME-Version: 1.0
References: <59a5676c-cbf7-4a8e-ace1-f079e09d21a8@gmail.com> <CAPDyKFocOzHfaZyGPJbUDMiTrV1DoEUjdu7TMN5B1wPjBiBS2Q@mail.gmail.com>
In-Reply-To: <CAPDyKFocOzHfaZyGPJbUDMiTrV1DoEUjdu7TMN5B1wPjBiBS2Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Nov 2020 07:38:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U1arH7-VRL_Xevvu_=1A9XKjqf4rZ4JqOM0ZUtWP716w@mail.gmail.com>
Message-ID: <CAD=FV=U1arH7-VRL_Xevvu_=1A9XKjqf4rZ4JqOM0ZUtWP716w@mail.gmail.com>
Subject: Re: [regression, bisected] no MMC on rk3399-gru-kevin with 5.10-rc1
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Vicente Bergas <vicencb@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <treding@nvidia.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Nov 2, 2020 at 7:02 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 30 Oct 2020 at 23:04, Vicente Bergas <vicencb@gmail.com> wrote:
> >
> > Hi,
> > commit 21b2cec61c04bd175f0860d9411a472d5a0e7ba1
> > mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4
> > broke booting rk3399-gru-kevin.
> >
> > The kernel waits forever for the root device to appear on MMC.
>
> Waiting forever sounds weird to me.
>
> > Removing the line containing PROBE_PREFER_ASYNCHRONOUS in
> > drivers/mmc/host/dw_mmc-rockchip.c fixes the issue.
>
> I am guessing when we enable async probe, we reveal some other
> existing error. Or, perhaps the rootfs mount point become wrong?
>
> Would it be possible to share a boot log (before/after) with some
> driver probe debugging enabled?

Are you sure you haven't just got your MMC block IDs shuffled now?
Perhaps a careful application of the newly-supported MMC aliases would
help fix things?  When we landed, Ulf pointed to:

[1]
https://patchwork.kernel.org/patch/11747669/
https://patchwork.kernel.org/patch/11747671/

The async probe can cause shuffling of block IDs which were previously
quite stable though never guaranteed (everyone always yelled loudly
"use UUIDs").

I will also note that I just put v5.10-rc1 on a rk3399-gru-kevin and
confirmed that it booted up OK.

-Doug



-Doug
