Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B8EC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Oct 2022 12:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJRM3s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJRM3o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2022 08:29:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADD15A00
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 05:29:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h12so13888691pjk.0
        for <linux-mmc@vger.kernel.org>; Tue, 18 Oct 2022 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sF63XVM3kFck7H44lNWss0lMEirIGHDeC4MVe7UjNZc=;
        b=U/aw46yCbUiFQ4IGn6MwhwZ/fTikL+l2nDG6cFYQkamA50bysQA9Wjlim3j6uspbVw
         E+qTJOYkjBDwiORjd286Pd1NnsbsNT2/rRzfYGce8fFrCS+gDJUd4nzTxJCmqXlCuTy/
         liAZDf58gMaChoh59894I2D/uvW0iYa/DgWtZ7zY12XVZCe6bTynEQfWWUAOKoMQwWiY
         sLANPsBy7zEDR8zIjiMYPu7dqvfCHWKTVeCull23bvmMYEYpgzKzfyDbLfWLqU/k9WR/
         6UylglRsHmuutLf8v8p1nXfle1At2eXp9zGn+x/iiofEsb0+kAFCLlnUlYTywDyzzV2w
         8Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sF63XVM3kFck7H44lNWss0lMEirIGHDeC4MVe7UjNZc=;
        b=iQi9L/WoUMP2pXCI5hivS9jHi8+3cLUFofo9DOI7UDDVTYbt3+XnDs6i03ITC+o/al
         Gj/VMdfNJfUHMiLGaATwC8TEpEU52/am1M0h6Tfj8t/AX9JGNM0cc5JyuvCi+1ChnMKg
         KXRHm9cGqKL1oBib7pJwSKChC6Z0sl+wvCfMzeIv8WMeVkUGXkd22QBc8SdYY1fJ0TLp
         U6l7d8OjKsHWMopwBvlKskCccfIe0qC4CsS5eNytfQIABzfduQLXSacSLNg0RhmiRvIG
         kDNAyiHqzJ2sPhfn7rolEl4Zhd6oRnMcjZU1X3r614GicyiY0t+vfIMsEK00yqBj2//q
         ln0g==
X-Gm-Message-State: ACrzQf1i940RAo0Nnd0t1Q9xetNERoryGqEXBMZTcIlnIF4cznA3CAmg
        CgNrf9d4RO8xmaQ8Tn/dT75bVN8Of2JYvjXL/3g=
X-Google-Smtp-Source: AMsMyM4HcABqtLNUAuAjmluqIgOuITLReQe53AvC2T6FpKS+aEx0OHgnCKMCLqWUpjqxEWuxjm2zHm4NX+v8Enb20bk=
X-Received: by 2002:a17:90b:1d0e:b0:20d:a61f:84b1 with SMTP id
 on14-20020a17090b1d0e00b0020da61f84b1mr30997148pjb.172.1666096178354; Tue, 18
 Oct 2022 05:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DCbC6MK=O1t20nLNKf2Oipf-Ar1TkHU+o9Bvpr0JRtxQ@mail.gmail.com>
 <VI1PR04MB40163FEB8AEC32F55E51931890D69@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <CAOMZO5Dmk_OWTZGEafTZO451Zo6W8UMUJAZguW85y0b2BmCpWA@mail.gmail.com>
In-Reply-To: <CAOMZO5Dmk_OWTZGEafTZO451Zo6W8UMUJAZguW85y0b2BmCpWA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 18 Oct 2022 09:29:29 -0300
Message-ID: <CAOMZO5CYvbd3uTKxq6suyn5H0yNU1R7tsgbawNdwjEbKgdt6bg@mail.gmail.com>
Subject: Re: imx7d: Timeout waiting for hardware interrupt.
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bough,

On Thu, May 26, 2022 at 4:07 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Bough,
>
> On Wed, May 25, 2022 at 7:21 AM Bough Chen <haibo.chen@nxp.com> wrote:
>
> > Hi Fabio,
> >
> > According to the log, ADMA Err:  0x00000007, seems meet ADMA length miss match issue, please double check whether the following patch is on your side:
> > commit e30be063d6dbcc0f18b1eb25fa709fdef89201fb mmc: sdhci-esdhc-imx: correct the fix of ERR004536
> >
> > also please add the following patch for suspend/resume case
> > commit a26a4f1baca55a05aecd8d7181802979a93e3d46 mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs
>
> Both commits are present in 5.10 stable, thanks.
>
> I am testing a devicetree change.

After 5 months, the "Timeout waiting for hardware interrupt." error
happened again
on the imx7d-based board running kernel 5.10.y from the stable tree:

mmc2: Timeout waiting for hardware interrupt.
mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc2: sdhci: Sys addr:  0x8310c85c | Version:  0x00000002
mmc2: sdhci: Blk size:  0x0000002c | Blk cnt:  0x00000001
mmc2: sdhci: Argument:  0x1410002c | Trn mode: 0x00000013
mmc2: sdhci: Present:   0x01dd8a0a | Host ctl: 0x00000013
mmc2: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
mmc2: sdhci: Wake-up:   0x00000008 | Clock:    0x0000007f
mmc2: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
mmc2: sdhci: Int enab:  0x107f100b | Sig enab: 0x107f100b
mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000302
mmc2: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b400
mmc2: sdhci: Cmd:       0x0000353a | Max curr: 0x00ffffff
mmc2: sdhci: Resp[0]:   0x00001000 | Resp[1]:  0x00000000
mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc2: sdhci: Host ctl2: 0x00000000
mmc2: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0x9c042200
mmc2: sdhci-esdhc-imx: ========= ESDHC IMX DEBUG STATUS DUMP =========
mmc2: sdhci-esdhc-imx: cmd debug status:  0x2100
mmc2: sdhci-esdhc-imx: data debug status:  0x2200
mmc2: sdhci-esdhc-imx: trans debug status:  0x2300
mmc2: sdhci-esdhc-imx: dma debug status:  0x2402
mmc2: sdhci-esdhc-imx: adma debug status:  0x25b4
mmc2: sdhci-esdhc-imx: fifo debug status:  0x2610
mmc2: sdhci-esdhc-imx: async fifo debug status:  0x2751
mmc2: sdhci: ============================================

Would you have any other suggestions as to why this timeout happens?

Thanks,

Fabio Estevam
