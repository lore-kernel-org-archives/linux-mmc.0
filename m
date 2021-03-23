Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A18C433C1
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 14:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B021619A9
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 14:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhCWONF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhCWOMr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2021 10:12:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE123C061764
        for <linux-mmc@vger.kernel.org>; Tue, 23 Mar 2021 07:12:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q29so26690897lfb.4
        for <linux-mmc@vger.kernel.org>; Tue, 23 Mar 2021 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l19bR+nFxXiu4GIfVq6f/m3LcDLqMDiNOa9Zpl4Ovvc=;
        b=K2WN6O0RNtylg2y5kj+7tUO3G3Ow+0lo/9Kbfq2doL0HIfUyReVmwWRdhF0uGNJ2OX
         Sf9sQUS2cU+99jYx7m3iFdK6k47YBGTOsnDBoiJD97coMPMO/lhH3U2sptWPOEIKO4H7
         YKr76EcmmC4dtIC8svew3hPv2dkrnaPY/Lq4EyGjEcvwN9FoVLvmOC/7dMwxApzKoebv
         SNkM+3naV4PXRdlZ/+86gfwzP06/2XLnnBDnSB/PWjL2e1cGIZAgoKHGTGQy8UxmfpbI
         qszWcnijbnse7HrTyooN+GkyEGYI6hkC3TXrEPzfmKXfvlr8EjllH/lgx+m5Xjj/4kQ9
         swaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l19bR+nFxXiu4GIfVq6f/m3LcDLqMDiNOa9Zpl4Ovvc=;
        b=D21D3YB5EDFKLOUaUQ5HQa9v5KSQkZAOKQ9no2zJEgOzn0DdARC7dYbAmwxz5l0L4q
         V8ISD5FjJ4zHyyNMvtcX2ojUHZ6bIinhdYiXi/1ESXCMk+/W+HlfLYm8eiPCqkGgsU57
         p+B2qh5YEjyBKmFK7dPgHZcWf3l/eYr3afGiFDcRklnBfWFooQXZoYcz9pguOiKs1yVw
         yz31ggVNCTG6xI+GsQ0AWAkD77WRk1EwWz2jX90Vl/j8mDBch4d+jL3IiT37Z6vlPoT9
         wdECSoM/Y9hi5oW621ndnnvUI4r3I+LsKB9MpWSD4dsKCjkS0ZetNX66JfH7ZCYSg0d5
         kZiA==
X-Gm-Message-State: AOAM530Vy4IF9tKS0pU+3TZ1vyyh+4aZvHdPiJkyIM7J9WeWCimActoe
        3IP8/s9FP/cUL09qjcRRkn50FKCWBTFYWwNPcuEGVw==
X-Google-Smtp-Source: ABdhPJzly95nqr4yJOsMgNbyvkzewf61fS24O2skNJrtHSN97B0AO6qNDxBBBfq6gMyuY4h8Z8m/nW9MARYn+j3bS1I=
X-Received: by 2002:a19:501b:: with SMTP id e27mr2822930lfb.584.1616508753810;
 Tue, 23 Mar 2021 07:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210315132501.441681-1-Jerome.Pouiller@silabs.com>
 <20210315132501.441681-9-Jerome.Pouiller@silabs.com> <CAPDyKFqJf=vUqpQg3suDCadKrFTkQWFTY_qp=+yDK=_Lu9gJGg@mail.gmail.com>
 <4503971.bAhddQ8uqO@pc-42>
In-Reply-To: <4503971.bAhddQ8uqO@pc-42>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Mar 2021 15:11:56 +0100
Message-ID: <CAPDyKFoXgV3m-rMKfjqRj91PNjOGaWg6odWG-EGdFKkL+dGWoA@mail.gmail.com>
Subject: Re: [PATCH v5 08/24] wfx: add bus_sdio.c
To:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Mar 2021 at 18:14, J=C3=A9r=C3=B4me Pouiller
<jerome.pouiller@silabs.com> wrote:
>
> Hello Ulf,
>
> On Monday 22 March 2021 13:20:35 CET Ulf Hansson wrote:
> > On Mon, 15 Mar 2021 at 14:25, Jerome Pouiller
> > <Jerome.Pouiller@silabs.com> wrote:
> > >
> > > From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> > >
> > > Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> > > ---
> > >  drivers/net/wireless/silabs/wfx/bus_sdio.c | 259 +++++++++++++++++++=
++
> > >  1 file changed, 259 insertions(+)
> > >  create mode 100644 drivers/net/wireless/silabs/wfx/bus_sdio.c
> >
> > [...]
> >
> > > +static const struct sdio_device_id wfx_sdio_ids[] =3D {
> > > +       { SDIO_DEVICE(SDIO_VENDOR_ID_SILABS, SDIO_DEVICE_ID_SILABS_WF=
200) },
> > > +       { },
> > > +};
> > > +MODULE_DEVICE_TABLE(sdio, wfx_sdio_ids);
> > > +
> > > +struct sdio_driver wfx_sdio_driver =3D {
> > > +       .name =3D "wfx-sdio",
> > > +       .id_table =3D wfx_sdio_ids,
> > > +       .probe =3D wfx_sdio_probe,
> > > +       .remove =3D wfx_sdio_remove,
> > > +       .drv =3D {
> > > +               .owner =3D THIS_MODULE,
> > > +               .of_match_table =3D wfx_sdio_of_match,
> >
> > It's not mandatory to support power management, like system
> > suspend/resume. However, as this looks like this is a driver for an
> > embedded SDIO device, you probably want this.
> >
> > If that is the case, please assign the dev_pm_ops here and implement
> > the ->suspend|resume() callbacks.
>
> I have no platform to test suspend/resume, so I have only a
> theoretical understanding of this subject.

I see.

>
> I understanding is that with the current implementation, the
> device will be powered off on suspend and then totally reset
> (including reloading of the firmware) on resume. I am wrong?

You are correct, for a *removable* SDIO card. In this case, the
mmc/sdio core will remove the corresponding SDIO card/device and its
corresponding SDIO func devices at system suspend. It will then be
redetected at system resume (and the SDIO func driver re-probed).

Although, as this is an embedded SDIO device, per definition it's not
a removable card (MMC_CAP_NONREMOVABLE should be set for the
corresponding mmc host), the SDIO card will stick around and instead
the ->suspend|resume() callback needs to be implemented for the SDIO
func driver.

>
> This behavior sounds correct to me. You would expect something
> more?

Yes, see above.

Kind regards
Uffe
