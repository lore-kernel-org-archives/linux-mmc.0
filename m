Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF610C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 08:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8AC60F35
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 08:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbhHQICZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbhHQICG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2021 04:02:06 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88B1C061764
        for <linux-mmc@vger.kernel.org>; Tue, 17 Aug 2021 01:01:33 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id j196so3239638vkj.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 Aug 2021 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0T5+4GaehyRT2WDHUgxn3a0qt2/eAPIKi9LZ5TymmvQ=;
        b=ay3ZdnM1u9ellkPfCAdX4UtnNqjB70RA00PwUe23eWY0x2MfYrF2THZ2MLkFdUVqKq
         o/uo587wedCqk/LdzGcgFMnVQibDExFZLeLCWZCb75lcxMnFwtsxA7qq8R8iFbDFqSyP
         DItlCbLO3QwMIcoeLFWGNK/a/rmlJgb5pd+wBcYQCSjluUsiWsSYsoaj+gTbkmaAcLmd
         LJuhxWqyLYzpAp1YIO42eUuXbkk6/684p3If9fuY4IStpml0wu4qq6E3uAZx2WMpn4Qx
         wq5tvhM2UcGPB9D1WPun0/XCO1T0alYv02juL/QIOnNEIBz8uGymnbMsEg6+oYJ2265s
         kOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0T5+4GaehyRT2WDHUgxn3a0qt2/eAPIKi9LZ5TymmvQ=;
        b=gzQB5Rk9XeFF9AL0LSICIHKMQ4JkV9CGK/TMP8IFA7xWbTxTG9hr34dDdWsmsMXg6m
         FrqqxjkXha4RRni2I7sIdTGkJhXeFM/+4dk+CdfYT223t5IozTtGF1jH2mSAGTEUQ1kC
         shGd0IEVjooZ8bqqlsodIlgcAsrLA1rbfVOQeZXDTZffr/oPBX1dYvbM8WrExYgW4X7c
         7JIEJhTqBOEuodtSYUen0n3FIRQygcMAw8NU58sxfvKmaTynl7LkMKCsJW7nYVUUpvGf
         DUUSC/15svGC6d5b50BFrzzSbj1o5ImxWs5cwcT0xNMRs9uEjInDatyYTEOyVO0eWBlp
         h+8g==
X-Gm-Message-State: AOAM530HJZyu6WOK9lTNyOipLX/+NwQViy2fRukAv8S1hkQ4+mydeHcq
        d1u0Ex+HTj8eKqLWfz4Qxs5VNMWwLC91Eni9PhZWUA==
X-Google-Smtp-Source: ABdhPJyy+w1eBi67Jn3EHb1wO3zBi/UmN4UEf7XNb//I3G/q42Wet4HlxNYNk/oz1QDSgDNmr5+sI3Vyd/1G0yrYvT8=
X-Received: by 2002:a1f:a555:: with SMTP id o82mr1653581vke.8.1629187292924;
 Tue, 17 Aug 2021 01:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
 <1629117508-4886-4-git-send-email-haibo.chen@nxp.com> <CAPDyKFpqTdKxFytQWo+TLJf+D=JYJo6B2aZDqOQc4+9_mbH40Q@mail.gmail.com>
 <VI1PR04MB52948F36F428AA3476A1F9D590FE9@VI1PR04MB5294.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB52948F36F428AA3476A1F9D590FE9@VI1PR04MB5294.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Aug 2021 10:00:56 +0200
Message-ID: <CAPDyKFpr9E6xxe2egiRGGWhUSY5aVr29rj1Hb_TwCzrY5bcvpg@mail.gmail.com>
Subject: Re: [PATCH 4/6] mmc: host: sdhci-esdhc-imx.c: correct the auto-tuning
 setting for sdio device
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Aug 2021 at 08:57, Bough Chen <haibo.chen@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > Sent: 2021=E5=B9=B48=E6=9C=8816=E6=97=A5 21:53
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>; Shawn Guo
> > <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> > Estevam <festevam@gmail.com>; linux-mmc <linux-mmc@vger.kernel.org>;
> > dl-linux-imx <linux-imx@nxp.com>; DTML <devicetree@vger.kernel.org>; Li=
nux
> > ARM <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: [PATCH 4/6] mmc: host: sdhci-esdhc-imx.c: correct the auto=
-tuning
> > setting for sdio device
> >
> > On Mon, 16 Aug 2021 at 15:00, <haibo.chen@nxp.com> wrote:
> > >
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > USDHC contain auto tuning circuit, this circuit will work
> > > automatically after the tuning procedurae, it can increase/decrease
> > > the delay cell according to the outside environment change (like
> > temperature).
> > >
> > > Unfortunately, this auto tuning circuit can not handle the async sdio
> > > device interrupt correctly. When sdio device use 4 data line, async
> > > sdio interrupt will use DAT[1], if we enable auto tuning circuit chec=
k
> > > 4 data lines, include the DAT[1], this circuit will detect this
> > > interrupt, take this as a data on DAT[1], and adjust the delay cell w=
rongly.
> > >
> > > This is the hardware design limitation, to avoid this, when sdio
> > > device enable async interrupt, auto tuning circuit only check DAT[0] =
and CMD
> > lines.
> >
> > SDIO irqs are being enabled/disabled dynamically in runtime by the mmc =
core
> > via the host ops ->enable_sdio_irq().
> >
> > Rather than forcing the autotuning circuit to stay unused statically, p=
erhaps an
> > option would be to disable it when the SDIO irqs becomes enabled? Or ma=
ybe
> > that becomes too complicated?
>
> For interrupt in 4-bit mode, there is a definition of interrupt period, o=
nly in this period can the interrupt be
> detect and recognize. The interrupt period can exist during data transfer=
.
>
> So to fix this issue, one method is to disable auto tuning circuit. Anoth=
er is my current method, just detect CMD
> and DAT0, but at least auto tuning still can work (this method need board=
 design keep align all data lines).

To allow DAT1 being used for SDIO irqs (async or not), the irqs needs
to be enabled internally in the SDIO card first. This is done by
writing to the CCCR register, which happens in sdio_claim_irq(). At
this point in sdio_claim_irq() the core also invokes the
->enable_sdio_irq() host ops, to allow the host to prepare itself to
accept SDIO irqs.

It sounds to me that you should be able to use the ->enable_sdio_irq
ops, as a way of understanding that the auto-tuning feature also needs
to be turned off, because it's not compatible with SDIO irqs.

Kind regards
Uffe

>
>
> Best Regards
> Haibo chen
>
> >
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > > ---
> > >  drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > index f18d169bc8ff..ab84c29777e5 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > @@ -226,6 +226,7 @@ struct esdhc_platform_data {
> > >         unsigned int tuning_step;       /* The delay cell steps in tu=
ning
> > procedure */
> > >         unsigned int tuning_start_tap;  /* The start delay cell point=
 in
> > tuning procedure */
> > >         unsigned int strobe_dll_delay_target;   /* The delay cell for
> > strobe pad (read clock) */
> > > +       bool sdio_async_interrupt_enabled;      /* sdio device enable
> > the async interrupt */
> > >  };
> > >
> > >  struct esdhc_soc_data {
> > > @@ -416,6 +417,8 @@ static inline void
> > > esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
> > >  /* Enable the auto tuning circuit to check the CMD line and BUS line
> > > */  static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host
> > > *host)  {
> > > +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > > +       struct pltfm_imx_data *imx_data =3D
> > > + sdhci_pltfm_priv(pltfm_host);
> > >         u32 buswidth, auto_tune_buswidth;
> > >
> > >         buswidth =3D USDHC_GET_BUSWIDTH(readl(host->ioaddr +
> > > SDHCI_HOST_CONTROL)); @@ -432,6 +435,18 @@ static inline void
> > usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
> > >                 break;
> > >         }
> > >
> > > +       /*
> > > +        * If sdio device use async interrupt, it will use DAT[1] to =
signal
> > > +        * the device's interrupt asynchronous when use 4 data lines.
> > > +        * Then hardware auto tuning circuit MUST NOT check the DAT[1=
]
> > line,
> > > +        * otherwise auto tuning will be impacted by this async inter=
rupt,
> > > +        * and change the delay cell incorrectly, which then cause
> > data/cmd
> > > +        * errors.
> > > +        * This is the hardware auto tuning circuit limitation.
> > > +        */
> > > +       if (imx_data->boarddata.sdio_async_interrupt_enabled)
> > > +               auto_tune_buswidth =3D
> > > + ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
> > > +
> > >         esdhc_clrset_le(host,
> > ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
> > >                         auto_tune_buswidth |
> > ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
> > >                         ESDHC_VEND_SPEC2); @@ -1531,6 +1546,9
> > @@
> > > sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
> > >         if (of_property_read_u32(np, "fsl,delay-line",
> > &boarddata->delay_line))
> > >                 boarddata->delay_line =3D 0;
> > >
> > > +       if (of_property_read_bool(np,
> > > + "fsl,sdio-async-interrupt-enabled"))
> >
> > As stated on the DT patch, I think you can use the "cap-sdio-irq" inste=
ad.
> >
> > > +               boarddata->sdio_async_interrupt_enabled =3D true;
> > > +
> > >         mmc_of_parse_voltage(host->mmc, &host->ocr_mask);
> > >
> > >         if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pinctrl)) {
> > > --
> > > 2.17.1
> > >
> >
> > Kind regards
> > Uffe
