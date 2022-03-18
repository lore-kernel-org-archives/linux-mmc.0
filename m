Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE22C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Mar 2022 16:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiCRQGu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbiCRQGD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2022 12:06:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2F02C5EEB
        for <linux-mmc@vger.kernel.org>; Fri, 18 Mar 2022 09:04:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e16so619466lfc.13
        for <linux-mmc@vger.kernel.org>; Fri, 18 Mar 2022 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h9XApkTh3yQbDDhq/6o67U0IGlirspPaXa+h4Gwx90c=;
        b=Vor22BPyexcx+h6sp1SlZ+tF3gOqx4KPkyueUA1s4+LW7NL1ZhDA4oQHD7/xctnbG+
         ybJwiISlYTdrlsvreHvZxugizERaCpLfbEM6D+CDGPt4A0IBPy9FkrJlRd+HLvG9gwr6
         enw1Hc21PozvR4LftkA5Wx8DA7Yj7/rcSq3M09tejc5PPBw+Af3wX1AFVfgxFxmAMEko
         fbvB1OMSz5HW8MYt39LuhR0D2qRb+9ZTg8s3LmMXTuyivSJgbMfdDrkVOCCM98nK5dWC
         bxAd+2nvu22ZljSzouMGSiZ2d8xjzi+/57hZ5C0s9PBlZ0Ed3HsiqsG3HMXczfEsOcSx
         YM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h9XApkTh3yQbDDhq/6o67U0IGlirspPaXa+h4Gwx90c=;
        b=f4G9o6uHK/0twoyxvUZkXvg8VCNhrlVe4m0J24TWMABCZ6HBfA1thQbrY0k9byD98Q
         VS1Se7CsgwwpMqfcombC9q+kwky8TlRnDmg7P+9VAm/xN70WnoppUdfo+lzCkbWZEPxf
         HbzNp0r0U7xS/meSo4XasilRGucY2ispynK82cCtJuF0vT+HhkLIwBI6v5EEWiWJxPCj
         +i4lgU+EYz/rGx64S/RrhVDbb8kA+ZsQfV+MopIVFTp8b3C5wyvQr142W0jdOPZmzA+r
         8yd/3fgEm2LKTNKUPPIHBaLJMec3z+4k1F759JW+XUyART04YrCYAMG1eqaCxvYURzs1
         GUqA==
X-Gm-Message-State: AOAM5301yhgQ9Ajy1A5yeAL8Cc/SArlwshIn0Gj9qTTgpNGbkGo+6+MZ
        DDty1wOzacV+rQ3Nh0P2JIketoiEpjxzkv21JywpPQ==
X-Google-Smtp-Source: ABdhPJwxiK2YtfW7+H8OsuaWT5qsZaqMMTiHG2hIzD78hqXDB+ih4mNtdsQeWAtRPQqaL0H8y5tmvEsK28wLNs0jF/s=
X-Received: by 2002:a05:6512:690:b0:449:fb6b:cf74 with SMTP id
 t16-20020a056512069000b00449fb6bcf74mr4698589lfe.209.1647619441897; Fri, 18
 Mar 2022 09:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220318141441.32329-1-pali@kernel.org> <20220318161744.5814b7d7@dellmb>
In-Reply-To: <20220318161744.5814b7d7@dellmb>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 18 Mar 2022 17:03:50 +0100
Message-ID: <CAPv3WKcrbDpcLkft2ybhMo336DmvFkoAOOQRa81-htHSZBKOfg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: sdhci-xenon: fix annoying 1.8V regulator warning"
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Konstantin Porotchkin <kostap@marvell.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

pt., 18 mar 2022 o 16:17 Marek Beh=C3=BAn <kabel@kernel.org> napisa=C5=82(a=
):
>
> On Fri, 18 Mar 2022 15:14:41 +0100
> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> > This reverts commit bb32e1987bc55ce1db400faf47d85891da3c9b9f.
> >
> > Commit 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v regulator stabilizatio=
n")
> > contains proper fix for the issue described in commit bb32e1987bc5 ("mm=
c:
> > sdhci-xenon: fix annoying 1.8V regulator warning").
> >
> > Fixes: 8d876bf472db ("mmc: sdhci-xenon: wait 5ms after set 1.8V signal =
enable")
> > Cc: stable@vger.kernel.org # 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v =
regulator stabilization")
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

I tested the patch in my setup, so you can add my:
Reviewed-by: Marcin Wojtas <mw@semihalf.com>

Thanks,
Marcin
