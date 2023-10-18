Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A451CDB47E
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Oct 2023 14:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbjJROnH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjJROnG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Oct 2023 10:43:06 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435F895
        for <linux-mmc@vger.kernel.org>; Wed, 18 Oct 2023 07:43:04 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so7339070276.2
        for <linux-mmc@vger.kernel.org>; Wed, 18 Oct 2023 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697640183; x=1698244983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh2QEiDnS34zmNEFSBaaNP2eLRyObPDCd1MWKw/iCTA=;
        b=f/zilfsLJZ+shOpP2JCDaxM3NyHD0KpRL5xZfuXVxHA7WD4samye7oNHDMRE019Xg8
         6YFHD66jf7Q18Vl/VcvXVF9B3VaQTm+TydhcKIfODuU4RWnmPoWqePAQs3fLqxw3+XeN
         nRdZ17ZStLGe0GcIhgCj7pWRaUF4COVRkArWsdoiSuifkUHXlW/kh0g7OJGKz1wlWzDm
         V2xOwRTjb6ygxOMmrp+2YRdm1RYNe0cUia9v/UQT8DYPhdfyUNyT6E98Rg3gb7oFed/j
         XR8QyMqhoU4uEUWoUTxdEnyHa8ru5D9/n8YAhCr8Bs/rSDuPvt5o6bjqsyosi1gOjhAY
         ZT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697640183; x=1698244983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xh2QEiDnS34zmNEFSBaaNP2eLRyObPDCd1MWKw/iCTA=;
        b=HK30oD7GqaIRJiolY5/cJyS9OT0cFb68MVYDrf6U+o4uDyurc5W50OQqlv62ZlNtui
         Z74FIVLvvPTpjhUNZwrT7AxW1sjd/tQ0sKXjpVhVEzotp2QECz9af6t/8Llazh3oSB0Q
         3g5hYdFztsZz1yLoDQrquSP4+OnAjaWznSAUeDDfKtL7fW52PXTg4SHmSnbBBvEV608v
         9cU0ScGJmOWHIIGEGctZjgPN7+Hp85ByuF0J2zDhMSKmUoY1V4ljfF60tO8yEeYqW9Q1
         e9rHGb8tU1SKVZZbBJ6mj3GbRPjeTjUSN8nU8BGLh42OGck8lJzVAiDwqUCnSHEHPCXu
         dkPg==
X-Gm-Message-State: AOJu0Yx0kMSxRZEwDYFY3pXBaxdEQNGnDQ4ADi2pQNdY8F5/4Psjjk5P
        lg/Q3HtaWA8TulVHH590x+ZZsDEy1nZCIE+yKufERA==
X-Google-Smtp-Source: AGHT+IFbd+sELhG1n1BOqvqJWWgjiWbYh+P4dngW4k4JbYntUWvykZ1ZG82KQVZiguweE2ZOpc0FrHYicpECb3Ff4SM=
X-Received: by 2002:a5b:64d:0:b0:d99:f29f:371 with SMTP id o13-20020a5b064d000000b00d99f29f0371mr5057614ybq.4.1697640183380;
 Wed, 18 Oct 2023 07:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231017073129.1406748-1-haibo.chen@nxp.com> <CAPDyKFrffRvM51ZSzEffH9iHOWr7A0tu_e7aub7GiXdG49-iNA@mail.gmail.com>
 <DB7PR04MB40100BAA35662C888819E05590D5A@DB7PR04MB4010.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB40100BAA35662C888819E05590D5A@DB7PR04MB4010.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Oct 2023 16:42:27 +0200
Message-ID: <CAPDyKFpvvk_yiUWKfxTAWwsDvEG6PS8rSv6kpmE5emANzYe_AA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config the wakeup
 for gpio cd pin through sysfs
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Bough Chen <haibo.chen@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Oct 2023 at 04:07, Bough Chen <haibo.chen@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: 2023=E5=B9=B410=E6=9C=8817=E6=97=A5 19:35
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: adrian.hunter@intel.com; linux-mmc@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com
> > Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config the =
wakeup
> > for gpio cd pin through sysfs
> >
> > On Tue, 17 Oct 2023 at 09:26, <haibo.chen@nxp.com> wrote:
> > >
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > Currently default enable the gpio cd pin wakeup, this will waste powe=
r
> > > after system suspend if usr do not need this cd pin wakeup feature.
> > > Now let usr to config the wakeup for gpio cd pin through sysfs.
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > > ---
> > >  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > index 40a6e2f8145a..2e46648344ba 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > @@ -1797,9 +1797,12 @@ static int sdhci_esdhc_imx_probe(struct
> > platform_device *pdev)
> > >         /*
> > >          * Setup the wakeup capability here, let user to decide
> > >          * whether need to enable this wakeup through sysfs interface=
.
> > > +        * First check the SDIO device, second check the gpio CD pin.
> > >          */
> > > -       if ((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
> > > -                       (host->mmc->pm_caps &
> > MMC_PM_WAKE_SDIO_IRQ))
> > > +       if (((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
> > > +                       (host->mmc->pm_caps &
> > MMC_PM_WAKE_SDIO_IRQ)) ||
> > > +           ((host->mmc->caps & MMC_CAP_CD_WAKE) &&
> > > +                        host->mmc->slot.cd_irq >=3D 0))
> > >                 device_set_wakeup_capable(&pdev->dev, true);
> >
> > If the wakeup is GPIO based, it doesn't mean that the device is wakeup =
capable,
> > so this is wrong.
> >
> > In principle this must be managed through the GPIO irqchip driver inste=
ad.
>
> Yes, I know GPIO and USDHC are different device, combine GPIO wakeup to U=
SDHC is not that reasonable.
> I send this patch because I notice there is similar code in sdhci-pci-cor=
e.c, refer to sdhci_pci_suspend_host()
>
> Seems PCI subsystem combine GPIO wakeup to PCI controller.

Good point! I am not sure that is the correct way to do it either, but
maybe it's fine for PCI based devices. Adrian probably knows this
better.

The main problem I see with your approach, is that it may prevent a PM
domain (genpd), if the USDHC device is attached to one, from being
powered-off during system suspend. That would be wrong as the USDHC
device doesn't need to stay powered-on to allow a GPIO to be
configured as a system wakeup irq.

>
> Anyway, I will try to implement this in GPIO irqchip driver.

That sounds like the right thing to do.

Although, it does mean that we won't be able to allow userspace to
decide on a per GPIO pin/irq basis, if system wakeup should be enabled
or disabled. As far as I know, we don't have a solution in place to
support that.

[...]

Kind regards
Uffe
