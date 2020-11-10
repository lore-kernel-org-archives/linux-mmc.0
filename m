Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182F5C388F7
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 13:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E8D20795
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 13:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDNNZITX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgKJNA7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgKJNA7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2020 08:00:59 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015F5C0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 05:00:58 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id r23so3906442uak.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 05:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6YurlLlicIVj7vLlm8si4vZRusPlgVaXDTWA7wmn+g=;
        b=rDNNZITX2eio3Y2gggFJkipPaqFZoZQ3tJdsafYlzEG4BApRQhWQFPJDQF//QFxRya
         hUiOKYI6hcoVOROiTkiedKf2AEc98+40lH8xz9TTtY1F0mg1BUw8ECnE7rclmWMzz0e+
         qxTnzDE3DBtGZwoScLgnikl5ly0U6vleBlO9WEynAQ5nlxswg6+tcFAqgC91LQiosFKh
         hilZI/29fQQLxqr+cbXrndzeA2hSTAEBmoW46D6JvX+h2Hl3LAnXGt1YWaMBvLhQrGBQ
         E4SJf6uLfHubJB99tf60FUa5hUaK2kKE++miD3zZzsLSNdjw9wN0BGK3FGAJD64rhRe1
         yXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6YurlLlicIVj7vLlm8si4vZRusPlgVaXDTWA7wmn+g=;
        b=FiveKNxWFbujDuxYX2ql7+D2uMZ9mx6Kp8aFukLSePWK5upTLFR4mT8adqSHVft48l
         1HpLRKaf5BrW1tcm1JkyGXOipxWCj5kxBctfC/9EGGfmVVI/AECmOIpMl8pk7fjFgBzq
         VgnWMTMjwMlFziAZ3ubdZf0uPNqQN+7oJLTbqNZ8js7Z7o1jxfuVMoi9GMsgFquuM01W
         Xu6Fwlo645acbFbIxrCXm2oVBguv1CuuTgTBAUuz/rlgEF5gXqep4bIKxnJiGoDzPe+c
         RhyK/ChxocQXfR7RgDsJPDFe4xZHogZHfu1nwEl4M+3k+ki3RmQvKvyPyEsUFKShrSMK
         AGoA==
X-Gm-Message-State: AOAM533pLCFmDhB4j+6/ja3Lyh0YybWeFpuHX1LOyLwqWFR0PukOzbB0
        DEcAPn0WlgmOK+FZKCsKQz3XSN7OP+/FPEe7vYJ++g==
X-Google-Smtp-Source: ABdhPJw3KTVisdj01eFLXUGuNaz3s+PkFiTbMVxRTquH65s3FQzzLHnoZJSAsiB0Ngt1mKU7ftVcAST6y5t4FF5A2hI=
X-Received: by 2002:ab0:7103:: with SMTP id x3mr4441288uan.100.1605013257136;
 Tue, 10 Nov 2020 05:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20201106072549.1495-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFpGX0HOQr4z4LEH9FLiqeRJzNiUpBLpCNquJGJnZNFycg@mail.gmail.com> <20201110124018.GA3612@ninjato>
In-Reply-To: <20201110124018.GA3612@ninjato>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Nov 2020 14:00:19 +0100
Message-ID: <CAPDyKFqT0Yz=aKku_OFj3=dDaBpK6kdvAPOOV9_xAvQ_yt+1bg@mail.gmail.com>
Subject: Re: [PATCH 0/3] tmio/sdhi: fix workaround for a regression
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Nov 2020 at 13:40, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Tue, Nov 10, 2020 at 01:26:08PM +0100, Ulf Hansson wrote:
> > On Fri, 6 Nov 2020 at 08:26, Wolfram Sang
> > <wsa+renesas@sang-engineering.com> wrote:
> > >
> > > After some refactoring, I had to insert a workaround because a
> > > regression was discovered when re-inserting SD cards. Now, this series
> > > implements the proper fixes and finally reverts the workaround.
> > >
> > > This has been tested on Salvator-XS (M3N and H3 ES2.0). These patches
> > > were already discussed with Shimoda-san and the BSP team internally.
> > > However, I'd appreciate Shimoda-san's tags be given here to make sure
> > > the patches are exactly that what we discussed.
> > >
> > > Thanks and happy hacking!
> > >
> > >
> > > Wolfram Sang (3):
> > >   mmc: tmio: when resetting, reset DMA controller, too
> > >   mmc: tmio: bring tuning HW to a sane state with MMC_POWER_OFF
> > >   Revert "mmc: renesas_sdhi: workaround a regression when reinserting SD
> > >     cards"
> > >
> > >  drivers/mmc/host/renesas_sdhi_core.c | 13 -------------
> > >  drivers/mmc/host/tmio_mmc_core.c     |  7 +++++--
> > >  2 files changed, 5 insertions(+), 15 deletions(-)
> > >
> >
> > Applied for next, thanks!
>
> Can we have this in 5.10, too?

Of course, thanks for the reminder! I have moved these to my fixes branch.

Kind regards
Uffe
