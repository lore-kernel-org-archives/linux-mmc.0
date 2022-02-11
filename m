Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C9EC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Feb 2022 12:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350357AbiBKMxd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Feb 2022 07:53:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiBKMxd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Feb 2022 07:53:33 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9E8E5E
        for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2022 04:53:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k13so16312162lfg.9
        for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2022 04:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HeUXG/zAHXDhKnRgHynhqcN3oTgfihFwSnaqKBQhHAY=;
        b=hJsVC6/8BOKl9j0kcNoT+u3oj69fku4ThvVdDApzZNeN0VsguxOaXUtxMWrzTN/4iy
         Zkw9YNFUubF6wbjLQCCIGxKNZJlN56D03cmgLPz8PmIhkbild7zc6FIZ4Fg7uChhFCSm
         Pwtlsa/ciT+IwwIBcybwQw96AqVKAliyRVcAdsSVdQL5oFXsX81/B1DYEsD5yEodl0jV
         DZtjbrZYW7KFS7ZgClSDkKP8BSnagPNrRpLwNmYDwd/hf7kM6kqprA9wGWTcTN2L2H87
         2GkU0aMyPpgDJw3A6carTLEeEmfe5o2u4HaSKjyrOwhKppWtvp2VYs7bJm1zyoMxbf8L
         1z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HeUXG/zAHXDhKnRgHynhqcN3oTgfihFwSnaqKBQhHAY=;
        b=CAMLdLFvga+CM6E8LkNiopc4aWRUhpZU5YK+pDzY2xHIVo+cQrOGEZiDR12ojKrqDb
         5WIQgNeYfYUGBHiLvmjVS7JhbdSg55tb7wPhkc550Ny251ObnDOZW7fZjGfdVR2Wf6qI
         YfCC/KHgy1GejcQkiNZfjf6I5LG0PvwQ1Z/jJoqbKH5pOpwjOajbkoX2EYURi2SkteJW
         ujm79DJSnklPj33xnjLJxQsb1mdBjacWd5Dc2UqWuKOiIXX8tK5oM4S3n8NI31FlABNR
         iimMgIbPA190jAtZAY7FpUZZblV9w9QVP3MsDNtMYr7wyxs8C/X955fc9r4t5G3w96i1
         fTwQ==
X-Gm-Message-State: AOAM530Qja7IawpbLPFb1f8TR2B8ZEnpao83dK9zf7DsTl6hxZ1vZ9Qe
        xk6rqk3iWpyGqNIhd9b+YMfAZF1hevlB5na3DslFuw==
X-Google-Smtp-Source: ABdhPJydaTxnrzMaWAYDCxiukFYx4B5EuZnJYoUhf1LLpPRdkKI8SwjczRNFDSCvL8NTM3YLYjWlmY4Z5Mb90aCl2Wg=
X-Received: by 2002:a05:6512:3b9a:: with SMTP id g26mr1130306lfv.71.1644584010394;
 Fri, 11 Feb 2022 04:53:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644398657.git.tonyhuang.sunplus@gmail.com>
 <f8b89f9981e17c023ce530afedb1f2b599edec0f.1644398657.git.tonyhuang.sunplus@gmail.com>
 <YgQQ2nJa12xblXBX@robh.at.kernel.org> <40d202104eec46d2a35445e0128a124f@sphcmbx02.sunplus.com.tw>
In-Reply-To: <40d202104eec46d2a35445e0128a124f@sphcmbx02.sunplus.com.tw>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Feb 2022 13:52:54 +0100
Message-ID: <CAPDyKFqPcpVr-JZF-9-4Jxq9fbsVbLYsh8TjEJffRfueczq=uQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
To:     =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>,
        Rob Herring <robh@kernel.org>
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?UTF-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 10 Feb 2022 at 09:56, Tony Huang =E9=BB=83=E6=87=B7=E5=8E=9A <tony.=
huang@sunplus.com> wrote:
>
> Dear Robh:
>
> > Subject: Re: [PATCH v3 1/2] dt-binding: mmc: Add mmc yaml file for Sunp=
lus
> > SP7021
> >
> > On Wed, Feb 09, 2022 at 06:41:06PM +0800, Tony Huang wrote:
> > > Add mmc yaml file for Sunplus SP7021
> > >
> > > Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> > > ---
> > > Changes in v3:
> > >  - combine sdcard and eMMC into one driver.
> > >
> > >  .../devicetree/bindings/mmc/sunplus-mmc.yaml       | 76
> > ++++++++++++++++++++++
> > >  MAINTAINERS                                        |  6 ++
> > >  2 files changed, 82 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> > > b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> > > new file mode 100644
> > > index 0000000..8f44d13
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> > > @@ -0,0 +1,76 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # Copyrigh=
t
> > > +(C) Sunplus Ltd. Co. 2021 %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mmc/sunplus-mmc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: sunplus MMC controller
> > > +
> > > +allOf:
> > > +  - $ref: "mmc-controller.yaml"
> > > +
> > > +maintainers:
> > > +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> > > +  - Li-hao Kuo <lhjeff911@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - sunplus,sp7021-emmc
> > > +      - sunplus,sp7021-sdhci
> >
> > Why are these still different? Looking at the driver, it seems the sett=
ings are
> > the same for both. And for clock speeds, we have properties to control =
them as
> > they can be board specific.
> >
>
> The register base address of emmc and sd card are different.
> eMMC and sdcard are individual hardware settings

When I looked at the previous version of the driver(s) that was
posted, I got the impression that you have some registers in the
controller that are specific for eMMC, SD or SDIO.

So, depending on how the controller is going to be used (for eMMC, SD
or SDIO) it's needs to be configured differently. Right?

If I got this right, I think you can instead use the existing common
DT properties, "no-sd", "no-sdio", "no-mmc" to explain how each
controller is configured.

Does this make sense to you?

Kind regards
Uffe
