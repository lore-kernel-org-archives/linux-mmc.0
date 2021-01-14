Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED87C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 06:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832E12395B
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 06:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbhANGZm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbhANGZl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2021 01:25:41 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3FDC061575;
        Wed, 13 Jan 2021 22:25:01 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id az16so1870209qvb.5;
        Wed, 13 Jan 2021 22:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pG7a1vssVKtoo0Y5zp9blZT3ZnWiGtiE9ZFvukEjuEk=;
        b=CTxNf2Islvp81xcibLmQJa4T5ye0vJPYa0+S2qIlYB5PW+K1bFgYaWnQcQtE9XbtLv
         nfhSW+ZGTZPHurVdg2T7kvl2etj93A9zLP1PWLrfuaNR99CWm8jPtE6sjzVKrN0Kk2Lk
         0oxs7xkRuFablHavfs2he5mcBaJ6bm1KwOCjvuwqI3W0mwb8jhhBykll+LXP7UN58/Fh
         aUyUwpMtmXs0VaRCXwr+1LVrFMgI56lkNngDXWi32HogGdznvzsNG1OMCYqqlMG+b3lz
         5fF5NneXbsVI4WFL/Wi1e7sHQYeHh935QHA5NBliv+1rW8fryXqq0bdthitVbDHwZRMc
         nQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pG7a1vssVKtoo0Y5zp9blZT3ZnWiGtiE9ZFvukEjuEk=;
        b=X4/yYCpMeHFoZjs5+Yf0n6OGnpmyvSfOz3zgRU11KEjdZJS7Q49hH7rWGfdssh4My+
         TUk3vx48DOCOln/5nQtrW/qH4p2zsnALP58ygNLojK6t57UkEo3xkvvy0LRShMsvqL7k
         /gYIRIPrqQF8fAdvle4hOUMWH048KLS2he5KYxTh5HHb64NPiOPxrJEbb5X3p8EPGNUN
         yiHRd4GSkhn9KMWi5Eaw7SZ4Ecslkol9cogZNPo2AS8q+WCws6CVDcrpUclSipeybaKR
         qoQOyAhf2zRooRx11XXRTHG1fpoVYk0OFiVbFuRCDIJGIz+0Xefhap/sH6jBu6DBGa5o
         rYLA==
X-Gm-Message-State: AOAM533Xn5E9iKirxIuHC6C3DSnyAm86po8TZlkV4bABFL/x5YsLvw2d
        S01syhU0zuf396w5yLs+C+s7yY2cfWpDTRBWpwo=
X-Google-Smtp-Source: ABdhPJwSLRpLdlU0kHL+21jK00xHqYpoeNec4AAwuoMo/gMHrzwC3TvpqMX++QRhuh85OcVgmd0LIhkCXFB7+osup1g=
X-Received: by 2002:a0c:8027:: with SMTP id 36mr5852530qva.57.1610605500522;
 Wed, 13 Jan 2021 22:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20210106092740.5808-1-reniuschengl@gmail.com> <CAPDyKFq1EVVfU4HU_=-7TmSRinkTCA41pKWtrMD4C+yCUPYECg@mail.gmail.com>
In-Reply-To: <CAPDyKFq1EVVfU4HU_=-7TmSRinkTCA41pKWtrMD4C+yCUPYECg@mail.gmail.com>
From:   =?UTF-8?B?6Zmz5bu65a6P?= <reniuschengl@gmail.com>
Date:   Thu, 14 Jan 2021 14:24:49 +0800
Message-ID: <CAJU4x8uKHQy_hbMhsErzWb2U5USjMRhAZv=+14a9zDn068vHmw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL9763E
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8813=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:53=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, 6 Jan 2021 at 10:27, Renius Chen <reniuschengl@gmail.com> wrote:
> >
> > The R/W performance of GL9763E is low with some platforms, which
> > support ASPM mechanism, due to entering L1 state very frequently
> > in R/W process. Enlarge its ASPM L1 entry delay to improve the
> > R/W performance of GL9763E.
>
> What do you mean by frequently? In between a burst of request or
> during a burst of request?

GL9763E enters ASPM L1 state after a very short idle in default, even
during a burst of request.

> I am thinking that this could have an effect on energy instead, but I
> guess it's not always straightforward to decide what's most important.
>
> Anyway, what does it mean when you change to use 0x3FF? Are you
> increasing the idle period? Then for how long?

Yes, we considered that having high performance is more important than
saving power during a burst of request.
So we increased the idle period for 260us, by setting 0x3FF to the
ASPM L1 entry delay bits of our vendor-specific register.
Anyway, GL9763E can still enter ASPM L1 state by a longer idle.

Thanks for reviewing.

Best regards,
Renius

> Kind regards
> Uffe
>
> >
> > Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index c6a107d7c742..2d13bfcbcacf 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -88,6 +88,10 @@
> >  #define PCIE_GLI_9763E_SCR      0x8E0
> >  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
> >
> > +#define PCIE_GLI_9763E_CFG2      0x8A4
> > +#define   GLI_9763E_CFG2_L1DLY    GENMASK(28, 19)
> > +#define   GLI_9763E_CFG2_L1DLY_MAX 0x3FF
> > +
> >  #define PCIE_GLI_9763E_MMC_CTRL  0x960
> >  #define   GLI_9763E_HS400_SLOW     BIT(3)
> >
> > @@ -792,6 +796,11 @@ static void gli_set_gl9763e(struct sdhci_pci_slot =
*slot)
> >         value &=3D ~GLI_9763E_HS400_SLOW;
> >         pci_write_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, value);
> >
> > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
> > +       value &=3D ~GLI_9763E_CFG2_L1DLY;
> > +       value |=3D FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DL=
Y_MAX);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
> > +
> >         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> >         value &=3D ~GLI_9763E_VHS_REV;
> >         value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> > --
> > 2.27.0
> >
