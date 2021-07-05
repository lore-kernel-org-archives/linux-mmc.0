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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC8FC07E99
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 15:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CB061946
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 15:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhGEPMU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Jul 2021 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhGEPMU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jul 2021 11:12:20 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D7C061574;
        Mon,  5 Jul 2021 08:09:42 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id z12so7339086qtj.3;
        Mon, 05 Jul 2021 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KS/xLE2X5eBY8D8ja58F5q7ILKuLtbu0bXLfT+K46TE=;
        b=YJiAEFxzvK7Ye5VKrr8AkG8D7KSuFVIt7X2d6Jhstfj841quFfmidak4WytRgvmOVe
         Uyu6/GHirO9Za1NojhUtfJcXYyZmUVdlqzYrZ7/IISqD8f5bzOF3qk6e82JS1FGlfOiQ
         DTR3yhaGWuU4fXzDhkvkE1CAkmzeQn+gViyAKygqCVWh1O0Ktr5GWsbhAZ+NtSPu+AZf
         QhMQpcjPh2usS6va3k+ATgWRrD5bpaDi6r7ckOlmHUyeSQeVinVzE69nH3lZsaMCnk/B
         iptfyVSqX4icNVFdCr6g5JNtphavrtTYJKWXf9vwLGMCEfPXvytXtNFz+9djs66h4OHk
         +uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KS/xLE2X5eBY8D8ja58F5q7ILKuLtbu0bXLfT+K46TE=;
        b=WhS110w0q2rQCfxxL1UotcyVfdDZ/2tj6YTfilTMWms+f6yYNIQ3K3G0C2Flt8dd2D
         f3bKyU2rDZLGHAmVD+2vDCnsqLAPS3Gmye8mTpsX55Pv1alMvTEPsgX+KvMBC6LXHqAM
         7Iph6r14eTXRLS0xE8UdQ6lvnlrGu7E+fdKSBRfBR4pfisfcfQdVt2XyYmX1nXaazwO4
         Tz4h+q5TxZrzV7vZCr+VRQOzOKpBPHu2LNTS4nZo4xPuzvOOhSQH9Anz1W2M0VjMQaN2
         J8M0ppPWdUVIuf30O4EvQuJ+c688n1oRh4WOjesw0kxYwpyOjN4xYshBgENbA16Znzgy
         xH+A==
X-Gm-Message-State: AOAM530zl2mKHtIsvmI5lktCCFCTpm7Pd6HJGFpteMhlt5tlKEoiOyku
        j8p7zncZbRZb+zaSZgOu+VhE4JnZHfraY1dunBc=
X-Google-Smtp-Source: ABdhPJxRXbRAAiPp2cpBY6WPAbIzAFMz7XPO1VSoDAb16VVWjgKhAHoY4F+6LSW7rO0UyPCGRxS7xTrETdy8DDEPWUI=
X-Received: by 2002:a05:622a:215:: with SMTP id b21mr13181032qtx.104.1625497781171;
 Mon, 05 Jul 2021 08:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com> <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
In-Reply-To: <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Mon, 5 Jul 2021 23:09:29 +0800
Message-ID: <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
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
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 5 Jul 2021 at 12:59, Renius Chen <reniuschengl@gmail.com> wrote:
> >
> > Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:03=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Mon, 5 Jul 2021 at 11:00, Renius Chen <reniuschengl@gmail.com> wro=
te:
> > > >
> > > > During a sequence of random 4K read operations, the performance wil=
l be
> > > > reduced due to spending much time on entering/exiting the low power=
 state
> > > > between requests. We disable the low power state negotiation of GL9=
763E
> > > > during a sequence of random 4K read operations to improve the perfo=
rmance
> > > > and enable it again after the operations have finished.
> > > >
> > > > Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> > > > ---
> > > >  drivers/mmc/host/sdhci-pci-gli.c | 68 ++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 68 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sd=
hci-pci-gli.c
> > > > index 302a7579a9b3..5f1f332b4241 100644
> > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > @@ -88,6 +88,9 @@
> > > >  #define PCIE_GLI_9763E_SCR      0x8E0
> > > >  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
> > > >
> > > > +#define PCIE_GLI_9763E_CFG       0x8A0
> > > > +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> > > > +
> > > >  #define PCIE_GLI_9763E_CFG2      0x8A4
> > > >  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> > > >  #define   GLI_9763E_CFG2_L1DLY_MID 0x54
> > > > @@ -128,6 +131,11 @@
> > > >
> > > >  #define GLI_MAX_TUNING_LOOP 40
> > > >
> > > > +struct gli_host {
> > > > +       bool start_4k_r;
> > > > +       int continuous_4k_r;
> > > > +};
> > > > +
> > > >  /* Genesys Logic chipset */
> > > >  static inline void gl9750_wt_on(struct sdhci_host *host)
> > > >  {
> > > > @@ -691,6 +699,62 @@ static void sdhci_gl9763e_dumpregs(struct mmc_=
host *mmc)
> > > >         sdhci_dumpregs(mmc_priv(mmc));
> > > >  }
> > > >
> > > > +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slo=
t *slot, bool enable)
> > > > +{
> > > > +       struct pci_dev *pdev =3D slot->chip->pdev;
> > > > +       u32 value;
> > > > +
> > > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > > > +       value &=3D ~GLI_9763E_VHS_REV;
> > > > +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_=
W);
> > > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > > > +
> > > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> > > > +
> > > > +       if (enable)
> > > > +               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> > > > +       else
> > > > +               value |=3D GLI_9763E_CFG_LPSN_DIS;
> > > > +
> > > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> > > > +
> > > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > > > +       value &=3D ~GLI_9763E_VHS_REV;
> > > > +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_=
R);
> > > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > > > +}
> > > > +
> > > > +static void gl9763e_request(struct mmc_host *mmc, struct mmc_reque=
st *mrq)
> > > > +{
> > > > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > > > +       struct mmc_command *cmd;
> > > > +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > > > +       struct gli_host *gli_host =3D sdhci_pci_priv(slot);
> > > > +
> > > > +       cmd =3D mrq->cmd;
> > > > +
> > > > +       if (cmd && (cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK) && =
(cmd->data->blocks =3D=3D 8)) {
> > > > +               gli_host->continuous_4k_r++;
> > > > +
> > > > +               if ((!gli_host->start_4k_r) && (gli_host->continuou=
s_4k_r >=3D 3)) {
> > > > +                       gl9763e_set_low_power_negotiation(slot, fal=
se);
> > > > +
> > > > +                       gli_host->start_4k_r =3D true;
> > > > +               }
> > > > +       } else {
> > > > +               gli_host->continuous_4k_r =3D 0;
> > > > +
> > > > +               if (gli_host->start_4k_r)       {
> > > > +                       gl9763e_set_low_power_negotiation(slot, tru=
e);
> > > > +
> > > > +                       gli_host->start_4k_r =3D false;
> > > > +               }
> > > > +       }
> > >
> > > The above code is trying to figure out what kind of storage use case
> > > that is running, based on information about the buffers. This does no=
t
> > > work, simply because the buffers don't give you all the information
> > > you need to make the right decisions.
> > >
> > > Moreover, I am sure you would try to follow up with additional change=
s
> > > on top, trying to tweak the behaviour to fit another use case - and s=
o
> > > on. My point is, this code doesn't belong in the lowest layer drivers=
.
> > >
> > > To move forward, I suggest you explore using runtime PM in combinatio=
n
> > > with dev PM qos. In this way, the driver could implement a default
> > > behaviour, which can be tweaked from upper layer governors for
> > > example, but also from user space (via sysfs) allowing more
> > > flexibility and potentially support for various more use cases.
> > >
> >
> > Hi Ulf,
> >
> > Thanks for advice.
> >
> > But we'll meet the performance issue only during a seqence of requests
> > of read commands with 4K data length.
> >
> > So what we have to do is looking into the requests to monitor such
> > behaviors and disable the low power state negotiation of GL9763e. And
> > the information from the request buffer is sufficient for this
> > purpose.
> >
> > We don't even care about if we disable the low power state negotiation
> > by a wrong decision because we'll enable it again by any requests
> > which are not read commands or their data length is not 4K. Disabling
> > the low power state negotiation of GL9763e not only has no side
> > effects but also helps its performance.
> >
> > The behavior is only about the low power state negotiation of GL9763e
> > and 4K reads, and not related to runtime PM, so that we monitor the
> > requests and implement it in the driver of GL9763e.
>
> I don't agree, sorry.
>
> The request doesn't tell you about the behavior/performance of the
> eMMC/SD card. You can have some average idea, but things vary
> depending on what eMMC/SD card that is being used - and over time when
> the card gets used, for example.
>
> But, let's not discuss use cases and exactly how to tune the behavior,
> that's a separate discussion.
>
> To repeat what I said, my main point is that this kind of code doesn't
> belong in the driver. Instead, please try using runtime PM and dev PM
> Qos.
>
> A rather simple attempt would be to deploy runtime PM support and play
> with a default autosuspend timeout instead. Would that work for you?
>

Hi Ulf,


Thanks for your explanation.

I think there may be some misunderstandings here.

Our purpose is to avoid our GL9763e from entering ASPM L1 state during
a sequence of 4K read requests. So we don't have to consider about the
behavior/performance of the eMMC/SD card and what eMMC/SD card that is
being used. We just need to know what kind of requests we are
receiving now from the PCIe root port.

Besides, the APSM L1 is purely hardware behavior in GL9763e and has no
corresponding relationship with runtime PM. It's not activated by
driver and the behaviors are not handled by software. I think runtime
PM is used to handle the behaviors of D0/D3 of the device, but not the
link status of ASPM L0s, L1, etc.

I agree that the policy of balancing performance vs the energy cost is
a generic problem that all mmc drivers share. But our driver of
GL9763e is a host driver, the setting in this patch is also only for
GL9763e, could not be used by other devices. It depends on our
specific hardware design so that it is not a generic solution or
policy. So I think to implement such a patch in our specific GL9763e
driver to execute the specific actions just for our hardware design is
reasonable.

Thanks a lot.


Best regards,

Renius

> >
> > Due to this behavior will only affect our GL9763e but not other
> > devices, so we think it could be implemented in the lower layer driver
> > of GL9763e, but not higher level or user space. And we are trying to
> > modify only our sdhci-pci-gli.c but not other mmc common codes.
> >
>
> That's exactly the problem.
>
> In principle, you want to apply some policy to balance performance vs
> the energy cost, which is a generic problem that all mmc drivers
> share.
>
> So far, the approach have been to run as fast as possible while there
> are requests in the queue - and then power off things with runtime PM,
> etc, after some period of idle. This certainly can be improved, but it
> needs to be done generically on not through independent hacks in
> drivers.
>
> Kind regards
> Uffe
>
> > Thank you!
> >
> > > > +
> > > > +       sdhci_request(mmc, mrq);
> > > > +}
> > > > +
> > > > +
> > > >  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
> > > >  {
> > > >         struct cqhci_host *cq_host =3D mmc->cqe_private;
> > > > @@ -848,6 +912,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_=
pci_slot *slot)
> > > >         gli_pcie_enable_msi(slot);
> > > >         host->mmc_host_ops.hs400_enhanced_strobe =3D
> > > >                                         gl9763e_hs400_enhanced_stro=
be;
> > > > +
> > > > +       host->mmc_host_ops.request =3D gl9763e_request;
> > > > +
> > > >         gli_set_gl9763e(slot);
> > > >         sdhci_enable_v4_mode(host);
> > > >
> > > > @@ -913,4 +980,5 @@ const struct sdhci_pci_fixes sdhci_gl9763e =3D =
{
> > > >         .suspend        =3D sdhci_cqhci_gli_suspend,
> > > >  #endif
> > > >         .add_host       =3D gl9763e_add_host,
> > > > +       .priv_size      =3D sizeof(struct gli_host),
> > > >  };
> > > > --
> > >
> > > Kind regards
> > > Uffe
