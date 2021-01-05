Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B9FC433DB
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jan 2021 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D1F21BE5
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jan 2021 15:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbhAEPHp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbhAEPHp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jan 2021 10:07:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E857AC061574
        for <linux-mmc@vger.kernel.org>; Tue,  5 Jan 2021 07:07:04 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kwnvC-00026B-EC; Tue, 05 Jan 2021 16:06:54 +0100
Message-ID: <cd99776c0107833d69c9c7fc4c8d6ba1a41ea3d7.camel@pengutronix.de>
Subject: Re: sdhci timeout on imx8mq
From:   Lucas Stach <l.stach@pengutronix.de>
To:     BOUGH CHEN <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 05 Jan 2021 16:06:49 +0100
In-Reply-To: <VI1PR04MB52942233A0BA6BCB692F281E90670@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
         <20200205092653.GB2737@bogon.m.sigxcpu.org>
         <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
         <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
         <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
         <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
         <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
         <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
         <VI1PR04MB52942233A0BA6BCB692F281E90670@VI1PR04MB5294.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi all,

Am Mittwoch, dem 08.07.2020 um 01:32 +0000 schrieb BOUGH CHEN:
> > -----Original Message-----
> > From: Fabio Estevam [mailto:festevam@gmail.com]
> > Sent: 2020年7月7日 20:45
> > To: Angus Ainslie <angus@akkea.ca>
> > Cc: BOUGH CHEN <haibo.chen@nxp.com>; Ulf Hansson
> > <ulf.hansson@linaro.org>; Guido Günther <agx@sigxcpu.org>; linux-
> > mmc
> > <linux-mmc@vger.kernel.org>; Adrian Hunter
> > <adrian.hunter@intel.com>;
> > dl-linux-imx <linux-imx@nxp.com>; Sascha Hauer <
> > kernel@pengutronix.de>;
> > moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> > <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: sdhci timeout on imx8mq
> > 
> > Hi Angus,
> > 
> > On Tue, Jun 30, 2020 at 4:39 PM Angus Ainslie <angus@akkea.ca>
> > wrote:
> > 
> > > Has there been any progress with this. I'm getting this on about
> > > 50%
> > > of
> > 
> > Not from my side, sorry.
> > 
> > Bough,
> > 
> > Do you know why this problem affects the imx8mq-evk versions that
> > are
> > populated with the Micron eMMC and not the ones with Sandisk eMMC?
> 
> Hi Angus,
> 
> Can you show me the full fail log? I do not meet this issue on my
> side, besides, which kind of uboot do you use?

I was finally able to bisect this issue, which wasn't that much fun due
to the issue not being reproducible 100%. :/ Turns out that the issue
is even more interesting than I thought and likely doesn't have
anything to do with SDHCI or used bootloader versions. Here's my
current debugging state:

I've bisected the issue down to b04383b6a558 (clk: imx8mq: Define gates
for pll1/2 fixed dividers). The change itself looks fine to me, still
CC'ed Leonard for good measure.

In my testing the following partial revert fixes the issue:

--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -365,7 +365,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
        hws[IMX8MQ_SYS1_PLL_133M_CG] = imx_clk_hw_gate("sys1_pll_133m_cg", "sys1_pll_out", base + 0x30, 15);
        hws[IMX8MQ_SYS1_PLL_160M_CG] = imx_clk_hw_gate("sys1_pll_160m_cg", "sys1_pll_out", base + 0x30, 17);
        hws[IMX8MQ_SYS1_PLL_200M_CG] = imx_clk_hw_gate("sys1_pll_200m_cg", "sys1_pll_out", base + 0x30, 19);
-       hws[IMX8MQ_SYS1_PLL_266M_CG] = imx_clk_hw_gate("sys1_pll_266m_cg", "sys1_pll_out", base + 0x30, 21);
        hws[IMX8MQ_SYS1_PLL_400M_CG] = imx_clk_hw_gate("sys1_pll_400m_cg", "sys1_pll_out", base + 0x30, 23);
        hws[IMX8MQ_SYS1_PLL_800M_CG] = imx_clk_hw_gate("sys1_pll_800m_cg", "sys1_pll_out", base + 0x30, 25);
 
@@ -375,7 +375,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
        hws[IMX8MQ_SYS1_PLL_133M] = imx_clk_hw_fixed_factor("sys1_pll_133m", "sys1_pll_133m_cg", 1, 6);
        hws[IMX8MQ_SYS1_PLL_160M] = imx_clk_hw_fixed_factor("sys1_pll_160m", "sys1_pll_160m_cg", 1, 5);
        hws[IMX8MQ_SYS1_PLL_200M] = imx_clk_hw_fixed_factor("sys1_pll_200m", "sys1_pll_200m_cg", 1, 4);
-       hws[IMX8MQ_SYS1_PLL_266M] = imx_clk_hw_fixed_factor("sys1_pll_266m", "sys1_pll_266m_cg", 1, 3);
+       hws[IMX8MQ_SYS1_PLL_266M] = imx_clk_hw_fixed_factor("sys1_pll_266m", "sys1_pll_out", 1, 3);
        hws[IMX8MQ_SYS1_PLL_400M] = imx_clk_hw_fixed_factor("sys1_pll_400m", "sys1_pll_400m_cg", 1, 2);
        hws[IMX8MQ_SYS1_PLL_800M] = imx_clk_hw_fixed_factor("sys1_pll_800m", "sys1_pll_800m_cg", 1, 1);

The sys1_pll_266m is the parent of nand_usdhc_bus. I've validated that
the SDHCI driver properly enables this bus clock across the problematic
card access. So what I think is happening here is that both
nand_usdhc_bus and sys1_pll_266m are initially enabled. Sometime during
boot sys1_pll_266m gets disabled due to runtime PM on the enet_axi
clock, which is a direct child of sys1_pll_266m. At this point
nand_usdhc_bus is still enabled, but no consumer has claimed the clock
yet, so the parent clock gets disabled while this branch of the clock
tree is still active.

The reference manual states about this situation: "For any clock, its
source must be left on when it is kept on. Behavior is undefined if
this rule is violated."
And it seems this is exactly what's happening here: some kind of glitch
is introduced in the nand_usdhc_bus clock, which prevents the SDHCI
controller from working, even though the clock branch is properly
enabled later on. On my system the SDHCI timeout and following runtime
suspend/resume cycle on the nand_usdhc_bus clock seem to get it back
into a working state.

So I think we need some solution at the clock driver/framework level to
prevent shutting down parent clocks that have active branches, even if
those branches aren't claimed by a consumer (yet).

Regards,
Lucas

