Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06710C18E5B
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C722D20736
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bfb5vvyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCQL7O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:59:14 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33799 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgCQL7O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2020 07:59:14 -0400
Received: by mail-vs1-f67.google.com with SMTP id t10so13639342vsp.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2020 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=//nkJUOqKK9I9JAKOxrGmWsdECFuBDzQRPdFg3EsiQg=;
        b=Bfb5vvyW8Um6QbFHf9848zR/18cgLJjMO0L87YBO9GKGqJwf10dftAbgEho2opGx08
         7obGXQ1qe6mBHhIoHhF6jRht1KOqrxoGMr/z3cAs0/1QyQCTSGk6cDolrLcqwbs+I5SP
         lLerm3aKZQ0kF5AeH2GVSQQFym8fztGih20fzvmsedWJsyXHtJ46cH0svzAjGS3RFORJ
         p9l8Wm1tL/PWwQkrJwhmoxF7IyzbBUaqexr0FWZbQIyAvCmCug9ldI3R8hFj1//VSowR
         YOg+acFUEN1fnkRXSR5HAC9631JvDr5kD3BcQpmaaeoTHo52qQq87TnWcGlT00W8m30Q
         qOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=//nkJUOqKK9I9JAKOxrGmWsdECFuBDzQRPdFg3EsiQg=;
        b=a3z6ojg9AbjzQJ8G7d2elQUNf7MAIbzidASTHeFdYme3lKRaEVhom1D6b4cC4fhC6m
         HcvYJSmFnaZxdMEGe7PVtLvMM8axMTDdB0c0ccAs4O4Z9W6p/5L5/kBKd0SMvVu6ltas
         P4IKBmQ+TqDG7xdaF8z3UhyjKh+Jksi2VQWgnbySN4X9x47ac4DcYkZgSEWGTy7kPQPi
         //wbtjO9awtYdFBiiiZcL1knMQH6RcbyqpGOvxHpCv4AgVFcJ0AhXje7xPiuNrKhn8yN
         lbe9SAn7zwxVoos57M7MjC8I5NnjBnc9Hoc5A3L86oxbWOmUVxZ1o9dXvOTaWlsCbf2M
         h+eg==
X-Gm-Message-State: ANhLgQ3dkgTJcSKS1LfiYLvyBnlhzvFY9AsVouSPQfww/D3XTTFu8jJ6
        L0PmfHFPIMlfT3dwGUzl+yKCPKsSyKvGWufdzABRGREP
X-Google-Smtp-Source: ADFU+vv5isQNdA5g+wqwclUzkcu2IFL4Dmwo02Mc625ND3vHM4gvxgPhQ/GgTAnGZ2t1Kd7nj5BaKeJVqWMMBBRs3H4=
X-Received: by 2002:a67:646:: with SMTP id 67mr3170330vsg.34.1584446351477;
 Tue, 17 Mar 2020 04:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200316025232.1167-1-ricky_wu@realtek.com> <CAPDyKFrWedEmZ=0trPEG8Z-11nyFX6_OB3cx7+SAdB5VW_vzgQ@mail.gmail.com>
 <6196929373bb43c8b8fbc550ad41e1fc@realtek.com>
In-Reply-To: <6196929373bb43c8b8fbc550ad41e1fc@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Mar 2020 12:58:35 +0100
Message-ID: <CAPDyKFqfNp0uo6oY2ZkYVYknkYiyovtU2Ss4+y39AnuRi4nWVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Fixed TX/RX register and optimized TX parameter
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Mar 2020 at 03:45, =E5=90=B3=E6=98=8A=E6=BE=84 Ricky <ricky_wu@r=
ealtek.com> wrote:
>
>
> > -----Original Message-----
> > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > Sent: Monday, March 16, 2020 10:17 PM
> > To: =E5=90=B3=E6=98=8A=E6=BE=84 Ricky
> > Cc: linux-mmc@vger.kernel.org; Linux Kernel Mailing List; Arnd Bergmann=
; Greg
> > Kroah-Hartman
> > Subject: Re: [PATCH] mmc: rtsx: Fixed TX/RX register and optimized TX
> > parameter
> >
> > On Mon, 16 Mar 2020 at 03:52, <ricky_wu@realtek.com> wrote:
> > >
> > > From: Ricky Wu <ricky_wu@realtek.com>
> > >
> > > Fixed sd_change_phase TX/RX register
> > > Optimized rts522a rts524a rts525a rts5260 rts5261 TX initial paramete=
r
> >
> > I don't understand what this actually fixes. Can you try to elaborate
> > a bit on this, please?
> >
> > Do you think this is needed for stable, then why?
>
> Yes, I think it need patch to stable
>
> In function sd_change_phase() whether it is TX or RX always write the sam=
e register(TX), so patch this function make RX and TX can change well.
> At mmc stack mechanism do not tuning TX phase, so need give a stable para=
meter for TX phase(sdr104 sdr50 ddr50) at initial.

Alright, I took the liberty to clarify the changelog a bit according
to this. Please have a look at my fixes branch and tell me if I should
do some additional changes of the changelog.

Applied for fixes and by adding a stable tag, thanks!

Arnd, Greg, so I am picking this via my mmc tree, please shout at me
(or ack it) if you have any concerns with this. :-)

Kind regards
Uffe


>
> >
> > Kind regards
> > Uffe
> >
> > >
> > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > ---
> > >  drivers/misc/cardreader/rts5227.c |  2 +-
> > >  drivers/misc/cardreader/rts5249.c |  2 ++
> > >  drivers/misc/cardreader/rts5260.c |  2 +-
> > >  drivers/misc/cardreader/rts5261.c |  2 +-
> > >  drivers/mmc/host/rtsx_pci_sdmmc.c | 13 ++++++++-----
> > >  5 files changed, 13 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/misc/cardreader/rts5227.c
> > b/drivers/misc/cardreader/rts5227.c
> > > index 4feed296a327..423fecc19fc4 100644
> > > --- a/drivers/misc/cardreader/rts5227.c
> > > +++ b/drivers/misc/cardreader/rts5227.c
> > > @@ -394,7 +394,7 @@ static const struct pcr_ops rts522a_pcr_ops =3D {
> > >  void rts522a_init_params(struct rtsx_pcr *pcr)
> > >  {
> > >         rts5227_init_params(pcr);
> > > -
> > > +       pcr->tx_initial_phase =3D SET_CLOCK_PHASE(20, 20, 11);
> > >         pcr->reg_pm_ctrl3 =3D RTS522A_PM_CTRL3;
> > >
> > >         pcr->option.ocp_en =3D 1;
> > > diff --git a/drivers/misc/cardreader/rts5249.c
> > b/drivers/misc/cardreader/rts5249.c
> > > index db936e4d6e56..1a81cda948c1 100644
> > > --- a/drivers/misc/cardreader/rts5249.c
> > > +++ b/drivers/misc/cardreader/rts5249.c
> > > @@ -618,6 +618,7 @@ static const struct pcr_ops rts524a_pcr_ops =3D {
> > >  void rts524a_init_params(struct rtsx_pcr *pcr)
> > >  {
> > >         rts5249_init_params(pcr);
> > > +       pcr->tx_initial_phase =3D SET_CLOCK_PHASE(27, 29, 11);
> > >         pcr->option.ltr_l1off_sspwrgate =3D
> > LTR_L1OFF_SSPWRGATE_5250_DEF;
> > >         pcr->option.ltr_l1off_snooze_sspwrgate =3D
> > >                 LTR_L1OFF_SNOOZE_SSPWRGATE_5250_DEF;
> > > @@ -733,6 +734,7 @@ static const struct pcr_ops rts525a_pcr_ops =3D {
> > >  void rts525a_init_params(struct rtsx_pcr *pcr)
> > >  {
> > >         rts5249_init_params(pcr);
> > > +       pcr->tx_initial_phase =3D SET_CLOCK_PHASE(25, 29, 11);
> > >         pcr->option.ltr_l1off_sspwrgate =3D
> > LTR_L1OFF_SSPWRGATE_5250_DEF;
> > >         pcr->option.ltr_l1off_snooze_sspwrgate =3D
> > >                 LTR_L1OFF_SNOOZE_SSPWRGATE_5250_DEF;
> > > diff --git a/drivers/misc/cardreader/rts5260.c
> > b/drivers/misc/cardreader/rts5260.c
> > > index 4214f02a17fd..711054ebad74 100644
> > > --- a/drivers/misc/cardreader/rts5260.c
> > > +++ b/drivers/misc/cardreader/rts5260.c
> > > @@ -662,7 +662,7 @@ void rts5260_init_params(struct rtsx_pcr *pcr)
> > >         pcr->sd30_drive_sel_1v8 =3D CFG_DRIVER_TYPE_B;
> > >         pcr->sd30_drive_sel_3v3 =3D CFG_DRIVER_TYPE_B;
> > >         pcr->aspm_en =3D ASPM_L1_EN;
> > > -       pcr->tx_initial_phase =3D SET_CLOCK_PHASE(1, 29, 16);
> > > +       pcr->tx_initial_phase =3D SET_CLOCK_PHASE(27, 29, 11);
> > >         pcr->rx_initial_phase =3D SET_CLOCK_PHASE(24, 6, 5);
> > >
> > >         pcr->ic_version =3D rts5260_get_ic_version(pcr);
> > > diff --git a/drivers/misc/cardreader/rts5261.c
> > b/drivers/misc/cardreader/rts5261.c
> > > index bc4967a6efa1..78c3b1d424c3 100644
> > > --- a/drivers/misc/cardreader/rts5261.c
> > > +++ b/drivers/misc/cardreader/rts5261.c
> > > @@ -764,7 +764,7 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
> > >         pcr->sd30_drive_sel_1v8 =3D CFG_DRIVER_TYPE_B;
> > >         pcr->sd30_drive_sel_3v3 =3D CFG_DRIVER_TYPE_B;
> > >         pcr->aspm_en =3D ASPM_L1_EN;
> > > -       pcr->tx_initial_phase =3D SET_CLOCK_PHASE(20, 27, 16);
> > > +       pcr->tx_initial_phase =3D SET_CLOCK_PHASE(27, 27, 11);
> > >         pcr->rx_initial_phase =3D SET_CLOCK_PHASE(24, 6, 5);
> > >
> > >         pcr->ic_version =3D rts5261_get_ic_version(pcr);
> > > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > index bd50935dc37d..11087976ab19 100644
> > > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > @@ -606,19 +606,22 @@ static int sd_change_phase(struct
> > realtek_pci_sdmmc *host,
> > >                 u8 sample_point, bool rx)
> > >  {
> > >         struct rtsx_pcr *pcr =3D host->pcr;
> > > -
> > > +       u16 SD_VP_CTL =3D 0;
> > >         dev_dbg(sdmmc_dev(host), "%s(%s): sample_point =3D %d\n",
> > >                         __func__, rx ? "RX" : "TX", sample_point);
> > >
> > >         rtsx_pci_write_register(pcr, CLK_CTL, CHANGE_CLK, CHANGE_CLK)=
;
> > > -       if (rx)
> > > +       if (rx) {
> > > +               SD_VP_CTL =3D SD_VPRX_CTL;
> > >                 rtsx_pci_write_register(pcr, SD_VPRX_CTL,
> > >                         PHASE_SELECT_MASK, sample_point);
> > > -       else
> > > +       } else {
> > > +               SD_VP_CTL =3D SD_VPTX_CTL;
> > >                 rtsx_pci_write_register(pcr, SD_VPTX_CTL,
> > >                         PHASE_SELECT_MASK, sample_point);
> > > -       rtsx_pci_write_register(pcr, SD_VPCLK0_CTL, PHASE_NOT_RESET, =
0);
> > > -       rtsx_pci_write_register(pcr, SD_VPCLK0_CTL, PHASE_NOT_RESET,
> > > +       }
> > > +       rtsx_pci_write_register(pcr, SD_VP_CTL, PHASE_NOT_RESET, 0);
> > > +       rtsx_pci_write_register(pcr, SD_VP_CTL, PHASE_NOT_RESET,
> > >                                 PHASE_NOT_RESET);
> > >         rtsx_pci_write_register(pcr, CLK_CTL, CHANGE_CLK, 0);
> > >         rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST,
> > 0);
> > > --
> > > 2.17.1
> > >
> >
> > ------Please consider the environment before printing this e-mail.
