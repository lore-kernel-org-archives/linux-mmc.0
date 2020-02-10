Return-Path: <SRS0=yrVg=36=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79808C352A3
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 13:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515D620714
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Feb 2020 13:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VL6rdjHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbgBJNbK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:31:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44483 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgBJNbK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2020 08:31:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so7110713ljj.11
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2020 05:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jotdy8MFBLVhx1Sh9lfn9iHCiwkToMzUuUBAe2so+lM=;
        b=VL6rdjHRHzCp8VBr7goiOi5MhKhTfcPYXJQcCbnZeLe2fP9veCP9EKXyewD8u3Y+Pe
         ajyJtNKhro1mQqqCNn7I/9aTUVzH5VT4ZLKqiR5UN9u4NebAu1Rc0bEoCFAyamu0KQjq
         XEIKmTf/GwjXlqgbn2FRefV9eW+1FsBJmXnrwNPqixamGdt43l0XkSM+UnmiITNaKd2k
         fHDxA01+oUOK2+3agRGC4BTLfpBcMOqZ4ywjLtRs5K/hmHVIY/wyq6okmDTpb4kCgDkL
         yUe7IAxBYOire+h9NlZXJQpSv33M5ZvQXh1vpCz9sUjfaWn1PlplzfMya1rCoc4tDVk5
         s0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jotdy8MFBLVhx1Sh9lfn9iHCiwkToMzUuUBAe2so+lM=;
        b=WVtJWb3YpLAG8W1yBKgm8A99xzmdY3lKbZDoIk2PCYHM8+U+EAuDBAA5tn0OGOBS/d
         P7sjXiw5urXCfY6qADy3o+kDW+JOi8PL4gUtRTpQek1Ra5/zKAD9cF6PXRytt15YFLft
         bKR3qefNyoIqusHaoE/8Y70DTB+W0mblkMG5pu16Q81LUjjpwmwWV/NztInykOMs1iUj
         KoQBWiIaFyy7/o+cHgNvk0QCerh7D3zUsvz7mEE3ug9NgSK2nbgaCLkWLaIQMiaw60Ac
         ae3ll9gxJc11NxgQ4ZkBDRbvM3PgEI10Qofl7Em70l/Eh5/28cErTsYAhdX4QU/9PApa
         6XMw==
X-Gm-Message-State: APjAAAUOiWYijsDXW/pHIqSCZWI3BQR1sYd/J4pLWggbcXcEebejxA8I
        Q5Wr5i36QIVX+zgsEqzWUjyeg8RCoXsSjmd/q8ObsA==
X-Google-Smtp-Source: APXvYqyBXvK6kUbSK2mLVarJegPD8AMBRjYLzYqfh+0LYUo2Cw4HBlcLsNvGNg52Ip/JWYIpW+L1IgWoXAfYZ138zSk=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr877477ljo.99.1581341468264;
 Mon, 10 Feb 2020 05:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20191203130120.11511-1-haibo.chen@nxp.com> <20191203130120.11511-10-haibo.chen@nxp.com>
 <CACRpkdYN9rL9go68dyGgED0=atZMV7uAU3jfsT025e1NvB6brg@mail.gmail.com>
 <CACRpkdaU+KbKmKdB2bniGbG34qMD-EPbkBLG1x+ac24uzKrW9Q@mail.gmail.com> <VI1PR04MB5040F88333696C1C0DD64B2390190@VI1PR04MB5040.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5040F88333696C1C0DD64B2390190@VI1PR04MB5040.eurprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Feb 2020 14:30:57 +0100
Message-ID: <CACRpkdbHJ0mqG6fpo-TaqTKU3k+fd-SZNA8=Z0jq78qB1BYJvA@mail.gmail.com>
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

On Mon, Feb 10, 2020 at 4:08 AM BOUGH CHEN <haibo.chen@nxp.com> wrote:
> > On Wed, Dec 11, 2019 at 12:32 AM Linus Walleij <linus.walleij@linaro.org>
> > wrote:
> > > On Tue, Dec 3, 2019 at 1:54 PM BOUGH CHEN <haibo.chen@nxp.com>
> > wrote:
> > >
> > > > +- sdhci,auto-cmd23-broken: disable the ACMD23 function of USDHC.
> > > > +  This is required for eMMC on imx6qpdl/imx6sx/imx7d when it use
> > > > +ADMA mode. Because
> > > > +  for these SoC, it do not support the ACMD23 completely, only take
> > > > +the 16 bit block
> > > > +  count from the 0x4 register (BLK_ATT) as argument for the ACMD23,
> > > > +the upper 16 bit
> > > > +  of the CMD23's argument is ignored. This will impact the reliable
> > > > +write operation
> > > > +  and the RPMB block write operation, because these operations need
> > > > +to set the bit 31
> > > > +  of the CMD23's argument. SDMA mode will default disable the
> > > > +ACMD23 mode. SD card do
> > > > +  not has this limitation on these SoCs.
> > >
> > > This looks weird.
> > >
> > > Is the bug in the *host controller* or in *the card*?
> > >
> > > It looks like the card.
> >
> > After looking at the next patch it looks like the host controller.
> >
> > In that case the compatible-string should indicate what version of the IP you
> > are using and if it has this bug.
> >
> > No special flags needed for that.
>
> Hi Linus,
>
> Yes, this is host IP limitation. I did consider the method as you suggested,
>  use compatible-string to distinguish. But then I notice that this host limitation
> only impact the eMMC device for RPMB reliable write, for SD card, it do not
> support this mode, so this hardware limitation do not impact for sd card.
> This is why I use "sdhci,auto-cmd23-broken" in devicetree, only the emmc
> device need to contain this in dts file.
>
> I double check this issue, since this auto-cmd23 will not impact the sd
> performance, and it is the host IP limitation, I will chose to accept your
> suggestion, will send a new patch.

Should be fine, the code in the MMC core knows if what you are using
is an eMMC or an SD card so you can just handle the quirk only in the
eMMC case.

Yours,
Linus Walleij
