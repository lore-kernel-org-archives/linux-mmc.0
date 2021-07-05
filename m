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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772BAC07E99
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 10:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561D661159
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 10:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGELBu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Jul 2021 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhGELBu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jul 2021 07:01:50 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D6C061574;
        Mon,  5 Jul 2021 03:59:13 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cz7so4506479qvb.9;
        Mon, 05 Jul 2021 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iNpxDJ0IHr2uLGa3LdBvz6wIanoEP5txuNBCCWNqTKE=;
        b=VjKEQNHvfdqW581tA2AkO6rVNMmOGaSGB4UWtHUqN/JlKcPwA1vZUjdzkDbUhS3ULC
         nW6XAVeHE7eAbD4Jtd6VxhI91acBbpdqV7ERAeAQIov+meA6P3vSxmOro0biRgtmASmH
         BP26YDXGzrc5FihmiAq3L7LPZJ8trhpNl+kxlvwYj0TyvKar8pTDZIKpjBdxADo0jman
         1e3lPEl27+gAT9GEHgvrpZUK287UYI9IVXwk1yBhMG17KaCHcoBnW/Q9SVs2Xkz2LktH
         v3gr5Y679kXMAMuS8ZLmoFt1ATDuqDvR1E7rERGPIr0Bbew0gkagGKgqUCgs46rI4G00
         M2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iNpxDJ0IHr2uLGa3LdBvz6wIanoEP5txuNBCCWNqTKE=;
        b=OZioQ9zZ/XiapAxZn8narEshsh9z4eK1R1jTaY0z4Pa65z7rjDhV8H+x0BIk5YH9fA
         8ZrBzd/BewOS6KPO90iYEvXfbzn+B0Un2Vn+aJSTKqNlZPU8rIt7tM+90OAuYC2nOrOc
         Spr8SsU3O8jyCBrR4jfOn7l5g58wh9IXDe4zf3jTDKdQ3jOeAf8X4Z4e7NcCiqSw45Bw
         yt8j/x34WaGQbomP2n9jh2psRIaDgL12Bl7r4JE2fj55sMVdbAXTf9OWFLqwrRBQJ/zP
         Aoh8mU9ZF03qrBtzTUcpvDExyg/tgKN5Z3X32OFIEOKMOnAVCe253Q/X2DjLYoORY1t/
         A0Mw==
X-Gm-Message-State: AOAM53114x708ynR2+sLPTwFQYEWFN/brolhLOeK7C5Xr9SMR0RPHu5X
        G+VkW8DE1kkiCHXs8RQuh+8ax6tpked23+2dH0o=
X-Google-Smtp-Source: ABdhPJwTmNIDGGu0cGzXdARsPcH+bDoQNvz9JrhYgzCSVuBqLM0Tm5UQL8RumPr2OmVuo7oiiK+If2C1YHSZgNw1Oxc=
X-Received: by 2002:ad4:5444:: with SMTP id h4mr12371464qvt.14.1625482752818;
 Mon, 05 Jul 2021 03:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com> <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
In-Reply-To: <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Mon, 5 Jul 2021 18:59:01 +0800
Message-ID: <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 5 Jul 2021 at 11:00, Renius Chen <reniuschengl@gmail.com> wrote:
> >
> > During a sequence of random 4K read operations, the performance will be
> > reduced due to spending much time on entering/exiting the low power sta=
te
> > between requests. We disable the low power state negotiation of GL9763E
> > during a sequence of random 4K read operations to improve the performan=
ce
> > and enable it again after the operations have finished.
> >
> > Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 68 ++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 302a7579a9b3..5f1f332b4241 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -88,6 +88,9 @@
> >  #define PCIE_GLI_9763E_SCR      0x8E0
> >  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
> >
> > +#define PCIE_GLI_9763E_CFG       0x8A0
> > +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> > +
> >  #define PCIE_GLI_9763E_CFG2      0x8A4
> >  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> >  #define   GLI_9763E_CFG2_L1DLY_MID 0x54
> > @@ -128,6 +131,11 @@
> >
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> > +struct gli_host {
> > +       bool start_4k_r;
> > +       int continuous_4k_r;
> > +};
> > +
> >  /* Genesys Logic chipset */
> >  static inline void gl9750_wt_on(struct sdhci_host *host)
> >  {
> > @@ -691,6 +699,62 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host=
 *mmc)
> >         sdhci_dumpregs(mmc_priv(mmc));
> >  }
> >
> > +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *s=
lot, bool enable)
> > +{
> > +       struct pci_dev *pdev =3D slot->chip->pdev;
> > +       u32 value;
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > +       value &=3D ~GLI_9763E_VHS_REV;
> > +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> > +
> > +       if (enable)
> > +               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> > +       else
> > +               value |=3D GLI_9763E_CFG_LPSN_DIS;
> > +
> > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> > +
> > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > +       value &=3D ~GLI_9763E_VHS_REV;
> > +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > +}
> > +
> > +static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *=
mrq)
> > +{
> > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > +       struct mmc_command *cmd;
> > +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +       struct gli_host *gli_host =3D sdhci_pci_priv(slot);
> > +
> > +       cmd =3D mrq->cmd;
> > +
> > +       if (cmd && (cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK) && (cmd=
->data->blocks =3D=3D 8)) {
> > +               gli_host->continuous_4k_r++;
> > +
> > +               if ((!gli_host->start_4k_r) && (gli_host->continuous_4k=
_r >=3D 3)) {
> > +                       gl9763e_set_low_power_negotiation(slot, false);
> > +
> > +                       gli_host->start_4k_r =3D true;
> > +               }
> > +       } else {
> > +               gli_host->continuous_4k_r =3D 0;
> > +
> > +               if (gli_host->start_4k_r)       {
> > +                       gl9763e_set_low_power_negotiation(slot, true);
> > +
> > +                       gli_host->start_4k_r =3D false;
> > +               }
> > +       }
>
> The above code is trying to figure out what kind of storage use case
> that is running, based on information about the buffers. This does not
> work, simply because the buffers don't give you all the information
> you need to make the right decisions.
>
> Moreover, I am sure you would try to follow up with additional changes
> on top, trying to tweak the behaviour to fit another use case - and so
> on. My point is, this code doesn't belong in the lowest layer drivers.
>
> To move forward, I suggest you explore using runtime PM in combination
> with dev PM qos. In this way, the driver could implement a default
> behaviour, which can be tweaked from upper layer governors for
> example, but also from user space (via sysfs) allowing more
> flexibility and potentially support for various more use cases.
>

Hi Ulf,

Thanks for advice.

But we'll meet the performance issue only during a seqence of requests
of read commands with 4K data length.

So what we have to do is looking into the requests to monitor such
behaviors and disable the low power state negotiation of GL9763e. And
the information from the request buffer is sufficient for this
purpose.

We don't even care about if we disable the low power state negotiation
by a wrong decision because we'll enable it again by any requests
which are not read commands or their data length is not 4K. Disabling
the low power state negotiation of GL9763e not only has no side
effects but also helps its performance.

The behavior is only about the low power state negotiation of GL9763e
and 4K reads, and not related to runtime PM, so that we monitor the
requests and implement it in the driver of GL9763e.

Due to this behavior will only affect our GL9763e but not other
devices, so we think it could be implemented in the lower layer driver
of GL9763e, but not higher level or user space. And we are trying to
modify only our sdhci-pci-gli.c but not other mmc common codes.

Thank you!

> > +
> > +       sdhci_request(mmc, mrq);
> > +}
> > +
> > +
> >  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
> >  {
> >         struct cqhci_host *cq_host =3D mmc->cqe_private;
> > @@ -848,6 +912,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_=
slot *slot)
> >         gli_pcie_enable_msi(slot);
> >         host->mmc_host_ops.hs400_enhanced_strobe =3D
> >                                         gl9763e_hs400_enhanced_strobe;
> > +
> > +       host->mmc_host_ops.request =3D gl9763e_request;
> > +
> >         gli_set_gl9763e(slot);
> >         sdhci_enable_v4_mode(host);
> >
> > @@ -913,4 +980,5 @@ const struct sdhci_pci_fixes sdhci_gl9763e =3D {
> >         .suspend        =3D sdhci_cqhci_gli_suspend,
> >  #endif
> >         .add_host       =3D gl9763e_add_host,
> > +       .priv_size      =3D sizeof(struct gli_host),
> >  };
> > --
>
> Kind regards
> Uffe
