Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB17EC433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Mar 2022 21:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiCCVxM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiCCVxL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2022 16:53:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA27D673EE
        for <linux-mmc@vger.kernel.org>; Thu,  3 Mar 2022 13:52:24 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s1so8332928edd.13
        for <linux-mmc@vger.kernel.org>; Thu, 03 Mar 2022 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYiLJYYPJSjUhcXRGu1IuMA7OVQstg8mWS33iyknnRU=;
        b=Zc/WF7ywL7MhnMKbU00JCToNkD/++ZgWE+Y89kS14vE0kJ93fDvXJU5KZ4j0/9sqRK
         u9AjOEVVqB293uk/CyLW01XQKf8FgYoh55sm0DdlmYgEg1i9BkiLpKzZDXMyBcFxiTKe
         r1vJZPhN00yxmarO4mEaCG8FJaDbFVV0xnbKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYiLJYYPJSjUhcXRGu1IuMA7OVQstg8mWS33iyknnRU=;
        b=Puw4pSJB6BtcCXiwC/8YvkUpVkQiyMn6BTfOw0PHpXTwjnpZ6nMmcQ7qpwMl77TRJG
         hOeujSsqPULB06lI3K5iUksp/1ZuQy4YJvrttGPHWdNcK6O8f8L7F6ed2QaHyLS2VV1K
         RnGM55WJdoPV/2GeaKXE5SQb0sZA+OzzFsJgy7++a8LfXYoqX+YgV80KePdU+yJttyFP
         QYin0PBPIh0kaAes0Yk+91iK4TkuOUNIVl5vr5A3TmQ9GwrFpNbIHc1dBigeNsqtJdHu
         +6FVPUocBwdNPW7fqCdptb9hGzh2NeimZwi3jXstWT1EmG5BB+NJmmoEqeFXjkm6dBRG
         WkgA==
X-Gm-Message-State: AOAM533nyNB6aD4qe8B/WlmYxKW3XlCnyvb5hLKOWbOU7Xgp+PfiUtl5
        Kd8eNxRnfRmR5ENOS07yxiYeiROXESpFDsvo
X-Google-Smtp-Source: ABdhPJw/o/UfX2Ftv2OPRdDltoadu4LZUQbsrNS033k8UGiarU48o/m6yhCR6Na0RtX3F8sSElu+bA==
X-Received: by 2002:a50:8e17:0:b0:415:c773:d0a6 with SMTP id 23-20020a508e17000000b00415c773d0a6mr7863095edw.322.1646344343087;
        Thu, 03 Mar 2022 13:52:23 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c487000000b00413a99bf3a3sm1396154edq.56.2022.03.03.13.52.21
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 13:52:22 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id ay10so9839726wrb.6
        for <linux-mmc@vger.kernel.org>; Thu, 03 Mar 2022 13:52:21 -0800 (PST)
X-Received: by 2002:a5d:64ed:0:b0:1f0:6672:f10c with SMTP id
 g13-20020a5d64ed000000b001f06672f10cmr1142174wri.679.1646344341238; Thu, 03
 Mar 2022 13:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20220303015151.1711860-1-pgwipeout@gmail.com>
In-Reply-To: <20220303015151.1711860-1-pgwipeout@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Mar 2022 13:52:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W6O5TtOHdVCbOyu221HrQWB8CnvcKA-5G49UF6TJaaHQ@mail.gmail.com>
Message-ID: <CAD=FV=W6O5TtOHdVCbOyu221HrQWB8CnvcKA-5G49UF6TJaaHQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: fix handling invalid clock rates
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Addy Ke <addy.ke@rock-chips.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Wed, Mar 2, 2022 at 5:52 PM Peter Geis <pgwipeout@gmail.com> wrote:
>
> The Rockchip ciu clock cannot be set as low as the dw-mmc hardware
> supports. This leads to a situation during card initialization where the
> ciu clock is set lower than the clock driver can support. The
> dw-mmc-rockchip driver spews errors when this happens.
> For normal operation this only happens a few times during boot, but when
> cd-broken is enabled (in cases such as the SoQuartz module) this fires
> multiple times each poll cycle.
>
> Fix this by testing the minimum frequency the clock driver can support
> that is within the mmc specification, then divide that by the internal
> clock divider. Set the f_min frequency to this value, or if it fails,
> set f_min to the downstream driver's default.
>
> Fixes: f629ba2c04c9 ("mmc: dw_mmc: add support for RK3288")

I don't spend tons of time either Rockchip or dw-mmc these days, but
your email tickled a memory in my mind and I swore that I remember
this whole 400 kHz minimum thing, though I never dug into it myself.
It actually looks like the 400 kHz minimum disappeared sometime in
2016! See commit 6a8883d614c7 ("ARM: dts: rockchip: replace to
"max-frequency" instead of "clock-freq-min-max"") which only accounted
for the high end, not the low end?

I'm pretty sure I've tested on veyron since then, though and I didn't
see any errors, but perhaps this is because I was never using
cd-broken and the 400 kHz always worked?

-Doug
