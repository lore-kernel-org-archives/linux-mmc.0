Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AEAC433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 13:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D28C64F4C
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 13:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbhCDNwU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 08:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbhCDNvx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 08:51:53 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8AC061763
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 05:51:10 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id w76so2337629vsw.10
        for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2021 05:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=S/geTw20p5B68cOXsZGd40rHnujdt48ezg4PHtsKNmg=;
        b=hVT2zPHnAAv7RWRP2/neTi5ZJiA86eP8gu7ETl+/12yqfrL+18Gr5WWM2IDQsOnJyy
         8U1LIZba3vqk3xdbPr0Dzs84cW6EFiKk9DlEb++QxiiVSN+PI+g5pbRiNHFzul7ecyzT
         T9N0vU4OQ1eD8+QsE8GBHp5xtcPMEslg69iLCGPMmTSVlG31WTo2UdXiN4cCwF1I4Lh8
         YbC7o1m6xBOxM6iNs6acvBamacjei15I2dV4sNKqNol48PzdmMC5vbtlMUZAKhxiLtCv
         4a72NlCJ9r6kPCSVyNnTyG2AumpJGwGU6diurVvxE47byEfUF3pHDFZq2O2eErk6oDhT
         H26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=S/geTw20p5B68cOXsZGd40rHnujdt48ezg4PHtsKNmg=;
        b=Qv4nNwkOYME4Bclf/rHr8h+N2JetJEPubENmBTPXGYOxJkGBXgqEvROvxgtn+BSrLf
         Yyjis0JEA8aXcEQyC5v+Sw3s+OK8Yj8IQ/MAwe8FcP2QLVo1spy+96v5WRs5KC/LPq/Q
         /5INXGFZGpCe+XUYdHMEvt/pMyXCQ1w5C1PjYK+g5u8G1hnTq0YHim7J/4CII4n60lsk
         KSIyO6PUqvnk2JWro1ibUVptC2i8fJUv1zX9+cNzpOSKeKjcSbBvQi9VeMy44bs4WTpG
         lkYB9WAUOcBge7Los5B+4EEH2Q6I87pgA8z3GlNF4SSkSBZqqf6CWWzbITL2toGO/BO6
         pcXw==
X-Gm-Message-State: AOAM532NX3+/JxsXiiVtJsBHrGCSHOQwEnbwvFoXpsn+pqWNFuxlZGeO
        atS9LBx/AlqedEz/XxdKppvme1mTlq/sA2ThWngOrQ==
X-Google-Smtp-Source: ABdhPJx5hMyeeS1L6mQiERbx+fONlsjxHasCwuB8sLR5b0RMei/ymoR3D/wTkyjHu9hVowx0atH7QDv0Eq7nv9/aL9c=
X-Received: by 2002:a05:6102:7b0:: with SMTP id x16mr535523vsg.34.1614865869628;
 Thu, 04 Mar 2021 05:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20210223100830.25125-1-wsa+renesas@sang-engineering.com>
 <20210223100830.25125-2-wsa+renesas@sang-engineering.com> <CAPDyKFrdxYNBeV4Fy_NJ+1JdF9OtHaxXmSdnvyepAPH4cxUs2A@mail.gmail.com>
 <20210304092931.GB967@kunai>
In-Reply-To: <20210304092931.GB967@kunai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Mar 2021 14:50:31 +0100
Message-ID: <CAPDyKFrBdCmrfkg37jedaN5uZ-hsJkuR9GBCzTNGHP-_kmFvag@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: support custom irq masks
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 Mar 2021 at 10:29, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > To be clear, I am awaiting a v2 of patch 2/2.
>
> Thanks for the heads up! Just sent.

V2 patch applied (could find the email in my inbox, but the patch was
picked up by the patchtracker, weird).

In any case, thanks and kind regards
Uffe
