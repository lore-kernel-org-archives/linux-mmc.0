Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22744ECAAD5
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Aug 2022 14:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiH2OXt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Aug 2022 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiH2OXr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2022 10:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CC896FE3
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 07:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9DD760FC1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 14:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE428C433D7;
        Mon, 29 Aug 2022 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661783017;
        bh=44zwQLhmVAx8XQIP4k+OY6eBr7ArSxuMTxjXKOEzXV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StQA3f4H9zV1pyOECNo1hi7KLQrLGd3w+AnrIPaQjg4kw1Qd3gaI0/nxunpTjGLUY
         sMra3fF3Z2KL7Ntke8L+yieyhAjRBxUn9sFt9DruJajjoV6zZKmkMUXHzlK15gFfSe
         ljQtVGhR3OXXRfr/aH8sC5OH+QFtdss4q4NwwDZ/dbwlK9vRK4YUV8nVdFU870Cl1h
         QSaQqQmwtMMLdmBJn75cfLFI3ZcHAg/m5n91mYnqIBbyjYkX6l10Pwh/6OZZk7Ki1s
         OfRwdekIH11Ik/CjPvGJ1CTo4fbcQ1h2WqEny8apfhWgImsbGLsQ5eLGDZYRGuT6L7
         ozeYHMS5to7bQ==
Date:   Mon, 29 Aug 2022 22:14:23 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Drew Fustini <pdp7pdp7@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-mmc@vger.kernel.org
Subject: Re: Designware MSHC: dw_mmc versus sdhci-of-dwcmshc?
Message-ID: <YwzJvxbGUcgpeD4u@xhacker>
References: <Ywp5dA3iQLZu/+2d@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ywp5dA3iQLZu/+2d@x1>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Aug 27, 2022 at 01:07:16PM -0700, Drew Fustini wrote:
> Hello, I am bringing up Linux on an SoC which has Synopsys "DesignWare

Hi Drew,

> Cores Mobile Storage Host Controller (Cryptographic)" IP configured to
> support an eMMC 5.0 device (IS21ES08G) on the bring-up board. I am
> trying to figure out why there are two seemingly similar drivers,
> dw_mmc and sdhci-of-dwmshc, in drivers/mmc/host for Synopsys
> DesignWare host controller IP. I am hoping someone might be able to
> give me some insight into the history of these drivers.

Generally speaking, dw_mmc isn't sdhci compatible while the
sdhci-of-dwmshc is sdhci compatible. Those two are for two different
controllers.

Regards
> 
> I have found the following:
> 
> - dw_mmc.c is a "DW Multimedia Card Interface driver"
> - created back in 2011 with f95f3850f7a9 ("mmc: dw_mmc: Add Synopsys
> DesignWare mmc host driver.")
> - CONFIG_MMC_DW  refers to it as "Synopsys DesignWare Memory Card
> Interface" with description of "Synopsys DesignWare Mobile Storage IP
> block, this provides host support for SD and MMC interfaces, in both
> PIO, internal DMA mode and external DMA mode"
> - "snps,dw-mshc" compatible supported in dw_mmc-pltfm.c and
> synopsys-dw-mshc.yaml binding refers to it as "Synopsys Designware
> Mobile Storage Host Controller"
> 
> - sdhci-of-dwcmshc.c is a "SDHCI platform driver for Synopsys DWC MSHC"
> - created more recently in 2018 with e438cf49b305 ("mmc:
> sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
> - CONFIG_MMC_SDHCI_OF_DWCMSHC refers to it as "SDHCI OF support for
> the Synopsys DWC MSHC" with description of "Synopsys DesignWare Cores
> Mobile Storage Controller support."
> - the driver supports "snps,dwcmshc-sdhci" compatible and the
> snps,dwcmshc-sdhci.yaml binding describes it as "Synopsys Designware
> Mobile Storage Host Controller"
> 
> I would greatly appreciate any advice anyone may have on which driver
> might be the best fit.
> 
> Thank you,
> Drew
