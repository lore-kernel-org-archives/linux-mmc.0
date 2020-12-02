Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1EEC64E7B
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384F2208FE
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 17:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgLBRkH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 12:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgLBRkH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 12:40:07 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6F1C0613D4
        for <linux-mmc@vger.kernel.org>; Wed,  2 Dec 2020 09:39:21 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id i199so2012661qke.5
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2020 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HGDDLpBXGNMg0LMolwGSeuNTRKQu3sxPBzrkwGCeCV8=;
        b=CRYaomH7zz71puhu+kMqSSkTSmpZpb22SXX5agzTtcAHK1XuFkv+sNcPwRLDiwl2iM
         DfK1bjPEBfr0ijAj6unk6UgTBqtmzcb03mc4FIaY+nY90iBKR9TvdydueKinRTsGXL9n
         Utg8gB+vKZI0s4mrOkISQRbWqcwoXQl4QmShDUcMqFD9wl4B8rhSrpXkBHcOWBn9qHSJ
         M4AO+sMAjut7KO1iiZfzbTCSArhL3+Z/Uuxx6SmE+LWoJiKlvgS0GoD6Yl0pQuCz9cKP
         dx82Gho0fL5FYiIqfMSe1/yMkq4KIBIFSpdgfkdtJRKMalxCmsiyPimVr/wvIrtr/VPc
         VPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HGDDLpBXGNMg0LMolwGSeuNTRKQu3sxPBzrkwGCeCV8=;
        b=P39IFX8GvHKLbI9zl8SiAaPU3zcyN865w1VGa+YwaqCCRmaxPTdLC1jGehM1Mz1Vk9
         SCfih+qrNIipvbbwkoPn+vQoVLxFUUI8R8K0fV/mMhOEf3N6KPyXI6kj955EZKAFCFRI
         ePoxdl/z0yXnV+OJlNRGx6Kg01Djf5zVdvcJu7t4hJaMsxQxtfoHt+vbQ66HdsLWXZrh
         CVSeNwS7uEFZPS3ujJg8Ps0eLt8zA7mB8Qm94xd9Fmk5bPtDPOhHHDD9sIsn94y+ZbF9
         DL80KtTj8BrhMbw++Km1rsQh7EXi0Q/139wJ0YNKZe2Kn0UFqt1F4aor1EdCTT3VAZCF
         v8bQ==
X-Gm-Message-State: AOAM531nnYrMaxVGnMR+8Vf4ns5LRTjtmIIrRPR5fpaTC6i0mb0rBtcF
        YuTrCbeOFdJMJtWHhyFjvBxsbcGXqTwYLB7Sm/eSaw==
X-Google-Smtp-Source: ABdhPJwJ5CP3xL/u9S7A6l5zYggC8BATzFrYqGlpBxtoUWCKus+HAwcGQ++rLe76lb1hP8z3tEnbzJDsjMi1CtyP/aE=
X-Received: by 2002:a37:4acb:: with SMTP id x194mr3593249qka.295.1606930760481;
 Wed, 02 Dec 2020 09:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20201120032639.24386-1-mw@semihalf.com> <5b5a1367-2632-2754-bc8b-7d57d0205232@intel.com>
In-Reply-To: <5b5a1367-2632-2754-bc8b-7d57d0205232@intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 2 Dec 2020 18:39:09 +0100
Message-ID: <CAPv3WKeQ27kUDE8Z4c7BWKBBX_CJRJe-t2TmHJ1ArTXX2V_PKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] sdhci-xenon ACPI support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Ziji Hu <huziji@marvell.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

=C5=9Br., 2 gru 2020 o 09:30 Adrian Hunter <adrian.hunter@intel.com> napisa=
=C5=82(a):
>
> On 20/11/20 5:26 am, Marcin Wojtas wrote:
> > Hi,
> >
> > The second version of the sdhci-xenon ACPI support
> > is now split into 4 patches instead of a single one.
> > There are minor functional differencse - match_data
> > introduction and using dedicated ACPI ID per
> > controller variant.
> >
> > The MacchiatoBin firmware for testing can be obtained from:
> > https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp
> >
> > Changelog:
> > v1->v2
> >   * Split single commit to 4
> >   * Use device_match_data and dedicated ACPI ID's per controller
> >     variant
> >
> > Marcin Wojtas (4):
> >   mmc: sdhci-xenon: use match data for controllers variants
> >   mmc: sdhci-xenon: switch to device_* API
> >   mmc: sdhci-xenon: use clk only with DT
> >   mmc: sdhci-xenon: introduce ACPI support
> >
> >  drivers/mmc/host/sdhci-xenon.h     |  12 +-
> >  drivers/mmc/host/sdhci-xenon-phy.c |  40 ++++---
> >  drivers/mmc/host/sdhci-xenon.c     | 120 +++++++++++++-------
> >  3 files changed, 110 insertions(+), 62 deletions(-)
> >
>
> Not withstanding Ulf's comments:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you, I will push v3 right away.

Best regards,
Marcin
