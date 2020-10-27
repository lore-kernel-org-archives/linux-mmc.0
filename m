Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6C1C55178
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 12:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5871922265
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 12:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kV+mB8j0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900347AbgJ0MzZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:55:25 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43938 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900341AbgJ0MzZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2020 08:55:25 -0400
Received: by mail-ua1-f65.google.com with SMTP id r21so430015uaw.10
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2020 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yCdvbFUyHpdrBv+0R3rldtDhPdmrVZHLD23aJiVdh28=;
        b=kV+mB8j0VOZ6sdzWuyRHu5o/rQbvD38R4CoRrk5sn4u7xE2nsi10zI0wVCkklNAxeC
         EL3RYgfDj+QR5mqQLDZJDfp4i0kuI3Vj2IAImQooxsRXFW2uqITcvN5eoJtH1T6dQkg+
         o1TYP6x5+w18MZ/fc4o8Ve5cO57SSTix/gsMAZjxcKTLDOfiqH5+FGcFqq0dS6aBw0OK
         7JSAcbsOsPQdZyf8JV6ruUlm6pB3sa3sL+m/jtUGopC5iq0+/yil4Kh8E0yeStSYrH88
         iw3UcyhR7p2hKDVRSPv4hG5onTOAgaYHO+j6oAIZgE//JtPclFzyuF+iBNyrXYwjfAPm
         autw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yCdvbFUyHpdrBv+0R3rldtDhPdmrVZHLD23aJiVdh28=;
        b=es8a7psAWcuIVhhuv0EzWR0ZzWXtLa90XrI93esou63nZjHt3+TKuuQvfPIjmCZtp3
         uXDzg46k9Q3G75Rkh3SBI8/oezY6sV7Yv8jXb5tfN6/WCB2n8rmebJPOgEVRiWt4ugrV
         UjLkkJxEI+B1hXNH7zAEt+S3V3REV9TcYhSBZka/mCEZ5T71AxaJiIWMQKKGgqpLCPrU
         igRDvYWJ9ud1z7HZk2XcnZQblMuAAcdjD5EhPtPtJRO4Qfd7dxwmZ1+NpZc5IZ3f3StU
         utjupanbw2kPgj+hcUHRaIcW0GYNNB2WRnTLXwKwcKE1auCQnMX+Bgy1sHEGRQfnJZwx
         qqJA==
X-Gm-Message-State: AOAM531N8vtwPO7yd5IvDcPQ5EYtkh6rTA/jPHNaDYa+9OaEkcOYZUIy
        pJP9axn+FS9gH78EC+pUzKgp128QIJnNZ+mFyvS1Qw==
X-Google-Smtp-Source: ABdhPJyWjW26t5TTR/DEYePLqwOlhydrApT7doIzzlRUhPkuJQftY4h04dnXrE8obaHhA/UM6IYyeT6nOaJfQFfVJw8=
X-Received: by 2002:a9f:2f15:: with SMTP id x21mr964922uaj.104.1603803322895;
 Tue, 27 Oct 2020 05:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn>
 <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com>
 <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn> <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com>
 <ba3c68fea4614434838a0a8cbc0e892a@realsil.com.cn>
In-Reply-To: <ba3c68fea4614434838a0a8cbc0e892a@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Oct 2020 13:54:46 +0100
Message-ID: <CAPDyKFrDLJtDkkWsSENLDu2xLqptkjDk94YxYfkfW7UPBoG+bg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Oct 2020 at 09:22, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn> =
wrote:
>
> >
> > + Christoph (to help us understand if PCIe/NVMe devices can be marked
> > + read-only)
> >
> > On Thu, 22 Oct 2020 at 08:04, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.=
cn> wrote:
> > >
> > > >
> > > > On Fri, 25 Sep 2020 at 03:57, <rui_feng@realsil.com.cn> wrote:
> > > > >
> > > > > From: Rui Feng <rui_feng@realsil.com.cn>
> > > > >
> > > > > RTS5261 support legacy SD mode and SD Express mode.
> > > > > In SD7.x, SD association introduce SD Express as a new mode.
> > > > > This patch makes RTS5261 support SD Express mode.
> > > >
> > > > As per patch 2, can you please add some more information about what
> > > > changes are needed to support SD Express? This just states that the
> > > > support is implemented, but please elaborate how.
> > > >
> > > > >
> > > > > Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
> > > > > ---
> > > > >  drivers/mmc/host/rtsx_pci_sdmmc.c | 59
> > > > > +++++++++++++++++++++++++++++++
> > > > >  1 file changed, 59 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > index 2763a376b054..efde374a4a5e 100644
> > > > > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > @@ -895,7 +895,9 @@ static int sd_set_bus_width(struct
> > > > > realtek_pci_sdmmc *host,  static int sd_power_on(struct
> > > > > realtek_pci_sdmmc *host)  {
> > > > >         struct rtsx_pcr *pcr =3D host->pcr;
> > > > > +       struct mmc_host *mmc =3D host->mmc;
> > > > >         int err;
> > > > > +       u32 val;
> > > > >
> > > > >         if (host->power_state =3D=3D SDMMC_POWER_ON)
> > > > >                 return 0;
> > > > > @@ -922,6 +924,14 @@ static int sd_power_on(struct
> > > > > realtek_pci_sdmmc
> > > > *host)
> > > > >         if (err < 0)
> > > > >                 return err;
> > > > >
> > > > > +       if (PCI_PID(pcr) =3D=3D PID_5261) {
> > > > > +               val =3D rtsx_pci_readl(pcr, RTSX_BIPR);
> > > > > +               if (val & SD_WRITE_PROTECT) {
> > > > > +                       pcr->extra_caps &=3D
> > > > ~EXTRA_CAPS_SD_EXPRESS;
> > > > > +                       mmc->caps2 &=3D ~(MMC_CAP2_SD_EXP |
> > > > > + MMC_CAP2_SD_EXP_1_2V);
> > > >
> > > > This looks a bit weird to me. For a write protected card you want t=
o
> > > > disable the SD_EXPRESS support, right?
> > > >
> > > Right. If end user insert a write protected SD express card, I will d=
isable
> > SD_EXPRESS support.
> > > If host switch to SD EXPRESS mode, the card will be recognized as a
> > > writable PCIe/NVMe device, I think this is not end user's purpose.
> >
> > Hmm.
> >
> > Falling back to use the legacy SD interface is probably not what the us=
er
> > expects either.
> >
> > Note that the physical write protect switch/pin isn't mandatory to supp=
ort and
> > it doesn't even exist for all formats of SD cards. In the mmc core, we =
are
> > defaulting to make the card write enabled, if the switch isn't supporte=
d by the
> > host driver. Additionally, nothing prevents the end user from mounting =
the
> > filesystem in read-only mode, if that is preferred.
> >
> > >
> > > > Is there no mechanism to support read-only PCIe/NVMe based storage
> > devices?
> > > > If that is the case, maybe it's simply better to not support the
> > > > readonly option at all for SD express cards?
> > > >
> > > I think there's no mechanism to support read-only PCIe/NVMe based sto=
rage
> > devices.
> >
> > I have looped in Christoph, maybe he can give us his opinion on this.
> >
> > > But different venders may have different opinions. This is only Realt=
ek's
> > opinion.
> >
> > I understand. However, the most important point for me, is that we don'=
t end
> > up in a situation where each mmc host handles this differently. We shou=
ld strive
> > towards a consistent behavior.
> >
> > At this point I tend to prefer to default to ignore the write protect s=
witch for SD
> > express, unless we can find a way to properly support it.
> >
> For information security purpose, some companies or business users set th=
eir notebook SD as "read only".
> Because a lot of "read only" requirements from those companies or busines=
s users, notebook vendor controls reader write protect pin to achieve it.
> Notebook BIOS might have option to choose "read only" or not.
> This is why we think write protect is more important than speed.

I understand that it may be used, in some way or the other to provide
a hint to the operating system to mount it in read-only mode.

Although, if there were a real security feature involved, the internal
FW of the SD card would also monitor the switch, to support read-only
mode. As I understand it, that's not the common case.

> If you prefer to consistent behavior, I can ignore the write protect swit=
ch for SD express.

At this point, I prefer if you would ignore the write protect switch
in the SD controller driver.

According to Christoph, it should be possible to support read-only
mode via PCIe/NVMe. You may need to add some tweaks to support this in
the PCIe controller driver, but I can't advise you how to exactly do
this.

Perhaps you need to read/store the state of SD write-protect pin
before switching to SD express mode, because you may not be able to
read it beyond some point?

>
> >
> > From this, I assume that my interpretations of the behavior was correct=
.
> >
> > Although, can you please elaborate on what you mean by that it will "no=
t
> > work"?
> >
> > Do you mean that rtsx_pci_card_exclusive_check() that is called early i=
n
> > sdmmc_set_ios() will fail and then make it bail out? Then, could you pl=
ease add
> > a comment about that in the code?
> >
> In init_sd_express() driver sets 0xFF54 bit0=3D1 and 0xFF55 bit4=3D0, the=
n RTS5261 will switch MCU and enter SD EXPRESS mode.
> After that RTS5261 can't receive any CMD from PCIe, so mmc_power_off() wi=
ll not work.

Thanks for trying to clarify.

However, this still doesn't explain to me, what *exactly* will happen
when rtsx_pci_card_exclusive_check() is called (or any other functions
in ->set_ios()).

In principle, "will not work" could mean that the calls to the
rtsx_pci_* cardreader interface hangs - and that would not be okay (as
it could lead to that the ->remove() callback hangs). So, either you
need to put a well written comment in the code about what will happen
- or add some kind of protection against potential problems for this.

Kind regards
Uffe
