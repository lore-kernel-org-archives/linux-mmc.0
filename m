Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A3C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD3B61001
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 08:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhEKIUF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 04:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhEKIUF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 04:20:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F639C061574
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 01:18:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lgNbR-0002sT-6E; Tue, 11 May 2021 10:18:53 +0200
Message-ID: <8b7ab5139fea41caf15b398ec975ed71229dfd5d.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode
 through MMC caps
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 11 May 2021 10:18:47 +0200
In-Reply-To: <VI1PR04MB5294AF754C68D41C844083A990539@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20210510190400.105162-1-l.stach@pengutronix.de>
         <20210510190400.105162-2-l.stach@pengutronix.de>
         <VI1PR04MB5294AF754C68D41C844083A990539@VI1PR04MB5294.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am Dienstag, dem 11.05.2021 um 03:00 +0000 schrieb Bough Chen:
> > -----Original Message-----
> > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > Sent: 2021年5月11日 3:04
> > To: Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunter
> > <adrian.hunter@intel.com>; Bough Chen <haibo.chen@nxp.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; dl-linux-imx <linux-imx@nxp.com>;
> > kernel@pengutronix.de; linux-mmc@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode through
> > MMC caps
> > 
> > Instead of having an indirection through the SDHCI layer and emulating a
> > capability bit, that isn't there in hardware, do the same same thing as
> with
> > HS400_ES and advertise the support for HS400 directly through the MMC
> caps.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index a20459744d21..65a52586db36 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -427,9 +427,6 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int
> > reg)
> >  					|
> FIELD_PREP(SDHCI_RETUNING_MODE_MASK,
> >  						     SDHCI_TUNING_MODE_3);
> > 
> > -			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> > -				val |= SDHCI_SUPPORT_HS400;
> > -
> >  			/*
> >  			 * Do not advertise faster UHS modes if there are no
> >  			 * pinctrl states for 100MHz/200MHz.
> > @@ -1603,7 +1600,7 @@ static int sdhci_esdhc_imx_probe(struct
> > platform_device *pdev)
> >  		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> > 
> >  	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> > -		host->quirks2 |= SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
> > +		host->mmc->caps2 |= MMC_CAP2_HS400;
> 
> Hi Lucas,
> 
> I think patch1 and patch 2 are enough to cover your requirement.
> For this patch, I think it's unnecessary, sdhci-esdhc-imx.c need to reuse
> sdhci.c as much as possible.
> In sdhci.c, already contain the following logic. 
> 
>          if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 &&
>              (host->caps1 & SDHCI_SUPPORT_HS400))
>                  mmc->caps2 |= MMC_CAP2_HS400;
> 
> The reason why we directly use host->mmc->caps2 for HS400ES mode is that
> sdhci.c do not contain the similar logic.

No, it's not enough. We call mmc_of_parse(), which clears the HS400
flags, before sdhci_setup_host() is called, which will then add the
HS400 flags again. So either I still need to evaluate the DT property
in the esdhc driver to make it return the right emulated SDHCI caps bit
for the HS400 case, or do it like in this patch.

While the way it is done here is a bit of a layering violation between
SDHCI and MMC, it still feels like the cleaner and more straight
forward solution.

Regards,
Lucas

