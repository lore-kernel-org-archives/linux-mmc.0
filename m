Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9FAC07E96
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 09:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDE061996
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 09:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhGFJ5g (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Jul 2021 05:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhGFJ5g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2021 05:57:36 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C4CC061574;
        Tue,  6 Jul 2021 02:54:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z12so8925534qtj.3;
        Tue, 06 Jul 2021 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hE/uo/1hJbOjrhY8TxtHJv3RVJ/fQgsD+ymeSOQbsTs=;
        b=jnQs5eXAjEpzhNGtSpk5kP6ztfYVcMwsCdCMG9a7kjLOW/KKMW+hH0UvubSTKRTRjS
         BJjacR/OoAb/eIJqnUj8/MhySAIWm6etMDz8GEnDyLLyHtLnH8uSqpCo62eDJO0OJfYO
         CuP6h/GMmW0NQ1BMCm6pYDGGmiIWBu2WgnjMCqJ4gkOyL6JevNH9oLBX2JQT0gjXOfzx
         IlPXX0Awri77aCHBiu8v2fNZUyTZsenXYuoPyoXzxYDN7qB+7EnMtf7toaaBgcW0/30U
         iACvLP+5LXeT4oop8iL/K8Dw4tPU1oW7Cn1r4a3F4vVkMNWAytMVxwp673BVbzOC9T0S
         KLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hE/uo/1hJbOjrhY8TxtHJv3RVJ/fQgsD+ymeSOQbsTs=;
        b=PpIEepv3FcGs2id68iX0cPRlLkkuUZtGuWGpaz9gFlZrQDR/FWx87W6P/X26ACiA+c
         IaBqoQofqgq7CX5QmxfoA2tE06BEOtGYkP3khWjxO7NBvrDYYrXx7rNLaGQBgOzC3sZ4
         W0Y3Osa+iGntKhi54ylJV2yMFqELczqAb/p2ce9WjjVOAwaD7mBOrXD4yWJgHT84hxIb
         tMalnC9nwptxJQqxFle0R4QKv88vdHoYDXpboaQ7dPJrNc7h1SYExGHX7LIx0iclUyED
         OeHNtbMI7GRm04zmUn3PksVictVfA3RpUA1N+4f8hj97aCsFqVEk6d43xDiKicffaI37
         1aDQ==
X-Gm-Message-State: AOAM533gpYOgMhkKlSXB3rZewOkMBj7nhWA711xdwQ8NezDm+QpFPm2D
        1JwW+Bz3O01i+wgBUMkqfY3rErThHHA7nHq6GT4=
X-Google-Smtp-Source: ABdhPJxzU1NKM5RQRNXRud3lqzXd9KM81muV4FmL252+/8jdISgKO6c63kXEpqRdQtSLYD95EeAq17TN+tCg6aUZ4l0=
X-Received: by 2002:a05:622a:215:: with SMTP id b21mr16727166qtx.104.1625565297252;
 Tue, 06 Jul 2021 02:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
 <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
 <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com> <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com>
In-Reply-To: <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Tue, 6 Jul 2021 17:54:46 +0800
Message-ID: <CAJU4x8uGxb5VD1WVV5-QeLkVzuuR09-NacL-9nuXe8Zofzb2=w@mail.gmail.com>
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

Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=886=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 5 Jul 2021 at 17:09, Renius Chen <reniuschengl@gmail.com> wrote:
> >
> > Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=888:51=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Mon, 5 Jul 2021 at 12:59, Renius Chen <reniuschengl@gmail.com> wro=
te:
> > > >
> > > > Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=885=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:03=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > >
> > > > > On Mon, 5 Jul 2021 at 11:00, Renius Chen <reniuschengl@gmail.com>=
 wrote:
> > > > > >
> > > > > > During a sequence of random 4K read operations, the performance=
 will be
> > > > > > reduced due to spending much time on entering/exiting the low p=
ower state
> > > > > > between requests. We disable the low power state negotiation of=
 GL9763E
> > > > > > during a sequence of random 4K read operations to improve the p=
erformance
> > > > > > and enable it again after the operations have finished.
> > > > > >
> > > > > > Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> > > > > > ---
> > > > > >  drivers/mmc/host/sdhci-pci-gli.c | 68 ++++++++++++++++++++++++=
++++++++
> > > > > >  1 file changed, 68 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/hos=
t/sdhci-pci-gli.c
> > > > > > index 302a7579a9b3..5f1f332b4241 100644
> > > > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > @@ -88,6 +88,9 @@
> > > > > >  #define PCIE_GLI_9763E_SCR      0x8E0
> > > > > >  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
> > > > > >
> > > > > > +#define PCIE_GLI_9763E_CFG       0x8A0
> > > > > > +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> > > > > > +
> > > > > >  #define PCIE_GLI_9763E_CFG2      0x8A4
> > > > > >  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> > > > > >  #define   GLI_9763E_CFG2_L1DLY_MID 0x54
> > > > > > @@ -128,6 +131,11 @@
> > > > > >
> > > > > >  #define GLI_MAX_TUNING_LOOP 40
> > > > > >
> > > > > > +struct gli_host {
> > > > > > +       bool start_4k_r;
> > > > > > +       int continuous_4k_r;
> > > > > > +};
> > > > > > +
> > > > > >  /* Genesys Logic chipset */
> > > > > >  static inline void gl9750_wt_on(struct sdhci_host *host)
> > > > > >  {
> > > > > > @@ -691,6 +699,62 @@ static void sdhci_gl9763e_dumpregs(struct =
mmc_host *mmc)
> > > > > >         sdhci_dumpregs(mmc_priv(mmc));
> > > > > >  }
> > > > > >
> > > > > > +static void gl9763e_set_low_power_negotiation(struct sdhci_pci=
_slot *slot, bool enable)
> > > > > > +{
> > > > > > +       struct pci_dev *pdev =3D slot->chip->pdev;
> > > > > > +       u32 value;
> > > > > > +
> > > > > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value)=
;
> > > > > > +       value &=3D ~GLI_9763E_VHS_REV;
> > > > > > +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_=
REV_W);
> > > > > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value)=
;
> > > > > > +
> > > > > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value)=
;
> > > > > > +
> > > > > > +       if (enable)
> > > > > > +               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> > > > > > +       else
> > > > > > +               value |=3D GLI_9763E_CFG_LPSN_DIS;
> > > > > > +
> > > > > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value)=
;
> > > > > > +
> > > > > > +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value)=
;
> > > > > > +       value &=3D ~GLI_9763E_VHS_REV;
> > > > > > +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_=
REV_R);
> > > > > > +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value)=
;
> > > > > > +}
> > > > > > +
> > > > > > +static void gl9763e_request(struct mmc_host *mmc, struct mmc_r=
equest *mrq)
> > > > > > +{
> > > > > > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > > > > > +       struct mmc_command *cmd;
> > > > > > +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > > > > > +       struct gli_host *gli_host =3D sdhci_pci_priv(slot);
> > > > > > +
> > > > > > +       cmd =3D mrq->cmd;
> > > > > > +
> > > > > > +       if (cmd && (cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK)=
 && (cmd->data->blocks =3D=3D 8)) {
> > > > > > +               gli_host->continuous_4k_r++;
> > > > > > +
> > > > > > +               if ((!gli_host->start_4k_r) && (gli_host->conti=
nuous_4k_r >=3D 3)) {
> > > > > > +                       gl9763e_set_low_power_negotiation(slot,=
 false);
> > > > > > +
> > > > > > +                       gli_host->start_4k_r =3D true;
> > > > > > +               }
> > > > > > +       } else {
> > > > > > +               gli_host->continuous_4k_r =3D 0;
> > > > > > +
> > > > > > +               if (gli_host->start_4k_r)       {
> > > > > > +                       gl9763e_set_low_power_negotiation(slot,=
 true);
> > > > > > +
> > > > > > +                       gli_host->start_4k_r =3D false;
> > > > > > +               }
> > > > > > +       }
> > > > >
> > > > > The above code is trying to figure out what kind of storage use c=
ase
> > > > > that is running, based on information about the buffers. This doe=
s not
> > > > > work, simply because the buffers don't give you all the informati=
on
> > > > > you need to make the right decisions.
> > > > >
> > > > > Moreover, I am sure you would try to follow up with additional ch=
anges
> > > > > on top, trying to tweak the behaviour to fit another use case - a=
nd so
> > > > > on. My point is, this code doesn't belong in the lowest layer dri=
vers.
> > > > >
> > > > > To move forward, I suggest you explore using runtime PM in combin=
ation
> > > > > with dev PM qos. In this way, the driver could implement a defaul=
t
> > > > > behaviour, which can be tweaked from upper layer governors for
> > > > > example, but also from user space (via sysfs) allowing more
> > > > > flexibility and potentially support for various more use cases.
> > > > >
> > > >
> > > > Hi Ulf,
> > > >
> > > > Thanks for advice.
> > > >
> > > > But we'll meet the performance issue only during a seqence of reque=
sts
> > > > of read commands with 4K data length.
> > > >
> > > > So what we have to do is looking into the requests to monitor such
> > > > behaviors and disable the low power state negotiation of GL9763e. A=
nd
> > > > the information from the request buffer is sufficient for this
> > > > purpose.
> > > >
> > > > We don't even care about if we disable the low power state negotiat=
ion
> > > > by a wrong decision because we'll enable it again by any requests
> > > > which are not read commands or their data length is not 4K. Disabli=
ng
> > > > the low power state negotiation of GL9763e not only has no side
> > > > effects but also helps its performance.
> > > >
> > > > The behavior is only about the low power state negotiation of GL976=
3e
> > > > and 4K reads, and not related to runtime PM, so that we monitor the
> > > > requests and implement it in the driver of GL9763e.
> > >
> > > I don't agree, sorry.
> > >
> > > The request doesn't tell you about the behavior/performance of the
> > > eMMC/SD card. You can have some average idea, but things vary
> > > depending on what eMMC/SD card that is being used - and over time whe=
n
> > > the card gets used, for example.
> > >
> > > But, let's not discuss use cases and exactly how to tune the behavior=
,
> > > that's a separate discussion.
> > >
> > > To repeat what I said, my main point is that this kind of code doesn'=
t
> > > belong in the driver. Instead, please try using runtime PM and dev PM
> > > Qos.
> > >
> > > A rather simple attempt would be to deploy runtime PM support and pla=
y
> > > with a default autosuspend timeout instead. Would that work for you?
> > >
> >
> > Hi Ulf,
> >
> >
> > Thanks for your explanation.
> >
> > I think there may be some misunderstandings here.
>
> I fully understand what you want to do.
>
> >
> > Our purpose is to avoid our GL9763e from entering ASPM L1 state during
> > a sequence of 4K read requests. So we don't have to consider about the
> > behavior/performance of the eMMC/SD card and what eMMC/SD card that is
> > being used. We just need to know what kind of requests we are
> > receiving now from the PCIe root port.
> >
> > Besides, the APSM L1 is purely hardware behavior in GL9763e and has no
> > corresponding relationship with runtime PM. It's not activated by
> > driver and the behaviors are not handled by software. I think runtime
> > PM is used to handle the behaviors of D0/D3 of the device, but not the
> > link status of ASPM L0s, L1, etc.
>
> Maybe runtime PM isn't the perfect fit for this type of use case.
>
> That still doesn't matter to to me, I will not accept this kind of
> governor/policy based code for use cases, in drivers. It doesn't
> belong there.
>

Hi Ulf,

The behavior of this patch is to set the value of a GL9763e vendor
specified register. Why it doesn't belong to GL9763e driver but other
common codes?

> >
> > I agree that the policy of balancing performance vs the energy cost is
> > a generic problem that all mmc drivers share. But our driver of
> > GL9763e is a host driver, the setting in this patch is also only for
> > GL9763e, could not be used by other devices. It depends on our
> > specific hardware design so that it is not a generic solution or
> > policy. So I think to implement such a patch in our specific GL9763e
> > driver to execute the specific actions just for our hardware design is
> > reasonable.
>
> From the use case point of view, the GL9763e hardware design isn't at
> all specific.
>
> In many cases, controllers/platforms have support for low power states
> that one want to enter to avoid wasting energy. The difficult part is
> to know *when* it makes sense to enter a low power state, as it also
> introduces a latency when the power needs to be restored for the
> device, to allow it to serve a new request.
>
> To me, it sounds like you may have been too aggressive on avoid
> wasting energy. If I understand correctly the idle period you use is
> 20/21 us, while most other drivers use 50-100 ms as idle period.
>

Yes, according to our customer's test for the GL9763e, if the ASPM L1
entry delay of GL9763e, which is the idle period you mentioned, is
larger than 20/21 us, it will not pass the PLT test. The PLT is
requested by Google for evaluating the product's battery life. The
product won't be accepted by Google if it fails the PLT test. So we
set the ASPM L1 entry delay to 20/21us.

With such a short idle period, during 4K reads, the idle time between
the read requests will be larger than 20/21us, so GL9763e will enter
ASPM L1 very frequently to impact the performance.

The bad performance of 4K reads was highlighted by Google, too. Our
customer has to pass both the PLT test and 4K read performance test by
Google's request. So after some discussions with our customer and
Google, we decided to submit such a patch to get the best balance to
satisfy Google's requiremnet.

The function and the register is vendor specified of GL9763e, so we
access it in the vendor driver of GL9763e. Add some functions in other
mmc general codes to do something only for GL9763e and can not be
applied by other devices might be a little bit strange and difficult
to implement and design?


Thanks for your comments.


Best regards,

Renius

> [...]
>
> Kind regards
> Uffe
