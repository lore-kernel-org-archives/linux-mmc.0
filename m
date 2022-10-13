Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595A7C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 14:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJMOCE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 10:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJMOCD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 10:02:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1A92701
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 07:01:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 70so2052357pjo.4
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EcdlK7Vr/NBxA2l1p86K0/Xpr5oeds229RhFU2676lM=;
        b=Z1/OTmQTgg5MeW7bFHC7ch+cisfd5L/kG4vLHsHa+J2XbdVcGLSLbPdVD7aU+GTOWy
         9IIBF2hecp4l1I1H3ZOM8c2eauZB0IxTf66Wamhv3bnvjunJlhdMPMGg7+ImKG7cy+lp
         naI4cZeaos+x949bSLDuxEdRJXVpOY90RDQXZAMZ0ek6ql5BgcNMH0C29zRP6mim/XRv
         k6edvFlARO/3MFXTeEcFb4uxgf92VLSy45D/o1AlEo3IAkkbDsheQcr8yPIvWpbWXmpM
         +QiO6jjcpjbTBxjI+BvLXWKMhvIsBezvjCn3M8ZMPmLEMk09l8NWKU3cZ7GT8UH4ksPG
         NqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcdlK7Vr/NBxA2l1p86K0/Xpr5oeds229RhFU2676lM=;
        b=fANT7GMNe0Cixzl1HWTmDTZuFEU53z2sUr7yuzw67H8ex8PjJgkno16uQv+QWlkbo5
         HYTsPaGpc1HZ83dDw8CS0gkyoXJx64U5TU1yGbqEsMqFBq0Vy5mp5EIAy1YOvhJfPPIS
         LwPCgrH+mg7z3HquqMyVfkwK6xTETTwPOeic0uYt6LWPfVljGfM/K8FdGn0PvUlr1EHD
         ULyWpyKaRoJVAKclLWopa3YCcMaKxjTF+NWglOYrQ1PZEEccAPW7p1+JUJ/X9VOUSDw2
         rM5O59hfdCslmJl7RJMj+R2s/IqXl0+3IohLnRHEIcFxiDzMhfCk8Wd52P6VCEztu5SF
         F0yA==
X-Gm-Message-State: ACrzQf2aH0u6fiDnHQ+PxbD+IUhYGRB5edd6ndVw/9pf+vVGvAtvxO/6
        ICv0tNHlR6bVzYpFs7JgvZOZdYa8skvl4dHNhgAQIA==
X-Google-Smtp-Source: AMsMyM7YlOYDM85JmxAy9tj6ehh+qlCTrMlQaBt9+S+9SzzxnYa0Fpc2f2gjt68nTOWdRF8mgGhJf7g+FbchCfLCr0Q=
X-Received: by 2002:a17:90a:7b8c:b0:20b:1f3b:f6fd with SMTP id
 z12-20020a17090a7b8c00b0020b1f3bf6fdmr34293pjc.202.1665669560510; Thu, 13 Oct
 2022 06:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221013093248.2220802-1-s.hauer@pengutronix.de> <20221013094451.GH6702@pengutronix.de>
In-Reply-To: <20221013094451.GH6702@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Oct 2022 15:58:44 +0200
Message-ID: <CAPDyKFpYDSS04bbWC4AKv-O+tEwdeqWNWrENGo-j2nWOcaQWzw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on
 8bit bus
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Oct 2022 at 11:44, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Thu, Oct 13, 2022 at 11:32:48AM +0200, Sascha Hauer wrote:
> > The core issues the warning "drop HS400 support since no 8-bit bus" when
> > one of the ESDHC_FLAG_HS400* flags is set on a non 8bit capable host. To
> > avoid this warning set these flags only on hosts that actually can do
> > 8bit, i.e. have bus-width = <8> set in the device tree.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
>
> Forgot to pass --notes to git send email, so adding this here:
>
> An alternative approach would be to just lower the warning message
> to debug level. In the end it's nice from the core to take the load
> from the drivers, if only the core wouldn't complain about it.

So I don't recall why we picked the warning level, but maybe the idea
was that it should become clear that it's the wrong configuration.

On the other hand, that works well with the debug level too. So, why
not do both $subject patch and what you propose here?

Kind regards
Uffe
