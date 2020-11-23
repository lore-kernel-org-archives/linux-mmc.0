Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8689CC388F9
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 13:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CE920782
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 13:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Drj+eK7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgKWM2y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 07:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbgKWM2x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 07:28:53 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920EFC061A4D
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 04:28:53 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id p12so5597128uam.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 04:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMrDSBRZ+BrQ7IeHtOwZdwbcJ4Pv+oUEuoNbzrU6uKc=;
        b=Drj+eK7hkAME0UZZLujX/V8zmRw/3UY95f5P2X9PZV/s8n/74Mch82IWyPSn0ruL1j
         DFdQwzjxW+nBZFpvdc4eOkzxaa+Xfed/oAcYHGrQVUOGpjPfVASJtyQibLYPWCoNAocE
         lS+SvY5rkcTNDvQWJk0ui6mJ+3oYBBbLXhlDt8h7tuma6YNk8v0YZzOSfdv0DSVh1fHx
         KAKxUiFDqnPOoajBuMMoP3IBufZeBLIzG7Hz7nvqWP/5KsB03L82Rjzn/qQoB2a1iNGn
         h+NRt3ee3VO8Iumb/PsHka48vTgMWC0nkqIxEOrLluq/x6wW8dQ56Rt/VnVUnq2HK+2N
         aF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMrDSBRZ+BrQ7IeHtOwZdwbcJ4Pv+oUEuoNbzrU6uKc=;
        b=sfhTnzfeYvfhTnCZ6RSiMePK67Q9JmzqfdvSe8RvMygPKmXDBjABX6m9g4XOc4SG9C
         QS4Durvi5jxE4Ol6ueCWLYLguK5Teq3iVFPcftlhwuH1LCChc8y/nuXCT2sHggYOVcM1
         8v8VUQsBjD1OQAcxYfDS85kniYnbxgMDOLSbJ0Lgyw/SG5mZ3buLIRyVjhm64AdRWPI1
         2xsIwLxllQwbjDGAo0uSeuFgzk2WsVMl8MFX3logOykKtDUWJYywLq2swXPsDTMXtp2i
         kuxHJiXOITkb2H9VEN1gJ/flh5wF27Px5vM6X5c8u+6keJJM8Zhy9gG+0S42d2pRv9y3
         aVDg==
X-Gm-Message-State: AOAM533KuGUAxYa9KMyHbMIfasbX5IotPaTKr2e04xcNWj1rm8Wcb3/Y
        0YNz/pw7iyjvNctdWuprz/yEcf++Unl9rPRyeQk3I0N3NHvgX8sE
X-Google-Smtp-Source: ABdhPJz7vYzOTV67myWhhRTgaBDXcXPu8RnLR6NqSvVbMutDb0CzrqOVlsiqjvhYCXdDOuMLfOtYC7kyyknGi09T8x0=
X-Received: by 2002:ab0:c12:: with SMTP id a18mr17291520uak.19.1606134532749;
 Mon, 23 Nov 2020 04:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20201119125304.1279-1-aisheng.dong@nxp.com> <20201119131720.GA348129@kozik-lap>
 <AM6PR04MB49666B9100F4CE87E1AE23D680E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201119152535.GA386850@kozik-lap>
In-Reply-To: <20201119152535.GA386850@kozik-lap>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 13:28:15 +0100
Message-ID: <CAPDyKFojf65BA40Ju3s8voOwHT0NU2wpcrnHuCfGrjPQMFwMKw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: imx: fix the wrongly dropped imx8qm
 compatible string
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Nov 2020 at 16:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Nov 19, 2020 at 03:21:59PM +0000, Aisheng Dong wrote:
> > > From: Krzysztof Kozlowski <krzk@kernel.org>
> > > Sent: Thursday, November 19, 2020 9:17 PM
> > >
> > > On Thu, Nov 19, 2020 at 08:53:02PM +0800, Dong Aisheng wrote:
> > > > The compatible string "fsl,imx8qm-usdhc" was wrongly dropped in patch:
> > > > 80fd350b9590 ("dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible
> > > > matching") Add it back.
> > >
> > > Although the compatible was dropped, by why wrongly? Please describe it.
> > > The compatible is nowhere to be found, it is not used.
> >
> > The DT patch using it is still under review. So we need it.

Where? Is there a corresponding update to the mmc driver?

>
> It looks like other patches here follow similar process of sending
> and applying dt-bindings separately from patches with users of these
> bindings. Please don't do it like this. Send the bindings as the first
> patch in the series implementing the users (so usually the series with
> driver and DTS changes). The new bindings then are applied by the
> driver subsystem maintainer.

Yep, I fully agree, that's the preferred approach.

Perhaps it's simply better if the series is reposted to linux-mmc
(including the DT doc).

Kind regards
Uffe
