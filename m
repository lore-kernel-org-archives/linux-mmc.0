Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A35C433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 20:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FC422CAD
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 20:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgLDUHC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUHC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 15:07:02 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16921C0613D1;
        Fri,  4 Dec 2020 12:06:22 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id x16so10429472ejj.7;
        Fri, 04 Dec 2020 12:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qs8bczzvvcOwQEvENjn4URGTN3wUu8Qwy1O5EPHsTig=;
        b=ZW/eWHESkxaXaG9FG2ERuWlrJJ2EoQMuQe1ap/t4Zug2xHTKyUvLAe0LSma4Hr4D/2
         sSMiCQ1AuK2IgAeuycOb5uINCa3XpZunE/MtvasipMDxT4x9h0dBXrW5ZSnsgrea6Quu
         oE+TKrBVdYlJ60LcYxbjCzHutv1LLN1GYFlPb/guIJxnxiFNKmOEAIGVzc+3dINf0y2U
         WMvf1vz+bq3a8zx96TxY3YgVrYLl7G3F6xV4fXFq5qaRSGXZ2escXPdnH/c9EEvY/7gt
         +xxDEd7L/SCwFRzp1bqlM5Pq0vWXHeILgrYhM+zGSha4PEPdAoyyF/YOerl7Dy8QWhmz
         QOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qs8bczzvvcOwQEvENjn4URGTN3wUu8Qwy1O5EPHsTig=;
        b=J6EaSr7WxdepE9I4get/d+QbhBrLf2MuLK82tB8c+jGVyI4gDxAgD0uaFltbXQzMaY
         etDSSM9suNGvZ1MmBbsvfcLiz3gJdrYBIcJwnvoxUE7bUxtdCYLX+sOb2Je62iYdBtK2
         Vx7wOJfPg44vliz1jkf7OUCEVEBxZ/OXqk844MV6dL/SE/GBuT0IPeQpfxnqntfzPeFi
         35ozp1Cy9MwWI4GCGk9Q/o6v5ovS2fRhJUp0ymvucnlvR/7lY+ACeOSZDS55FDMFsGFw
         2sb08d8nQ5qSTu9jHby1BKgsxEiM7eFj0LRxCwC60Gvpv+6Zpul1Nv4WqChVKDbHhvSx
         3ZJQ==
X-Gm-Message-State: AOAM532iGOxAX2mUI6An7OgQm2IP6PbUqQa0FjIy06FVFPf6zg8dyJgg
        wqjn3QSOePLg9fMiI9GKhuHjxasT8TDsFTllGHo0gz/s
X-Google-Smtp-Source: ABdhPJy8bqY9rTcK9UXixUcvuanWn9pcDguoM2gGjlVFhJsXrNeS0S/ACFdsGzvK97Sho3oM8Zmu3as25niNqcfU0q8=
X-Received: by 2002:a17:906:2ec3:: with SMTP id s3mr8450543eji.133.1607112380662;
 Fri, 04 Dec 2020 12:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20201129203116.11987-1-adrien.grassein@gmail.com> <CAPDyKFp0U5=s_AJh4-QAn=WCodkYUaFE9BuLjpJB80z23J7JkA@mail.gmail.com>
In-Reply-To: <CAPDyKFp0U5=s_AJh4-QAn=WCodkYUaFE9BuLjpJB80z23J7JkA@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Fri, 4 Dec 2020 21:06:09 +0100
Message-ID: <CABkfQAEnVqOikmEBy2XhzSUM1zzvTSLJvMEP8M_k_EfpRuDw5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: add an option to disable HS400 for fsl
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

Thanks, it's working with your suggestion.

You can delete/abandon these patches.

Thanks a lot,
Regards,
Adrien

Le ven. 4 d=C3=A9c. 2020 =C3=A0 14:18, Ulf Hansson <ulf.hansson@linaro.org>=
 a =C3=A9crit :
>
> On Sun, 29 Nov 2020 at 21:31, Adrien Grassein <adrien.grassein@gmail.com>=
 wrote:
> >
> > Add an option to disable the hs400 support in the fsl esdhc
> > driver.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b=
/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > index e71d13c2d109..070b40ae8c44 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > @@ -101,6 +101,10 @@ properties:
> >        If not use this property, driver default set the delay target to=
 value 7.
> >        Only eMMC HS400 mode need to take care of this property.
> >      default: 0
> > +  fsl,no-mmc-hs400:
> > +    description: |
> > +      boolean, if present, indicate to disable mmc-hs400 support.
> > +    type: boolean
>
> You need to disable hs400, because the sdhci capability register
> wrongly claims it to be supported, right?
>
> May I suggest using the DT property "sdhci-caps-mask" instead?
>
> Kind regards
> Uffe
