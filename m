Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34316C07E96
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 09:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103FB61961
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 09:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhGFJTd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Jul 2021 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhGFJTd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2021 05:19:33 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07CFC061574
        for <linux-mmc@vger.kernel.org>; Tue,  6 Jul 2021 02:16:54 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id u11so6775712vsl.7
        for <linux-mmc@vger.kernel.org>; Tue, 06 Jul 2021 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZKo+imJkkagE1w3LOgolpgQnWjb+BXVQZ/S2Akf0DrY=;
        b=sXu0dRLaTh0VGBBY2epEtE6j+ngfmgo+HBmFfQX0342xsqE6sQxMRhiyXKP7U/AsAT
         FAf8QzrG7liqP+xKxZkSQV7xVzwC7uAMG+XgZnimF9/TnDHtQhKVrEa36qD7ZtYo+YXU
         wTqNR3wZGz3iu69xAhU7TZgpnC3+BkC3gJFL/Hyd+0kjPPF0g2iXwegxAoYSebjIj7kr
         4TZ4FZmdS8CVpcLh0qOSjO3vGVFc/VKOwDlcB8C/UQ2aQfykfMheXyjLKo/v9mi7nhyZ
         1bTychxB/iItRUUcOCVEq7rPaVZ2LHxIQZAcJbGz4gK2V5PMLDPnSR30ifJDt+pLmFjc
         Hs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZKo+imJkkagE1w3LOgolpgQnWjb+BXVQZ/S2Akf0DrY=;
        b=XQVFuSTnSfR2NqDTCQyM62lAmuJIi1JDb+kuMK3RqMM9hM6i5yZxomJoKOT8alkoqX
         i2FNKSXCWFRZDuJp9LpPfX5fUO02sblscaQb5jqT3Zu6zI2WJZg7RCDtvH/vt5o2+4ld
         5ppuPaygQqLMpNrby7mK0fkF7sLpF1pvWcQ12OQb7kK/XXfB85XuSfUdOKSh9Gvkyahs
         vfMkwTm6PYMdjjMCwjac43bv4R5BdafHQyBMXw+Hszf1z8hZ4cjJimuzSOwXsZfZVd9P
         fGnGhpAx6XD5vjRWmND2/OXJPcO5aPi6GynkhRxnYW/LeVI7aPOFb2gv+wYE6CUtsrCN
         jg6g==
X-Gm-Message-State: AOAM533UEA2U9A13KF69JIZ+M27GuU373gJZ3g+lQfzlT8nIiDf7mzYe
        k3aZFhm3wtlK4YSwbfaA0m90ZYHUwTI4MjusilgNOw==
X-Google-Smtp-Source: ABdhPJy67k1vx0sDEMVnS8ZZF2fDC6nxnToRclV5KcnjIOHY9uP14YnrdAkjc3XJMXl57GeO1HnwEFAEIp4iZSvLJjM=
X-Received: by 2002:a67:ee54:: with SMTP id g20mr13578379vsp.55.1625563013859;
 Tue, 06 Jul 2021 02:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
 <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com> <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
In-Reply-To: <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 6 Jul 2021 11:16:17 +0200
Message-ID: <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com>
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

On Mon, 5 Jul 2021 at 17:09, Renius Chen <reniuschengl@gmail.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:51=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Mon, 5 Jul 2021 at 12:59, Renius Chen <reniuschengl@gmail.com> wrote=
:
> > >
> > > Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=885=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:03=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > >
> > > > On Mon, 5 Jul 2021 at 11:00, Renius Chen <reniuschengl@gmail.com> w=
rote:
> > > > >
> > > > > During a sequence of random 4K read operations, the performance w=
ill be
> > > > > reduced due to spending much time on entering/exiting the low pow=
er state
> > > > > between requests. We disable the low power state negotiation of G=
L9763E
> > > > > during a sequence of random 4K read operations to improve the per=
formance
> > > > > and enable it again after the operations have finished.
> > > > >
> > > > > Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> > > > > ---
> > > > >  drivers/mmc/host/sdhci-pci-gli.c | 68 ++++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 68 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/=
sdhci-pci-gli.c
> > > > > index 302a7579a9b3..5f1f332b4241 100644
> > > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > > @@ -88,6 +88,9 @@
> > > > >  #define PCIE_GLI_9763E_SCR      0x8E0
> > > > >  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
> > > > >
> > > > > +#define PCIE_GLI_9763E_CFG       0x8A0
> > > > > +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> > > > > +
> > > > >  #define PCIE_GLI_9763E_CFG2      0x8A4
> > > > >  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> > > > >  #define   GLI_9763E_CFG2_L1DLY_MID 0x54
> > > > > @@ -128,6 +131,11 @@
> > > > >
> > > > >  #define GLI_MAX_TUNING_LOOP 40
> > > > >
> > > > > +struct gli_host {
> > > > > +       bool start_4k_r;
> > > > > +       int continuous_4k_r;
> > > > > +};
> > > > > +
> > > > >  /* Genesys Logic chipset */
> > > > >  static inline void gl9750_wt_on(struct sdhci_host *host)
> > > > >  {
> > > > > @@ -691,6 +699,62 @@ static void sdhci_gl9763e_dumpregs(struct mm=
c_host *mmc)
> > > > >         sdhci_dumpregs(mmc_priv(mmc));
> > > > >  }
> > > > >
> > > > > +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_s=
lot *slot, bool enable)
> > > > > +{
> > > > > +       struct pci_dev *pdev =3D slot->chip->pdev;
> > > > > +       u32 value;
> > > > > +
> > > > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > > > > +       value &=3D ~GLI_9763E_VHS_REV;
> > > > > +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_RE=
V_W);
> > > > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > > > > +
> > > > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> > > > > +
> > > > > +       if (enable)
> > > > > +               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> > > > > +       else
> > > > > +               value |=3D GLI_9763E_CFG_LPSN_DIS;
> > > > > +
> > > > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> > > > > +
> > > > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > > > > +       value &=3D ~GLI_9763E_VHS_REV;
> > > > > +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_RE=
V_R);
> > > > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> > > > > +}
> > > > > +
> > > > > +static void gl9763e_request(struct mmc_host *mmc, struct mmc_req=
uest *mrq)
> > > > > +{
> > > > > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > > > > +       struct mmc_command *cmd;
> > > > > +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > > > > +       struct gli_host *gli_host =3D sdhci_pci_priv(slot);
> > > > > +
> > > > > +       cmd =3D mrq->cmd;
> > > > > +
> > > > > +       if (cmd && (cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK) &=
& (cmd->data->blocks =3D=3D 8)) {
> > > > > +               gli_host->continuous_4k_r++;
> > > > > +
> > > > > +               if ((!gli_host->start_4k_r) && (gli_host->continu=
ous_4k_r >=3D 3)) {
> > > > > +                       gl9763e_set_low_power_negotiation(slot, f=
alse);
> > > > > +
> > > > > +                       gli_host->start_4k_r =3D true;
> > > > > +               }
> > > > > +       } else {
> > > > > +               gli_host->continuous_4k_r =3D 0;
> > > > > +
> > > > > +               if (gli_host->start_4k_r)       {
> > > > > +                       gl9763e_set_low_power_negotiation(slot, t=
rue);
> > > > > +
> > > > > +                       gli_host->start_4k_r =3D false;
> > > > > +               }
> > > > > +       }
> > > >
> > > > The above code is trying to figure out what kind of storage use cas=
e
> > > > that is running, based on information about the buffers. This does =
not
> > > > work, simply because the buffers don't give you all the information
> > > > you need to make the right decisions.
> > > >
> > > > Moreover, I am sure you would try to follow up with additional chan=
ges
> > > > on top, trying to tweak the behaviour to fit another use case - and=
 so
> > > > on. My point is, this code doesn't belong in the lowest layer drive=
rs.
> > > >
> > > > To move forward, I suggest you explore using runtime PM in combinat=
ion
> > > > with dev PM qos. In this way, the driver could implement a default
> > > > behaviour, which can be tweaked from upper layer governors for
> > > > example, but also from user space (via sysfs) allowing more
> > > > flexibility and potentially support for various more use cases.
> > > >
> > >
> > > Hi Ulf,
> > >
> > > Thanks for advice.
> > >
> > > But we'll meet the performance issue only during a seqence of request=
s
> > > of read commands with 4K data length.
> > >
> > > So what we have to do is looking into the requests to monitor such
> > > behaviors and disable the low power state negotiation of GL9763e. And
> > > the information from the request buffer is sufficient for this
> > > purpose.
> > >
> > > We don't even care about if we disable the low power state negotiatio=
n
> > > by a wrong decision because we'll enable it again by any requests
> > > which are not read commands or their data length is not 4K. Disabling
> > > the low power state negotiation of GL9763e not only has no side
> > > effects but also helps its performance.
> > >
> > > The behavior is only about the low power state negotiation of GL9763e
> > > and 4K reads, and not related to runtime PM, so that we monitor the
> > > requests and implement it in the driver of GL9763e.
> >
> > I don't agree, sorry.
> >
> > The request doesn't tell you about the behavior/performance of the
> > eMMC/SD card. You can have some average idea, but things vary
> > depending on what eMMC/SD card that is being used - and over time when
> > the card gets used, for example.
> >
> > But, let's not discuss use cases and exactly how to tune the behavior,
> > that's a separate discussion.
> >
> > To repeat what I said, my main point is that this kind of code doesn't
> > belong in the driver. Instead, please try using runtime PM and dev PM
> > Qos.
> >
> > A rather simple attempt would be to deploy runtime PM support and play
> > with a default autosuspend timeout instead. Would that work for you?
> >
>
> Hi Ulf,
>
>
> Thanks for your explanation.
>
> I think there may be some misunderstandings here.

I fully understand what you want to do.

>
> Our purpose is to avoid our GL9763e from entering ASPM L1 state during
> a sequence of 4K read requests. So we don't have to consider about the
> behavior/performance of the eMMC/SD card and what eMMC/SD card that is
> being used. We just need to know what kind of requests we are
> receiving now from the PCIe root port.
>
> Besides, the APSM L1 is purely hardware behavior in GL9763e and has no
> corresponding relationship with runtime PM. It's not activated by
> driver and the behaviors are not handled by software. I think runtime
> PM is used to handle the behaviors of D0/D3 of the device, but not the
> link status of ASPM L0s, L1, etc.

Maybe runtime PM isn't the perfect fit for this type of use case.

That still doesn't matter to to me, I will not accept this kind of
governor/policy based code for use cases, in drivers. It doesn't
belong there.

>
> I agree that the policy of balancing performance vs the energy cost is
> a generic problem that all mmc drivers share. But our driver of
> GL9763e is a host driver, the setting in this patch is also only for
> GL9763e, could not be used by other devices. It depends on our
> specific hardware design so that it is not a generic solution or
> policy. So I think to implement such a patch in our specific GL9763e
> driver to execute the specific actions just for our hardware design is
> reasonable.

From the use case point of view, the GL9763e hardware design isn't at
all specific.

In many cases, controllers/platforms have support for low power states
that one want to enter to avoid wasting energy. The difficult part is
to know *when* it makes sense to enter a low power state, as it also
introduces a latency when the power needs to be restored for the
device, to allow it to serve a new request.

To me, it sounds like you may have been too aggressive on avoid
wasting energy. If I understand correctly the idle period you use is
20/21 us, while most other drivers use 50-100 ms as idle period.

[...]

Kind regards
Uffe
