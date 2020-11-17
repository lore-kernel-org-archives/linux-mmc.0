Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69DCC5519F
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CE2238E6
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzqcEnN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgKQLu3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgKQLu3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:50:29 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691FEC0617A7
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:29 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id h26so6401351uan.10
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+rjCaps2k7U9izTRIPQGN/KMYZwRytG4PHUUpIgG80=;
        b=YzqcEnN3GkNtcoqkI0qssQWdkbl05WfUiQqqJ2bWmCieyvmra8mQPgB7634gWNdORE
         b5PJ+mVtpRNgN2prafS3KaIq2yKpO5xTfx0CrxnWeCAX/n31LOft5nzVyu96/FGyquwT
         KTCiz+EqR2L8ESvFLPHHsR428S0sidn0fd157bydJeAdNYAorJL+vX2DTAX0bI6a0Oay
         yxr/A17G9V7zV/2Qm5W8hs2czi7yQLI23I4xLLlSzWJwCieYiV7rgasXl/x1pasdVZNa
         moSXmfsVJyhE9QtB88sqa9pNMQKz2afl9w/hZclYaEkWOXDI0dxS+Bvqh6c0bkf/YhLu
         RX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+rjCaps2k7U9izTRIPQGN/KMYZwRytG4PHUUpIgG80=;
        b=hz1DNBoXDmVGbw17jtiYjMgiCkjbTRJXgKLCgM+ws+KRibvjuRmTg2yDy28n7Tvj1i
         Nhej8YAA0EyqWEcd5t1WKt4LMKPeYyFmhGIR/DsXvY69siD291i+5wCmJUWqGVxr3c8W
         xpW0f+JTwv5NTWu3WXP734ptATtBlPX8v75SGTRmuMbctyG+JrK4oNUCRvDbxqykmlig
         orMnMVg3F1eFcb7bRF8mLFMRFagHHSmpU1Y8HIIJXmByhet7Y225S8ZTH1CdP/P1JH6M
         QKJYfU6ccPVTPM6hBovvwfwbri8XhfCU5mJIsvQADJTW7jI6TjJ2u/47OWLctOaSuJWe
         leUA==
X-Gm-Message-State: AOAM53183DMur1hsHcHI0nIYFzM/Rebep22LKLzdkkOFRwzUVaNo2aPl
        nO4aN/Dg6r7lWXj8yYbTyuYoVnlz2rccsZbCIyCP9Q==
X-Google-Smtp-Source: ABdhPJwF7Dt1wGHBA1HHAJEu9MvM5rVl5FxeUSNjTPa+EOqiQKf25uSI0oat04CPYqdeq/6atR0EsombgTTeDILVNKc=
X-Received: by 2002:ab0:754f:: with SMTP id k15mr10189267uaq.15.1605613828595;
 Tue, 17 Nov 2020 03:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20201110142058.36393-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201110142058.36393-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:49:52 +0100
Message-ID: <CAPDyKFrX=h_wOZkba9=gLHp46RwRPEX7QCMJ52ONA8nSxHH7Kw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mmc: renesas_sdhi: reset SCC only when available
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Nov 2020 at 15:21, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> While working on another improvement for the reset routine, I noted an
> issue with an old Gen2 SDHI instance which did not have a SCC. It turned
> out that we never distinguished between the SCC and non-SCC versions on
> Gen2 when it came to resetting. So far, it went OK but my upcoming
> change broke. So, this series fixes the underlying issue by only
> resetting the SCC when one is available.
>
> I made very fine-grained patches because this driver is so fragile.
> Nonetheless, my tests on a Renesas Lager board (R-Car H2) and
> Salvator-XS (R-Car M3-N) were successful. Debug output showed that
> proper code paths were taken and checksumming large files worked as well
> as reinserting cards. The patches are based on mmc/next and 5.11 will
> do because there seems to be no issue with current kernels.
>
> I'd be very happy about further review and testing!
>
> Thanks and all the best,
>
>    Wolfram
>
>
> Wolfram Sang (4):
>   mmc: renesas_sdhi: only reset SCC when its pointer is populated
>   mmc: renesas_sdhi: probe into TMIO after SCC parameters have been
>     setup
>   mmc: renesas_sdhi: populate SCC pointer at the proper place
>   mmc: renesas_sdhi: simplify reset routine a little
>
>  drivers/mmc/host/renesas_sdhi_core.c | 38 +++++++++++++---------------
>  1 file changed, 18 insertions(+), 20 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
