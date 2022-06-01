Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2748CC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jun 2022 14:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355184AbiFAO07 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jun 2022 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355620AbiFAO0n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 10:26:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1262ACD0
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 07:20:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id g12so2174460lja.3
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qDPxqxtAnqx70yomMz4iKcG/suKMrIdMG5mPCftR2g=;
        b=gVFN2d29Ob2IsoQslrcbptF3svKScdiHyFPmNr10CFxhknhNn7gqwsCr9mypdHMeuG
         I7gk65CFQNFA2oKopvqa13ri4A88g45f4vVdOURoytvhrtLUr9CcFjTCUiQugHnnOXiX
         1jOT8/raJcsgiLpvcIgBcyfQdYnhYIoFsUlynR1Cm5PJGCFH8ubju+VXnv+qmsEJ41uz
         nRA+RsZVOyGUxogebV8INdIHtxPZrKXyGasyf9ReRz6j850wBTV6UhXNjlxn7RYN70N/
         ahpY3ajNR6s6gcsLlhKnHBHSwtFNLicEaHdRprD/mwMZ8dQV35aorV1pkxL10dFefyNR
         NCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qDPxqxtAnqx70yomMz4iKcG/suKMrIdMG5mPCftR2g=;
        b=hqlB3uUY4XiuRKpRBF/lFjdhDWo0o4m5K9rG5rDCqat9ikDjjjkXxlLhxLDWUuAacI
         Buyz+INkPp3J2ccBDfQ6D2n5tooH9ci+4jbnKc/p5iRYfVHxCax3mgyIkuPiKawL2rw3
         PVaE4JBuEFD+7NIFuX6gpd4kHApI5rFjMR0VaQRYLQDy5iSMjh0x0B9qQefmrpAnKPRc
         qFmr000MWEvD5dhYbWeiNlyXG5ZZaaMDKmHzkZLOz/LE2Wn5vHGrZFnBaFmhYRQ0JMrD
         z0FmD4DXdiqMjswmK4y27qAOs26VpLvoC3R7iRsbGCuIAUFjYde0L45yfP753OYh30s7
         9UlQ==
X-Gm-Message-State: AOAM532p6E54CapQcrSqk0VIVrf/htyIqgMSTz/NSz2cC9fvT7UyWl3i
        p35pFMfjMIOrvW9Bq8nlRI8++bdxb66aW6vpLvjzgA==
X-Google-Smtp-Source: ABdhPJyHLe+8u5VYlCGJLP8Qc+G0asgDycWaaA6EZ0mEacenGngsM1+d36udkKA5adI89ZmSgyxTW2xZap3Rb49TyUQ=
X-Received: by 2002:a2e:9e54:0:b0:250:d6c8:c2a6 with SMTP id
 g20-20020a2e9e54000000b00250d6c8c2a6mr40310597ljk.16.1654093250356; Wed, 01
 Jun 2022 07:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220526014204.2873107-1-robh@kernel.org> <CAPDyKFoh5FyRDxr22XnkOd76MG4YjkvqL039=+qHGZKwfdFquw@mail.gmail.com>
 <20220601140429.GA3909718-robh@kernel.org>
In-Reply-To: <20220601140429.GA3909718-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 16:20:14 +0200
Message-ID: <CAPDyKFoDfBCFrdvDunCm4a2v_A=UzVMJvHyNN6XAdjjQ=gzkvg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Fix unevaluatedProperties warnings in examples
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hu Ziji <huziji@marvell.com>, Al Cooper <alcooperx@gmail.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 1 Jun 2022 at 16:04, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 01, 2022 at 02:46:21PM +0200, Ulf Hansson wrote:
> > On Thu, 26 May 2022 at 03:42, Rob Herring <robh@kernel.org> wrote:
> > >
> > > The 'unevaluatedProperties' schema checks is not fully working and doesn't
> > > catch some cases where there's a $ref to another schema. A fix is pending,
> > > but results in new warnings in examples. Fix the warnings by removing
> > > spurious properties or adding a missing property to the schema.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Queued for v5.20 on the devel branch, thanks!
>
> Can you take for 5.19 instead so I can enable this in dtschema sooner
> rather than later?

Sure! I have moved the patch to the fixes branch now.

Kind regards
Uffe
