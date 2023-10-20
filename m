Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD85CDB47E
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Oct 2023 10:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376891AbjJTKkg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Oct 2023 06:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376913AbjJTKkf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2023 06:40:35 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE9D53
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2023 03:40:33 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7d9d357faso6918517b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2023 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697798432; x=1698403232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMNuTR7dieohXmOCzMHRqu/tpDvJFgs9WxuSdI3vMRw=;
        b=UE8r/jhSyLmrM2+3LvGcZcRYO8KWgMNQuAFJyg8mpR1ejZHT87J8cQq7TEuTZIGWIX
         OVfLvTXXWI4jqff3wgNkobp5NdC7YI2iNKl9nQKEL0P24nY4Xf5kYYWusdNKqxTF3jVY
         BKRuGdImwLxjlZbyKOp1b8nuYRVT6QU9KK+WHb0WMZY5dPXLxDYz1ds57BFw9M49UYzc
         eC2Nu5cMxoEQ8eFBnt1CDoPYN1Fsr0wVroEb5I3qLg5C8viluzGf+u8GWsO6S11mUYU7
         E4gy0r/rHb95LarZhdrdjNYqPV8zWmpIJ1ZFqHLruDVNiWJKSEMTNDQtCvGtK9jN+Eie
         jasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697798432; x=1698403232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMNuTR7dieohXmOCzMHRqu/tpDvJFgs9WxuSdI3vMRw=;
        b=norbcsJSiuMsYPpQPSw+LwlTddrDrFeXrZkvf9yWzWjI7Ok9ZByftFDIcVCHZyVXO5
         GaTovEJXkLwR1sFSxO9B3Ep/NkK6cfAd914CbmYIpp8mw5JNbCY9mDbXF6tJLVkE+IVp
         PpA6KGWi5/YHApk7MGg8Hz3tEdrKNijKTBfc8BH7Ubf1bgZ7/i1rcLCJoYovp9SwJUqS
         pXlMXybte/NJXWHxv2DUfZ2noOih+hFe4lNCYMlbiUGGaNbdrgnHoTEe7FnNMcff+6KP
         /v8VuviaSANSMdjpG9+btF4l3r12DTGR5hGHYyCfLFcad1g4hyFyF0CFQ05dSI+ltnn+
         7XPA==
X-Gm-Message-State: AOJu0YwONTlJFqcuc/6ieeQ163JBBtH822EePhrdaB+gTf9CGWcmJs4k
        GThsWqCg/3UyTYqgV34qudi+26XH8dGmeCKd3H7dqg==
X-Google-Smtp-Source: AGHT+IFCVb773Y9hdTpouMK8xwLcrnQuuANGVrhnrAFOldrDNfHG/R0zuJc3VEIFdxSmMX11EAQtubsFhX4FkQHBhIw=
X-Received: by 2002:a25:3605:0:b0:d78:1502:9330 with SMTP id
 d5-20020a253605000000b00d7815029330mr1099199yba.7.1697798432605; Fri, 20 Oct
 2023 03:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231017073129.1406748-1-haibo.chen@nxp.com> <CAPDyKFrffRvM51ZSzEffH9iHOWr7A0tu_e7aub7GiXdG49-iNA@mail.gmail.com>
 <DB7PR04MB40100BAA35662C888819E05590D5A@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <CAPDyKFpvvk_yiUWKfxTAWwsDvEG6PS8rSv6kpmE5emANzYe_AA@mail.gmail.com>
 <4bcb3eb7-e204-4aef-bebc-575627d58127@intel.com> <CAPDyKFohqPexaKvsi091KqGj2WQYSQgx0Dr5g2x+bSZ2j71zHg@mail.gmail.com>
 <4bf5699e-c89c-455a-9e74-415509faf055@intel.com>
In-Reply-To: <4bf5699e-c89c-455a-9e74-415509faf055@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Oct 2023 12:39:56 +0200
Message-ID: <CAPDyKFoUtFiP_ZdiR3zvFx3+4yS4shN7TAzJrDNr76N5xhzJuQ@mail.gmail.com>
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

On Thu, 19 Oct 2023 at 18:59, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> On 19/10/23 18:24, Ulf Hansson wrote:
> > On Thu, 19 Oct 2023 at 16:48, Adrian Hunter <adrian.hunter@intel.com> w=
rote:
> >>
> >> On 18/10/23 17:42, Ulf Hansson wrote:
> >>> On Wed, 18 Oct 2023 at 04:07, Bough Chen <haibo.chen@nxp.com> wrote:
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
> >>>>> Sent: 2023=E5=B9=B410=E6=9C=8817=E6=97=A5 19:35
> >>>>> To: Bough Chen <haibo.chen@nxp.com>
> >>>>> Cc: adrian.hunter@intel.com; linux-mmc@vger.kernel.org; dl-linux-im=
x
> >>>>> <linux-imx@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de;
> >>>>> kernel@pengutronix.de; festevam@gmail.com
> >>>>> Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config =
the wakeup
> >>>>> for gpio cd pin through sysfs
> >>>>>
> >>>>> On Tue, 17 Oct 2023 at 09:26, <haibo.chen@nxp.com> wrote:
> >>>>>>
> >>>>>> From: Haibo Chen <haibo.chen@nxp.com>
> >>>>>>
> >>>>>> Currently default enable the gpio cd pin wakeup, this will waste p=
ower
> >>>>>> after system suspend if usr do not need this cd pin wakeup feature=
.
> >>>>>> Now let usr to config the wakeup for gpio cd pin through sysfs.
> >>>>>>
> >>>>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> >>>>>> ---
> >>>>>>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++----
> >>>>>>  1 file changed, 10 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> >>>>>> b/drivers/mmc/host/sdhci-esdhc-imx.c
> >>>>>> index 40a6e2f8145a..2e46648344ba 100644
> >>>>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> >>>>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> >>>>>> @@ -1797,9 +1797,12 @@ static int sdhci_esdhc_imx_probe(struct
> >>>>> platform_device *pdev)
> >>>>>>         /*
> >>>>>>          * Setup the wakeup capability here, let user to decide
> >>>>>>          * whether need to enable this wakeup through sysfs interf=
ace.
> >>>>>> +        * First check the SDIO device, second check the gpio CD p=
in.
> >>>>>>          */
> >>>>>> -       if ((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
> >>>>>> -                       (host->mmc->pm_caps &
> >>>>> MMC_PM_WAKE_SDIO_IRQ))
> >>>>>> +       if (((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
> >>>>>> +                       (host->mmc->pm_caps &
> >>>>> MMC_PM_WAKE_SDIO_IRQ)) ||
> >>>>>> +           ((host->mmc->caps & MMC_CAP_CD_WAKE) &&
> >>>>>> +                        host->mmc->slot.cd_irq >=3D 0))
> >>>>>>                 device_set_wakeup_capable(&pdev->dev, true);
> >>>>>
> >>>>> If the wakeup is GPIO based, it doesn't mean that the device is wak=
eup capable,
> >>>>> so this is wrong.
> >>>>>
> >>>>> In principle this must be managed through the GPIO irqchip driver i=
nstead.
> >>>>
> >>>> Yes, I know GPIO and USDHC are different device, combine GPIO wakeup=
 to USDHC is not that reasonable.
> >>>> I send this patch because I notice there is similar code in sdhci-pc=
i-core.c, refer to sdhci_pci_suspend_host()
> >>>>
> >>>> Seems PCI subsystem combine GPIO wakeup to PCI controller.
> >>>
> >>> Good point! I am not sure that is the correct way to do it either, bu=
t
> >>> maybe it's fine for PCI based devices. Adrian probably knows this
> >>> better.
> >>
> >> PCI / ACPI layers handle configuration of wakeup signaling, so a
> >> device will be put to the appropriate power state.  It won't be
> >> forced to be "on" by registering a wakeup source.
> >>
> >
> > Okay, I see.
> >
> > So you are saying that PCI bus/layers are aware of the GPIO pin/irq
> > being used for wakeup for the device in question?
>
> No, it is more like PCI / ACPI take care of most things but the
> wakeup framework provides sysfs wakeup API.  We can add that and
> use it to determine if wakeup is enabled (by the user) to then
> enable the CD GPIO IRQ wakeup.  That way, the sysfs wakeup API is
> on the correct device, and the user doesn't need to know anything
> about GPIO.
>

Okay, so it's really ACPI that is needed here too. Anyway, thanks for shari=
ng!

Kind regards
Uffe
