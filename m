Return-Path: <SRS0=MzOG=D3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D53C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Oct 2020 08:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31B5222E8
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Oct 2020 08:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fER9bgJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgJTIPI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbgJTIPG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2020 04:15:06 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8DEC061755
        for <linux-mmc@vger.kernel.org>; Tue, 20 Oct 2020 01:15:06 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s15so654142vsm.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Oct 2020 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SyK5m4b9FbWJeiZQwKGV7GetLhuHzJTDD0RMXLo9VRQ=;
        b=fER9bgJCf0H7mq5NyHhl1fThuiKtUXCmMyN0wjZ+JcPEsOHQA0Gcw7D1QEzvRwl9O6
         1Bw/cqKPksX4nDiO2Vud4K3nLn6OCFxtel1/5pfOLRumcm9F96RcUPo6trcHwzBVQWP3
         vB+NY/GPp12vb/xYW2o7jlJXdypEXxg8AzagkIDGjyKpDNwPauL2uNVPTBkiSVFxyuYX
         WUeGYIDCatQbHkA+pjmZb2IkWLoQV9Mt7NVWnZyQXReIEMw8a8hTb+HDb/LfK30ZV4ow
         lAztG5q32022YNkFccHpuEU07InFe1oYYWLFROefrwXuqXeCknQ9A5idDedUU4mWOMjq
         VGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SyK5m4b9FbWJeiZQwKGV7GetLhuHzJTDD0RMXLo9VRQ=;
        b=GZmwZDYAyODryrvCcSrwOGCuI9rkLoQtpMh9u32WI4EOaXchfKvf3M/FoU+itLTMdG
         81Hxqlf7vo6A9fD2Kgj+XM83ynghgMZQviENJ18ie/CUP+6kGZBvm9pWsfRMVUYOtVi3
         J7WrEAX85WUCGGQ36fg770oRJu3l9yTTjJZj6dhljgWMzNDDQJgTQD+4CKJx2LziE2IL
         mOlT+rsvV2hTTu0jTEdQMLPTp818jz+Sfmh6tHy363LiW8k1+6HLdZxBF7DNO9vp4hLc
         oaKFu+7+04ptEkkicjuuWg/UlbssmQlgbgFlfH2jwC/ddbQFdZhtW7gB6wEPkYuFFWy3
         nZJQ==
X-Gm-Message-State: AOAM533idbQ+fC/zYzt+veCsjgfyPMkDUxgO1Yx0avQ7PqsXGe5gnhTQ
        sj89xt4DBtFvGF+i5Qs3RxDx7J87S44UzQ+p4mabwg==
X-Google-Smtp-Source: ABdhPJzFcxHn50bGw0O+1RqDdjB8QAsZfnfM6QWEL4QGQ4u9R2WDubJtTAFx+nNdOwYsBQAA57J8YTnu2TXVgqXI3vA=
X-Received: by 2002:a67:f24e:: with SMTP id y14mr687194vsm.55.1603181705415;
 Tue, 20 Oct 2020 01:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn> <663240cd069644d0b5fdae7aec9d4597@realsil.com.cn>
In-Reply-To: <663240cd069644d0b5fdae7aec9d4597@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Oct 2020 10:14:29 +0200
Message-ID: <CAPDyKFr_CJzGaqncQy+eoibS6Nn+c29dPF8r7tsO6PoSmHVESw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Oct 2020 at 08:52, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn> =
wrote:
>
> Hi All,
>
> A month has passed, do I need to modify these patches?

Unfortunately I didn't get the time to review them before the merge
window opened, but I am looking at them now. Allow me a day or two to
complete the review.

Kind regards
Ufffe

>
> Thanks
>
> >
> > From: Rui Feng <rui_feng@realsil.com.cn>
> >
> > RTS5261 support legacy SD mode and SD Express mode.
> > In SD7.x, SD association introduce SD Express as a new mode.
> > This patch makes RTS5261 support SD Express mode.
> >
> > Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
> > ---
> >  drivers/mmc/host/rtsx_pci_sdmmc.c | 59
> > +++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >
> > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > index 2763a376b054..efde374a4a5e 100644
> > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > @@ -895,7 +895,9 @@ static int sd_set_bus_width(struct realtek_pci_sdmm=
c
> > *host,  static int sd_power_on(struct realtek_pci_sdmmc *host)  {
> >       struct rtsx_pcr *pcr =3D host->pcr;
> > +     struct mmc_host *mmc =3D host->mmc;
> >       int err;
> > +     u32 val;
> >
> >       if (host->power_state =3D=3D SDMMC_POWER_ON)
> >               return 0;
> > @@ -922,6 +924,14 @@ static int sd_power_on(struct realtek_pci_sdmmc
> > *host)
> >       if (err < 0)
> >               return err;
> >
> > +     if (PCI_PID(pcr) =3D=3D PID_5261) {
> > +             val =3D rtsx_pci_readl(pcr, RTSX_BIPR);
> > +             if (val & SD_WRITE_PROTECT) {
> > +                     pcr->extra_caps &=3D ~EXTRA_CAPS_SD_EXPRESS;
> > +                     mmc->caps2 &=3D ~(MMC_CAP2_SD_EXP |
> > MMC_CAP2_SD_EXP_1_2V);
> > +             }
> > +     }
> > +
> >       host->power_state =3D SDMMC_POWER_ON;
> >       return 0;
> >  }
> > @@ -1127,6 +1137,8 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
> >       if (val & SD_EXIST)
> >               cd =3D 1;
> >
> > +     if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
> > +             mmc->caps2 |=3D MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
> >       mutex_unlock(&pcr->pcr_mutex);
> >
> >       return cd;
> > @@ -1308,6 +1320,50 @@ static int sdmmc_execute_tuning(struct
> > mmc_host *mmc, u32 opcode)
> >       return err;
> >  }
> >
> > +static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios
> > +*ios) {
> > +     u32 relink_time, val;
> > +     struct realtek_pci_sdmmc *host =3D mmc_priv(mmc);
> > +     struct rtsx_pcr *pcr =3D host->pcr;
> > +
> > +     /*
> > +      * If card has PCIe availability and WP if off,
> > +      * reader switch to PCIe mode.
> > +      */
> > +     val =3D rtsx_pci_readl(pcr, RTSX_BIPR);
> > +     if (!(val & SD_WRITE_PROTECT)) {
> > +             /* Set relink_time for changing to PCIe card */
> > +             relink_time =3D 0x8FFF;
> > +
> > +             rtsx_pci_write_register(pcr, 0xFF01, 0xFF, relink_time);
> > +             rtsx_pci_write_register(pcr, 0xFF02, 0xFF, relink_time >>=
 8);
> > +             rtsx_pci_write_register(pcr, 0xFF03, 0x01, relink_time >>=
 16);
> > +
> > +             rtsx_pci_write_register(pcr, PETXCFG, 0x80, 0x80);
> > +             rtsx_pci_write_register(pcr, LDO_VCC_CFG0,
> > +                     RTS5261_LDO1_OCP_THD_MASK,
> > +                     pcr->option.sd_800mA_ocp_thd);
> > +
> > +             if (pcr->ops->disable_auto_blink)
> > +                     pcr->ops->disable_auto_blink(pcr);
> > +
> > +             /* For PCIe/NVMe mode can't enter delink issue */
> > +             pcr->hw_param.interrupt_en &=3D ~(SD_INT_EN);
> > +             rtsx_pci_writel(pcr, RTSX_BIER, pcr->hw_param.interrupt_e=
n);
> > +
> > +             rtsx_pci_write_register(pcr, RTS5260_AUTOLOAD_CFG4,
> > +                     RTS5261_AUX_CLK_16M_EN, RTS5261_AUX_CLK_16M_EN);
> > +             rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
> > +                     RTS5261_FW_ENTER_EXPRESS, RTS5261_FW_ENTER_EXPRES=
S);
> > +             rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
> > +                     RTS5261_MCU_BUS_SEL_MASK |
> > RTS5261_MCU_CLOCK_SEL_MASK
> > +                     | RTS5261_MCU_CLOCK_GATING |
> > RTS5261_DRIVER_ENABLE_FW,
> > +                     RTS5261_MCU_CLOCK_SEL_16M |
> > RTS5261_MCU_CLOCK_GATING
> > +                     | RTS5261_DRIVER_ENABLE_FW);
> > +     }
> > +     return 0;
> > +}
> > +
> >  static const struct mmc_host_ops realtek_pci_sdmmc_ops =3D {
> >       .pre_req =3D sdmmc_pre_req,
> >       .post_req =3D sdmmc_post_req,
> > @@ -1317,6 +1373,7 @@ static const struct mmc_host_ops
> > realtek_pci_sdmmc_ops =3D {
> >       .get_cd =3D sdmmc_get_cd,
> >       .start_signal_voltage_switch =3D sdmmc_switch_voltage,
> >       .execute_tuning =3D sdmmc_execute_tuning,
> > +     .init_sd_express =3D sdmmc_init_sd_express,
> >  };
> >
> >  static void init_extra_caps(struct realtek_pci_sdmmc *host) @@ -1338,6
> > +1395,8 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
> >               mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> >       if (pcr->extra_caps & EXTRA_CAPS_NO_MMC)
> >               mmc->caps2 |=3D MMC_CAP2_NO_MMC;
> > +     if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
> > +             mmc->caps2 |=3D MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
> >  }
> >
> >  static void realtek_init_host(struct realtek_pci_sdmmc *host)
> > --
> > 2.17.1
>
