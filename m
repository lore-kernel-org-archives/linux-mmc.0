Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBA6C64ED8
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Feb 2023 11:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjB0LWS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Feb 2023 06:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0LWR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2023 06:22:17 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409031E286
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2023 03:22:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da10so24365184edb.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2023 03:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuW3scZHE2qMIgtFav0tuZiA0IMLEVnQDpbtGr6T0Gw=;
        b=rNlxQQUOx7dVy6M2Z8ycX1fJmg8tUUKIH3s4Qlh4bIY/1L+x1oxqhlP7V9uFWJX8kv
         cBwFIP/yv0+pF4D0KH2+LoVhr13DnA7Ios8a6oLMt+s4mOcYEYL0TXKuEy6UvwW2dw+i
         J92QUwacdJfKIGUEhZwEG6GyjB/RvR2W4SVDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuW3scZHE2qMIgtFav0tuZiA0IMLEVnQDpbtGr6T0Gw=;
        b=ime6zL3baGVCuYJGaD9/i3eUxjlRUpHMUrFNchLY6CDp+92exEU9vtCA5xZMZ2bYF+
         U4Q/CW1JsmLaQGUCAn18iwO7OzhzzbBx18qOXWsyG+gTCHxKTFDs70KGWcxunAW21l/9
         8AHTJtG1Y15NGK8ReqkNn94irYTWXc4Kb4wgjbRgBCQeeQtvfE3xwDdtaP2jXxcXpTNw
         kSbwE1wSygFlHQotmpLbm9NkzbCOeT/XRrSeudjveXo5HnRes1USdgLNWks5WlLA4i5D
         Ed5h3m7Md3Y3dMlof8aXeD88f98uykCAGmKHC5YNffbZjt8zm72vq+tUOcQcvQiqzvco
         O/gg==
X-Gm-Message-State: AO0yUKV5gn7lJvHx2XDwc3MfcgGP/RutK1UTlOp3bRLzLEz+aFU+fkTX
        C7K/1J5NkkaNEeJcy8AwZNVianrE5F09LqIgmyrwRD7jVeo3WlGO
X-Google-Smtp-Source: AK7set+NST0tU95K/hcnvFxkA+frcNPo5jFrZM4yJiD8J/K/tyv/ByDI/Wz689ivuK6NQRsTfokduGioM6mvK9Bq3uI=
X-Received: by 2002:a50:d544:0:b0:4ad:6e3e:7da6 with SMTP id
 f4-20020a50d544000000b004ad6e3e7da6mr11797961edj.6.1677496934725; Mon, 27 Feb
 2023 03:22:14 -0800 (PST)
MIME-Version: 1.0
References: <CAOf5uwns3YZMY5xhM+o0rNvtTqEDwCbua5HuSy-LBwgZq_eWYg@mail.gmail.com>
 <DB7PR04MB4010D6ABA0D10AB826F468CC90C29@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <CAOf5uwmaP0x3s7W6OZaCfLmJguSMtKtJtLCgKZ2nuDZ9VgpLVg@mail.gmail.com>
In-Reply-To: <CAOf5uwmaP0x3s7W6OZaCfLmJguSMtKtJtLCgKZ2nuDZ9VgpLVg@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 27 Feb 2023 12:22:03 +0100
Message-ID: <CAOf5uwnuFBXF52Tbe7EFXcjzjbr-oOhn-fDVw=p8uZ8Y_Z7v+Q@mail.gmail.com>
Subject: Re: NXP imx6ull nonalignment buffer question
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bough

On Fri, Jan 13, 2023 at 8:19=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Fri, Jan 13, 2023 at 4:30 AM Bough Chen <haibo.chen@nxp.com> wrote:
> >
> > > -----Original Message-----
> > > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > > Sent: 2023=E5=B9=B41=E6=9C=889=E6=97=A5 21:02
> > > To: Bough Chen <haibo.chen@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> > > Fabio Estevam <festevam@gmail.com>; LKML <linux-kernel@vger.kernel.or=
g>
> > > Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>;
> > > linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>
> > > Subject: NXP imx6ull nonalignment buffer question
> > >
> > > Hi Haibo
> > >
> > > Working on imx6ulz design and found that if I send a sdio packet usin=
g the
> > > sdio_writesb the adma driver tries to handle it with two dma descript=
ors. The
> > > first one filled with the bytes up to 3 to cover the misalign and the=
n another
> > > buffer descriptor
> > >
> > >   offset =3D (SDHCI_ADMA2_ALIGN - (addr & SDHCI_ADMA2_MASK)) &
> > >                          SDHCI_ADMA2_MASK;
> > >                 if (offset) {
> > >                         if (data->flags & MMC_DATA_WRITE) {
> > >                                 buffer =3D sdhci_kmap_atomic(sg);
> > >                                 memcpy(align, buffer, offset);
> > >                                 sdhci_kunmap_atomic(buffer);
> > >                         }
> > >
> > >                         /* tran, valid */
> > >                         __sdhci_adma_write_desc(host, &desc,
> > > align_addr,
> > >                                                 offset,
> > > ADMA2_TRAN_VALID);
> > >
> > >                         BUG_ON(offset > 65536);
> > >
> > >                         align +=3D SDHCI_ADMA2_ALIGN;
> > >                         align_addr +=3D SDHCI_ADMA2_ALIGN;
> > >
> > >                         addr +=3D offset;
> > >                         len -=3D offset;
> > >                 }
> > >
> > > In 48.7.4 Data Length Setting
> > > For either ADMA (ADMA1 or ADMA2) transfer, the data in the data buffe=
r must
> > > be word aligned, so the data length set in the descriptor must be a m=
ultiple of 4.
> > > I have noticed that this code does not work as expected.
> >
> > Hi Michael,
> >
> > My understanding is: for the sentence " the data in the data buffer mus=
t be word aligned", this means the start address of the data must be word a=
ligned, but not limit the data length.
> >
>
> Ok. My specific problem is that this seems not working on imx6ulz, I
> found the problem working on a wifi chipset, if the request gets split
> for no-alignment
> of the data in two dma descriptors, the chipset does not reply to me.
> Anyway, I will retest it with the upstream kernel again. I will check
> better and I will follow up if any more question
>

I have done some tests and I need this quirk
SDHCI_QUIRK_32BIT_ADMA_SIZE on imx6ulz cpu and I think that it applies
even on imx6ull.
Wifi can work only if the data on the sdio are aligned or we use
interrupt mode for no-alignment data. I did not find an errata and I
can not add as a quirk without a confirmation

Michael
