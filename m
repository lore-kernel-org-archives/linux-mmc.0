Return-Path: <SRS0=9HeC=D6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40165C388F9
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 08:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A489B2223F
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 08:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3yh6iYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898629AbgJWIC4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372096AbgJWICz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Oct 2020 04:02:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12872C0613D2
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2020 01:02:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m20so599178ljj.5
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2020 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h2kWF09NgwPROtmt4sQNV0hMdRc9TR0X3TOzlpWh9a8=;
        b=O3yh6iYMJdQQmwUbwj3Px67lnCepjpQ23BJI3rBQHZ9nulSgbLTEJ70qvQH9UkNzGV
         DBqjrCkKORispKkpyKFMe9yErLeMfx+pm0FRL4mUaTN0Gt4cOdDvL/U/eiMo/o8XqRF/
         iEk8ddGkjoui+Qax6A/E6GYjeDtwuMt14CE/l3iq9MblNtXx+0hqN3ij1gEhLNFT/wpG
         8ZTkCqLx3HI4iY6JkCa5N1iRC7BrVrdE2HF+8X68hdmw9SRWXkWpWwU8e+FFbeouDC/z
         nnSx7650QpE3t22IUWtoSETwB/Ev8tdGAePZeJSB8xjIn9YLQcDB0ICVKvj8R43qIBML
         BmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h2kWF09NgwPROtmt4sQNV0hMdRc9TR0X3TOzlpWh9a8=;
        b=jXlrqnBD4cGIu3fDA61R8nczImPPWM4Z/Ere5YmmTK3s/RLTsTip8xF/B1Zx39SxmZ
         bq0F4E8Mwxn55Ex868VGSkK35U5y1V7X9iyLz50qCfS9m0A7C0atEvdAdKoetXM4ij0v
         01Wh6a6GbYNUELfE3jIulAgXvQPhGH/SxUWLNL4Y2zT/bq+lBtigYwZDzNpLAYS2KyeQ
         J1mYy0z6VCo9h30yUaa7BDtq6WagHgEKFmtcd5K+qj7FO7MogchyjOo4EhEttff4J74H
         oG39s9hnoZIDVBpIiAFtYdjmK6wRe5Y0pY9jf5xaTVOYeBefspXWbGQUSctl8yc9kBCi
         lqUw==
X-Gm-Message-State: AOAM53217QBDsjYNBMB+AhAcSsZ1GQ/+aCvYHcDZgJXpFHOzw0EUABUc
        VFBCfXVJCRiPJnRpnbmTjdH2iN0eO10AyLWVqC7dRQ==
X-Google-Smtp-Source: ABdhPJwLyc4+7kE9WtmyImphVds2d7cX3qNuK47OlpxrX7Ut85LUQeEItgPAUvtXi9pYerMx/5Aqv8rD1swwGeSkhOw=
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr364179lji.26.1603440173349;
 Fri, 23 Oct 2020 01:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn>
 <CAPDyKFrnkF3mU5PJsy0VtEjPSToktSsRRtyMvQF97vymc+rY5A@mail.gmail.com> <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn>
In-Reply-To: <dd210290eef6467cbffca8cbaddb8b84@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Oct 2020 10:02:15 +0200
Message-ID: <CAPDyKFqwsJaYrXMVabR7qui6yqr4FAHfYq1ghfsf0HtRSZpGGw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>,
        Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Christoph (to help us understand if PCIe/NVMe devices can be marked read-=
only)

On Thu, 22 Oct 2020 at 08:04, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn> =
wrote:
>
> >
> > On Fri, 25 Sep 2020 at 03:57, <rui_feng@realsil.com.cn> wrote:
> > >
> > > From: Rui Feng <rui_feng@realsil.com.cn>
> > >
> > > RTS5261 support legacy SD mode and SD Express mode.
> > > In SD7.x, SD association introduce SD Express as a new mode.
> > > This patch makes RTS5261 support SD Express mode.
> >
> > As per patch 2, can you please add some more information about what cha=
nges
> > are needed to support SD Express? This just states that the support is
> > implemented, but please elaborate how.
> >
> > >
> > > Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
> > > ---
> > >  drivers/mmc/host/rtsx_pci_sdmmc.c | 59
> > > +++++++++++++++++++++++++++++++
> > >  1 file changed, 59 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > index 2763a376b054..efde374a4a5e 100644
> > > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > > @@ -895,7 +895,9 @@ static int sd_set_bus_width(struct
> > > realtek_pci_sdmmc *host,  static int sd_power_on(struct
> > > realtek_pci_sdmmc *host)  {
> > >         struct rtsx_pcr *pcr =3D host->pcr;
> > > +       struct mmc_host *mmc =3D host->mmc;
> > >         int err;
> > > +       u32 val;
> > >
> > >         if (host->power_state =3D=3D SDMMC_POWER_ON)
> > >                 return 0;
> > > @@ -922,6 +924,14 @@ static int sd_power_on(struct realtek_pci_sdmmc
> > *host)
> > >         if (err < 0)
> > >                 return err;
> > >
> > > +       if (PCI_PID(pcr) =3D=3D PID_5261) {
> > > +               val =3D rtsx_pci_readl(pcr, RTSX_BIPR);
> > > +               if (val & SD_WRITE_PROTECT) {
> > > +                       pcr->extra_caps &=3D
> > ~EXTRA_CAPS_SD_EXPRESS;
> > > +                       mmc->caps2 &=3D ~(MMC_CAP2_SD_EXP |
> > > + MMC_CAP2_SD_EXP_1_2V);
> >
> > This looks a bit weird to me. For a write protected card you want to di=
sable the
> > SD_EXPRESS support, right?
> >
> Right. If end user insert a write protected SD express card, I will disab=
le SD_EXPRESS support.
> If host switch to SD EXPRESS mode, the card will be recognized as a writa=
ble PCIe/NVMe device,
> I think this is not end user's purpose.

Hmm.

Falling back to use the legacy SD interface is probably not what the
user expects either.

Note that the physical write protect switch/pin isn't mandatory to
support and it doesn't even exist for all formats of SD cards. In the
mmc core, we are defaulting to make the card write enabled, if the
switch isn't supported by the host driver. Additionally, nothing
prevents the end user from mounting the filesystem in read-only mode,
if that is preferred.

>
> > Is there no mechanism to support read-only PCIe/NVMe based storage devi=
ces?
> > If that is the case, maybe it's simply better to not support the readon=
ly option
> > at all for SD express cards?
> >
> I think there's no mechanism to support read-only PCIe/NVMe based storage=
 devices.

I have looped in Christoph, maybe he can give us his opinion on this.

> But different venders may have different opinions. This is only Realtek's=
 opinion.

I understand. However, the most important point for me, is that we
don't end up in a situation where each mmc host handles this
differently. We should strive towards a consistent behavior.

At this point I tend to prefer to default to ignore the write protect
switch for SD express, unless we can find a way to properly support
it.

>
> > > +               }
> > > +       }
> > > +
> > >         host->power_state =3D SDMMC_POWER_ON;
> > >         return 0;
> > >  }
> > > @@ -1127,6 +1137,8 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
> > >         if (val & SD_EXIST)
> > >                 cd =3D 1;
> > >
> > > +       if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
> > > +               mmc->caps2 |=3D MMC_CAP2_SD_EXP |
> > MMC_CAP2_SD_EXP_1_2V;
> >
> > This looks wrong. You shouldn't be using the ->get_cd() callback to re-=
enable
> > mmc caps.
> >
> > Normally set the mmc caps while host probes (from the ->probe() callbac=
k), but
> > I guess this is kind of a special case, as the read-only switch state i=
sn't known
> > until we have powered on the card, right?
> >
> Right.
>
> > If that is the case, I suggest to re-enable the mmc caps from the
> > ->set_ios() callback instead, when ios->power_mode =3D=3D MMC_POWER_OFF=
.
> >
> I will move it to sd_power_on().
>
> > >         mutex_unlock(&pcr->pcr_mutex);
> > >
> > >         return cd;
> > > @@ -1308,6 +1320,50 @@ static int sdmmc_execute_tuning(struct
> > mmc_host *mmc, u32 opcode)
> > >         return err;
> > >  }
> > >
> > > +static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_io=
s
> > > +*ios) {
> > > +       u32 relink_time, val;
> > > +       struct realtek_pci_sdmmc *host =3D mmc_priv(mmc);
> > > +       struct rtsx_pcr *pcr =3D host->pcr;
> > > +
> > > +       /*
> > > +        * If card has PCIe availability and WP if off,
> > > +        * reader switch to PCIe mode.
> > > +        */
> > > +       val =3D rtsx_pci_readl(pcr, RTSX_BIPR);
> > > +       if (!(val & SD_WRITE_PROTECT)) {
> >
> > This should not be needed, as you have already checked the write protec=
t bit
> > before enabling the mmc caps for SD EXPRESS, right?
> >
> Right.
>
> > > +               /* Set relink_time for changing to PCIe card */
> > > +               relink_time =3D 0x8FFF;
> > > +
> > > +               rtsx_pci_write_register(pcr, 0xFF01, 0xFF, relink_tim=
e);
> > > +               rtsx_pci_write_register(pcr, 0xFF02, 0xFF, relink_tim=
e >>
> > 8);
> > > +               rtsx_pci_write_register(pcr, 0xFF03, 0x01, relink_tim=
e
> > > + >> 16);
> > > +
> > > +               rtsx_pci_write_register(pcr, PETXCFG, 0x80, 0x80);
> > > +               rtsx_pci_write_register(pcr, LDO_VCC_CFG0,
> > > +                       RTS5261_LDO1_OCP_THD_MASK,
> > > +                       pcr->option.sd_800mA_ocp_thd);
> > > +
> > > +               if (pcr->ops->disable_auto_blink)
> > > +                       pcr->ops->disable_auto_blink(pcr);
> > > +
> > > +               /* For PCIe/NVMe mode can't enter delink issue */
> > > +               pcr->hw_param.interrupt_en &=3D ~(SD_INT_EN);
> > > +               rtsx_pci_writel(pcr, RTSX_BIER,
> > > + pcr->hw_param.interrupt_en);
> > > +
> > > +               rtsx_pci_write_register(pcr, RTS5260_AUTOLOAD_CFG4,
> > > +                       RTS5261_AUX_CLK_16M_EN,
> > RTS5261_AUX_CLK_16M_EN);
> > > +               rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
> > > +                       RTS5261_FW_ENTER_EXPRESS,
> > RTS5261_FW_ENTER_EXPRESS);
> > > +               rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
> > > +                       RTS5261_MCU_BUS_SEL_MASK |
> > RTS5261_MCU_CLOCK_SEL_MASK
> > > +                       | RTS5261_MCU_CLOCK_GATING |
> > RTS5261_DRIVER_ENABLE_FW,
> > > +                       RTS5261_MCU_CLOCK_SEL_16M |
> > RTS5261_MCU_CLOCK_GATING
> > > +                       | RTS5261_DRIVER_ENABLE_FW);
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > >  static const struct mmc_host_ops realtek_pci_sdmmc_ops =3D {
> > >         .pre_req =3D sdmmc_pre_req,
> > >         .post_req =3D sdmmc_post_req,
> > > @@ -1317,6 +1373,7 @@ static const struct mmc_host_ops
> > realtek_pci_sdmmc_ops =3D {
> > >         .get_cd =3D sdmmc_get_cd,
> > >         .start_signal_voltage_switch =3D sdmmc_switch_voltage,
> > >         .execute_tuning =3D sdmmc_execute_tuning,
> > > +       .init_sd_express =3D sdmmc_init_sd_express,
> > >  };
> > >
> > >  static void init_extra_caps(struct realtek_pci_sdmmc *host) @@
> > > -1338,6 +1395,8 @@ static void init_extra_caps(struct realtek_pci_sdm=
mc
> > *host)
> > >                 mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> > >         if (pcr->extra_caps & EXTRA_CAPS_NO_MMC)
> > >                 mmc->caps2 |=3D MMC_CAP2_NO_MMC;
> > > +       if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
> > > +               mmc->caps2 |=3D MMC_CAP2_SD_EXP |
> > MMC_CAP2_SD_EXP_1_2V;
> > >  }
> > >
> > >  static void realtek_init_host(struct realtek_pci_sdmmc *host)
> > > --
> > > 2.17.1
> > >
> >
> > A follow up question:
> >
> > Based upon your feedback from our earlier discussions, I believe you st=
ated
> > that the card reader driver (rtsx_pci_driver) will unregister the corre=
sponding
> > mfd/platform device that corresponds to the rtsx_pci_sdmmc_driver - whe=
n it
> > gets configured to manage a PCIe/NVMe based storage device. Correct?
> >
> > Perhaps I didn't get that part correctly, but if this is the case, it m=
eans that the
> > ->remove() callback (rtsx_pci_sdmmc_drv_remove()) will be invoked.
> > Furthermore, this will cause the ->set_ios() callback to be invoked whe=
n the
> > core calls mmc_power_off() in that path. Isn't that a problem that you =
need to
> > address?
> >
> After init_sd_express() is called, mmc_power_off() will not work, so it's=
 not a problem I need to
> address.

From this, I assume that my interpretations of the behavior was correct.

Although, can you please elaborate on what you mean by that it will "not wo=
rk"?

Do you mean that rtsx_pci_card_exclusive_check() that is called early
in sdmmc_set_ios() will fail and then make it bail out? Then, could
you please add a comment about that in the code?

Kind regards
Uffe
