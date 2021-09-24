Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E682EC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 07:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9226124F
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 07:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244264AbhIXHKE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 03:10:04 -0400
Received: from muru.com ([72.249.23.125]:36798 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244191AbhIXHKB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Sep 2021 03:10:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E101580EE;
        Fri, 24 Sep 2021 07:08:56 +0000 (UTC)
Date:   Fri, 24 Sep 2021 10:08:27 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] mmc: sdhci-omap: Configure optional wakeirq
Message-ID: <YU15a0dSxZLfxpTN@atomide.com>
References: <20210921111600.24577-1-tony@atomide.com>
 <20210921111600.24577-6-tony@atomide.com>
 <eafa3743-1f73-8a6e-bcb4-d97405dcdb11@ti.com>
 <YUwRrHT2mTvf9GDi@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUwRrHT2mTvf9GDi@atomide.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [210923 05:34]:
> * Grygorii Strashko <grygorii.strashko@ti.com> [210922 15:23]:
> > > @@ -1360,6 +1363,21 @@ static int sdhci_omap_probe(struct platform_device *pdev)
> > >   	sdhci_omap_context_save(omap_host);
> > >   	omap_host->context_valid = 1;
> > > +	of_irq_get_byname(dev->of_node, "wakeup");
> > 
> > No assign to omap_host->wakeirq
> 
> Oops. Thanks for spotting it, will fix.

Ah I forgot that wlcore does not use the dat1 interrupt but has a separate
gpio interrupt for wake-up. And that's why grep wake /proc/interrupts was
increasing for me.. I'll ad a comment about that and will also test with
mwifiex_sdio device I have.

Regards,

Tony
