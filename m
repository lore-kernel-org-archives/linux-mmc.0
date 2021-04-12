Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A4FC433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 11:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3757661287
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 11:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbhDLLwX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbhDLLwX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 07:52:23 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D661C06174A
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 04:52:05 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id l8so6461421vsj.13
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 04:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BE3YDkZvSgZ80+e/3OVAhPMEeA9aRadkKoQynsogWXQ=;
        b=P0COJN1rhSSKIZLGzUTiZr65atT2F8XqmHrWS+Iqw4HFbkGBL6NBcwMKRV/+b1AfPu
         qxQ8ZYSeU+wV994NWq+xdRt8Bgmoy4tJMOLKiYy3avvMU/81ULr3iMopWFVTXnhklyGk
         XXw4iQwZQeNxKWUfrm1VVZKd8q2j/drizWDmagpwyHFcQe2pHlODo7nwt10sAgCt0Qco
         0Jsci8l7EBnMiV050hh2+qYjirmldvFHZrE1LxnQR9NfRXf57soeXaOe8ekEfa+UQ45h
         ohHiOhiGio11KivZEfpXXFbsVsb4yMnl4srLjN9enYPP7EQ822nDblYn5eCJs84xDd5A
         VXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BE3YDkZvSgZ80+e/3OVAhPMEeA9aRadkKoQynsogWXQ=;
        b=A5BCIuUkvNcxFyGkzkwrIWFCw7TSobLpYITaB8BZbq9h3EvN5NYhXAI5GGxV/WITdT
         cShmwEBvdU/ZhEcyHeTU0gf35bZ5hb54kWFJ1L/jKvpw8WJEDOIx6DMX/I+ENlrM7paV
         kCHmlYA/xTlr5RpfqVpGwRVmySVayGDU5SJZKmGMuQf6pIpfMZjSXy6Os6U/afY1WE82
         Y+k7EuiRSCSt6Lkr4rG+h+PJeuxEPIVHacVeSqYnQ+wjj2xkZr0V3/PDnfJlt29W66Kx
         VfNSYiZ6ev5RoxqCxV00B+5isGb4hr4x+XNsIZob2VyRUHzyMQEF/o5DeqYFoxPpSGLf
         uYGA==
X-Gm-Message-State: AOAM533SPt/AsLYbBzuhMJAznAfa4zv469MZgPoBg3EETVU1Os2HrP7L
        rh1LoLyjyfrc3SEGWJWcKto6A8Zv9inN4hWlKTs2ZA==
X-Google-Smtp-Source: ABdhPJwPKKGX+JxDeWt1/IJmeQhG+AbESYOGE2pbjFKpkH8dsW2w3h1WIRpctUEZ4vFMBix2PwNoQ0oG7VE7FeeEodI=
X-Received: by 2002:a67:6942:: with SMTP id e63mr19729880vsc.48.1618228324579;
 Mon, 12 Apr 2021 04:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210407094617.770495-1-jonathanh@nvidia.com> <CAPDyKFo+HwkBaCkALaSuUiTFE_soptsECmGRQX873_WKAmN_Lw@mail.gmail.com>
 <69fd5e22-2d85-46bd-8abf-0baf0d97fc95@nvidia.com>
In-Reply-To: <69fd5e22-2d85-46bd-8abf-0baf0d97fc95@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 13:51:28 +0200
Message-ID: <CAPDyKFr0Mg5m6ndKf=ge5rj0+XGTXMbtwc7c6oEEma0b-_yi2g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-tegra: Add required callbacks to set/clear
 CQE_EN bit
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Kamal Mostafa <kamal@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 12 Apr 2021 at 11:35, Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 12/04/2021 08:52, Ulf Hansson wrote:
> > On Wed, 7 Apr 2021 at 11:46, Jon Hunter <jonathanh@nvidia.com> wrote:
> >>
> >> From: Aniruddha Tvs Rao <anrao@nvidia.com>
> >>
> >> CMD8 is not supported with Command Queue Enabled. Add required callback
> >> to clear CQE_EN and CQE_INTR fields in the host controller register
> >> before sending CMD8. Add corresponding callback in the CQHCI resume path
> >> to re-enable CQE_EN and CQE_INTR fields.
> >>
> >> Reported-by: Kamal Mostafa <kamal@canonical.com>
> >> Tested-by: Kamal Mostafa <kamal@canonical.com>
> >> Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >
> > Applied for next, thanks!
> >
> > Please tell, if you think this needs to be tagged for stable kernels
> > as well (and if so, perhaps we can set a fixes tag as well?).
>
> Thanks. We were talking about that. I believe that the callbacks were
> only added in v5.10 and so that is the earliest we could apply. The most
> logical fixes tag would be ...
>
> Fixes: 3c4019f97978 ("mmc: tegra: HW Command Queue Support for Tegra SDMMC")
>
> However, this does come before the support for the command queue callbacks.
>
> I would like to get this into the v5.10 stable branch and I can either
> send Greg a direct request once merged or we can tag for stable. Let me
> know what you think.

Let me amend the change and add a stable tag like below:

Cc: stable@vger.kerne.org # v5.10+

Kind regards
Uffe
