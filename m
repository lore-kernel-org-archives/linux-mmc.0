Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5BC433E6
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jan 2021 11:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33D723138
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Jan 2021 11:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbhAGL1l (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jan 2021 06:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbhAGL1l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jan 2021 06:27:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D6C0612F4
        for <linux-mmc@vger.kernel.org>; Thu,  7 Jan 2021 03:27:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kxTRN-0007ZP-1h; Thu, 07 Jan 2021 12:26:53 +0100
Message-ID: <f7e3cdd37d425d2df96112258dcaf0bc6565f3cf.camel@pengutronix.de>
Subject: Re: sdhci timeout on imx8mq
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Jacky Bai <ping.bai@nxp.com>, Fabio Estevam <festevam@gmail.com>
Cc:     Bough Chen <haibo.chen@nxp.com>, Angus Ainslie <angus@akkea.ca>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 07 Jan 2021 12:26:48 +0100
In-Reply-To: <DBBPR04MB79308EBA24C4FD6B1053C57E87AF0@DBBPR04MB7930.eurprd04.prod.outlook.com>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
         <20200205092653.GB2737@bogon.m.sigxcpu.org>
         <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
         <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
         <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
         <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
         <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
         <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
         <VI1PR04MB52942233A0BA6BCB692F281E90670@VI1PR04MB5294.eurprd04.prod.outlook.com>
         <cd99776c0107833d69c9c7fc4c8d6ba1a41ea3d7.camel@pengutronix.de>
         <CAOMZO5BzAw8CjvaOzH_Ynr2eapO1MViTOWN5yZ5i_BcAhv3tWA@mail.gmail.com>
         <DBBPR04MB79308EBA24C4FD6B1053C57E87AF0@DBBPR04MB7930.eurprd04.prod.outlook.com>
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

Hi Jacky,

Am Donnerstag, dem 07.01.2021 um 01:30 +0000 schrieb Jacky Bai:
> > -----Original Message-----
> > From: Fabio Estevam [mailto:festevam@gmail.com]
> > Sent: Thursday, January 7, 2021 2:57 AM
> > To: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Bough Chen <haibo.chen@nxp.com>; Angus Ainslie
> > <angus@akkea.ca>;
> > Leonard Crestez <leonard.crestez@nxp.com>; Peng Fan
> > <peng.fan@nxp.com>; Abel Vesa <abel.vesa@nxp.com>; Stephen Boyd
> > <sboyd@kernel.org>; Michael Turquette <mturquette@baylibre.com>;
> > Ulf
> > Hansson <ulf.hansson@linaro.org>; Guido Günther <agx@sigxcpu.org>;
> > linux-mmc <linux-mmc@vger.kernel.org>; Adrian Hunter
> > <adrian.hunter@intel.com>; dl-linux-imx <linux-imx@nxp.com>; Sascha
> > Hauer <kernel@pengutronix.de>; moderated list:ARM/FREESCALE IMX /
> > MXC
> > ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: sdhci timeout on imx8mq
> > 
> > Hi Lucas,
> > 
> > On Tue, Jan 5, 2021 at 12:06 PM Lucas Stach
> > <l.stach@pengutronix.de>
> > wrote:
> > 
> > > The reference manual states about this situation: "For any clock,
> > > its
> > > source must be left on when it is kept on. Behavior is undefined
> > > if
> > > this rule is violated."
> > > And it seems this is exactly what's happening here: some kind of
> > > glitch is introduced in the nand_usdhc_bus clock, which prevents
> > > the
> > > SDHCI controller from working, even though the clock branch is
> > > properly enabled later on. On my system the SDHCI timeout and
> > > following runtime suspend/resume cycle on the nand_usdhc_bus
> > > clock
> > > seem to get it back into a working state.
> > 
> > I think your analysis is correct and I recall helping a customer
> > with a similar
> > issue:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcomm
> > unity.nxp.com%2Ft5%2Fi-MX-Processors%2FExternal-clock-that-provide-
> > root
> > -clock-for-SAI3-and-SPDIF%2Fm-p%2F1019834&amp;data=04%7C01%7Cping
> > .bai%40nxp.com%7C8d250a158cce469c378308d8b274d6d1%7C686ea1d3bc
> > 2b4c6fa92cd99c5c301635%7C0%7C0%7C637455562183497049%7CUnknow
> > n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > WwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VkxuhmhDifzOxxfIgFz9PR5gKC1
> > SyQhGeSHYysX1Co4%3D&amp;reserved=0
> > 
> 
> For the customer case, it seem not the same issue. the customer issue
> is caused by clock source change while parent has no clock output.
> This is inherit limitation for the CCM clock slice when using the
> smart interface to change the clock parent.
> 
> For current mmc timeout issue, I think we can have a try with
> nand_usdhc_bus clock gated at the beginning of kernel boot, directly
> modify the nand_usdhc_bus
> Clock's HW register gate bit in clock-imx8mq.c.

While this might be an option to fix this specific issue, I would hope
we can come up with something more generic, as the current clock
framework behavior allows to violate the system specification
constraint that parent clocks must not be disabled when any of the
children are active. This seems like a fundamental issue and might hurt
us also with other clocks than this specific nand_usdhc_bus clock.

Can you tell us if there were other issues found with the PLL1/2 gating
patch? The fact that, according to Bough, it's reverted in your tree
seems to suggest this.

Regards,
Lucas

