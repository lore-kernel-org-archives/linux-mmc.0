Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ED4C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 14:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F087239D1
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 14:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbhAVOfB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 09:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbhAVOeC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 22 Jan 2021 09:34:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45B6F23A5B;
        Fri, 22 Jan 2021 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611326001;
        bh=apHhMVnZDv807tnG5lsX2afABBdRarhLvKdToqKf3J4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YH8kw24AeSk/pWjakZLTtH/JxuyrgSyGwuvnA2kurv7j+hUMYkpUIOO41kDbfiHWJ
         Dos/St2uVj37LyP/PcAoxAz36dK0sWnTKYvYcKvDq0obxQl3hxeOW69e6XSXOZoSCW
         MC64wBQBehVf0at6fs6bkIUCvMT/qc5xdCQU3cijiudNgSLHsuShwhFlQUQ3X1Vryd
         VUR5/xWwAyrHCKXidi71X5EFX5SmvfHxcHsNyHTXOJjtTc/VtK28ysTnGCaBGTiu06
         own9oVwhy890NC/6IPtgUhk+3KgOg2NRb7NusGHQQCyIUzZ1xEUyL9p4FdX+tu3ZUG
         cqq/eXO2HOW8g==
Received: by mail-ed1-f54.google.com with SMTP id n6so6764582edt.10;
        Fri, 22 Jan 2021 06:33:21 -0800 (PST)
X-Gm-Message-State: AOAM533v47YNWTnIjG91cMpBcqnJ77gkCGlUPmAaDWwMldFYwf0dxHcL
        GEXn+wsrtq1HkzHN0mohyU8x9jG1+2Rr1iN9/Q==
X-Google-Smtp-Source: ABdhPJyiGWu+Haib1SUyIoKfLUZdyEg7BDyYy2k0wtkK949TXAyLM01zcXdsjBnmtjRctBO9IxlreUujOfXnQgxU3mQ=
X-Received: by 2002:a50:fc04:: with SMTP id i4mr3464684edr.137.1611325999872;
 Fri, 22 Jan 2021 06:33:19 -0800 (PST)
MIME-Version: 1.0
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
 <1611198593-16287-3-git-send-email-peng.fan@nxp.com> <1611244918.545866.2814847.nullmailer@robh.at.kernel.org>
 <DB6PR0402MB27606B6ADC13EC6F889D9A9D88A00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB27606B6ADC13EC6F889D9A9D88A00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Jan 2021 08:33:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ1SJuBAP2917LrsXy=JG74-CmUzky0rMSoninDP=zOFQ@mail.gmail.com>
Message-ID: <CAL_JsqJ1SJuBAP2917LrsXy=JG74-CmUzky0rMSoninDP=zOFQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 21, 2021 at 6:55 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Rob,
>
> > Subject: Re: [PATCH V2 2/4] dt-bindings: mmc: fsl-imx-esdhc: add clock
> > bindings
> >
> > On Thu, 21 Jan 2021 11:09:51 +0800, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add clock bindings for fsl-imx-esdhc yaml
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml        | 11
> > +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
>
> Patch 3/4 addresses the dts, actually I think it is the dts not use correct
> clock order.

These errors are on the example.

Rob
