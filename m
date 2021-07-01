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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE311C11F64
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 03:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA64C61476
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 03:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhGADuX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhGADuX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 23:50:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B486EC061756;
        Wed, 30 Jun 2021 20:47:53 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b2so4736652qka.7;
        Wed, 30 Jun 2021 20:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FBLy8HhoOQw9pfBLv1qCVmi6SynKDzQv7BxPdiIz/K8=;
        b=V68wQ3Z7V0VQohcSlj5ylfMwuua5JqDVGeD/WUsl+prrVaaK8mT4erndv3YysAUG1Q
         iINVvFFenlXGchVxRJ6eo2BgZM1FTQhDCyRgLkPwnnzHl/EQ0ci7FeYpSqv5jdHBnvfz
         1QmatDB8IbxL2kERGq+f8yIZ94e6tzUeOpi96FKMwt75+iFcNeC2f52TL6RSfw+8lGkD
         9xME1QeGuA/nKan7V6HF7UB9kzE26WdVe5Bf3ByRPLZbLE6RNfKOrdAyKlizop/H7/4J
         GlPdks9mugdm0xVETvtjAe8jDOf1I67LBaYPgYskYsnAL2DKK71hT+1SjAuSw3hC8emC
         zQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FBLy8HhoOQw9pfBLv1qCVmi6SynKDzQv7BxPdiIz/K8=;
        b=C7I7441cB0WpjvCaxrxHswErDmOC7A7+9BcxIlSQKjQ7Kj9PHvkJ6kDwePQhg34L8E
         kF0i5G3YcZz23o30arKLhhpC/nUR17YJNHKwnDbOUzUSYR78OiVP4qSrSaI+3rgSUPcf
         vQDiqITwlJarqZLcns1Xm/9lQ8QlZVeCeBnXVlbBXCzRJssxIhnZ5+MpItjGT+Y8i657
         Fch+8Kdu6mVlUVX4TfKuuekNkIuddcZsn+lE0U+MvXXyItXxRPeGQUT+TEosredc8ofM
         M64rUvbn4VNICfsqz2J4Ek+es3OGZzLyd/bA9PV1zBPSktnTQz47LH3J70PZYpc1Bhub
         WuXw==
X-Gm-Message-State: AOAM533qoN2uKiVxRybA+YZ8J3QvRob4AR7YBA83SnF914jcenha7jyT
        11syJM4HrH/3YTZn1ARqy2u1aSrYDh/5Jaof2I4=
X-Google-Smtp-Source: ABdhPJwnh6wmcTvk9eS5Zbc8gujrbc8tIfSXoqpRvcqaYD0RWPUgwGV3c/oDHTi246Gw6qb+SJmw6SrmnwXQzau2cXM=
X-Received: by 2002:a05:620a:12b4:: with SMTP id x20mr21252019qki.217.1625111273013;
 Wed, 30 Jun 2021 20:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210624032543.101861-1-reniuschengl@gmail.com> <916ea01b-4265-0964-9139-8f50b80ea66e@intel.com>
In-Reply-To: <916ea01b-4265-0964-9139-8f50b80ea66e@intel.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Thu, 1 Jul 2021 11:47:42 +0800
Message-ID: <CAJU4x8tyO9wG_b3V7V3CDs9OgV7MDQRiYxwHEN4=NXZzC=76OQ@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adrian Hunter <adrian.hunter@intel.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:18=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 24/06/21 6:25 am, Renius Chen wrote:
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
> >  drivers/mmc/host/sdhci-pci-gli.c | 86 ++++++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 302a7579a9b3..0105f728ccc4 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -88,6 +88,9 @@
> >  #define PCIE_GLI_9763E_SCR    0x8E0
> >  #define   GLI_9763E_SCR_AXI_REQ         BIT(9)
> >
> > +#define PCIE_GLI_9763E_CFG       0x8A0
> > +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> > +
> >  #define PCIE_GLI_9763E_CFG2      0x8A4
> >  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> >  #define   GLI_9763E_CFG2_L1DLY_MID 0x54
> > @@ -691,6 +694,86 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host=
 *mmc)
> >       sdhci_dumpregs(mmc_priv(mmc));
> >  }
> >
> > +static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *=
mrq)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     struct mmc_command *cmd;
> > +     struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +     struct pci_dev *pdev =3D slot->chip->pdev;
> > +     u32 value;
> > +     static bool start_4k_r;
> > +     static int  continuous_4k_r;
>
> Please do not use static variables.  Instead define a struct for them and
> set .priv_size in sdhci_pci_fixes e.g.
>
> struct sdhci_pci_gli {
>         static bool start_4k_r;
>         static int  continuous_4k_r;
> };
>
> const struct sdhci_pci_fixes sdhci_gl9763e =3D {
>         .quirks         =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>         .probe_slot     =3D gli_probe_slot_gl9763e,
>         .ops            =3D &sdhci_gl9763e_ops,
> #ifdef CONFIG_PM_SLEEP
>         .resume         =3D sdhci_cqhci_gli_resume,
>         .suspend        =3D sdhci_cqhci_gli_suspend,
> #endif
>         .add_host       =3D gl9763e_add_host,
>         .priv_size      =3D sizeof(struct sdhci_pci_gli);
> };
>
> And then you can get a pointer to it:
>
> struct sdhci_pci_gli *sdhci_pci_gli =3D sdhci_pci_priv(slot);
>
>
> > +
> > +     cmd =3D (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23)) ? mrq->sb=
c : mrq->cmd;
>
> mrq->cmd is always the main command, so why look at mrq->sbc?

OK, I will just check if mrq->cmd is valid or not instead of looking
at mrq->sbc.
I will also modify the other parts by your comments and submit a newer vers=
ion.
Thanks for your review.

>
> > +
> > +     if (cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK) {
> > +             if (cmd->data->blocks =3D=3D 8) {
> > +                     continuous_4k_r++;
> > +
> > +                     if ((!start_4k_r) && (continuous_4k_r >=3D 3)) {
> > +                             pci_read_config_dword(pdev, PCIE_GLI_9763=
E_VHS, &value);
> > +                             value &=3D ~GLI_9763E_VHS_REV;
> > +                             value |=3D FIELD_PREP(GLI_9763E_VHS_REV, =
GLI_9763E_VHS_REV_W);
> > +                             pci_write_config_dword(pdev, PCIE_GLI_976=
3E_VHS, value);
> > +
> > +                             pci_read_config_dword(pdev, PCIE_GLI_9763=
E_CFG, &value);
> > +                             value |=3D GLI_9763E_CFG_LPSN_DIS;
> > +                             pci_write_config_dword(pdev, PCIE_GLI_976=
3E_CFG, value);
> > +
> > +                             pci_read_config_dword(pdev, PCIE_GLI_9763=
E_VHS, &value);
> > +                             value &=3D ~GLI_9763E_VHS_REV;
> > +                             value |=3D FIELD_PREP(GLI_9763E_VHS_REV, =
GLI_9763E_VHS_REV_R);
> > +                             pci_write_config_dword(pdev, PCIE_GLI_976=
3E_VHS, value);
> > +
> > +                             start_4k_r =3D true;
> > +                     }
> > +             } else {
> > +                     continuous_4k_r =3D 0;
> > +
> > +                     if (start_4k_r) {
> > +                             pci_read_config_dword(pdev, PCIE_GLI_9763=
E_VHS, &value);
> > +                             value &=3D ~GLI_9763E_VHS_REV;
> > +                             value |=3D FIELD_PREP(GLI_9763E_VHS_REV, =
GLI_9763E_VHS_REV_W);
> > +                             pci_write_config_dword(pdev, PCIE_GLI_976=
3E_VHS, value);
> > +
> > +                             pci_read_config_dword(pdev, PCIE_GLI_9763=
E_CFG, &value);
> > +                             value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> > +                             pci_write_config_dword(pdev, PCIE_GLI_976=
3E_CFG, value);
> > +
> > +                             pci_read_config_dword(pdev, PCIE_GLI_9763=
E_VHS, &value);
> > +                             value &=3D ~GLI_9763E_VHS_REV;
> > +                             value |=3D FIELD_PREP(GLI_9763E_VHS_REV, =
GLI_9763E_VHS_REV_R);
> > +                             pci_write_config_dword(pdev, PCIE_GLI_976=
3E_VHS, value);
> > +
> > +                             start_4k_r =3D false;
> > +                     }
> > +             }
> > +     } else {
> > +             continuous_4k_r =3D 0;
> > +
> > +             if (start_4k_r) {
> > +                     pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &=
value);
> > +                     value &=3D ~GLI_9763E_VHS_REV;
> > +                     value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763=
E_VHS_REV_W);
> > +                     pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, =
value);
> > +
> > +                     pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &=
value);
> > +                     value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> > +                     pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, =
value);
> > +
> > +                     pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &=
value);
> > +                     value &=3D ~GLI_9763E_VHS_REV;
> > +                     value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763=
E_VHS_REV_R);
> > +                     pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, =
value);
> > +
> > +                     start_4k_r =3D false;
> > +             }
>
> The code chunk above is the same as the previous and almost
> the same as the one before that.  Please make a separate function
>
> > +     }
> > +
> > +     sdhci_request(mmc, mrq);
> > +}
> > +
> > +
> >  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
> >  {
> >       struct cqhci_host *cq_host =3D mmc->cqe_private;
> > @@ -848,6 +931,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_=
slot *slot)
> >       gli_pcie_enable_msi(slot);
> >       host->mmc_host_ops.hs400_enhanced_strobe =3D
> >                                       gl9763e_hs400_enhanced_strobe;
> > +
> > +     host->mmc_host_ops.request =3D gl9763e_request;
> > +
> >       gli_set_gl9763e(slot);
> >       sdhci_enable_v4_mode(host);
> >
> >
>
