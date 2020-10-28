Return-Path: <SRS0=bNNl=ED=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDA2C388F7
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC9E20809
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yC8WWjjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390645AbgJ1Xnl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgJ1Xnf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Oct 2020 19:43:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257E7C0613CF
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2020 16:43:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x13so772582pfa.9
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2020 16:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SykzTHz0ZlidYUY+GXokJpRJME3UYCjAcmomBUmvyeI=;
        b=yC8WWjjXitSynpDjKu9UivOX9XdUXJa5A2kRFsqPZ+SiaHPHAk+PATIzZGvoy7hlti
         ZdcksSb3GRXaqQIIxBDJG/0WqxI0iiN/I5vEwYGMM3aQUbYKE+ysGmw2PM+Zf3YCglTC
         D4wCG+HO9Lk8e8vo5ZXpno/FxAAKDLhjfpxzVs9exkRYjywhpncsVUfJlRymMBmBwLNM
         m+CsTsA/tbE0j9diBwvim1GA7BM/1a/cOaeyB2l4HICs3qa6dB3A/UXGyO3Dpom3WKpP
         XBHd6lBcUTe1p9L6d9t7xdtWVYNvrGfibyEJb/RObT1uNUg9zUerTUxeKx2n63pUijIP
         5KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SykzTHz0ZlidYUY+GXokJpRJME3UYCjAcmomBUmvyeI=;
        b=h2ywOJfU0gHrBdZ3Oj7MTfQX7XmkXGUXqvVxzXJ6Xw/JhfLZEoYD5xoNIksczJFIbi
         gMXmumYhsaxZF3LE3x7J9pvS8uCcYnAkiJn3Ek8i6a3K9MLtrsRMh+/V0vq4a6dmwe7x
         xVBd8gSkZIIAOmtEhBbG/j+GYTD2cOIKvHwfUJhYHLm8TbDA6GdBSi7+Rb8SeKZcw5nX
         1mmkXh63lXt5CcEmTf+n6Vl5Fx5XYUWGalQqTWuiT6s9IZITb2TfdoMUPELx6Whp5c4L
         zEMYm24ZOUfzjeZc2OArVQt7hx1jGf5Rkyb+Wm+dRYpvtPxvFylm0gcYoz1clroLjwQZ
         ADSA==
X-Gm-Message-State: AOAM530Yhq4wW8XQmJ1n3HyIGRQsgnjYznYTlGm3ynqJiitXgvE82YgP
        NwzvcCcg+TrmwACxNM6R9QWPfY+GppFSp1zClUCT4y33/EzMRA==
X-Google-Smtp-Source: ABdhPJxlnZQQ5ls3dUZYu52Jl4gaW/3t+e9M73GYeTdd92rwIL9k+Pz90OVvFdCGZK0YSbh/hjc1WP3TsUInD+pvlIQ=
X-Received: by 2002:a1f:1c2:: with SMTP id 185mr4344263vkb.15.1603880498622;
 Wed, 28 Oct 2020 03:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201020081116.20918-1-yangbo.lu@nxp.com> <CAPDyKFoOPmqPhk7+-kNo6WQejS-GFPvbJcap3fXeJknb6spWiA@mail.gmail.com>
 <AM7PR04MB68858DD7249012E2B53E365FF8170@AM7PR04MB6885.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB68858DD7249012E2B53E365FF8170@AM7PR04MB6885.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 28 Oct 2020 11:21:02 +0100
Message-ID: <CAPDyKFrgcobAo_Qmt_aoSfmYErj=r3emb4_zwVSUnhMcFJnTLg@mail.gmail.com>
Subject: Re: [v3] mmc: sdhci-of-esdhc: make sure delay chain locked for HS400
To:     "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Oct 2020 at 09:56, Y.b. Lu <yangbo.lu@nxp.com> wrote:
>
> Hi Uffe,
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Tuesday, October 27, 2020 9:42 PM
> > To: Y.b. Lu <yangbo.lu@nxp.com>
> > Cc: linux-mmc@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>
> > Subject: Re: [v3] mmc: sdhci-of-esdhc: make sure delay chain locked for HS400
> >
> > On Tue, 20 Oct 2020 at 10:20, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> > >
> > > For eMMC HS400 mode initialization, the DLL reset is a required step
> > > if DLL is enabled to use previously, like in bootloader.
> > > This step has not been documented in reference manual, but the RM will
> > > be fixed sooner or later.
> > >
> > > This patch is to add the step of DLL reset, and make sure delay chain
> > > locked for HS400.
> > >
> > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> >
> > Applied for next (please tell if you think this deserves to be tagged
> > for stable), thanks!
>
> Thanks!
> Please help to tag for stable. The latest u-boot just supporting eSDHC HS400, may cause kernel HS400 issue without this patch.

I have added a stable and a fixes tag. Additionally I have moved the
patch to my fixes branch.

Please have a look in my git to make sure it looks good to you.

[...]

Kind regards
Uffe
