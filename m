Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E122CC07E9B
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 12:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8739613E1
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 12:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhGEMyQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhGEMyQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jul 2021 08:54:16 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A06C061574
        for <linux-mmc@vger.kernel.org>; Mon,  5 Jul 2021 05:51:38 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id o7so10035865vss.5
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jul 2021 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GqddWSm2FPSz+EL6oOH6eQyjrfFcGFuBCoGNvkQlAZg=;
        b=wjTCKAgxDH8bCLIUNfz84Uurm9CXBNXGF2GsSYTFt0kGyEXKAdu8usV5QfpzJKTf+m
         MOo8llghllGWkeg3InOtsvd5G57kmfsNqxGPaZj0J5dHv/h+e2Z600tzAf/dhcZPUXHs
         t/xUOlPSE3on/V6xP6esD36G8bA9kwP6ctpU+UtnfUMCaJhVP8hxLUWAC87Ru3zJrT2C
         ufojrzOzLZW7j6I1xTD9s97bbvHbIku5X+urisHHEy1HiIoVyJIq9Tf2s/pNk0nuig9i
         lhdI4H3r0mLodS//M8b3ckJ6Jlk4NKLnmPdTooTCNlx+d0rknzqscBvZL1Em/7hEl63F
         1DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GqddWSm2FPSz+EL6oOH6eQyjrfFcGFuBCoGNvkQlAZg=;
        b=fkjvOxOxQg+FRTlsh6WONcTZHZjZiwb49TRxuUBAltPtRUaVGXyfFw1Y+dzHZhwFN+
         bIhRqv1P33twmd4o9YIycWABBc6/lBKCUYSGLwLqJBL4l94wBuz0V/6zSs4Gxm2M6j/0
         1c+DsAvC5JWPpAFedy46IKBYL1bmbg/Ou8fCI8s9GnHlIiXFmJ0plLbDRcrxHLvOcYDO
         jy1f0L/MW8/yTAT+Rf14RIVsK4MiwCWJa096nFUnPjJaRomqapXCiynJoqZFo4Awec90
         Gvp/SBTBU02hf6RwD4c4Yoxy8NvrLvG1RnJccJMOxdutlHOF1ayzeREh0sOaHfKnZCim
         giow==
X-Gm-Message-State: AOAM533zS9S2xfYH54mtyIKwsGPwuao2QEeWnwpMxMkB4fNxKAmy5k6l
        4JDz4Jh5iC7EEM7NK5Qq1Q7Bx8jwRwhxiopojZaG0w==
X-Google-Smtp-Source: ABdhPJxiRzUG5gCsyGMzdGj1GtV7a51L2WP/p/ePQkXAmeA6pwd3JmhvviOeBJdRQAbTLzLJ1ZG/G14OEZCVtgosxN8=
X-Received: by 2002:a67:8c46:: with SMTP id o67mr8777375vsd.34.1625489497166;
 Mon, 05 Jul 2021 05:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com> <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
In-Reply-To: <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 5 Jul 2021 14:50:59 +0200
Message-ID: <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 5 Jul 2021 at 12:59, Renius Chen <reniuschengl@gmail.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:03=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Mon, 5 Jul 2021 at 11:00, Renius Chen <reniuschengl@gmail.com> wrote=
:
> > >
> > > During a sequence of random 4K read operations, the performance will =
be
> > > reduced due to spending much time on entering/exiting the low power s=
tate
> > > between requests. We disable the low power state negotiation of GL976=
3E
> > > during a sequence of random 4K read operations to improve the perform=
ance
> > > and enable it again after the operations have finished.
> > >
> > > Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> > > ---
> > >  drivers/mmc/host/sdhci-pci-gli.c | 68 ++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 68 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhc=
i-pci-gli.c
> > > index 302a7579a9b3..5f1f332b4241 100644
> > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > @@ -88,6 +88,9 @@
> > >  #define PCIE_GLI_9763E_SCR      0x8E0
> > >  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
> > >
> > > +#define PCIE_GLI_9763E_CFG       0x8A0
> > > +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> > > +
> > >  #define PCIE_GLI_9763E_CFG2      0x8A4
> > >  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> > >  #define   GLI_9763E_CFG2_L1DLY_MID 0x54
> > > @@ -128,6 +131,11 @@
> > >
> > >  #define GLI_MAX_TUNING_LOOP 40
> > >
> > > +struct gli_host {
> > > +       bool start_4k_r;
> > > +       int continuous_4k_r;
> > > +};
> > > +
> > >  /* Genesys Logic chipset */
> > >  static inline void gl9750_wt_on(struct sdhci_host *host)
> > >  {
> > > @@ -691,6 +699,62 @@ static void sdhci_gl9763e_dumpregs(struct mmc_ho=
st *mmc)
> > >         sdhci_dumpregs(mmc_priv(mmc));
> > >  }
> > >
> > > +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot =
*slot, bool enable)
> > > +{
> > > +       struct pci_dev *pdev =3D slot->chip->pdev;
> > > +       u32 value;
> > > +
> > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > > +       value &=3D ~GLI_9763E_VHS_REV;
> > > +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W)=
;
> > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > > +
> > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> > > +
> > > +       if (enable)
> > > +               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> > > +       else
> > > +               value |=3D GLI_9763E_CFG_LPSN_DIS;
> > > +
> > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> > > +
> > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > > +       value &=3D ~GLI_9763E_VHS_REV;
> > > +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R)=
;
> > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > > +}
> > > +
> > > +static void gl9763e_request(struct mmc_host *mmc, struct mmc_request=
 *mrq)
> > > +{
> > > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > > +       struct mmc_command *cmd;
> > > +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > > +       struct gli_host *gli_host =3D sdhci_pci_priv(slot);
> > > +
> > > +       cmd =3D mrq->cmd;
> > > +
> > > +       if (cmd && (cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK) && (c=
md->data->blocks =3D=3D 8)) {
> > > +               gli_host->continuous_4k_r++;
> > > +
> > > +               if ((!gli_host->start_4k_r) && (gli_host->continuous_=
4k_r >=3D 3)) {
> > > +                       gl9763e_set_low_power_negotiation(slot, false=
);
> > > +
> > > +                       gli_host->start_4k_r =3D true;
> > > +               }
> > > +       } else {
> > > +               gli_host->continuous_4k_r =3D 0;
> > > +
> > > +               if (gli_host->start_4k_r)       {
> > > +                       gl9763e_set_low_power_negotiation(slot, true)=
;
> > > +
> > > +                       gli_host->start_4k_r =3D false;
> > > +               }
> > > +       }
> >
> > The above code is trying to figure out what kind of storage use case
> > that is running, based on information about the buffers. This does not
> > work, simply because the buffers don't give you all the information
> > you need to make the right decisions.
> >
> > Moreover, I am sure you would try to follow up with additional changes
> > on top, trying to tweak the behaviour to fit another use case - and so
> > on. My point is, this code doesn't belong in the lowest layer drivers.
> >
> > To move forward, I suggest you explore using runtime PM in combination
> > with dev PM qos. In this way, the driver could implement a default
> > behaviour, which can be tweaked from upper layer governors for
> > example, but also from user space (via sysfs) allowing more
> > flexibility and potentially support for various more use cases.
> >
>
> Hi Ulf,
>
> Thanks for advice.
>
> But we'll meet the performance issue only during a seqence of requests
> of read commands with 4K data length.
>
> So what we have to do is looking into the requests to monitor such
> behaviors and disable the low power state negotiation of GL9763e. And
> the information from the request buffer is sufficient for this
> purpose.
>
> We don't even care about if we disable the low power state negotiation
> by a wrong decision because we'll enable it again by any requests
> which are not read commands or their data length is not 4K. Disabling
> the low power state negotiation of GL9763e not only has no side
> effects but also helps its performance.
>
> The behavior is only about the low power state negotiation of GL9763e
> and 4K reads, and not related to runtime PM, so that we monitor the
> requests and implement it in the driver of GL9763e.

I don't agree, sorry.

The request doesn't tell you about the behavior/performance of the
eMMC/SD card. You can have some average idea, but things vary
depending on what eMMC/SD card that is being used - and over time when
the card gets used, for example.

But, let's not discuss use cases and exactly how to tune the behavior,
that's a separate discussion.

To repeat what I said, my main point is that this kind of code doesn't
belong in the driver. Instead, please try using runtime PM and dev PM
Qos.

A rather simple attempt would be to deploy runtime PM support and play
with a default autosuspend timeout instead. Would that work for you?

>
> Due to this behavior will only affect our GL9763e but not other
> devices, so we think it could be implemented in the lower layer driver
> of GL9763e, but not higher level or user space. And we are trying to
> modify only our sdhci-pci-gli.c but not other mmc common codes.
>

That's exactly the problem.

In principle, you want to apply some policy to balance performance vs
the energy cost, which is a generic problem that all mmc drivers
share.

So far, the approach have been to run as fast as possible while there
are requests in the queue - and then power off things with runtime PM,
etc, after some period of idle. This certainly can be improved, but it
needs to be done generically on not through independent hacks in
drivers.

Kind regards
Uffe

> Thank you!
>
> > > +
> > > +       sdhci_request(mmc, mrq);
> > > +}
> > > +
> > > +
> > >  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
> > >  {
> > >         struct cqhci_host *cq_host =3D mmc->cqe_private;
> > > @@ -848,6 +912,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pc=
i_slot *slot)
> > >         gli_pcie_enable_msi(slot);
> > >         host->mmc_host_ops.hs400_enhanced_strobe =3D
> > >                                         gl9763e_hs400_enhanced_strobe=
;
> > > +
> > > +       host->mmc_host_ops.request =3D gl9763e_request;
> > > +
> > >         gli_set_gl9763e(slot);
> > >         sdhci_enable_v4_mode(host);
> > >
> > > @@ -913,4 +980,5 @@ const struct sdhci_pci_fixes sdhci_gl9763e =3D {
> > >         .suspend        =3D sdhci_cqhci_gli_suspend,
> > >  #endif
> > >         .add_host       =3D gl9763e_add_host,
> > > +       .priv_size      =3D sizeof(struct gli_host),
> > >  };
> > > --
> >
> > Kind regards
> > Uffe
