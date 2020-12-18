Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5783DC4361B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 20:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE42123602
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 20:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgLRUI2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Dec 2020 15:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgLRUI2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2020 15:08:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18DDC0617A7
        for <linux-mmc@vger.kernel.org>; Fri, 18 Dec 2020 12:07:47 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kqM2N-0004xR-LC; Fri, 18 Dec 2020 21:07:39 +0100
Message-ID: <4a1fb9fa69d6fdb0ec2d7c390112d412d512ff13.camel@pengutronix.de>
Subject: Re: sdhci timeout on imx8mq
From:   Lucas Stach <l.stach@pengutronix.de>
To:     BOUGH CHEN <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Angus Ainslie <angus@akkea.ca>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 18 Dec 2020 21:07:34 +0100
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
> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: 2020年7月7日 20:45
> To: Angus Ainslie <angus@akkea.ca>
> Cc: BOUGH CHEN <haibo.chen@nxp.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; Guido Günther <agx@sigxcpu.org>; linux-mmc
> <linux-mmc@vger.kernel.org>; Adrian Hunter <adrian.hunter@intel.com>;
> dl-linux-imx <linux-imx@nxp.com>; Sascha Hauer
> <kernel@pengutronix.de>;
> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>
> Subject: Re: sdhci timeout on imx8mq
> 
> Hi Angus,
> 
> On Tue, Jun 30, 2020 at 4:39 PM Angus Ainslie <angus@akkea.ca> wrote:
> 
> > Has there been any progress with this. I'm getting this on about
> > 50%
> > of
> 
> Not from my side, sorry.
> 
> Bough,
> 
> Do you know why this problem affects the imx8mq-evk versions that are
> populated with the Micron eMMC and not the ones with Sandisk eMMC?

Hi Angus,

Can you show me the full fail log? I do not meet this issue on my side,
besides, which kind of uboot do you use?

Has there been any progress on this issue? I'm now hitting this on a
system that just upgraded from 5.4 to 5.10. Has anyone tried bisecting
this issue, yet?

Regards,
Lucas

