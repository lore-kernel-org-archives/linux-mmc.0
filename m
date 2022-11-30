Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29795C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 13:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiK3NAS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 08:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiK3NAP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 08:00:15 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32105429B1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 05:00:15 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o12so7784149pjo.4
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 05:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vfEQmYFQW/ZK1X243P+JumNV7jJwB1rBZ2w+PSJzG80=;
        b=GAE4WIcOP35rEimrp1m+/bNCfENdbYEVgCB4sFV3rqcJekdK2G8b+CVSj4uCjuic/0
         155DwTFIf+Qu5Mb7h0K+KiZnlqzEmk45fXGA2ZwBBrsDZxfEapUZCcnVbZpuCwB1iHMN
         r51iWVdl1SNEkJ8AuuSaslmp1qfCAyrgtSxFnSZSCsoGe8vOKpkucTPWv+aYPMy6VpWy
         S2PuXRMeOH8C2VkM/SG6Uvzz5cplTEtvlU3/JPhwU3cmqbHk0JzseJfJeZK7yzOtP60G
         koRFP1Qv7+wnbdRiU2WGkGLaG5OBGe80ABdGMj2Lb7nh4xVOhN/Aaxh11fs1++3U4d2f
         OFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfEQmYFQW/ZK1X243P+JumNV7jJwB1rBZ2w+PSJzG80=;
        b=xqAG00BrZJ+p1RTwps5AcBLbNeNU1rPYDwG8tUQsTJJffDXWwiGLfXmqo706fClsOy
         APjGhT0PC+8Gh/XRON6P1rUqVzeoImINMyOpHOQn019gSYQR3+48r8/IJUH+kIVRDA4t
         C6dpl9oayVoFkRDk/EGZmpoc45X5FKcqtxoadc1hS/gWBN0F5IE/BHGl8e8nRCsZgnJF
         f3cwjyrtb2wyzn3frfLPqL38OnoLgmL7RkydZnknacjYWaFQWuVl3ypppXdlwUjZ7ZzT
         4+QuJ2Tl8C3g8E+UpV+5HG9o4r47EiUIOXBbYjiIcNtMALqhz0MLIDBUZMAfpGPLWiM9
         zu7w==
X-Gm-Message-State: ANoB5pkXAGRahRuHs28IoaEgNRGYCVBQsqL+MULSO2azz9CVA/Byr8Mx
        UA1ZOYbhiRKdzRqeDdA3aO1P9ZUPydHSrc5EY28=
X-Google-Smtp-Source: AA0mqf6ZZSJG4WwutWIAfv7epfa2F8VDZxfYvaKFFyaVGmdonRMfI8jD7HrGVE9rQl42EoeX2d3eukZyu7b5lscWsXQ=
X-Received: by 2002:a17:902:9307:b0:189:9284:2140 with SMTP id
 bc7-20020a170902930700b0018992842140mr11908090plb.111.1669813214689; Wed, 30
 Nov 2022 05:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20221128133259.38305-1-adrian.hunter@intel.com>
 <20221128133259.38305-3-adrian.hunter@intel.com> <b040b2b2-10c2-5414-1c8f-fd02fc3b300e@gmail.com>
 <1acb9b87-088c-06f8-a2de-63b3054c55bc@intel.com>
In-Reply-To: <1acb9b87-088c-06f8-a2de-63b3054c55bc@intel.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 30 Nov 2022 14:00:03 +0100
Message-ID: <CAOX2RU54TPBowXdbJMc-x+eO8XhKjREn9R0zwv9thya3kyCP-g@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Nov 2022 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 30/11/22 13:54, Robert Marko wrote:
> >
> > On 28. 11. 2022. 14:32, Adrian Hunter wrote:
> >> Avoid re-configuring UHS and preset settings when the settings have not
> >> changed, irrespective of whether the clock is turning on.
> >>
> >> Tested-by: Haibo Chen <haibo.chen@nxp.com>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> > Hi, this is breaking sdhci-msm on IPQ8074 in next-20221130 for me
> > and reverting it makes the eMMC work again.
> >
> > I get a lot of:
> >
> > [    2.727287] mmc0: tuning execution failed: -5
> > [    2.727323] mmc0: error -5 whilst initialising MMC card
> > [    3.846540] mmc0: tuning execution failed: -5
> > [    3.846564] mmc0: error -5 whilst initialising MMC card
> > [    4.966517] mmc0: tuning execution failed: -5
> > [    4.966539] mmc0: error -5 whilst initialising MMC card
> > [    6.096486] mmc0: tuning execution failed: -5
> > [    6.096508] mmc0: error -5 whilst initialising MMC card
> > [    7.206431] mmc0: tuning execution failed: -5
> > [    7.206454] mmc0: error -5 whilst initialising MMC card
>
> Thanks for the report!  Are you able to debug this any more?
> What transfer mode is it? e.g. HS400?  Can you enable debug
> messages and get more information?

With some guidance yes, it's in HS200 as there is an issue with HS400
to HS200 switch on this SoC so I have HS400 disabled.

With CONFIG_MMC_DEBUG and loglevel=8 I dont have any new
messages.

Regards,
Robert
>
