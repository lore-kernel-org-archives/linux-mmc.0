Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F26C6369E
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 15:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C540E246A7
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Nov 2020 15:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgKSPZm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:25:42 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42677 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbgKSPZk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2020 10:25:40 -0500
Received: by mail-ej1-f66.google.com with SMTP id i19so8440226ejx.9;
        Thu, 19 Nov 2020 07:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53Ib4MVNcSYI7Sm3hk9ijjliTiATLndMv+xGH2Zi+q0=;
        b=gRdfn6TAPnE6oRjaA0VCtt1lWShB0drGy1hKSFNfRzLkuU9jFW7FD5c3nLW/QWEZ72
         Hb5QX9JSg/FP+yOdwurq06l1cCBrcmVOLlAG1JxMuVrzKlUtLEDegVJOAwlE9Cbymqsv
         aQH/j8ll3X1I05OXlvyqkIpwEfzmoji2QiTdOFUTy0eXRXTtjMHe8HtXbYJK7K5QCprN
         RNPKbvYFa6bVHCH70j5UoP2HkQez3nTfg+AgVFeEsW5/QpgpuB2SecnujgBLz06LHsw3
         xCHvljFk9JrY3xYj6lKapAMP3Syq3rxnqkTPOBfY6/xffSC/VxZeOWjWALxHVPHiw40B
         sCAg==
X-Gm-Message-State: AOAM530+hsTgJUXz1wZyoRsZItoto+Ouwn3AuDq0lJ2BNWLRqCq9p2Kp
        785Ab5JrIBHK3DVDDi9K4bg=
X-Google-Smtp-Source: ABdhPJwQfcWVPFQNON5fFqUPKyPw2ecw2T4FlU2pU52NuwlBAifSnlVnbF0vjV/v0Fb0XJAjgCgYaA==
X-Received: by 2002:a17:907:2076:: with SMTP id qp22mr12063515ejb.436.1605799538060;
        Thu, 19 Nov 2020 07:25:38 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id q9sm14768573ejr.115.2020.11.19.07.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:25:37 -0800 (PST)
Date:   Thu, 19 Nov 2020 16:25:35 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: imx: fix the wrongly dropped
 imx8qm compatible string
Message-ID: <20201119152535.GA386850@kozik-lap>
References: <20201119125304.1279-1-aisheng.dong@nxp.com>
 <20201119131720.GA348129@kozik-lap>
 <AM6PR04MB49666B9100F4CE87E1AE23D680E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR04MB49666B9100F4CE87E1AE23D680E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 19, 2020 at 03:21:59PM +0000, Aisheng Dong wrote:
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: Thursday, November 19, 2020 9:17 PM
> > 
> > On Thu, Nov 19, 2020 at 08:53:02PM +0800, Dong Aisheng wrote:
> > > The compatible string "fsl,imx8qm-usdhc" was wrongly dropped in patch:
> > > 80fd350b9590 ("dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible
> > > matching") Add it back.
> > 
> > Although the compatible was dropped, by why wrongly? Please describe it.
> > The compatible is nowhere to be found, it is not used.
> 
> The DT patch using it is still under review. So we need it.

It looks like other patches here follow similar process of sending
and applying dt-bindings separately from patches with users of these
bindings. Please don't do it like this. Send the bindings as the first
patch in the series implementing the users (so usually the series with
driver and DTS changes). The new bindings then are applied by the
driver subsystem maintainer.

Best regards,
Krzysztof

