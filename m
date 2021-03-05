Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA2C433E6
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 14:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333C464F76
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 14:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhCEOOl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Mar 2021 09:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhCEOOh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 Mar 2021 09:14:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A0C06501A;
        Fri,  5 Mar 2021 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614953676;
        bh=nJW/qzlXmQLjEx5WtjuS7q3GToRzq3WGjVZX19qD8Jg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ujT6mUNrqJ6jlXFWAX1PRjYK0tftZpfJWLEY3DbgBEJ/3/vZY2zPlcu+MPfP/f/C9
         gxcjtYUNWqGHyIP9Offdvt5GU/9lHxv8AgwSewkvn98xQOyhslh/E3TD+W51q56Nkz
         1GR68fvhBdnD7bdTOneaZ/DzbB8Su8/p/5IaM1MNgwvXqLnxwLTlUs8qTw3was3Ut+
         b/k34hD8fPTzR7sA4hcj9I/mvl3YS09wjbpjo7NPx0tNYggrK048TXf4Vg7CBpfgRI
         RfPHFba9UWVx7rLCUvzU7IL0LBGymZCJZ8ZQ/J79ggYzOeK8B6xuw7wX6NOz2rFgiw
         jNOB5eYbz/9Cg==
Received: by mail-ej1-f54.google.com with SMTP id c10so3700009ejx.9;
        Fri, 05 Mar 2021 06:14:36 -0800 (PST)
X-Gm-Message-State: AOAM533JXMe/UOx97mPDBvOudoA4AmL2PsFIIbSr2XeiCQ25MrOFeMrp
        1QwGe+ZQKF/lpLYpQbg9ajCo6yxvNRYRzDIgPw==
X-Google-Smtp-Source: ABdhPJwNz6f1WnjfIEjnIlOIQSeFUxdiphznagy089tysI2uTGcdeuYk8oheFpgpAvN7aSri3oqhBTW4L9fuXdOWSes=
X-Received: by 2002:a17:906:d153:: with SMTP id br19mr2329504ejb.360.1614953674952;
 Fri, 05 Mar 2021 06:14:34 -0800 (PST)
MIME-Version: 1.0
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
 <1614222604-27066-5-git-send-email-peng.fan@oss.nxp.com> <AM6PR04MB4966041BFFDDAF1EF00BE1AD80969@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966041BFFDDAF1EF00BE1AD80969@AM6PR04MB4966.eurprd04.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 5 Mar 2021 08:14:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKK8t6XUqTuOKPzOviJbysqWqga_mdxWE0P0N4ejTgG=A@mail.gmail.com>
Message-ID: <CAL_JsqKK8t6XUqTuOKPzOviJbysqWqga_mdxWE0P0N4ejTgG=A@mail.gmail.com>
Subject: Re: [PATCH V3 4/5] dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Mar 5, 2021 at 8:09 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> Hi Rob,
>
> > From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > Sent: Thursday, February 25, 2021 11:10 AM
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add clock bindings for fsl-imx-esdhc yaml
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml        | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > index a7fbd8cc1e38..369471814496 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > @@ -103,6 +103,17 @@ properties:
> >        Only eMMC HS400 mode need to take care of this property.
> >      default: 0
> >
> > +  clocks:
> > +    maxItems: 3
> > +    description:
> > +      Handle clocks for the sdhc controller.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ipg
> > +      - const: ahb
> > +      - const: per
>
> One question:
> The side effect of this patch is that it imposes a forced order of clk names
> In DT which actually was not needed.
>
> Do we really have to do that?

Yes.

> Or any other better approach to allow a random order to match the DT
> usage better?

Why do you need random order?

We can not enforce the order, but we only do that when there's
multiple optional entries.

Rob
