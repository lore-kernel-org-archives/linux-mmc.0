Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C771C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 11:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9EA61007
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 11:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhEKL4B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 07:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhEKL4A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 07:56:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D49C061574
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 04:54:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lgQyM-0006g1-F2; Tue, 11 May 2021 13:54:46 +0200
Message-ID: <0aa51fabade743fbaac70a149a771f37e7d05165.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] mmc: core: add support for disabling HS400 mode
 via DT
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 11 May 2021 13:54:33 +0200
In-Reply-To: <CAPDyKFrAe-+CENhXkY2fGNw04g-zn+ebcAXSVGa9Td5pJcsujA@mail.gmail.com>
References: <20210510190400.105162-1-l.stach@pengutronix.de>
         <20210510190400.105162-3-l.stach@pengutronix.de>
         <CAPDyKFrAe-+CENhXkY2fGNw04g-zn+ebcAXSVGa9Td5pJcsujA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

Am Dienstag, dem 11.05.2021 um 13:14 +0200 schrieb Ulf Hansson:
> + Chris Ruehl
> 
> On Mon, 10 May 2021 at 21:04, Lucas Stach <l.stach@pengutronix.de> wrote:
> > 
> > From: Lucas Stach <dev@lynxeye.de>
> > 
> > On some boards the data strobe line isn't wired up, rendering HS400
> > support broken, even if both the controller and the eMMC claim to
> > support it. Allow to disable HS400 mode via DT.
> 
> Before I review the series, I just wanted to highlight that quite
> recently we got a related series posted from Chris [1]. I made some
> comments, but he hasn't replied yet.
> 
> In any case, if I understood it correctly, it looks like some
> controllers may support HS400 ES, but not HS200. Could that be the
> case here as well? Or is this a different problem?
> 
> 
That's not the issue I'm trying to solve here. HS400 modes, whether ES
nor not, require the data strobe line to work. ES mode just defines how
this line is used. I know for a fact that the board I'm dealing with
here, just hasn't wired up this line between the SoC and the eMMC. Thus
HS400 modes fail to work, even though both controller and eMMC support
this mode.

When HS400 is disabled, like in this series, communication falls back
to HS200 mode and works fine this way.

Regards,
Lucas

> Kind regards
> Uffe
> 
> [1]
> https://patchwork.kernel.org/project/linux-mmc/patch/20201208061839.21163-7-chris.ruehl@gtsys.com.hk/
> 
> > 
> > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > ---
> > v2:
> > - move to core
> > - actually disable all HS400 modes
> > ---
> >  drivers/mmc/core/host.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 9b89a91b6b47..0e066c5f5243 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -351,6 +351,9 @@ int mmc_of_parse(struct mmc_host *host)
> >                 host->caps2 |= MMC_CAP2_NO_SD;
> >         if (device_property_read_bool(dev, "no-mmc"))
> >                 host->caps2 |= MMC_CAP2_NO_MMC;
> > +       if (device_property_read_bool(dev, "no-mmc-hs400"))
> > +               host->caps2 &= ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V |
> > +                                MMC_CAP2_HS400_ES);
> > 
> >         /* Must be after "non-removable" check */
> >         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
> > --
> > 2.31.1
> > 


