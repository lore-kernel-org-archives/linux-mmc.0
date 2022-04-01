Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0233C433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Apr 2022 09:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbiDAJhK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbiDAJhK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2022 05:37:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FAD674C4
        for <linux-mmc@vger.kernel.org>; Fri,  1 Apr 2022 02:35:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q5so3098439ljb.11
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2022 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4FSuKnccX1iFN0uwomkiOn5u1Xbdrve2qg2JRoojKE=;
        b=VogYOcScEozGo2HMiWfqxuG6WYR1q4RB22WpLk5JKZJ7C7863bdDZMoez1zh52xN3E
         tQRCs5L9iLeEb3iV/aDNvioJiF6J1FXPf/1x+Jyf0ZnUG8mzmEooJR7j+y5YldogbuP+
         5ezZ26ojecVxEvsIhBKIacbEiCW3aRA9iQwLnC0eJIRp9QpLT3gCIlLWTVPWekSneKDD
         gETW8elTB+iNq/ztsFTbH9BsNjgxNo1YX7KDi+JnJHg6QgCVPbLGDuQJi9sf2ve2FCoA
         TVnlbcWW+EXB4ILmmm8EcrghRQ2R5G/sodiSOxtoOtAHy5iED1RwUgHk4B4qiR9ViDYB
         1gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4FSuKnccX1iFN0uwomkiOn5u1Xbdrve2qg2JRoojKE=;
        b=4dgduAiJ65ncTS/juVXgCBg8E8Mgj6+Hzb0bew5ncqIwqKMwZopSTtx9Uhr+n+fK5/
         SulOnmLm/+N+HvLDTN6/tqczigcX2yzFWxH8XNSLy39fI8X2XK5VpBaNAwdJCQUKNxHL
         svKZCW8fPvPpAusEnIxYWMtQOynM2e+fIDtpSyxyekCEyXiWZpiAeEJMkjaZcriFhlUS
         NFPl0/PyQ5DLqaRSGn2S3BwjUZZf6uQ0a+77uHC1xnRAWCF1qwYRjsI55Pb/Rvsx3qh+
         MP32/jF8iqEwVUTHqoGcvGebaNNLFSzlt8Ur4TLtouyJ9ao98MiHJZWlU5mp8ee3SXTv
         3XuA==
X-Gm-Message-State: AOAM532RPn92o4Q/cpi9CZgRUuJGtvSLXMZ74ak5cuKyhNmQMxMGudZ6
        lNw2k7cS4mrmEMrJk8jmQeX/87sFHUei+27bELyxIQ==
X-Google-Smtp-Source: ABdhPJz6psO/sjbUT/j1r3XjHcZRBUCIC5sFVlTg1I2riC4zd4S5suzIVESlXB2FKEJIV3qX81Z8ZtW69b0xCIMwSA8=
X-Received: by 2002:a2e:8189:0:b0:249:7d3a:ceb0 with SMTP id
 e9-20020a2e8189000000b002497d3aceb0mr12136101ljg.367.1648805715996; Fri, 01
 Apr 2022 02:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220329032913.8750-1-axe.yang@mediatek.com> <20220329032913.8750-2-axe.yang@mediatek.com>
 <CAPDyKFqoTN1pF-L6qCHxpdMCmPtHP0aHHaDURN2QJsN3v+wZBw@mail.gmail.com>
In-Reply-To: <CAPDyKFqoTN1pF-L6qCHxpdMCmPtHP0aHHaDURN2QJsN3v+wZBw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Apr 2022 11:34:39 +0200
Message-ID: <CAPDyKFo_PYc9ofWuXeaE86oK6FqOAnHsH-ZSG58MfNq8nEOVOw@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 1 Apr 2022 at 11:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 29 Mar 2022 at 05:29, Axe Yang <axe.yang@mediatek.com> wrote:
> >
> > Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> > This feature allow SDIO devices alarm asynchronous interrupt to host
> > even when host stop providing clock to SDIO card. An extra wakeup
> > interrupt and pinctrl states for SDIO DAT1 pin state switching are
> > required in this scenario.
> >
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  .../devicetree/bindings/mmc/mtk-sd.yaml         | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index 297ada03e3de..3872a6ce2867 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -69,12 +69,22 @@ properties:
> >        - const: ahb_cg
> >
> >    interrupts:
> > -    maxItems: 1
> > +    description:
> > +      Should at least contain MSDC GIC interrupt. To support SDIO in-band wakeup, an extended
> > +      interrupt is required and be configured as wakeup source irq.
>
> If I understand correctly, the extended interrupt (a GPIO irq) may not
> necessarily share the same interrupt parent as the primary device
> interrupt.
>
> Perhaps it's then better to extend this with "interrupts-extended"
> instead. See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt.

One more thing, looks like using the "interrupt-names" property would
be good to use too. To easier distinguish the different irqs.

[...]

Kind regards
Uffe
