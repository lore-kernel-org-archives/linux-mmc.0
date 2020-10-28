Return-Path: <SRS0=bNNl=ED=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BD9C63697
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Oct 2020 21:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0370C24743
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Oct 2020 21:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxRyotoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgJ1Vsm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgJ1Vhl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Oct 2020 17:37:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B5C0613CF
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2020 14:37:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y14so518627pfp.13
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2020 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qbvAGH/+Gr6HsAx+cEfZRUqTu0GwIJPlNLOpAb2FoYM=;
        b=xxRyotoRjKsBrbSG6Xuz0lPR5v2OwE30j1BpgwxF2EPvYQMWbhTbOjNDKTDJtiWVZt
         s1HvR0O2DkSl6RbF//5DAC/nSymMDGUr1nDfDsIcP3dM1pSMoiIsn2P3D5RKJBQS4vWK
         S1WKSFbt8MGGSJ1ReqnlUC/u+AaZWYri1a32JdKzG04D/7P4LWOly3JOK1ncMC0V2A4z
         0BwiiYcARBgCgSNqzI3dnX1pd4wwoeEJjvL3Pu4NGHD6DWS/qtKR2F1gIDScJXOcHFND
         IuyD+94PL8xrmHNLpp7Jh2QWjp77ZIKJcPrH9Yt8+6dOxgeBkAWtu4AryU9+vu5AZQTh
         dZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qbvAGH/+Gr6HsAx+cEfZRUqTu0GwIJPlNLOpAb2FoYM=;
        b=WpO5X7sjX2bvv+IsIP7TpSwqhaTxg+RsuReXBK7LXOXry0AkEWkCrY4k/8zW8yIQjV
         ocZlPDTQ2Lz4YZGX9AmnfwKRdwkijWLgq3KHpJecf1rRexSA9cKxuQRBjfKOqAJLrfV1
         JqnvhGrdCDn6VnA4Vhqzq5WCNAVtRM9eEJIV1fW0cgVhL8UJDbryYjI6eF+2F5Hw7MCX
         0/OM2OlShsaBisVE+s5qxtiFpg2y3I3UU7prWHlBQMSVN7zdOXRqs9NCKrBdjpy6S3cU
         WMzZIDktUYu27QRe3P/r0kSOpQDSi1mtSaBoWGOaGaZ06xGxyaY+hX6+TAGWqragGMaD
         j56Q==
X-Gm-Message-State: AOAM533RSGs4cfy8GvIeezNYameqnL6Tg2FVBz1iC2Bq5aIpoxQfoZAB
        x2/csrpnz3nXdlK/P+NQHlG/ljludRrsmHzzVPnxAiG9UVvLlQ==
X-Google-Smtp-Source: ABdhPJz+D+K09j+kA/3msWckVaX/tsiMARRK498ZPG9YJfYQI/tM8nbDl+06SeQ1WVT7Affb3jnzh2kbtd6loobWy3I=
X-Received: by 2002:a05:6102:41a:: with SMTP id d26mr4850463vsq.48.1603880318781;
 Wed, 28 Oct 2020 03:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn>
 <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com>
 <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn> <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com>
 <ba3c68fea4614434838a0a8cbc0e892a@realsil.com.cn> <CAPDyKFrDLJtDkkWsSENLDu2xLqptkjDk94YxYfkfW7UPBoG+bg@mail.gmail.com>
 <dd3bb2880b3e4da1b601b7e2b21f55c1@realsil.com.cn>
In-Reply-To: <dd3bb2880b3e4da1b601b7e2b21f55c1@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 28 Oct 2020 11:18:02 +0100
Message-ID: <CAPDyKFqA6Q9qvVu1gORLPed7iAn5JHTX7AWRO05D3GtsPA6tbg@mail.gmail.com>
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

On Wed, 28 Oct 2020 at 11:05, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn> =
wrote:
>
> >
> > >
> > > On Mon, 26 Oct 2020 at 09:22, =E5=86=AF=E9=94=90 <rui_feng@realsil.co=
m.cn> wrote:
> > > >
> > > > >
> > > > > + Christoph (to help us understand if PCIe/NVMe devices can be
> > > > > + marked
> > > > > + read-only)
> > > > >
> > > > > On Thu, 22 Oct 2020 at 08:04, =E5=86=AF=E9=94=90 <rui_feng@realsi=
l.com.cn> wrote:
> > > > > >
> > > > > > >
> > > > > > > On Fri, 25 Sep 2020 at 03:57, <rui_feng@realsil.com.cn> wrote=
:
> > > > > > > >
> > > > > > > > From: Rui Feng <rui_feng@realsil.com.cn>
> > > > > > > >
> > > > > > > > RTS5261 support legacy SD mode and SD Express mode.
> > > > > > > > In SD7.x, SD association introduce SD Express as a new mode=
.
> > > > > > > > This patch makes RTS5261 support SD Express mode.
> > > > > > >
> > > > > > > As per patch 2, can you please add some more information abou=
t
> > > > > > > what changes are needed to support SD Express? This just
> > > > > > > states that the support is implemented, but please elaborate =
how.
> > > > > > >
> > > > > > > >
> > > > > > > > Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
> > > > > > > > ---
> > > > > > > >  drivers/mmc/host/rtsx_pci_sdmmc.c | 59
> > > > > > > > +++++++++++++++++++++++++++++++
> > > > > > > >  1 file changed, 59 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > > > > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > > > > index 2763a376b054..efde374a4a5e 100644
> > > > > > > > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > > > > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > > > > > > @@ -895,7 +895,9 @@ static int sd_set_bus_width(struct
> > > > > > > > realtek_pci_sdmmc *host,  static int sd_power_on(struct
> > > > > > > > realtek_pci_sdmmc *host)  {
> > > > > > > >         struct rtsx_pcr *pcr =3D host->pcr;
> > > > > > > > +       struct mmc_host *mmc =3D host->mmc;
> > > > > > > >         int err;
> > > > > > > > +       u32 val;
> > > > > > > >
> > > > > > > >         if (host->power_state =3D=3D SDMMC_POWER_ON)
> > > > > > > >                 return 0;
> > > > > > > > @@ -922,6 +924,14 @@ static int sd_power_on(struct
> > > > > > > > realtek_pci_sdmmc
> > > > > > > *host)
> > > > > > > >         if (err < 0)
> > > > > > > >                 return err;
> > > > > > > >
> > > > > > > > +       if (PCI_PID(pcr) =3D=3D PID_5261) {
> > > > > > > > +               val =3D rtsx_pci_readl(pcr, RTSX_BIPR);
> > > > > > > > +               if (val & SD_WRITE_PROTECT) {
> > > > > > > > +                       pcr->extra_caps &=3D
> > > > > > > ~EXTRA_CAPS_SD_EXPRESS;
> > > > > > > > +                       mmc->caps2 &=3D
> > ~(MMC_CAP2_SD_EXP
> > > |
> > > > > > > > + MMC_CAP2_SD_EXP_1_2V);
> > > > > > >
> > > > > > > This looks a bit weird to me. For a write protected card you
> > > > > > > want to disable the SD_EXPRESS support, right?
> > > > > > >
> > > > > > Right. If end user insert a write protected SD express card, I
> > > > > > will disable
> > > > > SD_EXPRESS support.
> > > > > > If host switch to SD EXPRESS mode, the card will be recognized
> > > > > > as a writable PCIe/NVMe device, I think this is not end user's =
purpose.
> > > > >
> > > > > Hmm.
> > > > >
> > > > > Falling back to use the legacy SD interface is probably not what
> > > > > the user expects either.
> > > > >
> > > > > Note that the physical write protect switch/pin isn't mandatory t=
o
> > > > > support and it doesn't even exist for all formats of SD cards. In
> > > > > the mmc core, we are defaulting to make the card write enabled, i=
f
> > > > > the switch isn't supported by the host driver. Additionally,
> > > > > nothing prevents the end user from mounting the filesystem in
> > > > > read-only mode, if
> > > that is preferred.
> > > > >
> > > > > >
> > > > > > > Is there no mechanism to support read-only PCIe/NVMe based
> > > > > > > storage
> > > > > devices?
> > > > > > > If that is the case, maybe it's simply better to not support
> > > > > > > the readonly option at all for SD express cards?
> > > > > > >
> > > > > > I think there's no mechanism to support read-only PCIe/NVMe
> > > > > > based storage
> > > > > devices.
> > > > >
> > > > > I have looped in Christoph, maybe he can give us his opinion on t=
his.
> > > > >
> > > > > > But different venders may have different opinions. This is only
> > > > > > Realtek's
> > > > > opinion.
> > > > >
> > > > > I understand. However, the most important point for me, is that w=
e
> > > > > don't end up in a situation where each mmc host handles this
> > > > > differently. We should strive towards a consistent behavior.
> > > > >
> > > > > At this point I tend to prefer to default to ignore the write
> > > > > protect switch for SD express, unless we can find a way to
> > > > > properly support
> > > it.
> > > > >
> > > > For information security purpose, some companies or business users
> > > > set their
> > > notebook SD as "read only".
> > > > Because a lot of "read only" requirements from those companies or
> > > > business
> > > users, notebook vendor controls reader write protect pin to achieve i=
t.
> > > > Notebook BIOS might have option to choose "read only" or not.
> > > > This is why we think write protect is more important than speed.
> > >
> > > I understand that it may be used, in some way or the other to provide
> > > a hint to the operating system to mount it in read-only mode.
> > >
> > > Although, if there were a real security feature involved, the interna=
l
> > > FW of the SD card would also monitor the switch, to support read-only
> > > mode. As I understand it, that's not the common case.
> > >
> > > > If you prefer to consistent behavior, I can ignore the write protec=
t
> > > > switch for
> > > SD express.
> > >
> > > At this point, I prefer if you would ignore the write protect switch
> > > in the SD controller driver.
> > >
> > I will ignore write protect switch in V3.
> >
> Sorry I ignore the HW design.
> The reader has two mechanism for mode selection (SD Legacy or SD Express)=
. One is SW (MMC driver) and another is HW.
> We use HW mechanism when system exit S3 or S4.
> HW mechanism selects mode when chip is power on.
> Here is an example for HW mechanism.
> 1. Reader in SD Legacy mode ->
> 2. SD Express card insert ->
> 3. MMC driver selects the SD Express mode ->
> 4. SD Express initial and use NVMe driver and NVMe disk mount ->
> 5. system goes to S4 ->
> 6. system exits S4 ->
> 7. HW selects SD Express mode ->
> 8. SD Express still uses NVMe driver and disk keeps the same
> Therefore, after S4, disk is still keep the same.
>
> Because of HW mechanism selects SD legacy mode when write protect.
> If driver can't select SD legacy mode when write protect, disk might unmo=
unt and than mount after S3/S4.
> Here is an example for write protect.
> 1. Reader in SD Legacy mode ->
> 2. SD Express card insert with write protect ->
> 3. MMC driver selects the SD Express mode ->
> 4. SD Express initial and use NVMe driver and NVMe disk mount ->
> 5. system goes to S4 ->
> 6. system exits S4 ->
> 7. Because write protect, HW selects SD legacy mode ->
> 8. linux detect HW change, use MMC driver and NVMe disk unmount ->
> 9. MMC driver selects the SD Express mode ->
> 10. SD Express initial and use NVMe driver and NVMe disk mount
>
> If driver can select SD legacy mode when write protect, disk can keep the=
 same after S3/S4.
> Here is an example for write protect.
> 1. Reader in SD Legacy mode ->
> 2. SD Express card insert with write protect ->
> 3. MMC driver selects the SD legacy mode and disk mount ->
> 5. system goes to S4 ->
> 6. system exits S4 ->
> 7. Because write protect, HW selects SD legacy mode ->
> 8. MMC driver selects the SD legacy mode and disk keeps the same.
> If I ignore the write protect switch in mmc host driver, behavior of SW w=
ill not be consistent with HW.

Alright, let's keep the code monitoring the write protect switch then.
However, please add a comment in the code that it's needed because the
HW reads it when resuming from S3/S4 (and then picks SD legacy
interface if it's set in read-only mode).

[...]

Kind regards
Uffe
