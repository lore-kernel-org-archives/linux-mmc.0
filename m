Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27794C47084
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F393561432
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 12:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhEYM5q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 May 2021 08:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhEYM5q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 May 2021 08:57:46 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676DC061574;
        Tue, 25 May 2021 05:56:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id eb9so15898644qvb.6;
        Tue, 25 May 2021 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26X9qK4i0o6JrWdnAd2JnpXvFHwNqdNddtrdo/NdfKI=;
        b=nBkCcXaGwEkQhV6TKf2zXfPW4FjThvleyqszqwJFSVAou+D+bRwAbaxBSeKr8Pes11
         E5e18rziC1t8POYTRl4a6k8F416Y9cBU3ZUoIqpy6M/uYy9nvutL1W43NWNsss+At6NY
         6pcrFoSCPJm1K1tXt+w2Haimjmc6bi/oNcQGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26X9qK4i0o6JrWdnAd2JnpXvFHwNqdNddtrdo/NdfKI=;
        b=sw30dFRYkbKNYuGdSbaA9riiCIzKGrhRMHkFg9tmiHlHKoZSRhrG3sMTPCqimJGt3H
         /BOZa6XAoVPlC3/4kiRDQyyDK8TMzhjmVD+uu5Qvj4nFDXd06JPcJ7geQ+k6DoV2/lr7
         iAN2d9M2bCEXn30ziP1izD9Y9FEtrCaCOomI1Mu5fealKnpuf7eNlvPyLGFyExwozGyt
         NsnXd3FRiqMdhjzbECnmDgmX+F1BSnaYy2/lOCQcOpcdxFJXMemWJ1fLJ+kBIsLV22QC
         BVcn7lK3GPGlLJ9jwsI0GmciiXR0kjujrjdZihPWlcBUvQhvnw4u9AcG3lT1FOeXQ4eH
         vd+g==
X-Gm-Message-State: AOAM530Q8+eGwkT5ZUDjx2dFVI1hSa3Zx8lc+ZoPFwXuFeGDgqudzQoM
        h7H91Wo+ce0q7q8fI5xWbBmL+P0tvmMlSGsKp0RLE85e
X-Google-Smtp-Source: ABdhPJzDQUGrbvEccQD0Kpi4U8eTcle1vYjBru7kgLT7HNZqT7Mrjy2Zqn6NAZqxZDh/CJTJUcX0PuPEQ1ETi39cZKo=
X-Received: by 2002:ad4:4961:: with SMTP id p1mr36377153qvy.43.1621947375551;
 Tue, 25 May 2021 05:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
 <CACPK8XcfvUQD5xwb=2Va5Sr+bmaWfJMZkh61HK1=J1qLYc84zQ@mail.gmail.com> <20210525094815.GA8757@aspeedtech.com>
In-Reply-To: <20210525094815.GA8757@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 25 May 2021 12:56:03 +0000
Message-ID: <CACPK8XfdYAcx=RX07hf1ar8A7th8G8390exvKbgh92X=ov8u2A@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] mmc: sdhci-of-aspeed: Support toggling SD bus signal
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 May 2021 at 09:48, Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> The 05/25/2021 15:55, Joel Stanley wrote:
> > When I was testing on my A2 EVB I saw this:
> >
> > [    1.436219] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
> > clamping to tap 15
> > [    1.450913] sdhci-aspeed 1e750100.sdhci: Requested out of range
> > phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
> > clamping to tap 15
> >
> > Do you know what is happening there?
> >
>
> Per MMC spec, eMMC bus speed is set as legacy mode(0~26MHz) at startup of
> eMMC initializtion flow. Clock phase calculation is triggered in set_clock()
> and it calculates taps based on phase_deg(<9>, <225>) in the dts file and the
> current speed(1562500Hz), which causes the warning message you mentioned.
> As the phase_deg in the dts file should be calculated with 100MHz.
>
> https://lkml.org/lkml/2021/5/24/95
>
> But after some initialization flow, eMMC bus speed will be set to
> correct speed(100MHz).
> Clock phase calculation will be triggered again to get correct taps.

Thanks for the explanation. I added another debug print and I can see
it doing what you describe:

[    1.465904] sdhci-aspeed 1e750100.sdhci: Requested out of range
phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
clamping to tap 15
[    1.480598] sdhci-aspeed 1e750100.sdhci: rate 1562500 phase 9 tap 15
[    1.490316] sdhci-aspeed 1e750100.sdhci: Requested out of range
phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
clamping to tap 15
[    1.505077] sdhci-aspeed 1e750100.sdhci: rate 1562500 phase 45 tap 15
[    1.515059] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 9 tap 3
[    1.524886] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 45 tap 15
[    1.534904] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 9 tap 3
[    1.544713] sdhci-aspeed 1e750100.sdhci: rate 100000000 phase 45 tap 15

We should change the "out of range" message to be dev_dbg, as it is
expected on a normal boot.

Cheers,

Joel
