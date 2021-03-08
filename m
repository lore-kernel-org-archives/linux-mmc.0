Return-Path: <SRS0=Ubev=IG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1D3C433E9
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 00:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E6C650F8
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 00:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhCHAwW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 7 Mar 2021 19:52:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhCHAvw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 7 Mar 2021 19:51:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38A56650F8;
        Mon,  8 Mar 2021 00:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615164711;
        bh=1MGnQmu1b3U04ICK52m8O/d4JLHCpkWgIMSFMA+gp6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RE4rU4Ulk7Onj7JnwEzY4Yxz2+Aifjg4+5cyJntibiuIjrap7xt7HmWtHtxai9wOz
         Px41agLmJ68aiC5abovOPbYF7AMv6dD6qMudNjTaoH0J0Fif5fqi7PBv0CvlkfWjvw
         30OHAzD2iepyVO51hM2McAjmRkoigKZ4w8TdLpQfvR30wKGtAqyaBosYV4Fc0MofW1
         8pdsY3i+gMTwAquYanKv0KzYZaLOTIDHF395rkY1yqrmjGIzX3Udb1msds9jyuYgwP
         yoXfIWmlti1jQSKEilu1xFCZe5N1P1FF2dNGlQhfd+teldtA4LO/rd/tHj77VJEyW/
         i7XzgiWgZy0uQ==
Date:   Mon, 8 Mar 2021 08:51:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH V3 0/5] imx esdhc dt/driver update
Message-ID: <20210308005144.GN543@dragon>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
 <CAPDyKFq3J=Shzgxp8XsdZqdZcOZ-n5WJ+mWejXM1-Qp8PgjBNA@mail.gmail.com>
 <DB6PR0402MB276016438D7D39579A05D08A88989@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB276016438D7D39579A05D08A88989@DB6PR0402MB2760.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Mar 03, 2021 at 03:00:57AM +0000, Peng Fan (OSS) wrote:
> Hi Shawn,
> 
> > Subject: Re: [PATCH V3 0/5] imx esdhc dt/driver update
> > 
> > On Thu, 25 Feb 2021 at 04:22, <peng.fan@oss.nxp.com> wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V3:
> > >  Patch 1, drop unneeded pinctrl-0/1/2
> > >  Patch 2 is new to avoid break dt bindings check
> > > V2:
> > >  patch 1, 2, 3 is new
> > >  patch 4 is not changed
> > >
> > >
> > > Peng Fan (5):
> > >   dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
> > >   dt-bindings: clock: imx8qxp-lpcg: correct the example clock-names
> > >   arm64: dts: imx8qxp: correct usdhc clock-names sequence
> > >   dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
> > >   mmc: sdhci-esdhc-imx: validate pinctrl before use it
> > >
> > >  .../bindings/clock/imx8qxp-lpcg.yaml          |  6 +++---
> > >  .../bindings/mmc/fsl-imx-esdhc.yaml           | 20
> > +++++++++++++++++++
> > >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 18 ++++++++---------
> > >  drivers/mmc/host/sdhci-esdhc-imx.c            |  2 +-
> > >  4 files changed, 33 insertions(+), 13 deletions(-)
> > >
> > > --
> > > 2.30.0
> > >
> > 
> > Applied patch 1, 4 and 5, thanks!
> 
> 
> Would you pick patch 2,3?

Done.
