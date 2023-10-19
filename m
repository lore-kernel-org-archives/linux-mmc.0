Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E11CDB465
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Oct 2023 15:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbjJSPZE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Oct 2023 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345812AbjJSPZE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Oct 2023 11:25:04 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7A3130
        for <linux-mmc@vger.kernel.org>; Thu, 19 Oct 2023 08:25:02 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso8664567276.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Oct 2023 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697729101; x=1698333901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0buMkfbImwDhjEEhhEcpSZPwrn6a3RUt3SYysg4KMY=;
        b=jK24YkYCRg5WF8hjudveTGkKQ5jHHGH3NFlWTQUiAVSA8txbI8MkmvasHErnjAj6ac
         8bLrJs0fspWEMMbquHPUE9MLB+caBHa6tAh2NYc+2c8bmlMMfoXSrIOrQ1+AZAtR0D2s
         3jItMbDyPcDutLRNbq7kVE7iezqN8Sd1o1ziLVMN5Oas7R+9GWVE5gvfCnDh58ZsM41o
         a8sB4Xxjh92M0Cy2VE6g2BVMvUoMP7eREoaP7ywgjoA6gEBxux/Z9isnTmUiz63WOfns
         dRHyDHTZP2oIHbHV6hKuBhhq99K1friwcCv1iPRAJh1DJdexBzVfMHLeGz3lxoPM5+Nv
         9auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729101; x=1698333901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0buMkfbImwDhjEEhhEcpSZPwrn6a3RUt3SYysg4KMY=;
        b=Rt1fkP+jQ/XHynrl/XRNLwWEann50hjeEE6iH9xJqgxDapWACarF0uRy/l7GD0pq5r
         mv8VVXePnPHX0iWNxTMr60UZu6SPqquweE8IBUJafIxR59XaCjR6gamFp2MXelbpkPpC
         8rKk3UHmax3BEwkG9EBTaSrnxjtQlAghphzTVSrQSLhGszRdxOKQsoQoV5uasXhWo9sD
         5QJE/ZDXR7twM0+kDHjawkG7o/dVSOsLPH/r1iyHukadXP7Plh7BhDYj3pwHXuXSxyp8
         1wwyrj2xK2FBG1x1ic3RbYseG4JH/1oUoCASjRHC//9mvJZFp0TwVGpPAJAkqdjLrmGr
         9Z5Q==
X-Gm-Message-State: AOJu0YyYS8FFwdew1rBiakc45xpAidr8HU/t/5Ox2I1mNxUgYZcv6emn
        DYjMzxNrbza2jB4hzPq8aE2Ml2cz+sDNiN3WUhWj1UJUnn0gqumK
X-Google-Smtp-Source: AGHT+IEc4vGn2qfg/YO3kT0l8l8eGQvvpiHydx09ICOepaeMg9SY53SNyzXgCMTLgcWQkqLWW7R4viaEy8TFjSvwi/o=
X-Received: by 2002:a25:e057:0:b0:d9a:4b0f:402b with SMTP id
 x84-20020a25e057000000b00d9a4b0f402bmr2693340ybg.38.1697729101261; Thu, 19
 Oct 2023 08:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231017073129.1406748-1-haibo.chen@nxp.com> <CAPDyKFrffRvM51ZSzEffH9iHOWr7A0tu_e7aub7GiXdG49-iNA@mail.gmail.com>
 <DB7PR04MB40100BAA35662C888819E05590D5A@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <CAPDyKFpvvk_yiUWKfxTAWwsDvEG6PS8rSv6kpmE5emANzYe_AA@mail.gmail.com> <4bcb3eb7-e204-4aef-bebc-575627d58127@intel.com>
In-Reply-To: <4bcb3eb7-e204-4aef-bebc-575627d58127@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 17:24:24 +0200
Message-ID: <CAPDyKFohqPexaKvsi091KqGj2WQYSQgx0Dr5g2x+bSZ2j71zHg@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config the wakeup
 for gpio cd pin through sysfs
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Bough Chen <haibo.chen@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
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

On Thu, 19 Oct 2023 at 16:48, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> On 18/10/23 17:42, Ulf Hansson wrote:
> > On Wed, 18 Oct 2023 at 04:07, Bough Chen <haibo.chen@nxp.com> wrote:
> >>
> >>> -----Original Message-----
> >>> From: Ulf Hansson <ulf.hansson@linaro.org>
> >>> Sent: 2023=E5=B9=B410=E6=9C=8817=E6=97=A5 19:35
> >>> To: Bough Chen <haibo.chen@nxp.com>
> >>> Cc: adrian.hunter@intel.com; linux-mmc@vger.kernel.org; dl-linux-imx
> >>> <linux-imx@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de;
> >>> kernel@pengutronix.de; festevam@gmail.com
> >>> Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config th=
e wakeup
> >>> for gpio cd pin through sysfs
> >>>
> >>> On Tue, 17 Oct 2023 at 09:26, <haibo.chen@nxp.com> wrote:
> >>>>
> >>>> From: Haibo Chen <haibo.chen@nxp.com>
> >>>>
> >>>> Currently default enable the gpio cd pin wakeup, this will waste pow=
er
> >>>> after system suspend if usr do not need this cd pin wakeup feature.
> >>>> Now let usr to config the wakeup for gpio cd pin through sysfs.
> >>>>
> >>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> >>>> ---
> >>>>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++----
> >>>>  1 file changed, 10 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> >>>> b/drivers/mmc/host/sdhci-esdhc-imx.c
> >>>> index 40a6e2f8145a..2e46648344ba 100644
> >>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> >>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> >>>> @@ -1797,9 +1797,12 @@ static int sdhci_esdhc_imx_probe(struct
> >>> platform_device *pdev)
> >>>>         /*
> >>>>          * Setup the wakeup capability here, let user to decide
> >>>>          * whether need to enable this wakeup through sysfs interfac=
e.
> >>>> +        * First check the SDIO device, second check the gpio CD pin=
.
> >>>>          */
> >>>> -       if ((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
> >>>> -                       (host->mmc->pm_caps &
> >>> MMC_PM_WAKE_SDIO_IRQ))
> >>>> +       if (((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
> >>>> +                       (host->mmc->pm_caps &
> >>> MMC_PM_WAKE_SDIO_IRQ)) ||
> >>>> +           ((host->mmc->caps & MMC_CAP_CD_WAKE) &&
> >>>> +                        host->mmc->slot.cd_irq >=3D 0))
> >>>>                 device_set_wakeup_capable(&pdev->dev, true);
> >>>
> >>> If the wakeup is GPIO based, it doesn't mean that the device is wakeu=
p capable,
> >>> so this is wrong.
> >>>
> >>> In principle this must be managed through the GPIO irqchip driver ins=
tead.
> >>
> >> Yes, I know GPIO and USDHC are different device, combine GPIO wakeup t=
o USDHC is not that reasonable.
> >> I send this patch because I notice there is similar code in sdhci-pci-=
core.c, refer to sdhci_pci_suspend_host()
> >>
> >> Seems PCI subsystem combine GPIO wakeup to PCI controller.
> >
> > Good point! I am not sure that is the correct way to do it either, but
> > maybe it's fine for PCI based devices. Adrian probably knows this
> > better.
>
> PCI / ACPI layers handle configuration of wakeup signaling, so a
> device will be put to the appropriate power state.  It won't be
> forced to be "on" by registering a wakeup source.
>

Okay, I see.

So you are saying that PCI bus/layers are aware of the GPIO pin/irq
being used for wakeup for the device in question?

Kind regards
Uffe
