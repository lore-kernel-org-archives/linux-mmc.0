Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85895C433E7
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4382086A
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 08:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LvoKCakW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgH1IoZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgH1IoO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 04:44:14 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D46C061264
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 01:44:13 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id h19so137362ual.10
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeXlfnXZ4sTJswhwNtffWf0Y5RYZt7CDOEurreh9XAI=;
        b=LvoKCakWRKLvx/0BHLE5JGzq92yOk3o/lHDjeCNYJRZW2x4PnX4osD+BUJKunyCUj2
         /bqB9UVotpxVrZ5G923Rznp1fq4DzwoO4tD3hKWIMMQNSfyK3iXaOd14ozrYm5Ye5HCq
         0Rzr3iNz8cf5rlznhBgAvVEGYCLwb4S4oXh7MRVdr9zhOVoLT4PZvIkIJuc4utbIjTcz
         UqJF64cJ6Jk/hR8jwWu49mRJ8G2l8vDf+TK1xPJS06hCvHJZ7/rD3Laa0bSm+pCy/iJL
         0Mb1WU+Xtn3sOlJLpNsl3jOqTIEXq6svmJo31r7nkA/4n6OYkyyD33PSoncLANEO2ydm
         Em/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeXlfnXZ4sTJswhwNtffWf0Y5RYZt7CDOEurreh9XAI=;
        b=jQAWY7uC24feGqTvfY/zwNiuqEmbWxSek3UfB9htRsl3b05XwlypFCg/HgeYEgllky
         3c1GwGaup3Cakp0XpCmkVkVoys0+oCi5+RCqVSF87jnS+e7sibmypgb5DdzZuVnFa1Tv
         B0HywVSX5qof9ctYBeS/UF4SoNNaCOC3Eean2LprGaTZbMBX9t3fCYwGqjZ8ea9PR9fz
         hh92qpmpmbJZkF6DfNvefBteWbxniz9qC1DxrBUUbdaHcPb6RElaWrrEjEaRaZyrFkIx
         FwyJfrSiuyiydx+T2lGgkd7Mt7DHNXdANPvNiuXjpUI/W1bYgbXFgRcfRZ/TouEQVl/b
         0TBQ==
X-Gm-Message-State: AOAM533gp2r+46IzZF2u03gF3EyJPR4QOn/ipvdQCr3VDwBX/q4rEPPR
        Kbz4SvSr4gnviyi8uPOG89NcoJlfV5A2gTGQuBA7AA==
X-Google-Smtp-Source: ABdhPJxDXAOV/vb6si47r9ICjb8OmqVI+/7MJPxURFzZTGQqh0+TR5mXHiyTJTbQAY+DumtfmYUO31qltv4NzpdAdck=
X-Received: by 2002:ab0:2848:: with SMTP id c8mr283199uaq.15.1598604253138;
 Fri, 28 Aug 2020 01:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200814014346.6496-1-wenbin.mei@mediatek.com>
 <20200814014346.6496-3-wenbin.mei@mediatek.com> <CAPDyKFpt6-a+pkTXb2RZdx=yTONetugSCKbtSsRD2xQ3PRPhDQ@mail.gmail.com>
 <1dfc1938-f5e8-c4c8-57c7-d7b6c33dcb1d@gmail.com>
In-Reply-To: <1dfc1938-f5e8-c4c8-57c7-d7b6c33dcb1d@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 10:43:34 +0200
Message-ID: <CAPDyKFp+nFq11YcnNSe6sfDx-gkBHiYAjNE+r-OQ8HdrK1LBKw@mail.gmail.com>
Subject: Re: [v5,2/3] arm64: dts: mt7622: add reset node for mmc device
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 27 Aug 2020 at 10:23, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 24/08/2020 11:50, Ulf Hansson wrote:
> > On Fri, 14 Aug 2020 at 03:44, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
> >>
> >> This commit adds reset node for mmc device.
> >>
> >> Cc: <stable@vger.kernel.org> # v5.4+
> >> Fixes: 966580ad236e ("mmc: mediatek: add support for MT7622 SoC")
> >> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> >> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> >
> > I can pick this for my fixes branch, together with the other changes,
> > however deferring that until Matthias acks it.
>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> My understanding is, that this will land also in v5.9-rc[3,4], correct?

Correct.

Applied for fixes, thanks!

[...]

Kind regards
Uffe
