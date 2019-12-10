Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B4C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 23:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D7D2073B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 23:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEF+pLwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfLJXkN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:40:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40916 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfLJXkN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 18:40:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id s22so21850673ljs.7
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 15:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Rh6Qxoy1bXpG7uBYSksjXPDCcHM7m/8J7aRKftFsx8=;
        b=EEF+pLwJjQwlFG3K2o0/rHlBAKSJXL1HqJ96f4qObH24iMnp4DmRiswcIaqd8UIbLv
         lkVUnTBBUNjqlEiTQVraBnv8B4O655WjYFoAGnge7AsESS2jA5iHCD0w0ychZwG9H6DL
         jb+f68nkYx7kKdleoNLyiAUmDvNQhcZNni5fcpcgikT5mDGK14CnaBDp98haXFzzS1vR
         Dkf4uOK14i1818nFEGCQmCnYNZL9eIU8OsxvC3qii6Rq8uET8hwf/Td6UXFHBE7edxyL
         L8vjzmBqhTMTtIA22lYMySK5VKOVmjY+Tnxo5ztToLtq1cnj2QGeQ9McR1j3yLqbvFzM
         tCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Rh6Qxoy1bXpG7uBYSksjXPDCcHM7m/8J7aRKftFsx8=;
        b=oenNyxJG/ayjD9pqpP1Blo8jFrgP8QQhMnDSAnJsuX5nxTIzfOddyz4ZheWOVaiuok
         KYa1Kd4oAG8C8ah4kdFEvra9232bBca9aUTLLqFcq9abwWspoK5n5vpvXvn/CCSeHS2W
         azXNYkjz9TIODGpaFCGS6GKkqRhm1NkafEP/7PnAPX3JSfdNYD0AsWzs17rEIKafZN8K
         1hq8mab6rdWX6HcpVtK4UcTxJv2VJpLgD3sRHo/ZfyAjFb/88GwHV+/bwXN4OE61xdYx
         pOKJ1sqPrrCPA1u/ebzr61dHsbvSesA0Ce8eOD7HW9LZg47jlLbifCjRrgYDj6sdSULT
         a/+g==
X-Gm-Message-State: APjAAAVYoAyTFNn7P4kcRV0Kn5FKYRoWG78B/sv78vBHPFnB0dqhNt8V
        r2+n0i1yttLdtDTiVPNenFOJCfhLCWQeeNNUx8wtIw==
X-Google-Smtp-Source: APXvYqzCAXKTgIXbgN7mSt17IksOJcuBx3NW8SAulRYOFQ7LfufZmsylKdu2CjhS46KnT/wD9Pjkg0t1365AeuZse9k=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr21713865ljm.233.1576021210997;
 Tue, 10 Dec 2019 15:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20191203130120.11511-1-haibo.chen@nxp.com> <20191203130120.11511-10-haibo.chen@nxp.com>
 <CACRpkdYN9rL9go68dyGgED0=atZMV7uAU3jfsT025e1NvB6brg@mail.gmail.com>
In-Reply-To: <CACRpkdYN9rL9go68dyGgED0=atZMV7uAU3jfsT025e1NvB6brg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 00:39:59 +0100
Message-ID: <CACRpkdaU+KbKmKdB2bniGbG34qMD-EPbkBLG1x+ac24uzKrW9Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] doc: dt: fsl-imx-esdhc: add auto-cmd23-broken binding
To:     BOUGH CHEN <haibo.chen@nxp.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 11, 2019 at 12:32 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Dec 3, 2019 at 1:54 PM BOUGH CHEN <haibo.chen@nxp.com> wrote:
>
> > +- sdhci,auto-cmd23-broken: disable the ACMD23 function of USDHC.
> > +  This is required for eMMC on imx6qpdl/imx6sx/imx7d when it use ADMA mode. Because
> > +  for these SoC, it do not support the ACMD23 completely, only take the 16 bit block
> > +  count from the 0x4 register (BLK_ATT) as argument for the ACMD23, the upper 16 bit
> > +  of the CMD23's argument is ignored. This will impact the reliable write operation
> > +  and the RPMB block write operation, because these operations need to set the bit 31
> > +  of the CMD23's argument. SDMA mode will default disable the ACMD23 mode. SD card do
> > +  not has this limitation on these SoCs.
>
> This looks weird.
>
> Is the bug in the *host controller* or in *the card*?
>
> It looks like the card.

After looking at the next patch it looks like the host controller.

In that case the compatible-string should indicate what version of
the IP you are using and if it has this bug.

No special flags needed for that.

Yours,
Linus Walleij
